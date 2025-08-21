# Arch Linux Mirror Status Mirror

This repository automatically mirrors the Arch Linux mirror status JSON data and hosts it via GitHub Pages.

## 🔄 Automated Updates

The mirror status data is automatically fetched from [https://archlinux.org/mirrors/status/json/](https://archlinux.org/mirrors/status/json/) daily using a cron job and saved to `mirrors.json`.

## 🌐 Access the Data

- **GitHub Pages Site**: [https://arjixwastaken.github.io/arch-mirrorlist-mirror/](https://arjixwastaken.github.io/arch-mirrorlist-mirror/)
- **Direct JSON URL**: [https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json](https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json)

## 📋 Usage

Fetch the mirror status data:
```bash
curl https://arjixwastaken.github.io/arch-mirrorlist-mirror/mirrors.json
```

## ⚙️ How it Works

1. **Cron job** runs the update script daily
2. Fetches the latest mirror status from the official Arch Linux API
3. Saves the data to `mirrors.json`
4. Commits and pushes the updated file
5. GitHub Pages automatically serves the updated JSON file

## 🔧 Setup Instructions

To set up automatic updates on your own system:

1. Clone this repository to your local machine
2. Make the update script executable: `chmod +x update-mirrors.sh`
3. Add a cron job to run the script daily. For example, to run at 00:00 UTC daily:
   ```bash
   crontab -e
   # Add this line:
   0 0 * * * /path/to/your/repo/update-mirrors.sh
   ```
4. Ensure your system has `curl` installed and internet access
5. Make sure your git repository is configured with proper authentication for pushing changes

The script will automatically fetch the latest mirror data, validate it, and commit/push changes to keep the repository up to date.