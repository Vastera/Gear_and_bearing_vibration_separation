function out = sanc(x,L,mu,delta)
%self-adaptive noise cancellation

%x:     signal to be filtered
%L:     length of  the filter
%mu:    adaptation rate
%delta: delay of signal

%Relevant publications:
%   1) Domique Ho, "Bearing Diagnostics and Self-Adaptive Noise
%   Cancellation", PhD  Dissertation, 1995.
%   2) D. Ho and R. Randall, "Effects of Time delay, order of FIR filter, and
%   convergence factor on self adaptive noise cancellation," Fifth
%   International Congress on Sound and Vibration, December 15-18, 1997.
%   3) Robert Randall and Jerome Antoni, "Rolling element bearing
%   diagnostics--A tutorial," Mechanical Systems and Signal Processing,
%   2011, pp. 285-520.

W = mean(x)*ones(L,1); %initial weight vector, equal weights
n = size(x,1); %length of the vector for prediction
sigma2_k = 0;
alpha = 0.05;
for i=L+delta:n-1
    X = x(i-delta:-1:i-L+1-delta); %elements [i-delta-L+1:i+1]
    y = W'*X;
    e = x(i+1) - y;
    sigma2_k = alpha*X(1)^2 + (1-alpha)*sigma2_k;
    Wm1 = W;
    W = Wm1 + (2*mu*e/((L+1)*sigma2_k))*X;
%     diff(i) = norm((W-Wm1)./Wm1);
    
%     mu = (1-alpha)*mu; %reduce convergence factor exponentially if
%                           desired
end

out.filteredSignal = conv(x,W);
out.filteredSignal = out.filteredSignal(1:numel(x));
out.weight = W;
end