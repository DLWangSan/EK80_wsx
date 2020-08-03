function [xmlData] = ReadXmlData(fileId,contentLength)
%READXMLDATA Read EK80 raw XML datagram
%
% CALL: [xmlData] = ReadXmlData(fileId,contentLength)
%
% Inputs:
%   fileId        = 
%   contentLength = 
%
% Outputs:
%   xmlData       = 
%
% Description:
%
%
%
% Examples(s):
%   [xmlData] = ReadXmlData(fileId,contentLength)
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

textData = char(fread(fileId,contentLength,'char')');

[parseResult,p] = xmlreadstring(deblank(textData));

xmlData = parseResult;
