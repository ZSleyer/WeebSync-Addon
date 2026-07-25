# Global build args (must precede the first FROM to be usable in FROM lines)
ARG BUILD_FROM
# the fallback only applies to a bare `docker build`; the add-on build passes
# WEEBSYNC_IMAGE from build.yaml, where it is pinned to a digest so the build
# host cannot substitute an older copy of the tag. Unpinned here on purpose: a
# hand-run build should follow the channel, not a digest frozen in this file.
ARG WEEBSYNC_IMAGE=ghcr.io/zsleyer/weebsync:nightly

# WeebSync app image (static Go binary + prebuilt web assets)
FROM ${WEEBSYNC_IMAGE} AS app

# HA add-on wrapper: base has a shell + jq to map options.json onto env vars.
# ffmpeg gives ffprobe, used to read the true resolution / audio / subtitle
# tracks of media whose file names lack those tokens.
FROM ${BUILD_FROM}
RUN apk add --no-cache jq tzdata ffmpeg

COPY --from=app /weebsync /usr/bin/weebsync
COPY --from=app /web /web
COPY rootfs/ /
RUN chmod +x /usr/bin/run-weebsync.sh

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD /usr/bin/weebsync -healthcheck || exit 1

ENTRYPOINT ["/usr/bin/run-weebsync.sh"]
