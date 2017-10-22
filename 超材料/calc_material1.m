function [er,ur] = calc_material1(num,S11,S21)
%CALC_MATERIAL1 此处显示有关此函数的摘要
%   此处显示详细说明
d=10e-3;
k=2*pi.*num./0.3;
Z=sqrt(((1+S11).^2-S21.^2)./((1-S11).^2+S21.^2));%计算阻抗
n=1./k./d.*acos((1-S11.^2+S21.^2)./S21/2);
er=n./Z;
ur=n.*Z;
end

