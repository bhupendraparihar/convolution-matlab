function [convxh,XTMAT] = ConvolutionOperation(nx,x,nh,h)


Ts = nx(2) - nx(1);
% Delay Window Length
% Signal h(t/n) will be traversed from the left of x(t/n) to right of
% x(t/n)
len = 2*length(h)+length(x);
xtau = zeros(1,len);
% Placing signal x(t/n) at its index location
xtau(length(h)+1:length(h)+length(x)) = x;

XTMAT = zeros(length(nx)+length(nh)+1,length(x));
q = 1;
for p = 0:length(nx)+length(nh)
    htau = zeros(1,len);
    htau(1+p:length(h)+p) = flip(h);
    % Multiplying shifted 
    xhprod = htau.*xtau;
    XTMAT(q,:) = xhprod(length(nh)+1:length(nh)+length(nx));
%     subplot(311);stem(nt,xtau,'LineWidth',2);
%     subplot(312);stem(nt,httau,'LineWidth',2);
%     subplot(313);stem(nt,xhprod,'LineWidth',2);
%     pause(1);
    q = q + 1;
end
convxh = sum(XTMAT,2);
convxh = Ts*(convxh(2:end-1))';