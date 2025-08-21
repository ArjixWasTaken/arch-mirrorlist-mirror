# Cron Setup Example

This file provides examples of how to set up the update script as a cron job.

## Setting up a daily cron job

1. Open your crontab:
   ```bash
   crontab -e
   ```

2. Add one of these lines depending on when you want the update to run:

   **Daily at midnight (00:00):**
   ```
   0 0 * * * /path/to/arch-mirrorlist-mirror/update-mirrors.sh
   ```

   **Daily at 2 AM:**
   ```
   0 2 * * * /path/to/arch-mirrorlist-mirror/update-mirrors.sh
   ```

   **Every 6 hours:**
   ```
   0 */6 * * * /path/to/arch-mirrorlist-mirror/update-mirrors.sh
   ```

3. Save and exit the crontab editor

## Important Notes

- Replace `/path/to/arch-mirrorlist-mirror/` with the actual path to your cloned repository
- Make sure the script is executable: `chmod +x update-mirrors.sh`
- Ensure your system has `curl` and `git` installed
- The script will automatically handle git configuration if not already set
- Check your cron logs if the script doesn't run as expected: `grep CRON /var/log/syslog`

## Manual Testing

You can test the script manually before setting up the cron job:

```bash
cd /path/to/arch-mirrorlist-mirror
./update-mirrors.sh
```

The script will output detailed information about what it's doing and any errors encountered.