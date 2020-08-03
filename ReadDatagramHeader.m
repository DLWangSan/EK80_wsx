function [DatagramHeader] = ReadDatagramHeader(fileId)
%READDATAGRAMHEADER Read EK80 Raw Datagram Header
%
% CALL: [DatagramHeader] = ReadDatagramHeader(fileId)
%
% Inputs:
%   fileId         = 
%
% Outputs:
%   DatagramHeader = 
%
% Description:
%
%
%
% Examples(s):
%   [DatagramHeader] = ReadDatagramHeader(fileId)
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

DatagramHeader.type = char(fread(fileId,4,'char')');

lowDateTime     = fread(fileId,1,'uint32');
highDateTime    = fread(fileId,1,'uint32');

DatagramHeader.dateTime = NTTime2Mlab(highDateTime*2^32 + lowDateTime);
