```dockerfile
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Node.js, Python, Git, Supervisor aur Caddy install karein
RUN apt-get update && apt-get install -y \
    curl git nodejs npm python3 python3-pip supervisor wget \
    && rm -rf /var/lib/apt/lists/*

# Code-server (VS Code in browser) install
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Caddy (reverse proxy) install
RUN apt-get install -y debian-keyring debian-archive-keyring apt-transport-https && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && \
    apt-get update && apt-get install -y caddy

# Workspace folder (persistent storage ke liye)
RUN mkdir -p /workspace && mkdir -p /app/landing

# Landing page copy
COPY landing/index.html /app/landing/index.html

# Caddy configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Supervisor config (dono services ek saath chalane ke liye)
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

ENV PASSWORD="admin123"   
ENV USER=root
# <-- Isko apna strong password change karein

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
```
