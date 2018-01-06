% Setpath
setpath('G:\MTech\MY BOOK PROJECT\Codes\Convolution');

%Release Memory and Generate Signal
clear;clc;

% Sampling Period
Ts = 0.1;

% Time sample
nx = -2:Ts:2;

% Rectangular Pulse of width 2
xt = sin(pi*nx);

% Time sample
nh = 1:Ts:4;

% Asymmetric Triangular Pulse of width 1
ht = rectpuls(nh-2,2);
plot(nh,ht)

% Convolution Visualization
ConvolutionVisualization(nx,xt,nh,ht,[],'CT');