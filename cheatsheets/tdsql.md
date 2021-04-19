* clockdiff [-o] <host>
* /data/tdsql_run/DBPORT/mysqlagent/bin/mysql_param_modify --help
* /data/tdsql_run/DBPORT/mysqlagent/bin/mysql_param_modify --agent-conf="../conf/mysqlagent_4012.xml" --mode="modify" --param="param=lower_calse_table_names&conf=lower_case_table_names&value=0" --name="set_1586431277_5762"
* /data/tdsql_run/DBPORT/percona-5.7.17/install/jmysql.sh DBPORT
* /data/tdsql_run/DBPORT/percona-5.7.17/install/monitormysql.sh DBPORT
* /data/tdsql_run/DBPORT/percona-5.7.17/install/killallsession.sh DBPORT
* /data/tdsql_run/DBPORT/percona-5.7.17/install/killlongsession.sh DBPORT LONGSEC
* /data/tdsql_run/DBPORT/mysqlagent/bin/mydumper --host=HOST --port=PORT --user=USER --password=PASSWORD --events --routeines --triggers --less-locking --ignore-sysdb=1 --chunk-filesize=1024 --complete-insert --outputdir=OUTPUTDIR
* /data/tdsql_run/DBPORT/mysqlagent/bin/myloader --host=HOST --port=PORT --user=USER --password=PASSWORD --directory= --enable-binlog
