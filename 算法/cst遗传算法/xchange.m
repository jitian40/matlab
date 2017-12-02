%旋转函数依赖于椎体的旋转函数
function e=xchange(zarc,yarc,t,p)%单元天线的排列角度，参数包含圆锥体的底角，球坐标下theta角与phi角，激励相位，单元的Z坐标值，椎体的底面圆的半径
    Z_arc=zarc+180;
    Y_arc=360-yarc;
%     绕着Z轴旋转Z_arc
    theta_1=360-t;
    phi_1=p-Z_arc;
    %绕着Y轴旋转Y_arc;
    theta_2=acosd(cosd(theta_1).*cosd(Y_arc)-sind(theta_1).*cosd(phi_1).*sind(Y_arc));%变化后的theta角
    phi_2=atand((sind(theta_1).*sind(phi_1))./(cosd(theta_1).*sind(Y_arc)+sind(theta_1).*cosd(phi_1).*cosd(Y_arc)));%变化后的phi角
%   e=sin(5/2.*pi.*cos(theta_2))./(5*sin(pi/2.*cos(theta_2)));%单元天线方向图函数
    phi_2(isnan(phi_2))=0;
    e=unit_antenna(theta_2,phi_2);
%     e=cos(pi/2.*cosd(theta_2))./sind(theta_2);
%     dirGrah=e.*exp(1i*(2*pi/15.*(sind(t).*cosd(p-zarc).*(R-zn/2)+zn.*cosd(t))));
end