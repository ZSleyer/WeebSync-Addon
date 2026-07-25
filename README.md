# WeebSync Home Assistant Add-on

Home Assistant add-on repository for [WeebSync](https://github.com/ZSleyer/WeebSync):
download and sync anime folders from your own S/FTP servers, with an AniList/TMDB
catalog, a download manager with live speed throttling, and a rename engine.

> **Early, use at your own risk.** Not a mature or well-tested app.

## Install

Settings > Add-ons > Store > three-dot menu > **Repositories**, then add:

```
https://github.com/ZSleyer/WeebSync-Addon
```

Install **WeebSync** from the store afterwards. Its options are documented in
[the add-on docs](weebsync/DOCS.md).

## How it works

The add-on wraps the prebuilt multi-arch image `ghcr.io/zsleyer/weebsync` and maps
Home Assistant options onto the app's environment, so nothing is built here.

`.github/workflows/track-upstream.yml` polls the digest of the tracked image every
30 minutes and bumps the add-on version whenever it changes. Home Assistant then
offers it like any other add-on update. The tag it follows is read from
`weebsync/build.yaml` (`WEEBSYNC_IMAGE`), currently `:nightly`, which upstream
rebuilds once a day from `main`.

Home Assistant installs an update automatically only once that version is at least
a day old, and it looks for updates every 16 hours, so an automatic upgrade lands
roughly one to two days after an upstream build. Pressing **Update** on the add-on
page applies it right away.

## Storage

The add-on keeps its SQLite database and the generated `secret.key` in `/config`,
its own config directory. **Back that directory up:** without `secret.key` the
stored server credentials cannot be decrypted.

## License

[AGPL-3.0](LICENSE).
