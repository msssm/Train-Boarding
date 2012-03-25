% setup of special behaviour (non test case specific options, like movie output, save paths and plotting mode)

% plotting mode
plotting_mode = plotMAPview;
% plotting_mode = plotGRAPHview;
% plotting_mode = plotDEFAULT;
if plotting_mode ~= plotDEFAULT
    my_figure = figure('Position', [20, 100, 1200, 600], 'Name','Simulation Plot Window');
end

% video recording
%video_mode = videoON;
video_mode = videoOFF;
avi_file_dir = 'results/movies/';
avi_file_specs = strcat('simulation-',int2str(Testcase),'-',int2str(isample),'-');

init_video


% Data Export Mode Configuration
data_export_mode = data_export_OFF;
save_dt = 0.5;
save_file_prefix = strcat('results/frames/simulation-',int2str(Testcase),'-',int2str(isample),'-');
save_file_suffix = '.mat';
