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

# Install each package and check the result
for PACKAGE in "${PACKAGES[@]}"; do
    echo "Installing $PACKAGE..."
    pip install "$PACKAGE"
    if [ $? -eq 0 ]; then
        echo "$PACKAGE installed successfully."
    else
        echo "Failed to install $PACKAGE."
    fi
done

# Deactivate the virtual environment
deactivate

echo "Setup complete."
