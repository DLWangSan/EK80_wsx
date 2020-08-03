% EK80EXAMPLE Example of reading and processing EK80 raw data
%
% Description:
%
%
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



% Read EK80 Raw data files
[RawData] = ReadEK80Data;

% Perform basic processing of the raw complex sample data
[BasicProcessedData] = BasicProcessData(RawData);

% Create and display simple Sv and Sp echograms
[spFigureHandle,svFigureHandle] = CreateEchograms(BasicProcessedData);
