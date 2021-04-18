# zookeeper
## server side
./zkServer.sh start
./zkServer.sh status
./zkServer.sh stop
./zkServer.sh restart
echo ruok | nc 127.0.0.1 2181
echo mntr | nc 127.0.0.1 2181
echo conf | nc 127.0.0.1 2181
echo stat | nc 127.0.0.1 2181
others: cons crst dump envi reqs srst srvr wchs wchc wchp
## client side
./zkCli.sh -server 127.0.0.1:2181
commands: ls ls2 create get set delete quit help
python /data/zookeeper-[version]/bin/get_zk_all_status.py

# hdfs
hdfs dfs -ls /
hdfs dfs -du -h /
hdfs dfs -touchz FILE
hdfs dfs -cp PATH PATH
hdfs dfs -rm FILE
hdfs dfs -rmr DIR
hdfs dfsadmin -report
hdfs haadmin -getServiceState NAMENODE
hadoop fs -cat
hdfs dfs -put FILE PATH
hdfs balancer -threshold 5
hdfs balancer -include DATANODE ..

# rabbitmq
rabbitmqctl status
rabbitmqctl cluster_status
rabbitmq-server -detached
rabbitmqctl stop
rabbitmqctl list_exchanges
rabbitmqctl list_bindings
rabbitmqctl list_queues
rabbitmqctl environment
rabbitmqctl list_permissions
rabbitmqctl list_user_permissions guest
rabbitmqctl add_user USER PASSWD
rabbitmqctl set_user_tags USER adminstrator
curl http://HOST:15672
rabbitmqctl status
rabbitmqctl report
rabbitmqctl list_queues -p XXXX
cat /usr/local/rabbitmq/etc/rabbitmq/rabbitmq.config
rabbitmqctl set_policy POLICYNAME "^QUEUENAME$" '{"max-length-bytes":1048576}' --apply-to queues
rabbitmqctl set_policy POLICYNAME "^QUEUENAME$" '{"max-length":1000,"overflow":"reject-publish"}' --apply-to queues

# es
curl HOST:5100/search/clusters | python -m json.tool
curl -XGET http://HOST:9200/_cluster/health?pretty
curl -XGET http://HOST:9200/_cat/nodes?v
curl -XGET http://HOST:9200/_nodes/process?pretty
curl http://HOST:9200/_cat/indices?v
curl -XGET http://HOST:9200/_cat/shards?v
curl -XGET http://HOST:9200/_cat/shards?v | grep -v green
curl -XGET http://HOST:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason | grep UNASSIGNED
curl -XGET http://HOST:9200/_cluster/allocation/explain?pretty
curl -XGET http://HOST:9200/_cluster/allocation?v
curl -XGET http://HOST:9200/_cat/snapshots/ {repository}
curl -XPOST http://HOST:5100/cluster/update -d '{
	"cluster_name": "oam-es-barad",
	"operator": "walker",
	"restart_type": "full_cluster_restart"
}'
curl -XPOST http://HOST:5100/_cluster/settings -d '{
	"transient": {
		"cluster.routing.allocation.cluster_concurrent_rebalance":"20",
		"cluster.routing.allocation.node_concurrent_recoveries": "20",
		"indices.recovery.max_bytes_per_sec": "100mb"
	}
}'
curl -XPUT http://HOST:9200/_cluster/settings -d '{
	"transient": {
		"cluster.routing.allocation.cluster_concurrent_rebalance":"20",
		"cluster.routing.allocation.node_concurrent_recoveries": "20",
		"indices.recovery.max_bytes_per_sec": "100mb"
	}
}'
curl -XPUT http://HOST:9200/INDEXNAME/_settings -d '{
	"index.indexing.slowlog.threshold.index.debug": "5ms",
	"index.search.slowlog.threshold.fetch.debug": "10ms",
	"index.search.slowlog.threshold.query.info": "200ms"
}'
curl -XPUT http://HOST:9200/_all/_settings -d '{
	"index.indexing.slowlog.threshold.index.debug": "5ms",
	"index.search.slowlog.threshold.fetch.debug": "10ms",
	"index.search.slowlog.threshold.query.info": "200ms"
}'
curl -XGET http://HOST:9200/_nodes/stats/jvm?pretty | grep heap_used_percent
curl -XPOST http://HOST:9200/_cluster/reroute?retry_failed=true
curl -XPUT 127.0.0.1:9200/INDEXNAME/_settings?pretty -H 'Content-Type: application/json' -d'{
	"index": {
		"number_of_replicas": 0
	}
}'
curl -XDELETE http://HOST:9200/INDEXNAME

# tdsql
# mongo
# kafka
