@REM Setups up conda and compiler environments and then executes args
@REM This exists to work around unexpected behavior in Windows docker entrypoints

echo Executing bat commands %*
C:\Users\Administrator\miniconda3\Scripts\activate.bat

@REM commented out b/c compiler not installed
@REM C:\BuildTools\VC\Auxiliary\Build\vcvars64.bat -vcvars_ver=14.16 8.1



%*