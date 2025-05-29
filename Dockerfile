FROM python:3.9-slim

# Установим зависимости и docker CLI + compose plugin
RUN apt-get update && \
    apt-get install -y curl gnupg lsb-release ca-certificates apt-transport-https && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
        > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    mkdir -p /usr/lib/docker/cli-plugins && \
    curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
        -o /usr/lib/docker/cli-plugins/docker-compose && \
    chmod +x /usr/lib/docker/cli-plugins/docker-compose && \
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

