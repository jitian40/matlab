%叠加原理
clear all;
clc;
%相关参数
a=pi/100:pi/100:pi;
b=pi/50:pi/50:2*pi;
[theta,phi]=meshgrid(a,b);
e=f(theta,phi);
X=e.*sin(theta).*cos(phi);
Y=e.*sin(theta).*sin(phi);
Z=e.*cos(theta);
mesh(X,Y,Z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('圆锥共形等幅同相方向图');
axis equal;