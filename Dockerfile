FROM ubuntu:20.04

WORKDIR /opt/tk4

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
            unzip \
            wget \
            c3270 \
            binutils \
            && \
    wget --no-check-certificate https://wotho.ethz.ch/tk4-/tk4-_v1.00_current.zip && \
    unzip tk4-_v1.00_current.zip && rm tk4-_v1.00_current.zip && \
    apt-get --purge autoremove -y \
            unzip \
            wget \
            && \
    rm -rf /var/lib/apt/lists/*

RUN mv /opt/tk4/dasd /opt/tk4/dasd.source
COPY mvs /opt/tk4/mvs
COPY setup-dasd /opt/tk4/setup-dasd
RUN chmod 0755 /opt/tk4/mvs /opt/tk4/setup-dasd

CMD ["/opt/tk4/mvs"]

EXPOSE 3270
EXPOSE 8038

