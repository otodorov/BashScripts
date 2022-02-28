#!/bin/bash

# Archive folders older then $ROTATE_DAYS (A year)
ROTATE_DAYS=365
# Delete archives older then $TARGZ_DELETEION (A year and half)
TARGZ_DELETEION_DAYS=547
# Folder where the script will look for folders to archive
BACKUP_FOLDER=/mnt/backups/rubrik/github/backup-utils/data


cd $BACKUP_FOLDER
echo "compressing $BACKUP_FOLDER dirs that are $ROTATE_DAYS days old...";
for DIR in $(find ./ -maxdepth 1 -mindepth 1 -type d -mtime +${ROTATE_DAYS} | sort)
do
    echo -n "compressing ... ";
    if tar czvf "$DIR.tar.gz" "$DIR"
    then
        echo "done" && rm -rf "$DIR"
    else
        echo "failed";
    fi
done

echo "removing $BACKUP_FOLDER .tar.gz files that are $TARGZ_DELETEION_DAYS days old..."
for FILE in $(find ./ -maxdepth 1 -type f -mtime +${TARGZ_DELETEION_DAYS} -name "*.tar.gz" | sort)
do
    echo -n "removing $BACKUP_FOLDER/$FILE ... ";
    if rm -f "$BACKUP_FOLDER/$FILE"
    then
        echo "done";
    else
        echo "failed";
    fi
done
