%ÑÝËãº¯Êý
clear
clc
T=0:180;
P=1:360;
[theta,phi]=meshgrid(T,P);
e=sin(4*pi.*cosd(theta))./sin(pi/2.*cos(theta/180*pi))/8;
e=e./max(max(e));
F=e.^2.*sind(theta);
S=sum(sum(F')*pi/180)*pi/180;
D=4*pi/S;
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