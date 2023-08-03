#
# Dockerfile
#
FROM container-registry.oracle.com/os/oraclelinux:8-slim as base

LABEL maintainer="Daniel Armbrust <darmbrust@gmail.com>"

ENV PYTHONUNBUFFERED=1

WORKDIR /opt/celery-classifiedad

COPY requirements.txt ./
COPY docker-entrypoint.sh ./

RUN microdnf update -y && \
    microdnf install -y python3.8 && \
    python -m ensurepip && \
    python -m pip install --no-cache-dir --upgrade pip setuptools && \
    python -m pip install --no-cache-dir -r requirements.txt && \     
    microdnf clean all && rm -rf /var/cache/yum

RUN adduser -l -d /opt/celery-classifiedad celery

COPY --chown=celery:celery ./app /opt/celery-classifiedad/

# Environment: DEV
FROM base as envdev
COPY --chown=celery:celery ./ocisecrt/ /opt/celery-classifiedad/ocisecrt/

USER celery

EXPOSE 5555
EXPOSE 8100

ENTRYPOINT ["./docker-entrypoint.sh"]