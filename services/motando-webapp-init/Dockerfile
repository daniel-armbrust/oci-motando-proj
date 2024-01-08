#
# Dockerfile
#
FROM container-registry.oracle.com/os/oraclelinux:8-slim

LABEL maintainer="Daniel Armbrust <darmbrust@gmail.com>"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /

COPY motando-webapp-init.sh ./

RUN microdnf update -y && \
    microdnf install -y oraclelinux-developer-release-el8 && \
    microdnf install -y python36-oci-cli && \
    microdnf install -y gcc python38-devel python3.8 mysql mysql-devel git && \    
    ln -sf /usr/bin/python3.8 /usr/bin/python && \    
    ln -sf /usr/bin/pip3.8 /usr/bin/pip && \    
    python -m ensurepip && \
    python -m pip install --no-cache-dir --upgrade pip setuptools && \
    microdnf clean all && rm -rf /var/cache/yum

ENTRYPOINT ["./motando-webapp-init.sh"]