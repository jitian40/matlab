clear all;
clc;
a=pi/180:pi/180:pi;
b=pi/180:pi/180:2*pi;
[theta,phi]=meshgrid(a,b);
e=sin(4*pi.*cos(theta))./sin(0.4*pi.*(cos(theta)-1));
X=e.*sin(theta).*cos(phi);
Y=e.*sin(theta).*sin(phi);
Z=e.*cos(theta);
mesh(X,Y,Z);
axis equal;



