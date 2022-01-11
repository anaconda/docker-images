@REM Passes all arguments to runner.sh after setting up conda and compiler environments
@REM This exists to work around unexpected behavior in Windows docker entrypoints

@ECHO ON
echo Executing bash commands %*
C:\Users\Administrator\miniconda3\Scripts\activate.bat
@REM C:\BuildTools\VC\Auxiliary\Build\vcvars64.bat -vcvars_ver=14.16 8.1

@REM runner.sh is necessary b/c if -c was used then we'd have to quote the args as a single string
@REM and they probably wouldn't parse back into the same arguments because the quotes aren't escaped
C:\Users\Administrator\miniconda3\Library\usr\bin\bash.exe C:\Administrator\Users\runner.sh %*