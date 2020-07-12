FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y curl bash && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.3/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && chmod +x /usr/bin/kubectl && \
    curl -LO https://github.com/tsl0922/ttyd/releases/download/1.6.0/ttyd_linux.x86_64 && \
    mv ttyd_linux.x86_64 /usr/bin/ttyd && chmod +x /usr/bin/ttyd && \
    curl -LO https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 && \
    mv stern_linux_amd64 /usr/bin/stern && chmod +x /usr/bin/stern && \
    curl -LO https://github.com/jpillora/chisel/releases/download/v1.6.0/chisel_1.6.0_linux_amd64.gz && \
    gunzip chisel_1.6.0_linux_amd64.gz && mv chisel_1.6.0_linux_amd64 /usr/bin/chisel && chmod +x /usr/bin/chisel && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD bootstrap.sh /usr/bin/bootstrap.sh

RUN groupadd --gid 2100 system && \
    useradd system --uid 2100 --gid 2100 --shell /bin/bash --home-dir /home/system --create-home && \    
    chmod -R 775 /home/system

USER 2100
