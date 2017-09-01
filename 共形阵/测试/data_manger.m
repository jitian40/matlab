%CST数据处理中心

function fun=data_manger(mwsprojName)
Theta=0:5:180;
Phi=0:5:360;
%插值处理
theta_i=0:0.1:180;
phi_i=0:0.1:360;
e=get_farfiled(mwsprojName);
fun=interp2(Theta,Phi,e,theta_i,phi_i','spline');
end