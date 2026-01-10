FROM ubuntu:24.04

# Basic deps STM tools tend to need
# RUN apt-get update && apt-get install -y \
#     ca-certificates \
#     curl \
#     unzip \
#     xz-utils \
#     libusb-1.0-0 \
#     && rm -rf /var/lib/apt/lists/*


ENV DEBIAN_FRONTEND=noninteractive
ENV LICENSE_ALREADY_ACCEPTED=1

RUN apt-get update \
    && apt-get install unzip wget -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && wget https://github.com/ftobler/docker-STM32CubeCLT/releases/download/test/st-stm32cubeclt_1.20.0_26822_20251117_1245_amd64.deb_bundle.sh.zip \
    && mv *.zip st-stm32cubeclt_amd64.deb_bundle.zip \
    && unzip *.zip \
    && rm *.zip \
    && mv *.sh st-stm32cubeclt_amd64.deb_bundle.sh \
    && chmod +x *.sh \
    && ./st-stm32cubeclt_amd64.deb_bundle.sh \
    && rm *.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# STM tools usually end up here
ENV PATH="/opt/st/stm32cubeclt_1.20.0"

CMD ["bash"]
