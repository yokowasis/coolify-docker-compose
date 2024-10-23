FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    apt-transport-https \
    software-properties-common

# Install Microsoft VS Code
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list \
    && apt-get update \
    && apt-get install -y code \
    && rm /usr/share/keyrings/microsoft.gpg

# Start VS Code to listen on all interfaces and with specified connection token
ENTRYPOINT ["sh", "-c", "/usr/bin/code serve-web --host 0.0.0.0 --port 8080 --connection-token $TOKEN"]

# Expose port 8080 (default port for VS Code)
EXPOSE 8080
