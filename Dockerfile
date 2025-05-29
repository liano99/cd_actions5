FROM python:3.9-slim

# Установим curl, Docker CLI и docker compose plugin
RUN apt-get update && \
    apt-get install -y curl gnupg lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
        > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    mkdir -p ~/.docker/cli-plugins && \
    curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
        -o ~/.docker/cli-plugins/docker-compose && \
    chmod +x ~/.docker/cli-plugins/docker-compose && \
    docker --version && docker compose version && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Копируем приложение
WORKDIR /app
COPY requirements.txt requirements.txt
COPY app.py app.py
RUN pip install --no-cache-dir -r requirements.txt

# Порт и команда
EXPOSE 5000
CMD ["python", "app.py"]
