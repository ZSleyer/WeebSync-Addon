# Security

## Reporting a vulnerability

Report it privately through GitHub: **Security > Report a vulnerability** on
this repository. Do not open a public issue for a security problem.

This repository only packages the upstream app. A finding in WeebSync itself
belongs in [its repository](https://github.com/ZSleyer/WeebSync/security);
report it here when it concerns the add-on wrapper: the AppArmor profile, the
s6 services, or how Home Assistant options reach the container.

## Supported versions

Only the latest published add-on version, which tracks
`ghcr.io/zsleyer/weebsync:dev`.

## What the add-on exposes

- A **web UI on port 8080**, mapped to host port 42380 by default. It is not
  behind Home Assistant's ingress, so it is reachable by anyone who can reach
  the host on that port.
- The add-on's `/config` directory holds the **SQLite database and
  `secret.key`**, which decrypts the stored S/FTP credentials. Back it up, and
  treat a backup of it as a credential store.
- Write access to `media` and `share`, so downloads can land where Home
  Assistant already keeps files.

Enable `force_https` and put a TLS-terminating proxy in front when the UI is
reachable from outside the local network.
