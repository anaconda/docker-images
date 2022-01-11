@REM Setups up conda and compiler environments and then executes args
@REM This exists to work around unexpected behavior in Windows docker entrypoints

C:\Users\Administrator\miniconda3\Scripts\activate.bat
C:\BuildTools\VC\Auxiliary\Build\vcvars64.bat -vcvars_ver=14.16 8.1

@ECHO ON
%*