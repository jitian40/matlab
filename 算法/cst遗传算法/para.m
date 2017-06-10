function D = para(theta,e)
%PARA 此处显示有关此函数的摘要
%   此处显示详细说明
    F=e.^2.*sind(theta);
    S=sum(sum(F')*pi/180)*pi/90;
    D=4*pi/S;

end

