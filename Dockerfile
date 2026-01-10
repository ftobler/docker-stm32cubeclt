FROM ubuntu:24.04



# Basic deps STM tools tend to need
# RUN apt-get update && apt-get install -y \
#     ca-certificates \
#     curl \
#     unzip \
#     xz-utils \
#     libusb-1.0-0 \
#     && rm -rf /var/lib/apt/lists/*

# WORKDIR /opt/st

# Copy the installer (provided by GitHub Actions build context)
COPY st-stm32cubeclt_amd64.deb_bundle.zip .

ENV DEBIAN_FRONTEND=noninteractive
ENV LICENSE_ALREADY_ACCEPTED=1

# Make it executable and run it
RUN apt-get update && apt-get install unzip -y \
    unzip *.zip \
    rm *.zip \
    mv *.sh st-stm32cubeclt_amd64.deb_bundle.sh \
    chmod +x *.sh && \
    st-stm32cubeclt_amd64.deb_bundle.sh \
    rm *.sh

# STM tools usually end up here
ENV PATH="/opt/st/stm32cubeclt_1.20.0"

CMD ["bash"]
