function [signal]=simulated_signal(fs,T)
% Copyright@ vastera@163.com
% General introduction:generate the simulated signal for the functions of gear and bearing vibration separation.
%% ====================== INPUT ========================
% fs:          Type: Integer
%                           fs description:sampling frequency
%
% T:          Type: Integer
%                           T description:Duration time
% ---------------------OPTIONAL:
% optional arg:              Type:
%                            description:
%% ====================== OUTPUT =======================
% signal:          Type:vector
%                           signal description:simulated signal
%% =====================================================
t=1/fs:1/fs:T;
sinusoid=sin(2*pi*0.1*t)+sin(2*pi*0.14*t);
% sinusoid=sin(2*pi*0.1*t);
signal=awgn(sinusoid,-10);
end