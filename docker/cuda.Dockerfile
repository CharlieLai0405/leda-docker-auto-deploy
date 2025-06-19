FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

WORKDIR /LEDA

# 系統相依套件 
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    libzbar0 libdmtx0b ffmpeg libsm6 libxext6 libglib2.0-0 \
    build-essential cmake tzdata git libstdc++6 g++ pkg-config \
    libopencc-dev python3.8 python3.8-dev python3-pip && \
    ln -sf /usr/bin/python3.8 /usr/bin/python && \
    pip install --upgrade pip setuptools wheel

# 複製程式碼 
COPY . /LEDA
COPY ./requirements.txt /LEDA/requirements.txt

# 基礎 Python 依賴
RUN pip install numpy cython

# 先裝 pycocotools（GitHub 來源）
RUN pip install git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI

# 安裝 PyTorch GPU 版本
RUN pip install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 \
    --index-url https://download.pytorch.org/whl/cu118

# 其他 requirements
RUN pip install --no-cache-dir -r Cuda_requirements.txt

# 確保 opencc 從 source 編譯
ENV PIP_NO_BINARY=opencc            
RUN pip uninstall -y opencc || true && \
    pip install --no-build-isolation opencc==1.1.9

# 建立資料夾
RUN mkdir -p /LEDA/data /LEDA/store/upload /LEDA/dist

CMD ["python", "app.py"]
