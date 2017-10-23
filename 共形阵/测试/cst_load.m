function [ CSTResultReader,CSTResultReaderH,mwsProjName,libname] = cst_load(mwsprojName)
%CST_LOAD CST result reader 函数加载
%   此处显示详细说明
% Load library. The path to these two files must have been made known to matlab.
    DLL_Path = 'C:\Program Files (x86)\CST STUDIO SUITE 2016\';
    HeaderPath = 'C:\Program Files (x86)\CST STUDIO SUITE 2016\ResultReaderDLL\';
    CST_Path='D:\cst\myself\';
    libname = 'CSTResultReader';
    if (strcmp(computer, 'PCWIN64')) 
        libname = 'CSTResultReader_AMD64';
        DLL_Path = 'C:\Program Files (x86)\CST STUDIO SUITE 2016\AMD64\';
    end
    CSTResultReader = strcat( DLL_Path, libname, '.dll' );
    CSTResultReaderH = strcat( HeaderPath, 'CSTResultReaderInterf.h' );
    mwsProjName=strcat(CST_Path,mwsprojName);
end

