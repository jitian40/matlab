%��ת����������׵�����ת����
function dirGrah=xchange(zarc,yarc,t,p,phi_i,zn,R)%��Ԫ���ߵ����нǶȣ���������Բ׶��ĵ׽ǣ���������theta����phi�ǣ�������λ����Ԫ��Z����ֵ��׵��ĵ���Բ�İ뾶
    Z_arc=zarc+pi;
    Y_arc=2*pi-yarc;
    %����Z����תZ_arc
    theta_1=t;
    phi_1=p-Z_arc;
    %����Y����תY_arc;
    theta_2=acos(cos(theta_1).*cos(Y_arc)-sin(theta_1).*cos(phi_1).*sin(Y_arc));%�仯���theta��
    Phi_2=atan((sin(theta_1).*sin(phi_1))./(cos(theta_1).*sin(Y_arc)+sin(theta_1).*cos(phi_1).*cos(Y_arc)));%�仯���phi��
%   e=sin(5/2.*pi.*cos(theta_2))./(5*sin(pi/2.*cos(theta_2)));%��Ԫ���߷���ͼ����
    e=cos(pi/2.*cos(theta_2))./sin(theta_2).*(Phi_2<180);
    dirGrah=e.*exp(1i*(phi_i+2*pi/15.*(sin(t).*cos(p-zarc).*(R-zn/2)+zn.*cos(t))));
end