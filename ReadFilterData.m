function [FilterData] = ReadFilterData(fileId)
%READFILTERDATA Read filterdatagram in EK80 raw file 
%
% CALL: [FilterData] = ReadFilterData(fileId)
%
% Inputs:
%   fileId     = 
%
% Outputs:
%   FilterData = 
%
% Description:
%
%
%
% Examples(s):
%   [FilterData] = ReadFilterData(fileId)
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

FilterData.stage = fread(fileId,1,'int16');

FilterData.channelNumber = fread(fileId,1,'int16');

FilterData.channelId = char(fread(fileId,128,'char')');

FilterData.nCoefficients = fread(fileId,1,'uint16');
FilterData.decimationFactor = fread(fileId,1,'uint16');

coefficients = fread(fileId,2*FilterData.nCoefficients,'float32=>single');
coefficients = reshape(coefficients,[2 FilterData.nCoefficients]);
coefficients = (squeeze(complex(coefficients(1,:),coefficients(2,:)))).';

FilterData.coefficients = coefficients;

