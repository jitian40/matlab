function D = para(theta,e)
%PARA 此处显示有关此函数的摘要
%   此处显示详细说明
    F=e.^2.*sind(theta);
    S=sum(sum(F')*pi/180)*pi/90;
    [x,y]=find(e==1);
    [~,m]=min(abs(e(x:x,1:y)-0.707));
    [~,n]=min(abs(e(x:x,y:180)-0.707));
    Th=y-m+n;
    D1=4*pi/S;
    D=D1^2/Th^2;
%     [x,y]=max(max(e));
%     D=1/(20-D+2*(abs(x)+abs(y)));
end

