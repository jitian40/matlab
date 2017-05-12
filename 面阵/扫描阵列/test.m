% 16元的可分离阵列天线的研究
clear all;
clc;
lamda=10;
c=300;
Theta=linspace(0,pi);
Phi=linspace(0,2*pi);
[theta,phi]=meshgrid(Theta,Phi);
Nx=input('沿着x轴排列的天线阵元的个数：');
Ny=input('沿着y轴排列的天线阵元的个数：');
dx=input('沿着x轴排列的阵元间距（波长的倍数）：');
dy=input('沿着y轴排列的阵元间距（波长的倍数）：');
Sx=sin(Nx*pi*dx.*cos(theta))/Nx./sin(pi*dx.*cos(theta));%沿着x轴排列
Sy=sin(Ny*pi*dy.*cos(theta))/Ny./sin(pi*dy.*cos(theta));%沿着x轴排列
S=Sx.*Sy;
X=Sx.*sin(theta).*cos(phi);
Y=Sx.*sin(theta).*sin(phi);
Z=Sx.*cos(theta);
mesh(X,Y,Z);
