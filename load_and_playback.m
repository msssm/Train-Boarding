% playback saved simulation keyframes in real time
    init_style
for i = 1:round(tmax/save_dt)
    filename = strcat(save_file_prefix,num2str(i*(round(save_dt/dt))),save_file_suffix)
    load(filename)
    plotting_mode = plotMAPview;
    paint
    pause(save_dt)
end
    