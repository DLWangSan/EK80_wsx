function [ParameterData] = ParseParameterXmlData(XmlData)
%PARSEPARAMETERXMLDATA Parse EK80 raw Parameter XML datagrams
%
% CALL: [ParameterData] = ParseParameterXmlData(XmlData)
%
% Inputs:
%   XmlData       = 
%
% Outputs:
%   ParameterData = 
%
% Description:
%
%
%
% Examples(s):
%   [ParameterData] = ParseParameterXmlData(XmlData)
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

nAttributes = length(XmlData.Children.Attributes);

for i = 1:nAttributes,
    ParameterXmlData.(XmlData.Children.Attributes(i).Name) = XmlData.Children.Attributes(i).Value;
end

if isfield(ParameterXmlData,'ChannelID'),       ParameterData.channelId         = str2num(ParameterXmlData.ChannelID);          end
if isfield(ParameterXmlData,'ChannelMode'),     ParameterData.channelMode       = str2num(ParameterXmlData.ChannelMode);        end
if isfield(ParameterXmlData,'TransmitPower'),   ParameterData.transmitPower     = str2num(ParameterXmlData.TransmitPower);      end
if isfield(ParameterXmlData,'PulseForm'),       ParameterData.pulseForm         = str2num(ParameterXmlData.PulseForm);          end
if isfield(ParameterXmlData,'PulseLength'),     ParameterData.pulseLength       = str2num(ParameterXmlData.PulseLength);        end
if isfield(ParameterXmlData,'Slope'),           ParameterData.slope             = str2num(ParameterXmlData.Slope);              end
if isfield(ParameterXmlData,'FrequencyStart'),  ParameterData.frequencyStart    = str2num(ParameterXmlData.FrequencyStart);     end
if isfield(ParameterXmlData,'FrequencyEnd'),    ParameterData.frequencyStop     = str2num(ParameterXmlData.FrequencyEnd);       end
if isfield(ParameterXmlData,'SampleInterval'),  ParameterData.sampleInterval    = str2num(ParameterXmlData.SampleInterval);     end
if isfield(ParameterXmlData,'TransducerDepth'), ParameterData.transducerDepth   = str2num(ParameterXmlData.TransducerDepth);    end

if (isfield(ParameterXmlData,'FrequencyStart') && isfield(ParameterXmlData,'FrequencyEnd')), 
    ParameterData.frequencyCenter = (ParameterData.frequencyStart + ParameterData.frequencyStop) / 2;
end    
