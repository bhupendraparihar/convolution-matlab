function [ny,y] = ConvolutionVisualization(nx,x,nh,h,pv,auto)

% Create Figure Window and Setting its Color and Position
H = figure(1);
set(H,'Color',[1 1 1]);
set(H,'position', [40,30,1280,660]);

% Get Sample Period
Ts = nx(2) - nx(1);
% Convolution Operation
y = Ts*conv(x,h);
% Signal yn Index Calculation
ny = nx(1)+nh(1):Ts:nx(end)+nh(end);
% Convolution Operation
[~,XTMAT] = ConvolutionOperation(nx,x,nh,h);
% Folding nh
flipnh = flip(nh);
% Delay Window Length
% Folded signal h will be traversed from the left to right of x
k = (nx(1)-length(nh)*Ts):Ts:(nx(end)+length(nh)*Ts);


switch upper(auto)
    case 'DT'
        % Ploting first signal
        subplot(331);
        stem(nx,x,'LineWidth',2);
        ax = gca;
        ax.XTick = nx;
        title('$x[n]$','Interpreter','Latex');grid on;
        axis([min(nx)-1,max(nx)+1,min(x)-1,max(x)+1]);
            
        % Ploting second signal
        subplot(332);
        stem(nh,h,'LineWidth',2);
        ax = gca;
        ax.XTick = nh;
        title('$h[n]$','Interpreter','Latex');grid on;
        axis([min(nh)-1,max(nh)+1,min(h)-1,max(h)+1]);
        
        % Ploting third signal
        subplot(333);
        stem(-nh,h,'LineWidth',2);
        ax = gca;
        ax.XTick = -flip(nh);
        title('$h[-k]$','Interpreter','Latex');grid on;
        axis([min(-flip(nh))-1,max(-flip(nh))+1,min(h)-1,max(h)+1]);
        
        % Locating Index for 0 (Near to zero) of signal h
        idnh = length(nh)-sum((sign(nh)==-1))-1;
        X = -idnh*ones(1,10);
        Y = linspace(min(min(h),min(x))-1,max(max(h),max(x))+1,10);
        a = (nx(1)-Ts-idnh*Ts):Ts:(nx(end)+Ts+(length(nh)-idnh)*Ts);
        s = 1;
        for p = 1:length(a)-1
            subplot(3,3,4:6);
            stem(flipnh+a(p),h,'LineWidth',1);
            hold on;
            line(X,Y,'LineWidth',2);
            line(X + Ts*p,Y,'LineWidth',1);
            stem(nx,x,'LineWidth',2);
            hold off;
            
            grid on;
            axis([min(k)-1,max(k)+1,min(min(h),min(x))-1,max(max(h),max(x))+1]);
            str1 = strcat('$y[',num2str(a(p+1)),...
                ']=\sum_{k=-\infty}^{\infty}x[k]h[',num2str(a(p+1)),'-k]');
            str2 = strcat('=\sum_{k=',num2str(min(nx)),'}^{',...
                num2str(max(nx)),'}x[k]h[',num2str(a(p+1)),'-k]$');
            str = strcat(str1,str2);
            title(str,'Interpreter','Latex');
            subplot(3,3,7);
            stem(nx,XTMAT(p,:),'LineWidth',2);grid on;
%           fill(nx,XTMAT(p,:),'b');
            A = trapz(nx,XTMAT(p,:));
            str = strcat('$Area = ',num2str(A),'$');
            title(str,'Interpreter','Latex');
            axis([min(nx)-1,max(nx)+1,min(min(XTMAT))-1,max(max(XTMAT))+1]);
            if p>2 && (p<length(a))
                subplot(3,3,8:9);
                stem(ny(1:s),y(1:s),'LineWidth',2);
                axis([min(ny)-1,max(ny)+1,min(y)-1,max(y)+1]);
                grid on;
                s = s+1;
            end
            if isempty(pv) == 1
                pause();
            else
                pause(pv);
            end
        end
        
    case 'CT'      % Continuous Time
        
        % Ploting first signal
        subplot(331);
        plot(nx,x,'LineWidth',2);
        title('$x[n]$','Interpreter','Latex');grid on;
        axis([min(nx)-1,max(nx)+1,min(x)-1,max(x)+1]);
        
        % Ploting second signal
        subplot(332);
        plot(nh,h,'LineWidth',2);
        title('$h[n]$','Interpreter','Latex');grid on;
        axis([min(nh)-1,max(nh)+1,min(h)-1,max(h)+1]);
        
        % Ploting third signal
        subplot(333);
        plot(-nh,h,'LineWidth',2);
        title('$h[-k]$','Interpreter','Latex');grid on;
        axis([min(-flip(nh))-1,max(-flip(nh))+1,min(h)-1,max(h)+1]);
            
        % Locating Index for 0 (Near to zero) of signal h
        idnh = length(nh)-sum((sign(nh)==-1));
        a = (nx(1)-Ts-idnh*Ts):Ts:(nx(end)+Ts+(length(nh)-idnh)*Ts);
        s = 1;
        for p = 1:length(a)-1
            subplot(3,3,4:6);
            plot(flipnh+a(p),h,nx,x,'LineWidth',2);
            grid on;
            axis([min(k)-1,max(k)+1,min(min(h),min(x))-1,max(max(h),max(x))+1]);
            str1 = strcat('$y[',num2str(a(p+1)),...
                ']=\sum_{k=-\infty}^{\infty}x[k]h[',num2str(a(p+1)),'-k]');
            str2 = strcat('=\sum_{k=',num2str(min(nx)),'}^{',...
                num2str(max(nx)),'}x[k]h[',num2str(a(p+1)),'-k]$');
            str = strcat(str1,str2);
            title(str,'Interpreter','Latex');
            subplot(3,3,7);
            plot(nx,XTMAT(p,:),'LineWidth',2);grid on;
%             fill(nx,XTMAT(p,:),'b');
            A = trapz(nx,XTMAT(p,:));
            str = strcat('$Area = ',num2str(A),'$');
            title(str,'Interpreter','Latex');
            axis([min(nx)-1,max(nx)+1,min(min(XTMAT))-1,max(max(XTMAT))+1]);
            if p>2 && (p<length(a))
                subplot(3,3,8:9);
                plot(ny(1:s),y(1:s),'LineWidth',2);
                axis([min(ny)-1,max(ny)+1,min(y)-1,max(y)+1]);
                grid on;
                s = s+1;
            end
            if isempty(pv) == 1
                pause();
            else
                pause(pv);
            end
        end   
    otherwise
        error('Unhandeled Option Type');
end