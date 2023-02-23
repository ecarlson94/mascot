FROM cirrusci/flutter

RUN sudo apt-get update \
    && sudo apt-get upgrade -y \
    && export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get install --yes --no-install-recommends lcov wget clang cmake ninja-build pkg-config libgtk-3-dev

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install

# Install mkcert
ARG MKCERT_VERSION=v1.4.3
RUN wget https://github.com/FiloSottile/mkcert/releases/download/$MKCERT_VERSION/mkcert-$MKCERT_VERSION-linux-amd64 \
    && cp mkcert-$MKCERT_VERSION-linux-amd64 /usr/local/bin/mkcert \
    && chmod +x /usr/local/bin/mkcert
