function [prewhiten_sig]=cepstrum_prewhiten(sig,varargin)
% Copyright@ vastera@163.com
% General introduction:prewhiten the input signal to sweep out the gear vbiration part(deterministic) in the input signal.
%% ====================== INPUT ========================
% sig:          Type: vector
%                           sig description:input signal to be prewhitened
% ---------------------OPTIONAL:
% fs:              Type: integer (default=1)
%                            description:sampling frequency 
% freq_notch:          Type: vector
%                           sig description:frequency slices to remove from the real cepstrum
% df:              Type: double
%                             description: frequency space to be removed
%% ====================== OUTPUT =======================
% prewhiten_sig:          Type:vector with the same size as input signal
%                           prewhiten_sig description: prewhitened signal
%% =====================================================
narginchk(2,3);
fs=1;
if nargin>=2
    fs=varargin{1};
end
freq_notch=[];
if nargin>=3
    freq_notch=varargin{2};
end
df=0.01;
if nargin>=4
    df=varargin{3};
end
len=length(sig);
phase=angle(fft(sig));% phase angle of FFT of the signal
real_cepstrum=rceps(sig);
real_cepstrum=circshift(real_cepstrum,round(len/2));
f=linspace(-fs/2,fs/2,length(real_cepstrum));
if nargin<=2
    figure('Name','Real cepstrum of the input signal');
    plot(f,real_cepstrum);xlabel('Time [s]');ylabel('log amplitude')
    xlim([0 5]);
    input('Pick the frequencies to be removed, then press ''Enter'':');
    %% get the current cursor
    cursor_info=getCursorInfo(datacursormode(gcf));
    if isempty(cursor_info), msgbox('Please pick a piont in a figure by cursor'); return; end
    for ii=1:length(cursor_info)
        freq_notch=[freq_notch, cursor_info(ii).Position(1)];
    end
end

loc=[];
for freq_stop=freq_notch
    % Amp0((f>freq_stop-df & f<freq_stop+df)|(f>-freq_stop-df & f<-freq_stop+df))=0;% mark the locations of frequencies to be blocked
    loc=[loc,floor((freq_stop-df)/fs*len):ceil((freq_stop+df)/fs*len),len-(floor((freq_stop-df)/fs*len):ceil((freq_stop+df)/fs*len))];
end
if ~isempty(loc)
    loc(loc<=0)=1;loc(loc>length(sig))=length(sig);
    real_cepstrum(loc)=0;% set the frequencies around the freq_stop as zero within the width 2*df

    prewhiten_sig = ifft(exp(fft(real_cepstrum)+1i*phase),'symmetric');% reconstruct the signal via the inverse Fourier transform
else
    prewhiten_sig=x;
end
end