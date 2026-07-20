#!/usr/bin/env sh
# Maps the Home Assistant add-on options (/data/options.json) to the
# WEEBSYNC_*/OIDC_* environment the binary reads, then execs it.
set -eu

OPT=/data/options.json
[ -f "$OPT" ] || { OPT=/tmp/options.json; echo '{}' > "$OPT"; }

opt() {
  jq -r --arg k "$1" --arg d "$2" \
    'if has($k) and .[$k] != null and .[$k] != "" then .[$k] else $d end' "$OPT"
}

# fixed paths (add-on maps): config persists the sqlite DB + secret.key
export WEEBSYNC_DATA=/config
export WEEBSYNC_WEB=/web
export WEEBSYNC_ADDR=":8080"
export WEEBSYNC_DOWNLOADS="$(opt downloads_dir /media/weebsync)"
export TZ="$(opt tz UTC)"

set_if() { v="$(opt "$1" "")"; [ -n "$v" ] && export "$2=$v" || true; }
set_if secret            WEEBSYNC_SECRET
set_if base_url          WEEBSYNC_BASE_URL
set_if anilist_token     ANILIST_TOKEN
set_if oidc_issuer       OIDC_ISSUER
set_if oidc_client_id    OIDC_CLIENT_ID
set_if oidc_client_secret OIDC_CLIENT_SECRET
set_if oidc_redirect_url OIDC_REDIRECT_URL
set_if oidc_provider_name OIDC_PROVIDER_NAME
set_if oidc_claim         OIDC_CLAIM
set_if oidc_admin_values  OIDC_ADMIN_VALUES
set_if oidc_user_values   OIDC_USER_VALUES

[ "$(opt trusted_proxy false)" = "true" ] && export WEEBSYNC_TRUSTED_PROXY=true || true
[ "$(opt force_https false)"   = "true" ] && export WEEBSYNC_FORCE_HTTPS=true   || true

# downloads_dir may be a ":"-separated allowlist of roots (e.g. "/media:/share")
# so targets can live under any mounted path; create each one.
OLDIFS=$IFS; IFS=:
for d in $WEEBSYNC_DOWNLOADS; do [ -n "$d" ] && mkdir -p "$d"; done
IFS=$OLDIFS
echo "[weebsync] data=$WEEBSYNC_DATA downloads=$WEEBSYNC_DOWNLOADS oidc=${OIDC_ISSUER:-off}"
exec /usr/bin/weebsync
