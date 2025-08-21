# Arch Linux Mirror Status Mirror

This repository automatically mirrors the Arch Linux mirror status JSON data and hosts it via GitHub Pages.

## 🔄 Automated Updates

The mirror status data is automatically fetched from [https://archlinux.org/mirrors/status/json/](https://archlinux.org/mirrors/status/json/) daily using GitHub Actions and saved to `mirrors.json`.

## 🌐 Access the Data

- **GitHub Pages Site**: [https://arjixwastaken.github.io/arch-mirrorlist-mirror/](https://arjixwastaken.github.io/arch-mirrorlist-mirror/)
- **Direct JSON URL**: [https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json](https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json)

## 📋 Usage

Fetch the mirror status data:
```bash
curl https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json
```

## ⚙️ How it Works

1. **GitHub Actions workflow** runs daily at 00:00 UTC
2. Fetches the latest mirror status from the official Arch Linux API
3. Saves the data to `mirrors.json`
4. Commits and pushes the updated file
5. GitHub Pages automatically serves the updated JSON file

## 🔧 Manual Update

You can manually trigger an update by going to the [Actions tab](../../actions/workflows/update-mirrors.yml) and clicking "Run workflow".