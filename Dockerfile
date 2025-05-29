FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt requirements.txt
COPY app.py app.py
RUN curl -L "https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose && \ chmod +x /usr/local/bin/docker-compose
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD [python, app.py]

