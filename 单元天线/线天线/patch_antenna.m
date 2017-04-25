clear all;
clc;
a=pi/180:pi/180:pi
b=pi/180:pi/180:2*pi;
t=atan(0.5);
alp=pi/2;
phi_z=pi/2;
qr=[sin(t),0,-cos(t);0,1,0;cos(t),0,sin(t)];
[theta,phi]=meshgrid(a,b);
e=cos(pi/2.*cos(theta))./sin(theta);
X=e.*sin(theta).*cos(phi);
Y=e.*sin(theta).*sin(phi);
Z=e.*cos(theta);
mesh(X,Y,Z);
axis equal;



