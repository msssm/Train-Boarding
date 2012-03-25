 % save current workspace to file if activated
 if data_export_mode == data_export_ON
     if (mod(step,round(save_dt/dt)) == 0)
        save(strcat(save_file_prefix,int2str(step),save_file_suffix))
     end
 end
