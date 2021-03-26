%% generate simulated signal
fs=1;T=2e5;
x=simulated_signal(fs,T);
% x=inner;
% fs=20480;T=55;
% x=y(1:fs*T);
close all;
%% apply SANC method as baseline
L=512;mu=0.5;delta=5;
out = sanc(x,L,mu,delta);
figure('Name','Orignal spectrum');
[y0,f]=MyFFT(x,fs);
y=MyFFT(out.filteredSignal,fs);
plot(f,y0);
figure('Name','SANC method');
plot(f,y);
% figure('Name','SANC window');
% plot(out.weight);
%% check DSR method 
out2=DRS(x,round(fs/0.2*2000),fs/0.2*20);
y1=MyFFT(out2,fs);
figure('Name','DSR method');
plot(f,y1);
figure('Name','Gear Part');
plot(f,MyFFT(x-out2',fs));
%%
% [f_c,f_p_s,f_i,f_o,f_cg,f_b,f_m,f_sf,f_pf,f_rf] = CharacteristicFreq(6.5,36,35,108,3,0.0035,0.0195,10);
%% bearing vibration signal with slippages
T=1000;fs=2^11;fn=500;
bearing_sig=Bearing_vibration(fs,T,22,fn);
t=1/fs:1/fs:T;
% plot(t,sig);
% xlim([0 0.5]);
% Draw(sig,fs,2);
%% gear vibration signal part
gear_sig=0.1*sin(2*pi*150*t)+0.1*sin(2*pi*300*t);
%% test DRS method to exact bearing impulses
sig=bearing_sig+gear_sig';
out3=DRS(sig,round(fs*2),fs*2);
[y1,f]=MyFFT(out3,fs);
figure('Name','DSR method');
plot(f,y1);