#!/bin/sh

# get cron schedule from ENV and copy rule to the right place
cat << EOM > /cron_rule
${CRON_SCHEDULE:-0 2 * * *} /bin/backup
0 1 * * * /usr/bin/find /backup* -mtime +${KEEP_FILES_UNTIL:-30} -exec /bin/rm {} \;
EOM
cp /cron_rule /var/spool/cron/crontabs/root

# start cron
/usr/sbin/crond -f -l 2
