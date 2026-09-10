# WeebSync

Download & sync anime folders from your own S/FTP servers, with an AniList/TMDB
metadata catalog, a download manager with live speed throttling, and a rename engine.

> **Early, use at your own risk.** Not a mature or well-tested app.

This add-on wraps the prebuilt image `ghcr.io/zsleyer/weebsync`, see
[ZSleyer/WeebSync](https://github.com/ZSleyer/WeebSync).

## Installation

1. Add this repository to the add-on store (Settings > Add-ons > Store > three-dot menu > Repositories):
   `https://github.com/ZSleyer/WeebSync-Addon`
2. Install **WeebSync**, start it, open the Web UI.
3. The first registered user becomes admin. Configure servers/rename in the UI.

## Data

- `/config` (add-on config): SQLite DB + `secret.key` (auto-generated, **back it up**)
- `downloads_dir`: where downloads land (default `/media/weebsync`). Accepts a
  single path, or a `:`-separated allowlist of roots (e.g. `/media/anime:/media/tv`)
  to let targets live under any of them; the first is the default download root.
  Only `media` is mounted; the add-on gets no other host directory.

## Options

Everything runtime-related (throttling, auth mode, AniList token, …) is also
configurable in the app UI as admin. Options set here **override** the UI and
lock the field.

| Option | Purpose |
|---|---|
| `tz` | Timezone for log timestamps (e.g. `Europe/Berlin`) |
| `downloads_dir` | Download root, or `:`-separated roots (all under the mounted `media`) |
| `trusted_proxies` | Reverse proxies whose `X-Forwarded-*` headers to believe, as a comma-separated list of IPs/CIDRs (e.g. `172.30.0.0/16`) |
| `trusted_proxy` | Older blanket form of the above: trust whatever proxy the request arrives from. `trusted_proxies` wins when both are set |
| `force_https` | Force the `Secure` flag on cookies, enable behind a TLS proxy |
| `base_url` | Public URL, e.g. `https://weebsync.example.com` |
| `secret` | AES-GCM key for stored server passwords. Empty = auto-generated in `/config/secret.key` |
| `anilist_token` | AniList API token (higher rate limit) |
| `oidc_*` | Generic OIDC login: issuer, client id/secret, redirect URL, provider name, and role mapping via `oidc_claim` (e.g. `groups`) + `oidc_admin_values`/`oidc_user_values` (comma-separated) |

### Behind a reverse proxy + OIDC

Set `trusted_proxies` to the address your proxy talks to WeebSync from (for a
Home Assistant add-on that is usually `172.30.0.0/16`), `force_https: true`,
`base_url: https://weebsync.example.com`, and the `oidc_*` options. The redirect
URL is `https://weebsync.example.com/api/auth/oidc/callback`, register it with
your provider.

Naming the proxy matters: without it every request looks like it comes from the
proxy, so the per-IP login rate limit lumps all callers into one bucket. Trusting
`X-Forwarded-For` from *anywhere* is worse - a client reachable directly could
then choose its own address and slip past that limit.

**Both options are optional.** Leave them unset and the same two settings can be
configured in WeebSync itself, under Settings -> Security. Set here, they win
over the stored value and the app shows the field locked with an `ENV` badge, so
the two ways of running the app never disagree about which value is in effect.

## Ports

Internal `8080` is not published on the host by default. Point your reverse
proxy at the add-on's hostname on port `8080` (`8fbcfe04-weebsync:8080` from
another add-on such as Nginx Proxy Manager). A published host port sits behind
Docker's proxy, which hands the app a source address inside the add-on
network - the one `trusted_proxies` is meant for - so anything reaching that
port could set `X-Forwarded-For` itself. Publish it under the Network tab only
for a LAN-only install without a proxy.
