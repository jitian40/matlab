%ÑÝËãº¯Êý
clear
clc
t=0:pi/36:2*pi;  
for h=5:5:50
x=h*cos(t);
y=h*sin(t);
patch(x,y,h*ones(size(t)),h*[0.02 0 0])
view(72,12)
axis off
end 