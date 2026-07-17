# WeebSync — Home Assistant Add-on

Home Assistant add-on repository for [WeebSync](https://github.com/ZSleyer/WeebSync):
download & sync anime folders from your own S/FTP servers, with an AniList/TMDB
catalog, a download manager, and a rename engine.

> **Early, use at your own risk.** Not a mature or well-tested app.

## Install

Settings → Add-ons → Store → ⋮ → **Repositories** → add:

```
https://github.com/ZSleyer/WeebSync-Addon
```

Then install **WeebSync**. See [the add-on docs](weebsync/DOCS.md) for options.

## How it works

The add-on wraps the prebuilt multi-arch image `ghcr.io/zsleyer/weebsync` and maps
Home Assistant options to the app's environment. A workflow tracks the upstream
image and bumps the add-on version automatically, so a new upstream build surfaces
as a normal add-on update. Currently tracks the `:dev` tag.

## License

[AGPL-3.0](LICENSE).
