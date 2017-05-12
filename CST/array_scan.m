% 16元的可分离阵列天线的研究
clear all;
clc;
lamda=10;
c=300;
Theta=0:5/180*pi:pi;
Phi=0:5/180*pi:2*pi;
[theta,phi]=meshgrid(Theta,Phi);
mwsprojName = 'Round_patch.cst';
e=get_farfiled(mwsprojName);
Nx=5;
Mx=2;
Ny=5;
My=2;
dx=0.5;
dy=0.5;

s_theta1=45;%定义扫描角度
s_theta=s_theta1/180*pi;
%计算Sx
Sx=0;
for kx=-Mx:1:Mx
    Sx=Sx+exp(1j*kx.*(2*pi*dx.*sin(theta).*cos(phi)-2*pi*dx*sin(s_theta)));
end

%计算Sy
Sy=0;
for ky=-My:1:My
    Sy=Sy+exp(1j*ky.*(2*pi*dy.*sin(theta).*sin(phi)));
end
Sx=abs(Sx);
Sy=abs(Sy);
S=e.*Sx.*Sy;
S=S./max(max(S));
X=S.*sin(theta).*cos(phi);
Y=S.*sin(theta).*sin(phi);
Z=S.*cos(theta);
axis([-1 1 -1 1])
surf(X,Y,Z);
shading interp
xlabel('X');
ylabel('Y');
zlabel('Z(相对幅度)');
title({['主瓣指向\phi=0\circ,\theta=',num2str(s_theta1),'\circ']});
axis on;
line([-1 1],[0 0],[0 0])
line([0 0],[-1 1],[0 0])
line([0 0],[0 0],[0 1])
view(30,10)
grid off
hold on
