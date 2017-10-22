%矩形贴片天线参数计算
clear all;
clc;
%固定参数
c=300;%单位Mm/s
%材料数据
% materail_name=input('name is');%介质基片材料
materail_epsilon=input('epsilon= ');%介质基片的相对介电常数
materail_mue=input('mue= ');%介质基片的相对磁导率
materail_frequency=input('frequency(GHz)= ');%天线的中心频率
materail_height=input('height(mm)= ');%介质基片的厚度
%天线参数
%贴片宽度计算（mm）
Width=c/2/materail_frequency/sqrt(materail_epsilon/2+1/2);
%介质基片有效介电常数
if(Width>materail_height)
    materail_effepsilon=(materail_epsilon+1)/2+(materail_epsilon-1)/2/sqrt(1+12*materail_height/Width);
else
    materail_effepsilon=(materail_epsilon+1)/2+(materail_epsilon-1)/2*(1/sqrt(1+12*materail_height/Width)+0.04*(1-Width/materail_height)^2);
end
%介质基片边长延伸量(mm)
materail_dertalenght=0.412*materail_height*(materail_effepsilon+0.3)*(Width/materail_height+0.264)/(materail_effepsilon-0.258)/(Width/materail_height+0.8);
%贴片长度(mm)
Length=c/2/materail_frequency/sqrt(materail_effepsilon)-2*materail_dertalenght;
%同轴线馈电点
L1=Length/2*(1-1/sqrt(materail_effepsilon));

%嵌入馈电的深度
trans=0.001699*materail_epsilon^7+0.13761*materail_epsilon^6-6.1783*materail_epsilon^5+93.187*materail_epsilon^4-682.69*materail_epsilon^3+2561.9*materail_epsilon^2-4043*materail_epsilon+6697;
Dig_height=trans*Length/10^4/2;