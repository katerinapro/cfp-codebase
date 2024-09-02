FROM python:3.9-slim

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

COPY rates/requirements.txt .

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-pip && \
    pip install --no-cache-dir -U gunicorn && \
    pip install --no-cache-dir -Ur requirements.txt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY rates/ .

EXPOSE 3000

CMD ["gunicorn", "-b", ":3000", "wsgi"]
