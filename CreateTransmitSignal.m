function [transmitSignal] = CreateTransmitSignal(PingData)
%CREATETRANSMITSIGNAL Create EK80 transmit signal
%
% CALL: [transmitSignal] = CreateTransmitSignal(PingData)
%
% Inputs:
%   PingData        = 
%
% Outputs:
%   transmitSignal = 
%
% Description:
%
%
%
% Examples(s):
%   [transmitSignal] = CreateTransmitSignal(PingData)
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

narginchk(1,1);
nargoutchk(0,1);

sampleFrequency     = 1.5e6;


FilterData      = PingData.FilterData;
ParameterData   = PingData.ParameterData;

% Time vector

nSamples = floor(ParameterData.pulseLength*sampleFrequency);
timeVector  = 1/sampleFrequency*(0:nSamples-1)';

% Shaping

nShapingSamples = floor(ParameterData.slope*nSamples);
windowFunction  = hann(2*nShapingSamples);
shapingWindow   = [windowFunction(1:nShapingSamples); ones(nSamples-2*nShapingSamples,1); windowFunction(nShapingSamples+1:end)];

transmitSignal = chirp(timeVector,ParameterData.frequencyStart,ParameterData.pulseLength,ParameterData.frequencyStop).*shapingWindow;
 
% FPGA and PC Filters and decimation

for filterStage = 1:2,
    transmitSignal  = conv(transmitSignal,FilterData(filterStage).coefficients);
    transmitSignal  = downsample(transmitSignal,FilterData(filterStage).decimationFactor);
end

end
