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
    microdnf install -y gcc python38-devel python3.8 mysql mysql-devel git && \
    python -m ensurepip && \
    python -m pip install --no-cache-dir --upgrade pip setuptools && \
    microdnf clean all && rm -rf /var/cache/yum

ENTRYPOINT ["./motando-webapp-init.sh"]