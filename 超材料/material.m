clc;
clear;
%CST��MATLAB������ò��ϵķ���ϵ���봫��ϵ��

%������������������������������������������������
%��������������������������������������������������
pro_name='������\material 10.cst';
% pro_name='������\cir.cst';
% pro_name='������\�������ڽṹ.cst';
s11_name='S2,2';
s21_name='S1,2';
[num1,s11]=get_S_Parameter(pro_name,s11_name);
[num2,s21]=get_S_Parameter(pro_name,s21_name);
Sre1 = s11(1:2:length(s11));
Sim1 = s11(2:2:length(s11));
S11=Sre1+1j*Sim1;%��ø���S11����
Sre2 = s21(1:2:length(s21));
Sim2 = s21(2:2:length(s21));
S21=Sre2+1j*Sim2;%��ø���S21����
%��������������������������������������������������
%���÷��ݺ������㱾������
%��������������������������������������������������
[er,ur]=calc_material(num1,S11,S21);
%��������������������������������������������������
%��ͼ���������
%��������������������������������������������������
figure(1)
plot(num1,real(er),'r',num1,imag(er),'y');
grid on;
xlabel('Ƶ��/GHz');
ylabel('��������');
title('�����Ͻ�糣��');

figure(2)
plot(num1,real(ur),'r',num1,imag(ur),'y');
grid on;
xlabel('Ƶ��/GHz');
ylabel('��������');
title('�����ϴŵ���');



