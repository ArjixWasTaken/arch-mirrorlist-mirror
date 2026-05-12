# Arch Linux Mirror Status Mirror

Mirrors the [Arch Linux mirror status JSON](https://archlinux.org/mirrors/status/json/) daily and hosts it via GitHub Pages.

## Data

- **Site**: https://arjixwastaken.github.io/arch-mirrorlist-mirror/
- **JSON**: https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json

```bash
curl https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json
```

## Setup

Requires `curl`, `git`, and git push authentication configured.

```bash
git clone https://github.com/ArjixWasTaken/arch-mirrorlist-mirror.git ~/arch-mirrorlist-mirror
cd ~/arch-mirrorlist-mirror
chmod +x update-mirrors.sh
systemctl --user link ./arch-mirror-update.service
systemctl --user link ./arch-mirror-update.timer
systemctl --user daemon-reload
systemctl --user enable --now arch-mirror-update.timer
sudo loginctl enable-linger $USER  # optional: run when not logged in
```

See [SYSTEMD_SETUP.md](SYSTEMD_SETUP.md) for managing, customizing, and troubleshooting the timer.
