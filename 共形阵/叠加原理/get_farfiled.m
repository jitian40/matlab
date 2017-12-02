function eFun = get_farfiled( mwsprojName )
%GET_FARFILED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[ CSTResultReader,CSTResultReaderH,mwsProjName,libname] = cst_load(mwsprojName);
% unloadlibrary(libname)
loadlibrary(CSTResultReader,CSTResultReaderH);%����cst dll
sHandle.m_pProj = 0; 
[ret,mwsProjName,sHandle]=calllib(libname,'CST_OpenProject',mwsProjName, sHandle);  %��cst�ļ�
nFFM=0;
[ret,sHandle,nFFM]= calllib(libname, 'CST_GetNumberOfFarfieldMonitors', sHandle, nFFM);%��ȡԶ������
assert(~ret);

FFMNames = cellstr(num2str((1:nFFM)'));%�����ַ��ռ�
FFMFrequencies = zeros(1,nFFM,'double');%����Ƶ�ʴ�С����
for i=1:nFFM
    FFMName = libpointer('stringPtr',blanks(100));
    [ret, sHandle, FFMName, FFMFrequencies(i)] = calllib(libname, 'CST_GetFarfieldMonitorInfo', sHandle, i-1, FFMName, FFMFrequencies(i));
    assert(~ret)
    FFMNames(i,:) = cellstr(char(FFMName));
    clear FFMName;
end
display(FFMNames);
%��ȡ������Ŀ
nExcitations = 0;
[ret, sHandle, nExcitations] = calllib(libname, 'CST_GetNumberOfExcitations', sHandle, nExcitations);
assert(~ret)
%��ȡ����
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
%Ŀǰֻ�ж�ά�Ŀ���ѡ��
Dimension = 2;
% ��cst�����е�Ŀ¼����ʽ����Ҫ��
sTree3DResName = strcat('Farfields\',char(FFMNames(monNum)),' [',char(ExNames(exNum)),']');
display(sTree3DResName)

%��ȡ��ĸ���
nDataSizePhi=0;
nDataSizeTheta=0;
[ret,sHandle,sTree3DResName,nDataSizeTheta,nDataSizePhi] = calllib(libname, 'CST_GetFarfieldResultSize', sHandle, sTree3DResName, isApprox, Dimension, nDataSizeTheta, nDataSizePhi);
assert(~ret)
%��ȡԶ������

%��ȡ��Ӧ���ֵ,
FFDataSize = (3-isApprox)*nDataSizeTheta*nDataSizePhi;
FFre = zeros(1,FFDataSize,'double');
FFim = zeros(1,FFDataSize,'double');
[ret, sHandle, sTree3DResName, FFre, FFim] = calllib(libname, 'CST_GetFarfieldResultField', sHandle, sTree3DResName, isApprox, Dimension, FFre, FFim);
assert(~ret)

%��Զ�����ݽ��д���

%Theta����
FFreTheta = FFre(1:(3-isApprox):FFDataSize);
FFimTheta = FFim(1:(3-isApprox):FFDataSize);
FFabsTheta = realsqrt(FFreTheta.^2+FFimTheta.^2);
%phi����
FFrePhi = FFre(2:(3-isApprox):FFDataSize);
FFimPhi = FFim(2:(3-isApprox):FFDataSize);
FFabsPhi = realsqrt(FFrePhi.^2+FFimPhi.^2);

%����ͼ����
if (~isApprox)
   FFreR = FFre(3:3:FFDataSize);
   FFimR = FFim(3:3:FFDataSize);
   FFabsR = realsqrt(FFreR.^2+FFimR.^2);
   FFabs = realsqrt(FFabsTheta.^2+FFabsPhi.^2+FFabsR.^2);
else
    FFabs = realsqrt(FFabsTheta.^2+FFabsPhi.^2);
end

%��ͼ
% Select a constant angle phi, map to corresponding index
e=reshape(FFabs,37,72);
e=e';
e(nDataSizePhi+1:nDataSizePhi+1,1:nDataSizeTheta)=e(1:1,1:nDataSizeTheta);
eFun=e;%����ֵ
%�رչ���
[ret, sHandle] = calllib(libname, 'CST_CloseProject', sHandle);
assert(~ret)

% �ͷſ��ļ�
unloadlibrary(libname)

%�����ڴ棬�������Ҫ������������
clear i j k n X Y xmargin ymargin zmargin symbol ret iResultNumber MEColor MFColor nzLevel zLevel sHandle resSize sTree3DResName nDataSizePhi nDataSizeTheta

end

