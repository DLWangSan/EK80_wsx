function [spFigureHandle,svFigureHandle] = CreateEchograms(BasicProcessedData)
%CREATEECHOGRAMS Create echograms from EK80 raw data
%
% CALL: [spFigureHandle,svFigureHandle] = CreateEchograms(BasicProcessedData)
%
% Inputs:
%   BasicProcessedData = 
%
% Outputs:
%   spFigureHandle     = 
%   svFigureHandle     = 
%
% Description:
%
%
%
% Examples(s):
%   [spFigureHandle,svFigureHandle] = CreateEchograms(BasicProcessedData)
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
nargoutchk(0,2);

% Echogram parameters
promptText      = {'Range [m]:','Range resolution [m]:','Minimum colour scale threshold [dB]:','Maximum colour scale threshold [dB]:'};
dialogTitle     = 'Echogram settings';
defaultValues   = {'500','1e-3','-70','-30'};
answer          = inputdlg(promptText,dialogTitle,1,defaultValues);

rangeEchogram               = str2num(answer{1});
rangeResolutionEchogram     = str2num(answer{2});
colorMinimum                = str2num(answer{3});
colorMaximum                = str2num(answer{4});

colorLimits     = [colorMinimum colorMaximum];

% 最大像素 = 深度/回声分辨率 并向着正无穷方向取整
maxRangePixels  = ceil(rangeEchogram/rangeResolutionEchogram);
rangeVector     = (0:maxRangePixels-1) * rangeResolutionEchogram;

nFiles      = size(BasicProcessedData,1);
nChannels   = size(BasicProcessedData,2);

for channelNumber = 1:nChannels,
    totalPingNumber = 0;
    for fileNumber = 1:nFiles,
        ProcessedSampleData = BasicProcessedData(fileNumber,channelNumber).ProcessedSampleData;
        nPings = length(ProcessedSampleData);

        for pingNumber = 1:nPings,
            if (~isempty(ProcessedSampleData(pingNumber).spRange))
                totalPingNumber = totalPingNumber+1;

                % Sp
                spRange = ProcessedSampleData(pingNumber).spRange;
                sp      = ProcessedSampleData(pingNumber).sp;

                spInterpolated = interp1(spRange,sp,rangeVector);
                spMatrix(1:maxRangePixels,totalPingNumber,channelNumber) = spInterpolated;

                % Sv
                svRange = ProcessedSampleData(pingNumber).svRange;
                sv      = ProcessedSampleData(pingNumber).sv;

                svInterpolated = interp1(svRange,sv,rangeVector);
                svMatrix(1:maxRangePixels,totalPingNumber,channelNumber) = svInterpolated;
            end
        end
        disp(['Finished processing file ' int2str(fileNumber) ' of ' int2str(nFiles) ' files for channel number ' int2str(channelNumber) ' of ' int2str(nChannels) ' channels']);

    end
    pingNumberVector = 1:totalPingNumber;

    % Sp
    spFigureHandle(channelNumber) = figure;
    imagesc(pingNumberVector,rangeVector,spMatrix(:,:,channelNumber),colorLimits);
    echogramColorMap = colormap(jet);
    echogramColorMap(1,:) = [1 1 1];
    colormap(echogramColorMap);
    colorbar
    titleText = ['Sp for ' BasicProcessedData(1,channelNumber).ChannelData.ChannelIdShort];
    title(titleText)

    % Sv
    svFigureHandle(channelNumber) = figure;
    imagesc(pingNumberVector,rangeVector,svMatrix(:,:,channelNumber),colorLimits);
    echogramColorMap = colormap(jet);
    echogramColorMap(1,:) = [1 1 1];
    colormap(echogramColorMap);
    colorbar
    titleText = ['Sv for ' BasicProcessedData(1,channelNumber).ChannelData.ChannelIdShort];
    title(titleText)


end
