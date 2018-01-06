%Release Memory and Generate Signal
clear;clc;

% Sampling Period
Ts = 0.01;

% Time sample
nx = -2:Ts:2;

% Rectangular Pulse of width 2
xt = zeros(1,length(nx));
xt(nx>=0) = exp(-nx(nx>=0));

% Time sample
nh = -2:Ts:2;

% Asymmetric Triangular Pulse of width 1
ht = zeros(1,length(nh));
ht(nh>=-1) = ones(1,sum(nh>=-1));

% Convolution Visualization
ConvolutionVisualization(nx,xt,nh,ht,0.1,'CT');