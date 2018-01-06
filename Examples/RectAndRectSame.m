% Release Memory and Generate Signal
clear;clc;

% Sampling Period
Ts = 0.4;

% Time sample
nx = -2:Ts:2;

% Rectangular Pulse of width 2
xt = 2*rectpuls(nx,2);

% Convolution Visualization
ConvolutionVisualization(nx,xt,nx,xt,0.1,'CT');