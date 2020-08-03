function [RawData] = ReadEK80Data
%READEK80RAWFILES Read EK80 Data
%
% CALL: [RawData] = ReadEK80Data
%
% Outputs:  
%   RawData = 
%
% Description:
%
%
%x
% Examples(s):
%   [RawData] = ReadEK80Data
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
nargoutchk(0,1);

defaultPath = 'C:\Installations\EK80 Installation\Example Data';
%defaultPath = 'C:\Users\Public\Documents\Simrad\EK80\Data';

% Select raw data files
[fileNameList,filePath,~] = uigetfile('*.raw','Select raw files','MultiSelect','on',defaultPath);
if ~iscell(fileNameList)
    fileNameList = {fileNameList};
end
nFiles = length(fileNameList);

% Read raw data files
for fileNumber = 1:nFiles,
    fileName = fullfile(filePath,fileNameList{fileNumber});
    
    %%%%%%%%%%%%%%%%%%%
    % Read "npingsmax" pings from file "filename"
    
    RawData(fileNumber).Data = ReadEK80RawFile(fileName);
    disp(['Finished reading file ' int2str(fileNumber) ' of ' int2str(nFiles)]);
end

