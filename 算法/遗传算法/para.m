function D = para(theta,e)
%PARA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    F=e.^2.*sin(theta);
    S=sum(sum(F')*pi/100)*pi/50;
    D=4*pi/S;

end

