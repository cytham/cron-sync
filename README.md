# Cron-sync: A tool for recurrent and non-redundant copy of files

## About
Cron-sync is developed to allow the recurrent copying of exclusively new files produced in real-time. It uses crontab and rsync to copy only newly generated files from the source to the destination directory at a scheduled interval. To allow the repeated copying of old files, a regex expression matching these files can be set. 

## Usage

```
Cron-sync: A tool for recurrent and non-redundant copy of files.

usage: cron-sync [-s <source_directory>][-d <destination_directory>][-f <every (1-30)th minute>][-r <regex of old files for repeated copying>][-x][-c][-h]

Examples:
            Activate session: cron-sync -s /path/to/source_dir -d /path/to/destination_dir -f 15  # Copy new files every 15th min
 Activate session with regex: cron-sync -s /path/to/source_dir -d /path/to/destination_dir -f 15 -r .csv$  # Copy new files and old files ending with '.csv' every 15th min
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

If `cron-sync -x` fails to terminate session, simply do `crontab -r` and reinstall cron-sync.
