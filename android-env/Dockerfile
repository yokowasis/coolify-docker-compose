# Use an Ubuntu base image with OpenJDK 17
FROM ubuntu:24.04

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Set environment variables for the Android SDK
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools:$PATH

# Set environment variables for micromamba
ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV PATH=$MAMBA_ROOT_PREFIX/bin:$PATH

# Install required dependencies and Node.js LTS
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk \
    wget \
    unzip \
    git \
    curl \
    gnupg \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    && \
    # Install Node.js LTS
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    # Install micromamba
    curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj -C /usr/local/bin --strip-components=1 bin/micromamba && \
    # Clean up
    rm -rf /var/lib/apt/lists/*

# Create the base environment and install Python packages
RUN micromamba create --yes --name base python=3.10 && \
    micromamba install --yes --name base fastapi[standard] pydantic jinja2 requests rembg pillow && \
    micromamba clean --all --yes

# Configure micromamba shell
SHELL ["/usr/local/bin/micromamba", "run", "-n", "base", "/bin/bash", "-c"]

# Install Yarn and pnpm
RUN npm install -g yarn pnpm

# Download and install the Android Command Line Tools
RUN mkdir -p /opt/android-sdk/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /cmdline-tools.zip && \
    unzip /cmdline-tools.zip -d /opt/android-sdk/cmdline-tools && \
    mv /opt/android-sdk/cmdline-tools/cmdline-tools /opt/android-sdk/cmdline-tools/latest && \
    rm /cmdline-tools.zip

# Accept Android SDK licenses
RUN yes | sdkmanager --licenses

# Install Android SDK components
RUN sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-8.3-bin.zip -O /gradle.zip && \
    unzip /gradle.zip -d /opt && \
    ln -s /opt/gradle-8.3/bin/gradle /usr/bin/gradle && \
    rm /gradle.zip

# Default command to provide an interactive shell
CMD ["micromamba", "run", "-n", "base", "bash"]
