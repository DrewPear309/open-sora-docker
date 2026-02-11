# Use NVIDIA CUDA base image compatible with Ubuntu 22.04
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /workspace

# Install basic system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    git \
    wget \
    build-essential \
    cmake \
    ninja-build \
    pkg-config \
    libaio-dev \
    libnuma-dev \
    libgoogle-perftools-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip3 install --upgrade pip setuptools wheel

# Copy your install script into container
COPY open-sora.sh /workspace/open-sora.sh

# Make script executable
RUN chmod +x /workspace/open-sora.sh

# Run your Open-Sora install script
RUN /workspace/open-sora.sh

# Default command when container starts
CMD ["/bin/bash"]
