clear all;
clc;
Theta=1:1:180;
Phi=2:2:360;
[theta,phi]=meshgrid(Theta,Phi);
% array_im=[0.98,0.86,0.82,0.75,0.83,0.62,0.01,0.45,0.81,0.83,0.47,0.12,0.75,0.53,0.02,0.57];
% array_phase=[3.56,3.07,3.02,3.22,3.66,5.69,3.91,6.23,3.46,3.31,2.82,0.59,4.11,2.62,0.35,3.56];
array_im=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
array_phase=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

% array_im=[0.96,0.97,1.00,0.88,0.43,0.61,0.05,0.52,0.45,0.65,0.77,0.37,0.71,0.63,0.31,0.48];
% array_phase=[0.94,0.69,0.64,0.89,4.5,2.72,5.79,2.67,5.1,1.93,0.59,2.47,4.45, 5.15,4.01,4.85];

% array_im=[0.42,0.80,0.94,0.98,0.02,0.76,0.15,0.38,1.00, 0.26,0.96,0.77,0.08,0.10,0.75,0.97];
% array_phase=[3.91,5.39,6.13,5.74,1.68,0.10,5.89,6.13,0.59,1.39,1.68,0.69,1.14,2.97,1.43,0.45];

et=unit_fun(theta,phi);
a=0;
% array_phase=[array_phase(1:4)+a,array_phase(5:8)+a,array_phase(9:12)-a,array_phase(13:16)+a];
F=f(theta,phi,array_phase,array_im,et);
D=para(theta,F);
[x,y]=find(F==1);
X=F.*sind(theta).*cosd(phi);
Y=F.*sind(theta).*sind(phi);
Z=F.*cosd(theta);
figure(1)
mesh(X,Y,Z);
figure(2)
polar(Theta/180*pi,F(x:x,:),'b');
title({['主波瓣指向,\theta=',num2str(y),'\circ,增益G=',num2str(20*log10(D)),'dB']});
box on
