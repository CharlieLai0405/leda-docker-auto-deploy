FROM python:3.8-slim

WORKDIR /LEDA

# 安裝系統套件
RUN apt-get update && apt-get install -y \
    libzbar0 libdmtx0b ffmpeg libsm6 libxext6 libglib2.0-0 \
    build-essential cmake \
    && pip install --upgrade pip

# 複製專案與需求檔案
COPY . /LEDA
COPY ./requirements.txt /LEDA/requirements.txt

# 安裝 PyTorch CPU 版本
RUN pip install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 --index-url https://download.pytorch.org/whl/cpu

# 安裝其他套件
RUN pip install -r requirements.txt

# 建立必備資料夾
RUN mkdir -p /LEDA/data /LEDA/store/upload /LEDA/dist

CMD ["python", "app.py"]
