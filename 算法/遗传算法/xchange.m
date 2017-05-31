%旋转函数依赖于椎体的旋转函数
function dirGrah=xchange(zarc,yarc,t,p,phi_i,zn,R)%单元天线的排列角度，参数包含圆锥体的底角，球坐标下theta角与phi角，激励相位，单元的Z坐标值，椎体的底面圆的半径
    Z_arc=zarc+pi;
    Y_arc=2*pi-yarc;
    %绕着Z轴旋转Z_arc
    theta_1=t;
    phi_1=p-Z_arc;
    %绕着Y轴旋转Y_arc;
    theta_2=acos(cos(theta_1).*cos(Y_arc)-sin(theta_1).*cos(phi_1).*sin(Y_arc));%变化后的theta角
    Phi_2=atan((sin(theta_1).*sin(phi_1))./(cos(theta_1).*sin(Y_arc)+sin(theta_1).*cos(phi_1).*cos(Y_arc)));%变化后的phi角
%   e=sin(5/2.*pi.*cos(theta_2))./(5*sin(pi/2.*cos(theta_2)));%单元天线方向图函数
    e=cos(pi/2.*cos(theta_2))./sin(theta_2).*(Phi_2<180);
    dirGrah=e.*exp(1i*(phi_i+2*pi/15.*(sin(t).*cos(p-zarc).*(R-zn/2)+zn.*cos(t))));
end