#!/bin/bash

# skip these databases from backup
SKIP_DIRECTORIES="log cache"

# backup input directory
INPUT="/input"

# backup destination directory
DEST="/backup"

# binary paths, autodetected via which command
TAR="$(which tar)"

# get current date in yyyy-mm-dd format
NOW="$(date +"%Y-%m-%d")"

# current date and time
DATETIME="$(date +"%Y-%m-%d %H:%M:%S")"

# generate skip flags from input
SKIPFLAGS=""
for i in $SKIP_DIRECTORIES
do
    SKIPFLAGS="${SKIPFLAGS} --exclude=${i}"
done

# tar directories
if [ "$SEPARATE_ARCHIVES" != "true" ];
then
	file="$DEST/backup.$NOW.gz"
	$TAR -C $INPUT -zc $SKIPFLAGS -f $file .
else
	for d in $INPUT/*
	do
		base=$(basename "$d")
		file="$DEST/$base.$NOW.gz"
		$TAR -C "$INPUT/$base" -zc $SKIPFLAGS -f $file .
	done
fi;

echo "$DATETIME - Directory backup script ... RUNNED"