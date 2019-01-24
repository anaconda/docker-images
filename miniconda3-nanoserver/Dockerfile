FROM mcr.microsoft.com/windows/servercore:1809 AS servercorebase

WORKDIR /tmp

RUN powershell (New-Object System.Net.WebClient).DownloadFile('https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86_64.exe', 'Miniconda3.exe')

RUN powershell Unblock-File Miniconda3.exe

RUN Miniconda3.exe /InstallationType=JustMe /RegisterPython=1 /S /D=C:\Miniconda3

FROM mcr.microsoft.com/windows/nanoserver:1809

COPY --from=servercorebase C:/Miniconda3 C:/Miniconda3

USER ContainerAdministrator

RUN setx /M PATH "%PATH%;C:\Miniconda3;C:\Miniconda3\Scripts;C:\Miniconda3\Library\bin"

CMD ["cmd"]