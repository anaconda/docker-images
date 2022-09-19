FROM mcr.microsoft.com/windows/servercore:2009 AS buildbase

WORKDIR /tmp

# default and makes hadolint skip this intermediate container
SHELL [ "cmd", "/S", "/C" ]

RUN powershell (New-Object System.Net.WebClient).DownloadFile('https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Windows-x86_64.exe', 'Miniconda3.exe') && \
    powershell (Get-FileHash .\Miniconda3.exe).Hash -eq 'b33797064593ab2229a0135dc69001bea05cb56a20c2f243b1231213642e260a' && \
    powershell Unblock-File Miniconda3.exe && \
    Miniconda3.exe /InstallationType=JustMe /RegisterPython=1 /S /D=C:\Miniconda3

FROM mcr.microsoft.com/windows/nanoserver:1809

# default and makes hadolint skip this container
SHELL [ "cmd", "/S", "/C" ]

COPY --from=buildbase C:/Miniconda3 C:/Miniconda3

USER ContainerAdministrator

RUN C:\Miniconda3\Library\bin\conda init && \
    C:\Miniconda3\Library\bin\conda clean -afy

# Test
RUN conda list && \
    conda create --name testenv numpy --dry-run && \
    conda clean -afy

CMD ["cmd"]
