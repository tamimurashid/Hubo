#!/bin/bash

# Define the virtual environment name
VENV_NAME="hubovenv"

# Check if the virtual environment directory exists and remove it if it does
if [ -d "$VENV_NAME" ]; then
    echo "Removing existing virtual environment: $VENV_NAME"
    rm -rf "$VENV_NAME"
fi

# Create a new virtual environment
echo "Creating a new virtual environment: $VENV_NAME"
python3 -m venv "$VENV_NAME"

# Activate the virtual environment
source "$VENV_NAME/bin/activate"


# Define the packages to install
PACKAGES=(
    "wikipedia"
    "pyaudio"
    "pygame"
    "pyttsx3"
    "SpeechRecognition"
    "openai"      # For ChatGPT model
    "pyserial"
    "torch"       # For PyTorch
    "numpy"
    "pandas"
)

# Initialize counters for success and failure
SUCCESS_COUNT=0
FAILURE_COUNT=0

# Install each package and check the result
for PACKAGE in "${PACKAGES[@]}"; do
    echo "Installing $PACKAGE..."
    pip install "$PACKAGE"
    if [ $? -eq 0 ]; then
        echo "$PACKAGE installed successfully."
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    else
        echo "Failed to install $PACKAGE."
        FAILURE_COUNT=$((FAILURE_COUNT + 1))
    fi
done

cd python_files/face_recorgnition/ 
echo "installing yolov3 package for image recorgnition"
git clone https://github.com/zzh8829/yolov3-tf2.git

# Deactivate the virtual environment
# deactivate

# Print a summary of the installation results
echo "Setup complete."
echo "Successfully installed packages: $SUCCESS_COUNT"
echo "Failed to install packages: $FAILURE_COUNT"
