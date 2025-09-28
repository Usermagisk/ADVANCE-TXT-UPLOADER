FROM python:3.10-slim

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg aria2 gcc libffi-dev musl-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python requirements
RUN pip install --no-cache-dir -r requirements.txt

# Expose Flask port
ENV PORT=5000

# Run both Flask (via gunicorn) + main.py
CMD gunicorn --bind 0.0.0.0:$PORT app:app & python3 main.py
