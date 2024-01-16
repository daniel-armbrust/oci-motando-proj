#
# Dockerfile
#
FROM container-registry.oracle.com/os/oraclelinux:8-slim as base

LABEL maintainer="Daniel Armbrust <darmbrust@gmail.com>"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /opt/webapp

COPY requirements.txt ./
COPY docker-entrypoint.sh ./

RUN microdnf update -y && \
    microdnf install -y gcc python38-devel python3.8 mysql-devel && \    
    python -m ensurepip && \    
    python -m pip install --no-cache-dir --upgrade pip setuptools && \
    python -m pip install --no-cache-dir -r requirements.txt && \
    python -m pip install --no-cache-dir oci-cli && \
    microdnf clean all && rm -rf /var/cache/yum

RUN adduser -l -d /opt/webapp webapp

COPY --chown=webapp:webapp ./motando /opt/webapp/motando/

USER webapp
EXPOSE 8000

ENTRYPOINT ["./docker-entrypoint.sh"]

# Environment: DEV
FROM base as envdev
COPY --chown=webapp:webapp ./ocisecrt/ /opt/webapp/ocisecrt/

ENTRYPOINT ["./docker-entrypoint.sh"]