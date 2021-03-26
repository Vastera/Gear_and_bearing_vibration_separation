function out = DRS(sig,L,delta,varargin)
% Copyright@ vastera@163.com
% General introduction:Discrete / random separation method in the paper 'Unsupervised noise cancellation for vibration % signals: part II—a novel frequency-domain algorithm'  
% Used to separate the bearing vibration (random) from the signal corrputed by gear vibration (discrete)
%% ====================== INPUT ========================
% sig:          Type:vector
%                           sig description:original signal
% L:      Type: integer
%                            L description: length of each signal sequence
% delta       Type: integer
%                           delta Description: time delay (samples)
%% ====================== OPTIONAL ARGUMENTS =================
% K:           Type: integer (default=2)
%                            k Description: dividend factor of window
%
%% ====================== OUTPUT =======================
% out:          Type:vector with the same size as sig
%                           out description:The bearing vbiration part of the signal
%% =====================================================
narginchk(3, 4);
k=2;
if nargin>=4
    k=varargin{1};
end
if ~iscolumn(sig)
    sig=sig';
end
Len = length(sig);% total length of signal
N = floor((Len-delta-L)/L);% the total number of segments
Numerator=zeros(L,1);
Denominator=zeros(L,1);
for m=1:N
    x = sig(delta+m*L+(1:L)).*parzenwin(L); % one segement without delay
    wb = round(L/k);% shorted length of segments
    if rem(L,2) == 0 % L is even
        dstart = L / 2 + (m - 1) * L - floor(wb/2);% segement start point of delay segments
    else % L is odd
        dstart = (L + 1) / 2 + (m - 1) * L - floor(wb/2);
    end
    xd = sig(dstart+(1:wb)).*parzenwin(wb);
    X = fft(x,L);
    XD = fft(xd,L);% padding zero to make XD long as the X
    Numerator = Numerator+X.*conj(XD);
    Denominator = Denominator+XD.*conj(XD);
end
H=Numerator./Denominator/k;
% plot(ifft(H));
gear=conv(sig,ifft(H),'same');% gear(deterministic) part of the signal
out=sig-gear;
end