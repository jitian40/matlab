%��ת����������׵�����ת����
function dirGrah=xchange(zarc,yarc,t,p,phi_i,zn,R)%��Ԫ���ߵ����нǶȣ���������Բ׶��ĵ׽ǣ���������theta����phi�ǣ�������λ����Ԫ��Z����ֵ��׵��ĵ���Բ�İ뾶
    Z_arc=zarc+180;
    Y_arc=360-yarc;
    %����Z����תZ_arc
    theta_1=t;
    phi_1=p-Z_arc;
    %����Y����תY_arc;
    theta_2=acosd(cosd(theta_1).*cosd(Y_arc)-sind(theta_1).*cosd(phi_1).*sind(Y_arc));%�仯���theta��
    Phi_2=atand((sind(theta_1).*sind(phi_1))./(cosd(theta_1).*sind(Y_arc)+sind(theta_1).*cosd(phi_1).*cosd(Y_arc)));%�仯���phi��
%   e=sin(5/2.*pi.*cos(theta_2))./(5*sin(pi/2.*cos(theta_2)));%��Ԫ���߷���ͼ����
    e=cos(pi/2.*cosd(theta_2))./sind(theta_2);
    dirGrah=e.*exp(1i*(phi_i+2*pi/15.*(sind(t).*cosd(p-zarc).*(R-zn/2)+zn.*cosd(t))));
end