%ÑÝËãº¯Êý
clear
clc
T=linspace(0,360);
P=linspace(0,360);
[theta,phi]=meshgrid(T,P);
e=cos(pi/2.*cosd(theta))./sind(theta).*(phi<180);
X=e.*sind(theta).*cosd(phi);
Y=e.*sind(theta).*sind(phi);
Z=e.*cosd(theta);

figure(1)
mesh(X,Y,Z);
line([-1 1],[0 0],[0 0])
line([0 0],[-1 1],[0 0])
line([0 0],[0 0],[0 1])
view(30,10)
axis equal

figure(2)
polar(T/180*pi,e(1:1,:));