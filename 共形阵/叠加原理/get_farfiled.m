function eFun = get_farfiled( mwsprojName )
%GET_FARFILED 此处显示有关此函数的摘要
%   此处显示详细说明
[ CSTResultReader,CSTResultReaderH,mwsProjName,libname] = cst_load(mwsprojName);
% unloadlibrary(libname)
loadlibrary(CSTResultReader,CSTResultReaderH);%加载cst dll
sHandle.m_pProj = 0; 
[ret,mwsProjName,sHandle]=calllib(libname,'CST_OpenProject',mwsProjName, sHandle);  %打开cst文件
nFFM=0;
[ret,sHandle,nFFM]= calllib(libname, 'CST_GetNumberOfFarfieldMonitors', sHandle, nFFM);%获取远场个数
assert(~ret);

FFMNames = cellstr(num2str((1:nFFM)'));%定义字符空间
FFMFrequencies = zeros(1,nFFM,'double');%定义频率大小数组
for i=1:nFFM
    FFMName = libpointer('stringPtr',blanks(100));
    [ret, sHandle, FFMName, FFMFrequencies(i)] = calllib(libname, 'CST_GetFarfieldMonitorInfo', sHandle, i-1, FFMName, FFMFrequencies(i));
    assert(~ret)
    FFMNames(i,:) = cellstr(char(FFMName));
    clear FFMName;
end
display(FFMNames);
%获取激励数目
nExcitations = 0;
[ret, sHandle, nExcitations] = calllib(libname, 'CST_GetNumberOfExcitations', sHandle, nExcitations);
assert(~ret)
%读取激励
ExNames = cellstr(num2str((1:nExcitations)'));
for i=1:nExcitations
    ExName = libpointer('stringPtr',blanks(100));
    [ret, sHandle, ExName] = calllib(libname, 'CST_GetExcitationString', sHandle, i-1, ExName);
    assert(~ret)
    ExNames(i,:) = cellstr(char(ExName));
    clear ExName
end
display(ExNames)

% Which monitor/excitation (number) to look at?
monNum = 1;
exNum = 1;
% Use FF approximation?
isApprox = 1; 
%目前只有二维的可以选择
Dimension = 2;
% 在cst工程中的目录，格式很重要啊
sTree3DResName = strcat('Farfields\',char(FFMNames(monNum)),' [',char(ExNames(exNum)),']');
display(sTree3DResName)

%获取点的个数
nDataSizePhi=0;
nDataSizeTheta=0;
[ret,sHandle,sTree3DResName,nDataSizeTheta,nDataSizePhi] = calllib(libname, 'CST_GetFarfieldResultSize', sHandle, sTree3DResName, isApprox, Dimension, nDataSizeTheta, nDataSizePhi);
assert(~ret)
%获取远场数据

%获取对应点的值,
FFDataSize = (3-isApprox)*nDataSizeTheta*nDataSizePhi;
FFre = zeros(1,FFDataSize,'double');
FFim = zeros(1,FFDataSize,'double');
[ret, sHandle, sTree3DResName, FFre, FFim] = calllib(libname, 'CST_GetFarfieldResultField', sHandle, sTree3DResName, isApprox, Dimension, FFre, FFim);
assert(~ret)

%对远场数据进行处理

%Theta数据
FFreTheta = FFre(1:(3-isApprox):FFDataSize);
FFimTheta = FFim(1:(3-isApprox):FFDataSize);
FFabsTheta = realsqrt(FFreTheta.^2+FFimTheta.^2);
%phi数据
FFrePhi = FFre(2:(3-isApprox):FFDataSize);
FFimPhi = FFim(2:(3-isApprox):FFDataSize);
FFabsPhi = realsqrt(FFrePhi.^2+FFimPhi.^2);

%方向图数据
if (~isApprox)
   FFreR = FFre(3:3:FFDataSize);
   FFimR = FFim(3:3:FFDataSize);
   FFabsR = realsqrt(FFreR.^2+FFimR.^2);
   FFabs = realsqrt(FFabsTheta.^2+FFabsPhi.^2+FFabsR.^2);
else
    FFabs = realsqrt(FFabsTheta.^2+FFabsPhi.^2);
end

%画图
% Select a constant angle phi, map to corresponding index
e=reshape(FFabs,37,72);
e=e';
e(nDataSizePhi+1:nDataSizePhi+1,1:nDataSizeTheta)=e(1:1,1:nDataSizeTheta);
eFun=e;%返回值
%关闭工程
[ret, sHandle] = calllib(libname, 'CST_CloseProject', sHandle);
assert(~ret)

% 释放库文件
unloadlibrary(libname)

%清理内存，好像很重要啊。。。。。
clear i j k n X Y xmargin ymargin zmargin symbol ret iResultNumber MEColor MFColor nzLevel zLevel sHandle resSize sTree3DResName nDataSizePhi nDataSizeTheta

end

