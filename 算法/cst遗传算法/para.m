function D = para(theta,e)
%PARA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    F=e.^2.*sind(theta);
    S=sum(sum(F')*pi/180)*pi/90;
    D=4*pi/S;

end

