clc;
clear;
close all;

% This program is to simulate the process of mcmc,using a simple Gaussian
% distribution N(0,0.05), A final hist figure wil show the effects.

% author: moxie
% date: 2014.3.21

n = 250000; % sample number
x = zeros(n,1); % samples

x(1) = 0;

for s = 1:n-1
    x_c = x(s) + randn() * 0.05; %random walk,q is N(x(s),0.05)
    u = rand();
    if u < min(exp((- x_c ^2 + x(s) ^2)/(2 * 0.05)),1) %accept or not
        x(s+1) = x_c;
    else
        x(s+1) = x(s);
    end
end

hist(x,250);



