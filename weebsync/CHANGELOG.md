# Changelog

## 2026.11.1.1

WeebSync [`6170e2d`](https://github.com/ZSleyer/WeebSync/commit/6170e2dc98edc6acb303934fa7a25f07bb3cb8d6)

Add-on:

- fix: rewrite the user's ids in place so AppArmor lets the uid option work

## 2026.11.1

WeebSync [`6170e2d`](https://github.com/ZSleyer/WeebSync/commit/6170e2dc98edc6acb303934fa7a25f07bb3cb8d6)

Add-on:

- feat: options uid and gid to run as the media share's owner

## 2026.11.0.30

WeebSync [`6170e2d`](https://github.com/ZSleyer/WeebSync/commit/6170e2dc98edc6acb303934fa7a25f07bb3cb8d6)

- fix(files): keep the phone action bar inside its card
- fix(player): copy the root style into the PiP window through the CSSOM
- fix(security): refuse inline style attributes in the CSP
- fix(local): answer localExists from the folder cache
- test(player): give the scrollTop setter stub a block body
- build(deps): bump distroless/cc-debian13 from `d74d144` to `58e12be`
- build(deps): bump the go group in /backend with 2 updates
- build(deps): bump docker/login-action
- build(deps): bump the prod group in /frontend with 7 updates
- build(deps-dev): bump the dev group in /frontend with 3 updates
- fix(licenses): accept jassub 2.5.23, libass 0.17.5 under the same notices
- chore(licenses): update the third-party license inventory
- build(deps): bump the prod group across 1 directory with 2 updates
- build(deps-dev): bump oxfmt
- chore(licenses): update the third-party license inventory
- build(deps): bump react-router
- chore(licenses): update the third-party license inventory
- build(deps): go 1.26.11 and golang 1.27.4 for the net/http fix
- build(deps): bump distroless/cc-debian13 from `58e12be` to `e1f5543`
- build(deps): bump the go group in /backend with 2 updates
- build(deps-dev): bump @types/node in /frontend in the dev group
- build(deps): bump the prod group in /frontend with 6 updates
- test(auth): parse the logout token as a compact JWS
- chore(licenses): update the third-party license inventory
- build(deps): bump distroless/cc-debian13 from `e1f5543` to `809d04a`
- build(deps): bump the go group across 1 directory with 4 updates
- build(deps): bump the prod group across 1 directory with 5 updates
- build(deps-dev): bump the dev group across 1 directory with 5 updates
- fix(needs): number the rows without a counter mutated during render
- fix(licenses): accept jassub 2.5.36 under the same notices

Add-on:

- feat: follow the stable release again instead of :dev [skip ci]

## 2026.11.0.17.1

WeebSync [`65d4f39`](https://github.com/ZSleyer/WeebSync/commit/65d4f398133cec50064cafc96fe57fdcdbf92262)

Add-on:

- Merge pull request #2 from ZSleyer/feat/prebuilt-image

## 2026.11.0.17

WeebSync [`65d4f39`](https://github.com/ZSleyer/WeebSync/commit/65d4f398133cec50064cafc96fe57fdcdbf92262)

Add-on:

- Ship a prebuilt add-on image versioned after WeebSync, with changelog and image cleanup

