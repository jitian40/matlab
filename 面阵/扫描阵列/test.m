% 16Ԫ�Ŀɷ����������ߵ��о�
clear all;
clc;
lamda=10;
c=300;
Theta=linspace(0,pi);
Phi=linspace(0,2*pi);
[theta,phi]=meshgrid(Theta,Phi);
Nx=input('����x�����е�������Ԫ�ĸ�����');
Ny=input('����y�����е�������Ԫ�ĸ�����');
dx=input('����x�����е���Ԫ��ࣨ�����ı�������');
dy=input('����y�����е���Ԫ��ࣨ�����ı�������');
Sx=sin(Nx*pi*dx.*cos(theta))/Nx./sin(pi*dx.*cos(theta));%����x������
Sy=sin(Ny*pi*dy.*cos(theta))/Ny./sin(pi*dy.*cos(theta));%����x������
S=Sx.*Sy;
X=Sx.*sin(theta).*cos(phi);
Y=Sx.*sin(theta).*sin(phi);
Z=Sx.*cos(theta);
mesh(X,Y,Z);
