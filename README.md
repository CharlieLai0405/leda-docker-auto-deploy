# leda-docker-auto-deploy

> Dockerized AI inference service with GPU/CPU switching, multi-model support, and one-click startup via Flask API.

---

## Features

- **One-click launch** using `run.bat` (Windows) or `run.sh` (Linux/macOS)
- **Auto-detect GPU** and choose CUDA/CPU container accordingly
- **Dockerized backend** using `docker-compose`
- **RESTful API** with Flask + OpenAPI 3
- Auto-open web UI at: [http://127.0.0.1:8000](http://127.0.0.1:8000)

---

## Project Structure

```

├── run.bat / run.sh        # One-click launcher with GPU/CPU detection
├── docker-compose.yml      # Defines CPU and CUDA containers
├── docker/
│   ├── cuda.Dockerfile     # GPU-based image using CUDA
│   └── cpu.Dockerfile      # CPU-only image
├── requirements.txt        # Python dependency list

````

---

## Quick Start

### Clone the repository

```bash
git clone https://github.com/<your-username>/leda-docker-auto-deploy.git
cd leda-docker-auto-deploy
````

### One-click run

#### On Windows:

```bat
run.bat
```

#### On Linux/macOS:

```bash
chmod +x run.sh
./run.sh
```

> Automatically detects GPU via `nvidia-smi` and launches the right container.

---

## Docker Overview

* CUDA version: based on `nvidia/cuda` + PyTorch GPU
* CPU version: runs on `python:3.8` + PyTorch CPU
* Mounted volume: `.:/LEDA`
* Port: 8000 (default)

```bash
# Manual build (optional)
docker-compose build cuda     # for GPU
docker-compose build cpu      # for CPU
```

---

## API Preview

* All routes are hosted at `http://127.0.0.1:8000`
* Includes OpenAPI documentation
* Supports:

  * `/api/upload_single_file`
  * `/api/weight/upload`
  * `/api/listdirs`
  * `/api/get_infer_result/...`
  * `/api/download_result`
  * ...and more


