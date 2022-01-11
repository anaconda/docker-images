@REM Passes all arguments to run.sh
@REM This exists to work around unexpected behavior in Windows docker entrypoints
@REM Windows has problems using anything except a single command (i.e. no args) in entrypoints
@REM Without this you'd only be able to us plain bash as the entry point, and then
@REM you'd always have to remember to use run.sh.

C:\Users\Administrator\miniconda3\Scripts\activate.bat
C:\BuildTools\VC\Auxiliary\Build\vcvars64.bat -vcvars_ver=14.16 8.1

%*