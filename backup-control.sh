#!/bin/bash
# Exporting bacula backups control
# Created 10-01-2018
# Author: David Tinoco Castillo
# Version 0.1

hosts=("mickey" "minnie" "donald")
mickey="'172.22.200.73'"
minnie="'172.22.200.74'"
donald="'172.22.200.75'"


for i in ${hosts[@]};
do
	registro=$(mariadb -e "select Level, JobStatus, max(date_format(RealEndTime,'%x-%m-%d')) from bacula.Job where Name='$i'")
	level=$(echo $registro | cut -d " " -f 4)
	status=$(echo $registro | cut -d " " -f 5)
	fecha=$(echo $registro | cut -d " " -f 6)
	fechaSys=$(date +%Y-%m-%d)

	if [ $i == "mickey" ]; then
		ip="172.22.200.73"
	elif [ $i == "minnie" ]; then
		ip="172.22.200.74"
	elif [ $i == "donald" ]; then
		ip="172.22.200.74"
	fi

	if [ $status == 'T' ] && [ $fecha == $fechaSys ]; then
		psql -h 172.22.200.110 -U david.tinoco -d db_backup -c "insert into backups (backup_user, backup_host, backup_label, backup_status, backup_mode) values ('david.tinoco', '$ip','$level','200','Automatica'"
	else
		echo "Fallo al realizar la copia de seguridad de $i a día de $fechaSys " | /usr/bin/mail -s "Error en copias de seguridad" daviid.tc@gmail.com
	fi
done
