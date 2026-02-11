#!/bin/bash

# Update package list
sudo apt update

# Remove any existing incorrect repos (like debian ones)
sudo rm -f /etc/apt/sources.list.d/cuda-*-local.list

# Install the correct CUDA keyring for Ubuntu 22.04
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update

# Install the NVIDIA proprietary driver (version 570 is stable for CUDA 12.x)
sudo apt-get install -y nvidia-driver-570

# Install CUDA Toolkit 12.8 (matches PyTorch cu121 well)
sudo apt-get install -y cuda-toolkit-12-8

# Set environment variables for CUDA
echo 'export CUDA_HOME=/usr/local/cuda' >> ~/.bashrc
echo 'export PATH=$CUDA_HOME/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc

# Reload bashrc to apply changes
source ~/.bashrc

# Reboot to activate the driver
echo "Rebooting system to activate the driver..."
sudo reboot
