%w5j.m (Hough transform: accumulator array)-example from lecture slide
close all, clear all, clc
pxp=[-1 0 0 1 1 2]; pyp=[4 1 3 2 3 1];
figure(1), plot(pxp,pyp, 'r*'), grid on, 
axis([-2, 3, 0, 5]);

[aa,point_num]=size(pxp); 
figure(2),
for k=1:point_num;
    px=pxp(k); py=pyp(k);
    theta_angle=-90:0.5:90;  
    [n1 n2]=size(theta_angle);
    minx=-5;maxx=5; x=minx:maxx; %Give range of x values
    %calculate linear equations
    for i=1:n2;
        m2=tan(theta_angle(i)*pi/180);
        m1=-1/m2; b1=py-m1*px;
        yh=m1*x+b1;%line passing though (px,py)
        yp=m2*x; %line perpendicular to yh with angle theta
        %To calculate 'r'
        cx=(b1)/(m2-m1); cy=m2*cx; r(i)=sqrt(cx^2+cy^2); 
    end
    %To make negative part of r. we need to find the minimum r first
    for i=1:n2; 
        if r(i)==min(r); 
            KL=i; 
        end, 
    end
    % Since all r after the minimum r is negative--> we need to reflect it.  
    for i=KL:n2; 
        r(i)=-r(i); 
    end
    plot(theta_angle, r, 'LineWidth',2), grid on, hold all
end

axis on, axis normal, xlabel('\theta'),ylabel('\rho')
%draw x and y axis lines
v=axis;
line([0 0],[v(3) v(4)],'Color','k','LineWidth',1)%y-axis
line([v(1) v(2)],[0 0],'Color','k','LineWidth',1)%x-axis
