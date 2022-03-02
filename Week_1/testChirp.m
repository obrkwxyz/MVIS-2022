fs = 1e3;
t = 0:1/fs:20;
f_u = 1000;
f_l = 10;

y = chirp(t,f_u,4,f_l,'linear');
pspectrum(y,1e3,'spectrogram','TimeResolution',0.1, ...
    'OverlapPercent',99,'Leakage',0.85)
sound(y)