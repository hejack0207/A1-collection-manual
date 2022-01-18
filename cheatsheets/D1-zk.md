## server side
* ./zkServer.sh start
* ./zkServer.sh status
* ./zkServer.sh stop
* ./zkServer.sh restart
* echo ruok | nc 127.0.0.1 2181
* echo mntr | nc 127.0.0.1 2181
* echo conf | nc 127.0.0.1 2181
* echo stat | nc 127.0.0.1 2181
* others: cons crst dump envi reqs srst srvr wchs wchc wchp

## client side
* ./zkCli.sh -server 127.0.0.1:2181
* commands: ls ls2 create get set delete quit help
* python /data/zookeeper-[version]/bin/get_zk_all_status.py

