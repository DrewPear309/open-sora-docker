#!/bin/bash

# Set environment variable to reduce CUDA memory fragmentation
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

# Install CUDA runtime libraries and other dependencies
sudo apt install -y libcuda1-570 libgoogle-perftools-dev

# Fix the libcuda.so symlink (critical for Triton/Inductor compilation)
sudo ln -sf /usr/lib/x86_64-linux-gnu/libcuda.so.1 /usr/lib/x86_64-linux-gnu/libcuda.so


# Update package list
sudo apt update

# Install OS-level build dependencies required for TensorNVMe and other packages
sudo apt install -y build-essential cmake ninja-build pkg-config git \
                    libaio-dev libnuma-dev python3-dev

# Clone the Open-Sora repository
git clone https://github.com/hpcaitech/Open-Sora
cd Open-Sora

# Install the package in development mode
pip install -v .

# Install xformers for CUDA 12.1 (compatible with torch 2.4.0+cu121)
pip install xformers==0.0.27.post2 --index-url https://download.pytorch.org/whl/cu121

# Install FlashAttention without build isolation (assumes CUDA is already set up)
pip install flash-attn --no-build-isolation

# Install huggingface_hub with CLI support
pip install "huggingface_hub[cli]"

# Download Open-Sora model weights to ./ckpts folder
huggingface-cli download hpcai-tech/Open-Sora-v2 --local-dir ./ckpts

# Install tensornvme (needed for advanced memory management in Open-Sora)
pip install git+https://github.com/hpcaitech/TensorNVMe.git

echo "Open-Sora full setup completed successfully!"
