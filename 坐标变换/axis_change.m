clc;
clear all;
theta=2:2:360;
phi=2:2:360;
[t,p]=meshgrid(theta,phi);
 zarc=270;
 yarc=90;
 Z_arc=zarc+180;
 Y_arc=360-yarc;
%     绕着Z轴旋转Z_arc
 theta_1=360-t;
 phi_1=p-Z_arc;
 %绕着Y轴旋转Y_arc;
 theta_2=acosd(cosd(theta_1).*cosd(Y_arc)-sind(theta_1).*cosd(phi_1).*sind(Y_arc));%变化后的theta角
 phi_2=atand((sind(theta_1).*sind(phi_1))./(cosd(theta_1).*sind(Y_arc)+sind(theta_1).*cosd(phi_1).*cosd(Y_arc)));%变化后的phi角
%   e=sin(5/2.*pi.*cos(theta_2))./(5*sin(pi/2.*cos(theta_2)));%单元天线方向图函数
phi_2(isnan(phi_2))=0;
e=unit_antenna(theta_2,phi_2);
    X=e.*sind(t).*cosd(p);
    Y=e.*sind(t).*sind(p);
    Z=e.*cosd(t);
%     mesh(X,Y,Z);
    polar(phi./180*pi,e(:,45:45)');
%     xlabel('X');
%     ylabel('Y');
%     zlabel('Z');