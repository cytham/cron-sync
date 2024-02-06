# Cron-sync: Pseudo-realtime copying of new files

## About
Cron-sync is developed to perform the intermittent copying of new files produced in real-time. It uses crontab and rsync to copy only newly generated files from the source to the destination directory at a scheduled interval. It keeps a memory of the copied files and prevents copying them again the next time, even if these files were deleted in the destination directory. However, a regex expression can be set during configuration to allow the repeated copying of old files. 

### Key points
- Scheduled copying of files at every 1st to 30th minute of each hour (each job is locked to ensure no overlapping)
- Non-redundant file transfer (only new files will be copied despite files deleted at destination)

## Usage

```
cron-sync: Pseudo-realtime copying of new files

usage: cron-sync [-s <source_directory>][-d <destination_directory>][-f <every (1-30)th minute>][-r <regex of old files for repeated copying>][-x][-c][-h]

Examples:
            Activate session: cron-sync -s /path/to/source_dir -d /path/to/destination_dir -f 15  # Copy new files every 15th min
                              cron-sync -s /path/to/source_dir -d /path/to/destination_dir -f 15 -r .csv$  # Copy new files and old files ending with '.csv' every 15th min

           Terminate session: cron-sync -x  # Terminate current cron-sync session
               Clean history: cron-sync -c  # This will reset the memory of all previous sessions
                   Show help: cron-sync -h
```

## Installation

```
git clone https://github.com/cytham/cron-sync.git
cd cron-sync
chmod +x cron-sync
chmod +x data-transfer.sh
```

## Troubleshooting

If `cron-sync -x` fails to terminate session, simply do `crontab -r` and reinstall cron-sync. Please note that doing this will wipe any pre-existing cron job.
