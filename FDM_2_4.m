%% finite difference method to estimate the 2 order difference with 4 order accuracy
function [accleration]=FDM_2_4(phase,fs)
% Copyright@ vastera@163.com
% General introduction:
%% ====================== INPUT ========================
% phase:          Type:vector
%                           phase description:instantaneous phases obtained by 2-channel encoder signal
% fs:             Type: integer
%                             fs description: sampling frequency
% ---------------------OPTIONAL:
% optional arg:              Type:
%                            description:
%% ====================== OUTPUT =======================
% accleration:          Type:vector with the same size as phase 
%                           accleration description:second order difference of phase: i.e. accleration signal
%% =====================================================
if ~iscolumn(phase),phase=phase';end
accleration=conv(phase,[-1,16,-30,16,-1],'same')/12*fs^2;
accleration(1)=[35,-104,114,-56,11]*phase(1:5)*fs^2/12;
accleration(2)=[17,-44,42,-20,5]*phase(1:5)*fs^2/12;
accleration(end)=[35,-104,114,-56,11]*phase(end:-1:end-4)*fs^2/12;
accleration(end-1)=[17,-44,42,-20,5]*phase(end:-1:end-4)*fs^2/12;
%% Solve the edge effect according to the PDF in evernote ,named 有限差分法 infinite difference method
end