% Readout the complex S11 parameter from the CST project "coaxial connector td-hex.cst"

% Load library. The path to these files must be known to matlab.
DLL_Path = '..\';
HeaderPath = '.\';
libname = 'CSTResultReader';
if (strcmp(computer, 'PCWIN64')) 
    libname = 'CSTResultReader_AMD64';
    DLL_Path = '..\AMD64\';
end
CSTResultReader = strcat( DLL_Path, libname, '.dll' );
CSTResultReaderH = strcat( HeaderPath, 'CSTResultReaderInterf.h' );
loadlibrary(CSTResultReader,CSTResultReaderH);

% Show a summary of all available functions in the .dll. It also shows what arguments
% a function call needs in matlab.
%libfunctionsview CSTResultReader 

% Project from the current directory
mwsProjName = '.\coaxial connector td-hex.cst';
%mwsProjName = '.\coaxial connector fd-tet 2012.cst';
sTree1DName = '1D Results\S-Parameters\S2,1';

% Initalize the return value
ret = 0;

% Define the CST project handle
sHandle = libstruct('CSTProjHandle');
sHandle.m_pProj = 0;

% Initialize the handle
[ret, mwsProjName, sHandle] = ...
calllib(libname, 'CST_OpenProject', mwsProjName, sHandle);

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
[ret, sHandle, sTree1DName, yVal] = ...
calllib(libname, 'CST_Get1D_2Comp_DataOrdinate', sHandle, sTree1DName, iResultNumber, yVal);

% Extract the complex components from the vector.
Sre = yVal(1:2:length(yVal));
Sim = yVal(2:2:length(yVal));

% Create a 1D-Plot of the absolute value of S11 versus frequency.
plot(xVal,Sre,xVal,Sim)

% Close the CST project handle.
[ret, sHandle] = ...
calllib(libname, 'CST_CloseProject', sHandle);

% Free the library.
unloadlibrary(libname)
