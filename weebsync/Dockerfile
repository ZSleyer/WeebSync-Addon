# Global build args (must precede the first FROM to be usable in FROM lines)
ARG BUILD_FROM
ARG WEEBSYNC_IMAGE=ghcr.io/zsleyer/weebsync:dev

# WeebSync app image (static Go binary + prebuilt web assets)
FROM ${WEEBSYNC_IMAGE} AS app

# HA add-on wrapper: base has a shell + jq to map options.json → env
FROM ${BUILD_FROM}
RUN apk add --no-cache jq tzdata

COPY --from=app /weebsync /usr/bin/weebsync
COPY --from=app /web /web
COPY rootfs/ /
RUN chmod +x /usr/bin/run-weebsync.sh

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD /usr/bin/weebsync -healthcheck || exit 1

ENTRYPOINT ["/usr/bin/run-weebsync.sh"]
