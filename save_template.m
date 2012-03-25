prefix = 'testfile';
nummern = linspace(1,10,10)';
date = datestr(now,'yyyy-mm-dd-HH-MM-SS');
filename = strcat(prefix,'_',int2str(nummern(1)),'_',date)
save(filename)