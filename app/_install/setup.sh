#!/bin/bash

DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

success() {
	echo " Success!"
}

failure() {
	echo " Failed!"
}

cd "$DIR"

echo -en "MySQL username [root]: "; read NAME
NAME=${NAME:-root}

echo -en "MySQL password [vagrant]: "; read -s PASS
PASS=${PASS:-vagrant}

echo -en "\nMySQL server [localhost]: "; read SQL_SERVER
SQL_SERVER=${SQL_SERVER:-localhost}

echo -en "MySQL db name [omgcatz]: "; read DB_NAME
DB_NAME=${DB_NAME:-omgcatz}


if [ ! -d "../api/stuff/download" ]; then
	echo
	git clone "https://github.com/cadejscroggins/omgcatz-minion/" "../api/stuff/download"
	echo -e "\nRunning api/stuff/download/_install/setup.sh..."
	../api/stuff/download/_install/setup.sh
fi

# create Config class
echo "<?php class Config { public static \$server=\"$SQL_SERVER\",\$user=\"$NAME\",\$password=\"$PASS\",\$database=\"$DB_NAME\";$MINIONS }" > ../api/include/Config.php

