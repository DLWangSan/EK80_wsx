function [BasicProcessedData] = BasicProcessData(RawData)
%BASICPROCESSDATA Perform basic processing of EK80 raw data.
%
% CALL: [BasicProcessedData] = BasicProcessData(RawData)
%
% Inputs:
%   RawData            = 
%
% Outputs:
%   BasicProcessedData = 
%
% Description:
%
%
%
% Examples(s):
%   [BasicProcessedData] = BasicProcessData(RawData)
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

nFiles = length(RawData);

for fileNumber = 1:nFiles,
    FileData    = RawData(fileNumber).Data;
    PingData    = FileData.PingData;
    nChannels   = size(PingData,1);
    nPings      = size(PingData,2);
    
     for channelNumber = 1:nChannels,
        ChannelData = GetChannelData(FileData.ConfigurationData,channelNumber);
        ChannelData.FilterData = FileData.FilterData(channelNumber,:);
        
        ProcessedSampleDataVector = struct('range',[],'power',[],'alongship',[],'athwartship',[],'spRange',[],'sp',[],'svRange',[],'sv',[]);

        for pingNumber = 1:nPings,
                ProcessedSampleData = EstimateProcessedSampleData(ChannelData,PingData(channelNumber,pingNumber));
                ProcessedSampleDataVector(pingNumber) = ProcessedSampleData;
        end
        BasicProcessedData(fileNumber,channelNumber).ChannelData            = ChannelData;
        BasicProcessedData(fileNumber,channelNumber).ProcessedSampleData    = ProcessedSampleDataVector;

    end
    disp(['Finished processing file ' int2str(fileNumber) ' of ' int2str(nFiles)]);
end

end


function ChannelData = GetChannelData(ConfigurationData,channelNumber)

Transceivers = ConfigurationData.Transceivers;
nTransceivers = length(Transceivers);
for transceiverNumber = 1:nTransceivers,
    CurrentTransceiver = Transceivers(transceiverNumber);
    ChannelsInTransceiver = CurrentTransceiver.Channels;
    nChannelsInTransceiver = length(ChannelsInTransceiver);
    for channelInTransceiverNumber = 1:nChannelsInTransceiver,
        CurrentChannelInTransceiver = ChannelsInTransceiver(channelInTransceiverNumber);
        % if (str2double(CurrentTransceiver.TransceiverNumber) - channelNumber == 0)
        if 1
            ChannelData = CurrentChannelInTransceiver;
            ChannelData.TransceiverType = CurrentTransceiver.TransceiverType;
        end
    end
end

end
    

    

    
    
    
    