%叠加原理
clear all;
clc;
%相关参数
a=1:1:180;
b=2:2:360;
[theta,phi]=meshgrid(a,b);
e=f(theta,phi);
X=e.*sind(theta).*cosd(phi);
Y=e.*sind(theta).*sind(phi);
Z=e.*cosd(theta);
mesh(X,Y,Z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('圆锥共形等幅同相方向图');
axis equal;