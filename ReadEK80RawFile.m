
function [RawData] = ReadEK80RawFile(fileName)
%READEK80RAWFILE Reads an EK80 raw data file
%
% CALL: [RawData] = ReadEK80RawFile(fileName)
%
% Inputs:
%   fileName = 
%
% Outputs:
%   RawData  = 
%
% Description:
%
%
%
% Examples(s):
%   [RawData] = ReadEK80RawFile(fileName)
%

% References:
%
%
% Created by Lars Nonboe Andersen
% Perfected by Wangshuxian(last changed 20200727)
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

% 控制输入输出
narginchk(1,1);
nargoutchk(0,1);

fileId = fopen(fileName,'r');

headerLength = 12; % Bytes in datagram header

pingNumber      = 0;
pingTime        = 0;
EnvironmentData = struct;
FilterData      = struct;
MotionData      = struct;

i  = 0;
if (fileId==-1)
    error(['Could not open file: ' fileName]);
else

    while(1)
        i= i+1;
%        datagramLength = fread(fileId,1, 'int32');
        datagramLength = fread(fileId, [1,1], 'int32');

%         disp(datagramLength)

        if (feof(fileId))
            disp(i)
            break
        end
        
        DatagramHeader = ReadDatagramHeader(fileId);
        
        switch (DatagramHeader.type)
            
            case 'XML0' % XML datagram
                XmlDataUnparsed = ReadXmlData(fileId,datagramLength-headerLength);
                XmlData = ParseXmlData(XmlDataUnparsed);

                switch (XmlData.Name)
                    case 'Configuration' % Configuration XML data
                        ConfigurationData           = ParseConfigurationXmlData(XmlData);
                        RawData.ConfigurationData   = ConfigurationData;
                        
                    case 'Environment' % Environment XML data
                        EnvironmentData = ParseEnvironmentXmlData(XmlData,EnvironmentData);
                        
                    case 'Parameter' % Sampledata parameter data
                        ParameterData = ParseParameterXmlData(XmlData);

                    otherwise
                        error(['Unknown XML datagram in file: ' fileName]);
                end
                
            case 'FIL1' % Filter datagram
                FilterData = ReadFilterData(fileId);

                Channels        = [ConfigurationData.Transceivers(:).Channels];
                channelNumber   = strcmp(deblank(FilterData.channelId),{Channels.ChannelID});
                
                FilterDataVector(channelNumber,FilterData.stage) = FilterData;
                
                RawData.FilterData = FilterDataVector;
                
            case 'NME0' % NMEA datagram
                NmeaData = ReadTextData(fileId,datagramLength-headerLength);
                
            case 'TAG0' % Annotation datagram
                AnnotationData = ReadTextData(fileId,datagramLength-headerLength);
                
            case 'MRU0' % Motion data
                MotionData = ReadMotionData(fileId);
                
            case 'RAW3' % Sample datagram
                
                if (DatagramHeader.dateTime~=pingTime)
                    pingTime    = DatagramHeader.dateTime;
                    pingNumber  = pingNumber+1;
                end
                
                SampleData = ReadSampleData(fileId,DatagramHeader.type);

                Channels        = [ConfigurationData.Transceivers(:).Channels];
                channelNumber   = strcmp(deblank(SampleData.channelId),{Channels.ChannelID});

                % Extract current samples from LSB of voltage samples
                currentData             = ExtractCurrentData(FilterDataVector(channelNumber,:),ParameterData,SampleData);
                SampleData.currentData  = currentData;

                PingData.time               = pingTime;
                PingData.fileName           = fileName;
                PingData.EnvironmentData    = EnvironmentData;
                PingData.MotionData         = MotionData;
                PingData.FilterData         = FilterDataVector(channelNumber,:);
                PingData.ParameterData      = ParameterData;
                PingData.SampleData         = SampleData;
                
                RawData.PingData(channelNumber,pingNumber) = PingData;
                
            otherwise
                error(strcat('Unknown datagram ''',DatagramHeader.type,''' in file'));
        end
        
%        datagramLength = fread(fileId,1,'int32');
        datagramLength = fread(fileId,1, 'int32');

    end
    
    fclose(fileId);
end


end


