% 16元的可分离阵列天线的研究
clear all;
clc;
lamda=10;
c=300;
Theta=0:5/180*pi:pi;
Phi=0:5/180*pi:2*pi;
[theta,phi]=meshgrid(Theta,Phi);
%差值处理
theta_i=0:0.1/180*pi:pi;
phi_i=0:0.1/180*pi:2*pi;
mwsprojName = 'unit 30.cst';
e=get_farfiled(mwsprojName);
e1=interp2(Theta,Phi,e,theta_i,phi_i','spline');
Nx=4;
Mx=1.5;
Ny=4;
My=1.5;
dx=0.7;
dy=0.7;
Im=[1,1.7357,1.7357,1];
s_theta1=20;%定义扫描角度
s_theta=s_theta1/180*pi;
%计算Sx
Sx=0;
Ix=1;

for kx=-Mx:1:Mx
    Sx=Sx+Im(Ix).*exp(1j*kx.*(2*pi*dx.*sin(theta).*cos(phi)-2*pi*dx*sin(s_theta)));
    Ix=Ix+1;
end

%计算Sy
Sy=0;
Iy=1;
for ky=-My:1:My
    Sy=Sy+Im(Iy).*exp(1j*ky.*(2*pi*dy.*sin(theta).*sin(phi)));
    Iy=Iy+1;
end
Sx=abs(Sx);
Sy=abs(Sy);
S1=Sx.*Sy;
S1=interp2(Theta,Phi,S1,theta_i,phi_i','spline');
S1=e1.*S1;
S=e.*Sx.*Sy;
S1=S1./max(max(S1));
[theta,phi]=meshgrid(theta_i,phi_i);
X=S1.*sin(theta).*cos(phi);
Y=S1.*sin(theta).*sin(phi);
Z=S1.*cos(theta);
axis([-1 1 -1 1])
surf(X,Y,Z);
alpha(0.5)
hold on
hidden off
shading interp
xlabel('X');
ylabel('Y');
zlabel('Z(相对幅度)');
% title({['主瓣指向\phi=0\circ,\theta=',num2str(s_theta1),'\circ']});
title('波束由-20\circ-20\circ扫描过程');
axis on
grid on

line([-1 1],[0 0],[0 0])
line([0 0],[-1 1],[0 0])
line([0 0],[0 0],[0 1])
view(30,10)
