function [MotionData] = ReadMotionData(fileId)
%READMOTIONDATA Read EK80 raw Motion datagram
%
% CALL: [MotionData] = ReadMotionData(fileId)
%
% Inputs:
%   fileId     = 
%
% Outputs:
%   MotionData = 
%
% Description:
%
%
%
% Examples(s):
%   [MotionData] = ReadMotionData(fileId)
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

MotionData.heave    = fread(fileId,1,'float32');
MotionData.roll     = fread(fileId,1,'float32');
MotionData.pitch    = fread(fileId,1,'float32');
MotionData.heading  = fread(fileId,1,'float32');
