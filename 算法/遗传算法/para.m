function D = para(theta,e)
%PARA 此处显示有关此函数的摘要
%   此处显示详细说明
    F=e.^2.*sin(theta);
    S=sum(sum(F')*pi/100)*pi/50;
    D=4*pi/S;

end

