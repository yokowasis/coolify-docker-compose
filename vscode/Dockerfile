FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    apt-transport-https \
    software-properties-common

# Install Microsoft VS Code
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/ \
    && sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt-get update \
    && apt-get install -y code \
    && rm microsoft.gpg

ENV TOKEN=123123

# Set up VS Code to listen on all interfaces and with specified connection token
CMD ["--host", "0.0.0.0", "--port", "8080", "--connection-token", "${TOKEN}"]

# Expose port 8080 (default port for VS Code)
EXPOSE 8080

# Start VS Code
ENTRYPOINT ["/usr/bin/code", "serve-web"]
