function sig=Bearing_vibration(fs,T,fg,fn,varargin)
% Copyright@ vastera@163.com
% General introduction:generate a bearing vibration signal
%% ====================== INPUT ========================
% fs:          Type:integer
%                           fs description: Sampling frequency
%
% T:          Type:double
%               T description: total duration
%
% fg:          Type:double
%                 fg description: characteristic frequency of bearing fault (impulsive frequency)
%
% fn:           Type:double
%                   fn description: natural frequency of system
% ---------------------OPTIONAL:
% sigma:                Type:double range is (0,1); (default=0.01)
%                           sigma description: slippage factor (variance of impulsive interval, which subject to 
%                                              Gaussian distribution)
% beta:                 Type: double (default=200)
%                           beta description: damping factor
%% ====================== OUTPUT =======================
% sig:          Type:Vector with the length of T*fs
%                           sig description: the generated bearing vibration signal
%% =====================================================
narginchk(4,5);
sigma = 0.02;
if nargin>=5
    sigma=varargin{1};
end
beta=200;
if nargin>=6
    beta=varargin{2};
end
Tg=1/fg;% expected impulsive interval
Len=T*fs;
interval=normrnd(Tg,Tg*sigma,round(T/Tg*1.5),1);
if sum(interval)<=T
    interval = AppendInterval(interval);
end
i_interval=1;
T_current=interval(i_interval);
sig=zeros(Len,1);
while T_current<T
    sig(round(T_current*fs))=1;
    i_interval=i_interval+1;
    T_current=T_current+interval(i_interval);
end
t=1/fs:1/fs:T/10;
NaturalVib = exp(-beta*t).*sin(2*pi*fn*t);
sig=conv(sig,NaturalVib,'same');
function interval = AppendInterval(interval)%% append the interval if the total length sum is less than the Duration
    interval=[interval;normrnd(Tg,Tg*sigma,round(T/Tg*0.5)),1];
    if sum(interval)<=T
        interval = AppendInterval(interval);
    end
end
end
