# syntax=docker/dockerfile:1

FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt ./
RUN python -m pip install --no-cache-dir --upgrade pip \
    && python -m pip install --no-cache-dir -r requirements.txt

COPY main.py log.py user.py config.json.example ./

# Keep credentials and runtime state outside the image.
WORKDIR /data

STOPSIGNAL SIGINT

ENTRYPOINT ["python", "/app/main.py"]
