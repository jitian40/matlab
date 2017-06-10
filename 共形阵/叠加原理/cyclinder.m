%����ԭ��
clear all;
clc;
%��ز���
a=1:1:180;
b=2:2:360;
[theta,phi]=meshgrid(a,b);
et=unit_fun(theta,phi);
e=f(theta,phi,et);
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
title('Բ׶���εȷ�ͬ�෽��ͼ');
axis equal;