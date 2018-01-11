#!/bin/bash
# Exporting bacula backups control
# Created 10-01-2018
# Author: David Tinoco Castillo
# Version 0.1

hosts=("'mickey'" "'minnie'" "'donald'")
mickey="'172.22.200.73'"
minnie="'172.22.200.74'"
donald="'172.22.200.75'"


for i in ${hosts[@]};
do
	registro=$(mariadb -e "select Level, JobStatus, max(date_format(RealEndTime,'%x-%m-%d')) from bacula.Job where Name="$i)
	level=$(echo $registro | cut -d " " -f 4)
	status=$(echo $registro | cut -d " " -f 5)
	fecha=$(echo $registro | cut -d " " -f 6)
	fechaSys=$(date +%Y-%m-%d)

	if [ $status == 'T' ] && [ $fecha == $fechaSys ]; then
		psql -h 172.22.200.110 -U david.tinoco -d db_backup -c "insert into backups (backup_user, backup_host, backup_label, backup_description, backup_status, backup_mode) values ('david.tinoco', "$ip","$level","
	else
		echo "hubo problemas"
	fi
done

backup_user, backup_host, backup_label, backup_description, backup_status, backup_mode) values ('juanjose.lopez', '172.22.200.78','$mickey_tipo', '$mickey_fecha con tamano de $mickey_tamano M', '200', 'Automatica');"
psql -h 172.22.200.110 -d db_backup -U manuel.franco -c " insert into backups (backup_user, backup_host, backup_label, backup_description, backup_status, backup_date, backup_mode) values ('manuel.franco','$1','$2','$3', '200', '$5', 'Automatica') "
