%叠加原理
clear all;
clc;
%相关参数
a=2:2:360;
b=2:2:360;
[theta,phi]=meshgrid(a,b);
degree=[0,90,180,270];%单元分布角度
d_busbar=[0,8,16,24];%单元分布层数
R=20;%底面圆半径
bottom_corner=90;%曲面底角
et=unit_fun(theta,phi,degree,bottom_corner);  %获取每个位置单元贴片的全局方向图函数
e=f(theta,phi,et,degree,d_busbar,R,bottom_corner);%获取总的方向图函数
F=e.^2.*sind(theta);
S=sum(sum(F')*pi/180)*pi/90;
D=4*pi/S;
X=e.*sind(theta).*cosd(phi);
Y=e.*sind(theta).*sind(phi);
Z=e.*cosd(theta);
mesh(X,Y,Z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('圆锥共形等幅同相方向图');
axis equal;