%����ԭ��
clear all;
clc;
%��ز���
a=2:2:360;
b=2:2:360;
[theta,phi]=meshgrid(a,b);
degree=[0,90,180,270];%��Ԫ�ֲ��Ƕ�
d_busbar=[0,8,16,24];%��Ԫ�ֲ�����
R=20;%����Բ�뾶
bottom_corner=90;%����׽�
et=unit_fun(theta,phi,degree,bottom_corner);  %��ȡÿ��λ�õ�Ԫ��Ƭ��ȫ�ַ���ͼ����
e=f(theta,phi,et,degree,d_busbar,R,bottom_corner);%��ȡ�ܵķ���ͼ����
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