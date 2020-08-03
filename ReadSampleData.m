function [SampleData] = ReadSampleData(fileId,rawType)
%READSAMPLEDATA Read EK80 raw Sample datagram
%
% CALL: [SampleData] = ReadSampleData(fileId,rawType)
%
% Inputs:
%   fileId     = 
%   rawType    =
%
% Outputs:
%   SampleData = 
%
% Description:
%
%
%
% Examples(s):
%   [SampleData] = ReadSampleData(fileId,rawType)
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

SampleData.channelId                = char(fread(fileId,128,'char')');
SampleData.modeLow                  = fread(fileId,1,'int8');
SampleData.modeHigh                 = fread(fileId,1,'int8');
SampleData.mode                     = 256*SampleData.modeHigh + SampleData.modeLow;
SampleData.spare1                   = char(fread(fileId,2,'char')');
SampleData.offset                   = fread(fileId,1,'int32');
SampleData.count                    = fread(fileId,1,'int32');

if (SampleData.modeLow<4)
    power                           = fread(fileId,SampleData.count,'int16');
    SampleData.power                = power*10*log10(2)/256;
    if (SampleData.modeLow==3)
        angle                       = fread(fileId,[2 SampleData.count],'int8');
        SampleData.angle            = angle(1,:) + angle(2,:)*256;
        SampleData.angleAlongship   = angle(2,:)';
        SampleData.angleAthwartship = angle(1,:)';
    end
elseif (SampleData.modeLow==8)
    nComplexValues                  = SampleData.modeHigh;
    complexSamples                  = fread(fileId,2*nComplexValues*SampleData.count,'float32=>single');
    complexSamples                  = reshape(complexSamples,[2 nComplexValues SampleData.count]);
    SampleData.complexSamples       = (squeeze(complex(complexSamples(1,:,:),complexSamples(2,:,:)))).';
else
    error('Unknown sample mode');
end
