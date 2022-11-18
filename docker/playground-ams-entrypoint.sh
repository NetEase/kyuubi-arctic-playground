#!/bin/bash

SQL_RESULT=""
while [[ "${SQL_RESULT}" != "ddl_record" ]]
do
	echo "Wait for table initialization to complete..."
	sleep 1
	SQL_RESULT=$(mysql -h mysql -P 3306 --database=arctic \
	  --user="${MYSQL_USER}" --password="${MYSQL_PASSWORD}" \
	  --execute="show tables like 'ddl_record';" \
	  -s -N)
done
echo "Successfully get the last table created by arctic-init.sql:" "${SQL_RESULT}"
echo "MySQL initialization is successful, starting AMS..."

/opt/arctic/bin/ams.sh start