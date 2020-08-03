function [EnvironmentData] = ParseEnvironmentXmlData(XmlData,EnvironmentData)
%PARSEENVIRONMENTXMLDATA Parse EK80 raw Environment XML0 datagram
%
% CALL: [EnvironmentData] = ParseEnvironmentXmlData(XmlData,EnvironmentData)
%
% Inputs:
%   XmlData         = 
%   EnvironmentData = Previous Environment Data
% Outputs:
%   EnvironmentData = Updated Enviroment Data
%
% Description:
%
%
%
% Examples(s):
%   [EnvironmentData] = ParseEnvironmentXmlData(XmlData,EnvironmentData)
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

nAttributes = length(XmlData.Attributes);

for i = 1:nAttributes,
    EnvironmentXmlData.(XmlData.Attributes(i).Name) = XmlData.Attributes(i).Value;
end

if isfield(EnvironmentXmlData,'Temperature'),    EnvironmentData.temperature     = str2num(EnvironmentXmlData.Temperature);  end
if isfield(EnvironmentXmlData,'Salinity'),       EnvironmentData.salinity        = str2num(EnvironmentXmlData.Salinity);     end
if isfield(EnvironmentXmlData,'Depth'),          EnvironmentData.depth           = str2num(EnvironmentXmlData.Depth);        end
if isfield(EnvironmentXmlData,'Acidity'),        EnvironmentData.acidity         = str2num(EnvironmentXmlData.Acidity);      end
if isfield(EnvironmentXmlData,'SoundSpeed'),     EnvironmentData.soundSpeed      = str2num(EnvironmentXmlData.SoundSpeed);   end