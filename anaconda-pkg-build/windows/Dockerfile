FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]
WORKDIR C:/Users/Administrator

# Download VS 2019 Build Tools and install the 14.16 Version (VS 2017)
# Based on https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2019
RUN powershell -Command " \
    $url = \"https://aka.ms/vs/16/release/vs_buildtools.exe\"; \
    $client = new-object System.Net.WebClient; \
    $client.DownloadFile( $url, \"vs_buildtools.exe\"); \
    " && \
    vs_buildtools.exe --quiet --wait --norestart --nocache \
        --installPath C:\BuildTools \
        --add "Microsoft.VisualStudio.Workload.VCTools;includeRecommended" \
        --add Microsoft.VisualStudio.Component.VC.v141 \
        --add Microsoft.VisualStudio.Component.VC.v141.x86.x64 \
        --add Microsoft.VisualStudio.Component.Windows81SDK \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.17763 && \
    del vs_buildtools.exe

# hadolint ignore=DL3059
RUN powershell -Command " \
    $url = \"https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Windows-x86_64.exe\"; \
    $client = new-object System.Net.WebClient; \
    $client.DownloadFile( $url, \"miniconda3.exe\"); \
    ./miniconda3.exe /S /D=C:\Users\Administrator\miniconda3 | Write-Output; \
    del miniconda3.exe; \
    ./miniconda3/Scripts/conda clean --all -y; \
    " && \
    miniconda3\Scripts\activate.bat && \
    conda update --all --yes && \
    conda install conda-build posix --yes && \
    conda config --set anaconda_upload false && \
    conda clean --all --yes && \
    conda config --system --set show_channel_urls True && \
    conda config --system --set add_pip_as_python_dependency False && \
    conda config --show-sources

COPY entry-cmd.bat entry-bash.bat runner.sh ./

# ENTRYPOINT Windows notes
# the command form (["command", "arg1", "arg2"]) does not work right on Windows
# the script form (command arg1 arg2, not sure if quotes work) does work correctly, with the CMD (the positional params to docker run)
# appended as extra arguments to the entrypoint.

# hadolint ignore=DL3025

# this would allow you to choose between cmd and bash if we can figure out how to pass the cmd+args from docker run to it
#ENTRYPOINT entry-cmd.bat
#ENTRYPOINT entry-bash.bat

# the [cmd arg] format does not correctly pass docker run cmd+args to entrypoint
ENTRYPOINT miniconda3\Library\usr\bin\bash.exe /c/Users/Administrator/runner.sh
#ENTRYPOINT miniconda3\Scripts\activate.bat&& C:\BuildTools\VC\Auxiliary\Build\vcvars64.bat -vcvars_ver=14.16 8.1&& cd C:/Users/Administrator&& cmd /S /C dir
