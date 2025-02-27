FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    openssh-client \
    gnupg \
    ca-certificates \
    apt-transport-https \
    software-properties-common

# Install NVM and Node.js
ENV NVM_DIR=/opt/nvm
RUN mkdir -p $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash \
    && bash -c 'source $NVM_DIR/nvm.sh && nvm install 22.14.0 && npm i -g yarn pnpm'
ENV PATH=$NVM_DIR/versions/node/v22.14.0/bin:$PATH

# Install Microsoft VS Code
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list \
    && apt-get update \
    && apt-get install -y code \
    && rm /usr/share/keyrings/microsoft.gpg

# Install Python and virtualenv
RUN apt-get update -y && apt-get install -y python3.12 python3.12-venv \
    && python3.12 -m venv /opt/venv

# Install MariaDB, Apache, PHP and common PHP extensions
RUN apt-get update -y && apt-get install -y \
    gh \
    ffmpeg \
    yt-dlp \
    ssh \
    openjdk-17-jdk \
    wget \
    zip \
    unzip \
    bzip2 \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    php-cli \
    php-common \
    php-soap \
    php-redis \
    php-xdebug \
    ninja-build \
    gettext \
    cmake \
    curl \
    build-essential \
    mariadb-server \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    php-curl \
    php-mbstring \
    php-xml \
    php-zip \
    php-gd \
    php-bcmath \
    php-intl

# Set environment variable for token.
# (For sensitive data, consider passing it at runtime with -e TOKEN=your_token)
ENV TOKEN="3333333"

# Copy the entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose ports for VS Code (8080), Apache (80) and MariaDB (3306)
EXPOSE 8080 80 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
