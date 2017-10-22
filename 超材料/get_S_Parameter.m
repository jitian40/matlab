function [num,s11] = get_S_Parameter(pro_Name,S)
%GET_S_PARAMETER 此处显示有关此函数的摘要
%   此处显示详细说明
    [ CSTResultReader,CSTResultReaderH,mwsProjName,libname] = cst_load(pro_Name);
    loadlibrary(CSTResultReader,CSTResultReaderH);
    sTree1DName =strcat('1D Results\S-Parameters\',S);
    ret = 0;
    % Define the CST project handle
    sHandle=libstruct('CSTProjHandle');
    sHandle.m_pProj = 0;
    
    % Initialize the handle
    [ret,mwsProjName,sHandle]= calllib(libname, 'CST_OpenProject', mwsProjName, sHandle);
    % Specify the desired result number. In most cases there is only one result.
    % (as assumed here)
    iResultNumber = 0;

    % Size of expected 1D-Data
    nSigSize = 0;

    % Ask for the size of the expected data vector.
    [ret, sHandle, sTree1DName, nSigSize] = ...
    calllib(libname, 'CST_Get1DResultSize', sHandle, sTree1DName, iResultNumber, nSigSize);

    % Define an array of proper size. 
    % Since a two-component result is requested, the previously encountered data size is large enough 
    % to cover all those values. However, the abscissa values are of real type (1 component values) 
    % and so the storage needs to be only half of that size.
    % NOTE: If the array size does not have the proper size, matlab may crash!
    xVal=zeros(nSigSize,1);

    % Get the frequency values.
    [ret, sHandle, sTree1DName, xVal] = ...
    calllib(libname, 'CST_Get1DRealDataAbszissa', sHandle, sTree1DName, iResultNumber, xVal);

    % Get the complex S11 values.
    yVal=zeros(nSigSize*2,1);
    [ret, sHandle, sTree1DName, yVal] = calllib(libname, 'CST_Get1D_2Comp_DataOrdinate', sHandle, sTree1DName, iResultNumber, yVal);
     % Extract the complex components from the vector.
    Sre = yVal(1:2:length(yVal));
    Sim = yVal(2:2:length(yVal));
    num=xVal;
    s11=yVal;
     % Close the CST project handle.
    [ret, sHandle]=calllib(libname, 'CST_CloseProject', sHandle);

    % Free the library.
    unloadlibrary(libname)
end

