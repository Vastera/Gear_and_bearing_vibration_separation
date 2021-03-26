[baseline,fs]=LoadData;
addpath('D:\Study and Research\comeon!\My Papers\Encoder Signal\KLPD');
addpath('D:\Study and Research\comeon!\My Papers\Encoder Signal');
phase=BiChannels2Phase(Baseline_encoder);
v0=LPD(phase,5,fs)/5000;
phase0=phase(1:end-10);
v1=interp1(phase0,v0,linspace(phase0(1),phase0(end),length(phase0)),'spline');
v=resample(v1,20480,fs);fs=20480;
[y0,f]=MyFFT(detrend(envelope(v)),fs);

% figure('Name','Original signal');
% plot(f,y0);xlim([2 1000]);
out=DRS(detrend(v),round(length(v)/6),round(length(v)/6));
[y1,f]=MyFFT(envelope(out),fs);
figure('Name','DRS method');
plot(f,y0,'b',f,y1,'r');xlim([1 100]);
[f_c,f_p_s,f_i,f_o,f_cg,f_b,f_m,f_sf,f_pf,f_rf] = CharacteristicFreq(6.5,36,35,108,3,0.0035,0.0195,10);
%% vibration signal validation using DRS method
phase=BiChannels2Phase(Inner_encoder);
phase=resample(phase,20480,102400);fs=20480;
range=1:1220000;
v0=LPD(phase,5,fs)/5000;
x1=interp1(phase(range),v0(range),linspace(phase(1),phase(1220000),1220000),'spline');
[y0,f]=MyFFT(detrend(x1),fs);
out=DRS(detrend(x1),round(length(x1)/5),round(length(x1)/5));
[y1,f]=MyFFT(detrend(out),fs);
figure('Name','vibratiohn DRS method')
plot(f,y0,f,y1);xlim([0 100]);
%% cepstrum method using encoder signal
phase=BiChannels2Phase(Inner_encoder);
phase=resample(phase,20480,102400);fs=20480;
range=1:1220000;
v0=LPD(phase,5,fs)/5000;
x1=interp1(phase(range),v0(range),linspace(phase(1),phase(1220000),1220000),'spline');
[y0,f]=MyFFT(detrend(x1),fs);
out3=cepstrum_prewhiten(x1,fs);
[y2,f]=MyFFT(detrend(out3),fs);
figure('Name','cepstrum method')
plot(f,y0,f,y2);xlim([0 100]);
Draw(out3,fs,2);