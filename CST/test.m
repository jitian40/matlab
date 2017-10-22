clear;
clc;
theta=0:5:180;
phi=0:5:360;
[t,p]=meshgrid(theta,phi);
mwsprojName = 'unit 30.cst';
e=get_farfiled(mwsprojName);

X=e.*sind(t).*cosd(p);
Y=e.*sind(t).*sind(p);
Z=e.*cosd(t);

mesh(X,Y,Z);

