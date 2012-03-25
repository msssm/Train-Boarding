% add picture to video
if video_mode == videoON

    new_Frame = getframe(my_figure);
    aviobj = addframe(aviobj, new_Frame);

    if t == tmax
        aviobj = close(aviobj);
    end

end