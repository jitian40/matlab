clear;
clc;
theta=linspace(0,2*pi);
e=cos(6*theta).*(theta<pi/12);
polar(theta,e,'r');