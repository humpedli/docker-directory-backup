Backup a specified directory periodically (using cron rule)

*Note: you can skip subdirectories from backup if you define `SKIP_DIRECTORIES=` environment variable and put folder names after it (with space separator), default: `log cache`*

*Note 2: define `KEEP_FILES_UNTIL=` environment variable to delete files after x days automatically, default: `30`*

*Note 3: define `SEPARATE_ARCHIVES=true` if you want to backup the subdirectories in separated archives*

## Usage

**Docker command:**

```bash
docker run --name=backup-directory \
  --restart=always \
  -v <path_to_input>:/input \
  -v <path_to_backup_output>:/backup \
  -v /etc/localtime:/etc/localtime:ro \
  -e CRON_SCHEDULE='0 2 * * *' \
  -e KEEP_FILES_UNTIL=30 \
  -e SKIP_DIRECTORIES='log cache' \
  -e SEPARATE_ARCHIVES=false \
  -d humpedli/docker-directory-backup
```

---
**Docker compose:**

```bash
version: '3'
services:
  backup-directory:
    container_name: "backup-directory"
    image: "humpedli/docker-directory-backup"
    volumes:
      - "<path_to_input>:/input"
      - "<path_to_backup_output>:/backup"
      - "/etc/localtime:/etc/localtime:ro"
    environment:
      - "CRON_SCHEDULE=0 2 * * *"
      - "KEEP_FILES_UNTIL=30"
      - "SKIP_DIRECTORIES=log cache"
      - "SEPARATE_ARCHIVES=false"
    restart: "always"
```