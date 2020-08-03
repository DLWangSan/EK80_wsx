function [currentData] = ExtractCurrentData(FilterData,ParameterData,SampleData)
%EXTRACTCURRENTDATA Extracts transmit current sample data from sample data
%
% CALL: [currentData] = ExtractCurrentData(FilterData,ParameterData,SampleData)
%
% Inputs:
%   FilterData    =
%   ParameterData = 
%   SampleData    = 
%
% Outputs:
%   currentData   = 
%
% Description:
%
%
%
% Examples(s):
%   [currentData] = ExtractCurrentData(FilterData,ParameterData,SampleData)
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

narginchk(3,3);
nargoutchk(0,1);

nCurrentSamples = floor(ParameterData.pulseLength/ParameterData.sampleInterval + ...
    FilterData(1).nCoefficients/(FilterData(1).decimationFactor*FilterData(2).decimationFactor) +  FilterData(2).nCoefficients/FilterData(2).decimationFactor);

nChannels = size(SampleData.complexSamples,2);
for channelNumber = 1:nChannels,
    currentReal(:,channelNumber)        = typecast(bitshift(typecast(real(SampleData.complexSamples(1:nCurrentSamples,channelNumber)),'uint32'),16),'single');
    currentImaginary(:,channelNumber)   = typecast(bitshift(typecast(imag(SampleData.complexSamples(1:nCurrentSamples,channelNumber)),'uint32'),16),'single');
end

currentData = complex(currentReal,currentImaginary);