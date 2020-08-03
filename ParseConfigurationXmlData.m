function [ConfigurationData] = ParseConfigurationXmlData(XmlData)
%PARSECONFIGURATIONXMLDATA Parse EK80 raw Configuration XML0 datagram
%
% CALL: [ConfigurationData] = ParseConfigurationXmlData(XmlData)
%
% Inputs:
%   XmlData    = 
%
% Outputs:
%   ConfigurationData = 
%
% Description:
%
%
%
% Examples(s):
%   [ConfigurationData] = ParseConfigurationXmlData(XmlData)
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

% Header

headerIndex = find(strcmp({XmlData.Children.Name},'Header'));
HeaderXml = XmlData.Children(headerIndex);

nAttributes = length(HeaderXml.Attributes);

for i = 1:nAttributes,
    [value, status] = str2num(HeaderXml.Attributes(i).Value);
    if status
        Header.(HeaderXml.Attributes(i).Name) = value;
    else
        Header.(HeaderXml.Attributes(i).Name) = HeaderXml.Attributes(i).Value;
    end
end

transceiversIndex = find(strcmp({XmlData.Children.Name},'Transceivers'));
TransceiversXml = XmlData.Children(transceiversIndex);

nTransceivers = length(TransceiversXml.Children);

for i = 1:nTransceivers,
   TransceiverXml = TransceiversXml.Children(i);
   Transceivers(i).id =  TransceiverXml.Name;
   nAttributes = length(TransceiverXml.Attributes);
   for j = 1:nAttributes,
       [value, status] = str2num(TransceiverXml.Attributes(j).Value);
       if status
           Transceivers(i).(TransceiverXml.Attributes(j).Name) = value;
       else
           Transceivers(i).(TransceiverXml.Attributes(j).Name) = TransceiverXml.Attributes(j).Value;
       end
   end
   
   ChannelsXml = TransceiverXml.Children;
   nChannels = length(ChannelsXml.Children);
   Channels = [];
   for j = 1:nChannels,
       ChannelXml = ChannelsXml.Children(j);
       Channels(j).Name = ChannelXml.Name;
       nAttributes = length(ChannelXml.Attributes);
       for k = 1:nAttributes,
           Channels(j).(ChannelXml.Attributes(k).Name) = ChannelXml.Attributes(k).Value;
       end
       
       Transducer = [];
       TransducerXml = ChannelXml.Children;
       nAttributes = length(TransducerXml.Attributes);
       for m = 1:nAttributes,
           Transducer.(TransducerXml.Attributes(m).Name) = TransducerXml.Attributes(m).Value;
       end
       Channels(j).Transducer = Transducer;
   end
   Transceivers(i).Channels = Channels;
end  

ConfigurationData.Header = Header;
ConfigurationData.Transceivers = Transceivers;

return

% Header
config.header.TimeBias = str2num(ConfigurationData.header.TimeBias);

% Transceivers
for i = 1:nTransceivers,
    config.transceivers(i).SerialNumber = str2num(ConfigurationData.transceivers(i).SerialNumber);
    nChannels = length(ConfigurationData.transceivers(i).channels);
    Channels = [];
    for j = 1:nChannels,
        Channels(j).ChannelId          = ConfigurationData.transceivers(i).channels(j).ChannelID;
        Channels(j).TransceiverType    = ConfigurationData.transceivers(i).TransceiverType;
%        channels(j).ChannelId = configxml.transceivers(i).channels(j).ChannelIdLong;
        Transducer = [];
        Transducer.AngleSensitivityAlongship    = str2num(ConfigurationData.transceivers(i).channels(j).transducer.AngleSensitivityAlongship);
        Transducer.AngleSensitivityAthwartship  = str2num(ConfigurationData.transceivers(i).channels(j).transducer.AngleSensitivityAthwartship);
        Transducer.BeamWidthAlongship           = str2num(ConfigurationData.transceivers(i).channels(j).transducer.BeamWidthAlongship);
        Transducer.BeamWidthAthwartship         = str2num(ConfigurationData.transceivers(i).channels(j).transducer.BeamWidthAthwartship);
        Transducer.EquivalentBeamAngle          = str2num(ConfigurationData.transceivers(i).channels(j).transducer.EquivalentBeamAngle);
        Transducer.Frequency                    = str2num(ConfigurationData.transceivers(i).channels(j).transducer.Frequency);
        Transducer.Gain                         = str2num(ConfigurationData.transceivers(i).channels(j).transducer.Gain);
        Transducer.TransducerName               = ConfigurationData.transceivers(i).channels(j).transducer.TransducerName;
        Channels(j).transducer = Transducer;
    end
    config.transceivers(i).channels = Channels;
end