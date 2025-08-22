# Arch Linux Mirror Status Mirror

This repository automatically mirrors the Arch Linux mirror status JSON data and hosts it via GitHub Pages.

## 🔄 Automated Updates

The mirror status data is automatically fetched from [https://archlinux.org/mirrors/status/json/](https://archlinux.org/mirrors/status/json/) daily using a systemd timer and saved to `mirrors.json`.

## 🌐 Access the Data

- **GitHub Pages Site**: [https://arjixwastaken.github.io/arch-mirrorlist-mirror/](https://arjixwastaken.github.io/arch-mirrorlist-mirror/)
- **Direct JSON URL**: [https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json](https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json)

## 📋 Usage

Fetch the mirror status data:
```bash
curl https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json
```

## ⚙️ How it Works

1. **Systemd timer** runs the update script daily
2. Fetches the latest mirror status from the official Arch Linux API
3. Saves the data to `mirrors.json`
4. Commits and pushes the updated file
5. GitHub Pages automatically serves the updated JSON file

## 🔧 Setup Instructions

To set up automatic updates on your own system:

1. Clone this repository to your home directory:
   ```bash
   git clone https://github.com/ArjixWasTaken/arch-mirrorlist-mirror.git ~/arch-mirrorlist-mirror
   cd ~/arch-mirrorlist-mirror
   chmod +x update-mirrors.sh
   ```

2. Install the systemd timer:
   ```bash
   # Link systemd files to user systemd
   systemctl --user link ./arch-mirror-update.service
   systemctl --user link ./arch-mirror-update.timer
   
   # Enable and start the timer
   systemctl --user daemon-reload
   systemctl --user enable --now arch-mirror-update.timer
   
   # (Optional) Enable lingering to run when not logged in
   sudo loginctl enable-linger $USER
   ```

3. Ensure your system has `curl` and `git` installed
4. Make sure your git repository is configured with proper authentication for pushing changes

For detailed setup instructions and troubleshooting, see [SYSTEMD_SETUP.md](SYSTEMD_SETUP.md).

The systemd timer will automatically fetch the latest mirror data, validate it, and commit/push changes to keep the repository up to date with better reliability and logging than traditional cron jobs.