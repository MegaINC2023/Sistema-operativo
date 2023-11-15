#!/bin/bash

d=$(date +%Y-%m-%d_%H:%M:%S)
mkdir /home/megainc/backups/$d
if [[ "$USER" == "root" ]]; then
        chown backupi /home/megainc/backups/$d
        chgrp gbackups /home/megainc/backups/$d
fi
chmod 770 /home/megainc/backups/$d
docker exec contenedor-mysql mysqldump --no-tablespaces --user=user --password=pass sisgran > out.sql
tar -czvf bsd.tar.gz /home/sisgran/out.sql
rm -r -f out.sql
mv bsd.tar.gz /home/megainc/backups/$d
cd /megainc/sisgran/

