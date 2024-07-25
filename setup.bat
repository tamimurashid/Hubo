@echo off
setlocal

REM Define the virtual environment name
set VENV_NAME=hubovenv

REM Check if the virtual environment directory exists and remove it if it does
if exist %VENV_NAME% (
    echo Removing existing virtual environment: %VENV_NAME%
    rmdir /s /q %VENV_NAME%
)

REM Create a new virtual environment
echo Creating a new virtual environment: %VENV_NAME%
python -m venv %VENV_NAME%

REM Activate the virtual environment
call %VENV_NAME%\Scripts\activate

REM Define the packages to install
set PACKAGES=wikipedia pyaudio pygame pyttsx3 SpeechRecognition openai pyserial torch numpy pandas

REM Initialize counters for success and failure
set SUCCESS_COUNT=0
set FAILURE_COUNT=0

REM Install each package and check the result
for %%P in (%PACKAGES%) do (
    echo Installing %%P...
    pip install %%P
    if %ERRORLEVEL% equ 0 (
        echo %%P installed successfully.
        set /a SUCCESS_COUNT+=1
    ) else (
        echo Failed to install %%P.
        set /a FAILURE_COUNT+=1
    )
)

REM Deactivate the virtual environment
deactivate

REM Print a summary of the installation results
echo Setup complete.
echo Successfully installed packages: %SUCCESS_COUNT%
echo Failed to install packages: %FAILURE_COUNT%

endlocal
