#!/bin/bash

echo "Checking for GPU environment..."

if command -v nvidia-smi &> /dev/null && nvidia-smi > /dev/null 2>&1; then
  echo "NVIDIA GPU detected. Starting CUDA container..."
  xdg-open http://127.0.0.1:8000 2>/dev/null || open http://127.0.0.1:8000
  docker-compose up --build cuda
else
  echo "No GPU detected. Starting CPU container..."
  xdg-open http://127.0.0.1:8000 2>/dev/null || open http://127.0.0.1:8000
  docker-compose up --build cpu
fi
