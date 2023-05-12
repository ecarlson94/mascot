FROM cirrusci/flutter

RUN sudo apt-get update \
    && sudo apt-get upgrade -y \
    && export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get install --yes --no-install-recommends lcov wget clang cmake ninja-build pkg-config libgtk-3-dev \
    && sudo apt-get install -y curl unzip git xvfb libxi6 libgconf-2-4 \
    && sudo apt-get install -y nodejs npm \
    && curl -sSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o chrome.deb \
    && dpkg -i chrome.deb || apt-get install -yf \
    && rm chrome.deb

ENV CHROME_BIN=/usr/bin/google-chrome-stable
ENV CHROME_PATH=/usr/bin/google-chrome-stable
ENV DISPLAY=:99

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - \
    && export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get install -y nodejs
RUN npm install -g browserify

# Install mkcert
ARG MKCERT_VERSION=v1.4.3
RUN wget https://github.com/FiloSottile/mkcert/releases/download/$MKCERT_VERSION/mkcert-$MKCERT_VERSION-linux-amd64 \
    && cp mkcert-$MKCERT_VERSION-linux-amd64 /usr/local/bin/mkcert \
    && chmod +x /usr/local/bin/mkcert
