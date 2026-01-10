FROM ubuntu:24.04

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

RUN apt-get update \
    && apt-get install -y nodejs npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV STM32CLT_DIR="/opt/st/stm32cubeclt_1.20.0"
ENV PATH="${PATH}:${STM32CLT_DIR}"

RUN if [ ! -d "$STM32CLT_DIR" ]; then \
    echo "Error: $STM32CLT_DIR is missing! The installation failed."; \
    exit 1; \
fi

CMD ["/bin/bash"]
