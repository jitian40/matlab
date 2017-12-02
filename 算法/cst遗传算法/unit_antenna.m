function unit_fun=unit_antenna(theta,phi)
%UNIT_ANTENNA 此处显示有关此函数的摘要
%   此处显示详细说明
  theta1=roundn(theta,-1);
  phi1=roundn(phi,-1);
  phi1(phi1<=0)=phi1(phi1<=0)+360;
  theta1(theta1==0)=theta1(theta1==0)+0.1;
  thetan=int16(theta1./0.1);
  phin=int16(phi1./0.1);
  mwsprojName = 'unit 30.cst';
  e=data_manger(mwsprojName);
  [p,t]=size(thetan);
  unit_fun=zeros(p,t);
  for kt=1:p
      for kp=1:t
          tn=thetan(kt:kt,kp:kp);
          pn=phin(kt:kt,kp:kp);
          unit_fun(kt:kt,kp:kp)=e(pn:pn,tn:tn);
      end
  end
  
end

