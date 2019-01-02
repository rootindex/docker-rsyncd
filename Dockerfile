FROM alpine:latest

RUN set -xe \
    && apk add --no-cache rsync \
    && rm -rf /var/cache/apk/*

ADD rootfs /

EXPOSE 873

WORKDIR /data

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "/usr/local/bin/healthcheck.sh" ]

CMD ["rsync", "--daemon", "--no-detach", "--log-file", "/proc/self/fd/1", "--config", "/etc/rsyncd.conf"]

ENTRYPOINT [ "/entrypoint.sh" ]