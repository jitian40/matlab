function [er,ur] = calc_material1(num,S11,S21)
%CALC_MATERIAL1 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
d=10e-3;
k=2*pi.*num./0.3;
Z=sqrt(((1+S11).^2-S21.^2)./((1-S11).^2+S21.^2));%�����迹
n=1./k./d.*acos((1-S11.^2+S21.^2)./S21/2);
er=n./Z;
ur=n.*Z;
end

