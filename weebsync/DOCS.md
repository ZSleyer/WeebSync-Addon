# WeebSync

Download & sync anime folders from your own S/FTP servers — with an AniList/TMDB
metadata catalog, a download manager with live speed throttling, and a rename engine.

> **Early, use at your own risk.** Not a mature or well-tested app.

This add-on wraps the prebuilt image `ghcr.io/zsleyer/weebsync` — see
[ZSleyer/WeebSync](https://github.com/ZSleyer/WeebSync).

## Installation

1. Add this repository to the add-on store (Settings → Add-ons → Store → ⋮ → Repositories):
   `https://github.com/ZSleyer/WeebSync-Addon`
2. Install **WeebSync**, start it, open the Web UI.
3. The first registered user becomes admin. Configure servers/rename in the UI.

## Data

- `/config` (add-on config) — SQLite DB + `secret.key` (auto-generated, **back it up**)
- `downloads_dir` — where downloads land (default `/media/weebsync`)

## Options

Everything runtime-related (throttling, auth mode, AniList token, …) is also
configurable in the app UI as admin. Options set here **override** the UI and
lock the field.

| Option | Purpose |
|---|---|
| `tz` | Timezone for log timestamps (e.g. `Europe/Berlin`) |
| `downloads_dir` | Download root (mapped to `media`/`share`) |
| `trusted_proxy` | Trust `X-Forwarded-*` — enable when behind a reverse proxy |
| `force_https` | Force the `Secure` flag on cookies — enable behind a TLS proxy |
| `base_url` | Public URL, e.g. `https://weebsync.example.com` |
| `secret` | AES-GCM key for stored server passwords. Empty = auto-generated in `/config/secret.key` |
| `anilist_token` | AniList API token (higher rate limit) |
| `oidc_*` | Generic OIDC login: issuer, client id/secret, redirect URL, provider name, and role mapping via `oidc_claim` (e.g. `groups`) + `oidc_admin_values`/`oidc_user_values` (comma-separated) |

### Behind a reverse proxy + OIDC

Set `trusted_proxy: true`, `force_https: true`, `base_url: https://weebsync.example.com`,
and the `oidc_*` options. The redirect URL is
`https://weebsync.example.com/api/auth/oidc/callback` — register it with your provider.

## Ports

Internal `8080` is published on host `42380` by default (change under the add-on's
Network tab). Point your reverse proxy at the add-on on port `8080`.
