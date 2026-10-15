# Global build args (must precede the first FROM to be usable in FROM lines)
ARG BUILD_FROM
# the fallback only applies to a bare `docker build`; the add-on build passes
# WEEBSYNC_IMAGE from build.yaml, where it is pinned to a digest so the build
# host cannot substitute an older copy of the tag. Unpinned here on purpose: a
# hand-run build should follow the channel, not a digest frozen in this file.
ARG WEEBSYNC_IMAGE=ghcr.io/zsleyer/weebsync:dev

# WeebSync app image (static Go binary + prebuilt web assets)
FROM ${WEEBSYNC_IMAGE} AS app

# HA add-on wrapper: base has a shell + jq to map options.json onto env vars.
# ffmpeg gives ffprobe, used to read the true resolution / audio / subtitle
# tracks of media whose file names lack those tokens.
FROM ${BUILD_FROM}
ARG BUILD_ARCH
# su-exec drops to the unprivileged user; the base image only has the
# busybox setpriv, which cannot change the uid. The user exists by name so
# su-exec keeps the groups the entrypoint adds for the GPU (see
# run-weebsync.sh); with a bare uid:gid it drops every supplementary group.
# Its home is /tmp: mesa keeps a shader cache there instead of failing to
# create one under /home.
# On amd64 the VA-API drivers let the player transcode on an Intel or AMD GPU;
# a Raspberry Pi has no H.264 encoder, so aarch64 stays without.
RUN apk add --no-cache jq tzdata ffmpeg su-exec \
    && if [ "$BUILD_ARCH" = amd64 ]; then apk add --no-cache intel-media-driver mesa-va-gallium; fi \
    && addgroup -g 65532 weebsync \
    && adduser -D -H -h /tmp -u 65532 -G weebsync weebsync

COPY --from=app /weebsync /usr/bin/weebsync
COPY --from=app /web /web
COPY rootfs/ /
RUN chmod +x /usr/bin/run-weebsync.sh

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD /usr/bin/weebsync -healthcheck || exit 1

ENTRYPOINT ["/usr/bin/run-weebsync.sh"]
