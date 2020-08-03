function [ProcessedSampleData] = EstimateProcessedSampleData(ChannelData,PingData)
%ESTIMATEPROCESSEDSAMPLEDATA 
%
% CALL: [ProcessedSampleData] = EstimateProcessedSampleData(ChannelData,PingData)
%
% Inputs:
%   ChannelData     = 
%   PingData        = 
%
% Outputs:
%   ProcessedSampleData = 
%
% Description:
%
%
%
% Examples(s):
%   [ProcessedSampleData] = EstimateProcessedSampleData(ChannelData,PingData)
%

% References:
%
%
% Created by Lars Nonboe Andersen
%
%
%
% Copyright (c) 2015 Kongsberg Maritime
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
% ---------------------------------------------------------------------------

narginchk(2,2);
nargoutchk(0,1);

ProcessedSampleData = struct('range',[],'power',[],'alongship',[],'athwartship',[],'spRange',[],'sp',[],'svRange',[],'sv',[]);

EnvironmentData = PingData.EnvironmentData;
ParameterData   = PingData.ParameterData;
SampleData      = PingData.SampleData;

if (~isempty(SampleData))
    
    % Power and Angle
    
    if strcmp(ChannelData.TransceiverType,'GPT')
        % GPT
        
        % Estimate power and angle
        PowerAngleData.power        = SampleData.power;
        PowerAngleData.alongship    = SampleData.alongship;
        PowerAngleData.athwartship  = SampleData.athwartship;
        
    else
        % WBT
        
        nominalTransducerImpedance  = 75;
        wbtImpedanceRx              = 5e3;
        
        transmitSignal = CreateTransmitSignal(PingData);

        % Perform pulse compression if FM
        if (~ParameterData.pulseForm)
            % CW
            complexSamples = SampleData.complexSamples;
        else
            % FM
            pulseCompressedData = conv2(flipud(conj(transmitSignal)),1,PingData.SampleData.complexSamples)/norm(transmitSignal)^2;
            pulseCompressedData = pulseCompressedData(length(transmitSignal):end,:);
            
            complexSamples  = pulseCompressedData;
        end
        
        % Estimate power and angle
        nSectors = size(SampleData.complexSamples,2);
        PowerAngleData.power = nSectors*(abs(sum(complexSamples,2)/nSectors)/(2*sqrt(2))).^2 * ((wbtImpedanceRx+nominalTransducerImpedance)/wbtImpedanceRx)^2 * 1/nominalTransducerImpedance;
        
        if (nSectors==4)
            complexFore         = sum(complexSamples(:,3:4),2)/2;
            complexAft          = sum(complexSamples(:,1:2),2)/2;
            complexStarboard    = (complexSamples(:,1) + complexSamples(:,4))/2;
            complexPort         = sum(complexSamples(:,2:3),2)/2;
            
            PowerAngleData.alongship    = angle( complexFore.*conj(complexAft)) *180/pi;
            PowerAngleData.athwartship  = angle( complexStarboard.*conj(complexPort)) *180/pi;
        elseif (nSectors==1)
            % Single beam
            PowerAngleData.alongship    = 0*complexSamples;
            PowerAngleData.athwartship  = 0*complexSamples;
        else
            error('Sector configuration not supported')
        end
        
    end
    
    % Sp and Sv
    
    % Estimate effective pulse duration
    if strcmp(ChannelData.TransceiverType,'GPT')
        % GPT
        
        effectivePulselLength = ParameterData.pulseLength;
    else
        %WBT
        
        if (~PingData.ParameterData.pulseForm)
            % CW
            transmitSignalPower = abs(transmitSignal).^2;
            effectivePulselLength  = ParameterData.sampleInterval * sum(transmitSignalPower) / max(transmitSignalPower);
        else
            autoCorrelationTransmitSignal = conv(transmitSignal,flipud(conj(transmitSignal)))/norm(transmitSignal)^2;
            autoCorrelationTransmitSignalPower = (abs(autoCorrelationTransmitSignal).^2);
            effectivePulselLength  = ParameterData.sampleInterval * sum(autoCorrelationTransmitSignalPower) / max(autoCorrelationTransmitSignalPower);
        end
    end
    
    nSamples = length(PowerAngleData.power);
    rangeVector = (0:nSamples-1)'*ParameterData.sampleInterval*EnvironmentData.soundSpeed/2;
    
    absorptionCoefficients = EstimateAbsorptionCoefficients(EnvironmentData,ParameterData.frequencyCenter);
    
    % Do not apply TVG before transmit pulse has finished and range > 1 m
    tvgDelay = ParameterData.pulseLength * EnvironmentData.soundSpeed/2;
    startTvg = max(tvgDelay, 1);
    tvg20 = zeros(length(rangeVector), 1);
    tvg40 = zeros(length(rangeVector), 1);
    if (~PingData.ParameterData.pulseForm)
        % CW
        tvg20RangeVector = rangeVector - EnvironmentData.soundSpeed*ParameterData.pulseLength/4;
    else
        % FM
            tvg20RangeVector = rangeVector;
    end
    
    for index = 1:length(rangeVector)
        if(rangeVector(index) > startTvg)
            tvg20(index) = 20*log10(tvg20RangeVector(index)) + 2*absorptionCoefficients*tvg20RangeVector(index);
            tvg40(index) = 40*log10(rangeVector(index)) + 2*absorptionCoefficients*rangeVector(index);
        else
            tvg20(index) = 0;
            tvg40(index) = 0;
        end
    end
    
    pulseLengthTable = str2num(ChannelData.PulseLength);
    gainTable       = str2num(ChannelData.Transducer.Gain);
    if (~PingData.ParameterData.pulseForm)
        % CW
        pulseLengthIndex = dsearchn(pulseLengthTable,ParameterData.pulseLength);
        gain = gainTable(pulseLengthIndex);
    else
        % FM
        gain = gainTable(end);
    end
    
    % Sp
    sp = 10*log10(PowerAngleData.power)  + tvg40 - 10*log10(ParameterData.transmitPower*(EnvironmentData.soundSpeed/ParameterData.frequencyCenter)^2/(16*pi^2)) - 2*(gain + 20*log10(ParameterData.frequencyCenter/str2num(ChannelData.Transducer.Frequency)));
    
    % Sv
    sv = 10*log10(PowerAngleData.power)  + tvg20 - 10*log10(ParameterData.transmitPower*(EnvironmentData.soundSpeed/ParameterData.frequencyCenter)^2*EnvironmentData.soundSpeed/(32*pi^2)) - 2*(gain + 20*log10(ParameterData.frequencyCenter/str2num(ChannelData.Transducer.Frequency))) - 10*log10(effectivePulselLength) - (str2num(ChannelData.Transducer.EquivalentBeamAngle) + 20*log10(str2num(ChannelData.Transducer.Frequency)/ParameterData.frequencyCenter));
    
    
    % Create ProcessedSampleData structure
    ProcessedSampleData.range           = rangeVector;
    ProcessedSampleData.power           = PowerAngleData.power;
    ProcessedSampleData.alongship       = PowerAngleData.alongship  / (str2num(ChannelData.Transducer.AngleSensitivityAlongship) * ParameterData.frequencyCenter/str2num(ChannelData.Transducer.Frequency));
    ProcessedSampleData.athwartship     = PowerAngleData.athwartship  / (str2num(ChannelData.Transducer.AngleSensitivityAthwartship) * ParameterData.frequencyCenter/str2num(ChannelData.Transducer.Frequency));
    ProcessedSampleData.spRange         = rangeVector;
    ProcessedSampleData.sp              = sp;
    ProcessedSampleData.svRange         = tvg20RangeVector;
    ProcessedSampleData.sv              = sv;
end