clc;
clear;
%CST与MATLAB交互获得材料的反射系数与传输系数

%————————————————————————
%—————————————————————————
pro_name='超材料\material 10.cst';
% pro_name='超材料\cir.cst';
% pro_name='超材料\方形周期结构.cst';
s11_name='S2,2';
s21_name='S1,2';
[num1,s11]=get_S_Parameter(pro_name,s11_name);
[num2,s21]=get_S_Parameter(pro_name,s21_name);
Sre1 = s11(1:2:length(s11));
Sim1 = s11(2:2:length(s11));
S11=Sre1+1j*Sim1;%获得复数S11参数
Sre2 = s21(1:2:length(s21));
Sim2 = s21(2:2:length(s21));
S21=Sre2+1j*Sim2;%获得复数S21参数
%—————————————————————————
%调用反演函数计算本征函数
%—————————————————————————
[er,ur]=calc_material(num1,S11,S21);
%—————————————————————————
%作图，结果处理
%—————————————————————————
figure(1)
plot(num1,real(er),'r',num1,imag(er),'y');
grid on;
xlabel('频率/GHz');
ylabel('本征函数');
title('超材料介电常数');

figure(2)
plot(num1,real(ur),'r',num1,imag(ur),'y');
grid on;
xlabel('频率/GHz');
ylabel('本征函数');
title('超材料磁导率');



