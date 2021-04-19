* curl HOST:5100/search/clusters | python -m json.tool
* curl -XGET http://HOST:9200/_cluster/health?pretty
* curl -XGET http://HOST:9200/_cat/nodes?v
* curl -XGET http://HOST:9200/_nodes/process?pretty
* curl http://HOST:9200/_cat/indices?v
* curl -XGET http://HOST:9200/_cat/shards?v
* curl -XGET http://HOST:9200/_cat/shards?v | grep -v green
* curl -XGET http://HOST:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason | grep UNASSIGNED
* curl -XGET http://HOST:9200/_cluster/allocation/explain?pretty
* curl -XGET http://HOST:9200/_cluster/allocation?v
* curl -XGET http://HOST:9200/_cat/snapshots/ {repository}
* curl -XPOST http://HOST:5100/cluster/update -d '{
 	"cluster_name": "oam-es-barad",
 	"operator": "walker",
 	"restart_type": "full_cluster_restart"
 }'
* curl -XPOST http://HOST:5100/_cluster/settings -d '{
 	"transient": {
 		"cluster.routing.allocation.cluster_concurrent_rebalance":"20",
 		"cluster.routing.allocation.node_concurrent_recoveries": "20",
 		"indices.recovery.max_bytes_per_sec": "100mb"
 	}
* }'
* curl -XPUT http://HOST:9200/_cluster/settings -d '{
 	"transient": {
 		"cluster.routing.allocation.cluster_concurrent_rebalance":"20",
 		"cluster.routing.allocation.node_concurrent_recoveries": "20",
 		"indices.recovery.max_bytes_per_sec": "100mb"
 	}
 }'
* curl -XPUT http://HOST:9200/INDEXNAME/_settings -d '{
 	"index.indexing.slowlog.threshold.index.debug": "5ms",
 	"index.search.slowlog.threshold.fetch.debug": "10ms",
 	"index.search.slowlog.threshold.query.info": "200ms"
 }'
* curl -XPUT http://HOST:9200/_all/_settings -d '{
 	"index.indexing.slowlog.threshold.index.debug": "5ms",
 	"index.search.slowlog.threshold.fetch.debug": "10ms",
 	"index.search.slowlog.threshold.query.info": "200ms"
 }'
* curl -XGET http://HOST:9200/_nodes/stats/jvm?pretty | grep heap_used_percent
* curl -XPOST http://HOST:9200/_cluster/reroute?retry_failed=true
* curl -XPUT 127.0.0.1:9200/INDEXNAME/_settings?pretty -H 'Content-Type: application/json' -d'{
 	"index": {
 		"number_of_replicas": 0
 	}
 }'
* curl -XDELETE http://HOST:9200/INDEXNAME
