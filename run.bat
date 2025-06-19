@echo off

echo Checking for GPU environment...
where nvidia-smi >nul 2>nul

if %errorlevel%==0 (
    echo NVIDIA GPU detected. Launching CUDA container...
    docker-compose up -d --build cuda
) else (
    echo No GPU detected. Launching CPU container...
    docker-compose up -d --build cpu
)

echo Waiting for service to start...
ping -n 8 127.0.0.1 >nul

set "CHROME=C:\Program Files\Google\Chrome\Application\chrome.exe"
if exist "%CHROME%" (
     start "" "%CHROME%" http://127.0.0.1:8000
 ) else (
     echo Chrome not found, opening with default browser.
     start "" http://127.0.0.1:8000
 )

echo.
echo Container is running. To view logs use: docker-compose logs -f
pause
