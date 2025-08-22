# Systemd Timer Setup

This file provides instructions on how to set up the update script as a systemd timer.

## Why Systemd Timer?

Systemd timers offer several advantages over cron jobs:
- Better logging integration with journald
- Persistent execution (runs even after missed schedules due to system suspend)
- Advanced scheduling options
- Better dependency management
- Automatic restart on failure

## Setup Instructions

### 1. Prepare the Repository

First, clone the repository to your home directory:

```bash
git clone https://github.com/ArjixWasTaken/arch-mirrorlist-mirror.git ~/arch-mirrorlist-mirror
cd ~/arch-mirrorlist-mirror
chmod +x update-mirrors.sh
```

### 2. Install Systemd Files

Copy the systemd files to the user systemd directory:

```bash
# Create the user systemd directory if it doesn't exist
mkdir -p ~/.config/systemd/user

# Copy the service and timer files
cp arch-mirror-update.service ~/.config/systemd/user/
cp arch-mirror-update.timer ~/.config/systemd/user/
```

### 3. Enable and Start the Timer

```bash
# Reload systemd user configuration
systemctl --user daemon-reload

# Enable the timer to start automatically
systemctl --user enable arch-mirror-update.timer

# Start the timer immediately
systemctl --user start arch-mirror-update.timer
```

### 4. Enable Lingering (Optional but Recommended)

To ensure the timer runs even when you're not logged in:

```bash
sudo loginctl enable-linger $USER
```

## Managing the Timer

### Check Timer Status
```bash
# Check if the timer is active
systemctl --user status arch-mirror-update.timer

# List all timers
systemctl --user list-timers
```

### Check Service Status
```bash
# Check the last run status
systemctl --user status arch-mirror-update.service

# View logs from the last runs
journalctl --user -u arch-mirror-update.service
```

### Manual Execution
```bash
# Run the service manually (for testing)
systemctl --user start arch-mirror-update.service
```

### Stop/Disable the Timer
```bash
# Stop the timer
systemctl --user stop arch-mirror-update.timer

# Disable the timer
systemctl --user disable arch-mirror-update.timer
```

## Timer Schedule

The default timer runs daily at midnight with a randomized delay of up to 5 minutes to avoid system load spikes.

### Customizing the Schedule

You can modify the timer schedule by editing `~/.config/systemd/user/arch-mirror-update.timer`:

- **Every 6 hours**: `OnCalendar=*-*-* 00,06,12,18:00:00`
- **Twice daily**: `OnCalendar=*-*-* 00,12:00:00`
- **Weekly**: `OnCalendar=weekly`
- **Custom time**: `OnCalendar=*-*-* 02:30:00` (daily at 2:30 AM)

After editing, reload and restart:
```bash
systemctl --user daemon-reload
systemctl --user restart arch-mirror-update.timer
```

## Troubleshooting

### Check Timer Next Run
```bash
systemctl --user list-timers arch-mirror-update.timer
```

### View Detailed Logs
```bash
# Follow logs in real-time
journalctl --user -u arch-mirror-update.service -f

# View last 20 log entries
journalctl --user -u arch-mirror-update.service -n 20
```

### Debug Service
```bash
# Test the script manually
cd ~/arch-mirrorlist-mirror
./update-mirrors.sh

# Run the service manually with detailed output
systemctl --user start arch-mirror-update.service
journalctl --user -u arch-mirror-update.service --since "1 minute ago"
```

## Requirements

- `curl` for fetching mirror data
- `git` for committing and pushing changes
- Proper git authentication configured for pushing to remote repository
- Internet connectivity

The systemd timer will automatically handle execution scheduling and provide better reliability compared to traditional cron jobs.