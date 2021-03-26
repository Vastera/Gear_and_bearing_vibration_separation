% %% simulated signal test
% fs=1024;
% t=1/fs:1/fs:10;
% x=sin(2*t);
% plot(t,x);
% figure('Name','Acceleration');
% hold on;
% plot(t,x);
% plot(t,FDM_2_4(x,fs));
%% experiment data test
[encoder,fs]=LoadData;
phase = BiChannels2Phase(encoder);
v0=LPD(phase,5,fs)/5000;
phase0=phase(1:end-10);
v1=interp1(phase0,v0,linspace(phase0(1),phase0(end),length(phase0)),'spline');
accel = FDM_2_4(phase0,fs);
%% accleartion (FDM)
prewhiten_accel =cepstrum_prewhiten(envelope(accel),fs);
Draw(prewhiten_accel,fs,1);
xlim([0 100]);
%% velocity KPLD
prewhiten_v =cepstrum_prewhiten(v1,fs);
Draw(prewhiten_v,fs,2);
xlim([0 100]);