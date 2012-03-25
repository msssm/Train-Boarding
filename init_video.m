% initialising terms for capturing an avi-file
if video_mode == videoON

    avi_file_prefix = 'video_';
    avi_file_date = datestr(now, 'yyyy-mm-dd-HH-MM-SS');
    avi_file_suffix ='.avi';

    avi_filename = strcat(avi_file_dir, avi_file_prefix, avi_file_date, ...
        '_', avi_file_specs, avi_file_suffix)

    aviobj = avifile(avi_filename);
    aviobj.fps = 20;    % Because we simulate with dt = 0.05s
    aviobj.compression = 'Cinepak';
    aviobj.quality = 60; % percent

end