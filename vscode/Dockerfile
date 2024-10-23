FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    apt-transport-https \
    software-properties-common

# Install NVM and Node.js
ENV NVM_DIR=/opt/nvm
RUN mkdir -p $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash \
    && bash -c 'source $NVM_DIR/nvm.sh && nvm install 20'
ENV PATH=$NVM_DIR/versions/node/v20.0.0/bin:$PATH

# Install Microsoft VS Code
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list \
    && apt-get update \
    && apt-get install -y code \
    && rm /usr/share/keyrings/microsoft.gpg

# Install Python and virtualenv
RUN apt-get update && apt-get install -y python3.10 python3.10-venv \
    && python3.10 -m venv /opt/venv \
    && . /opt/venv/bin/activate

ENV TOKEN="333333"

# Start VS Code to listen on all interfaces and with specified connection token
ENTRYPOINT ["sh", "-c", ". /opt/nvm/nvm.sh && /usr/bin/code serve-web --host 0.0.0.0 --port 8080 --connection-token $TOKEN"]

# Expose port 8080 (default port for VS Code)
EXPOSE 8080
