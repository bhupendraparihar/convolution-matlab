%Release Memory and Generate Signal
clear;clc;

% Sampling Period
Ts = 0.1;

% Time sample
nx = -2:Ts:2;

% Rectangular Pulse of width 2
xt = 2*rectpuls(nx,2);

% Time sample
nh = -2:Ts:2;

% Asymmetric Triangular Pulse of width 1
ht = 2*tripuls(nh-0.5,1,-1);

% Convolution Visualization
ConvolutionVisualization(nx,xt,nh,ht,[],'CT');