# topics
## show
* bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --list
* bin/kafka-topics.sh --describe [--topic TOPICNAME]

## create
* bin/kafka-topics.sh --create --zookeeper 127.0.0.1:2181 --replication-factor 1 --partitions 1 --topic TOPICNAME

## alter
* bin/kafka-topics.sh --zookeeper ZKHOST:2181/kafka/kafka -alter --partitions 8 --topic TOPICNAME

## delete
* kafka-topics.sh --delete --zookeeper ZKHOST:2181/kafka/kafka --topic TOPICNAME

# producer
* echo MESSAGETEXT | bin/kafaka-console-producer.sh --broker-list 127.0.0.1:9092 --topic TOPICNAME > /dev/null

# consumer
* bin/kafaka-consumer-groups.sh --bootstrap-server 127.0.0.1:9092 --list
* bin/kafaka-consumer-groups.sh --new-consumer --bootstrap-server 127.0.0.1:9092 --group CONSUMERGROUPNAME --describe
* bin/kafaka-console-consumer.sh --bootstrap-server 127.0.0.1:9092 --topic TOPICNAME --from-beginning

# management
* kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list 127.0.0.1:9092 --topic TOPICNAME --time <-1|-2>
* kafka-run-class.sh kafka.tools.JmxTool --object-name kafka.server:type=BrokerTopicsMetrics,name=BytesInPerSec --jmx-url service:jmx:rmi:///jndi/rmi://:9997/jmxrmi --date-format "YYYY-MM-dd HH:mm:ss" --attributes FifteenMinuteRate --reporting-interval 5000

# config
## show
* kafka-configs.sh --describe --zookeeper ZKHOST:2181 --entity-type topics --entity-name TOPICNAME

## modify
* kafka-configs.sh --zookeeper ZKHOST:2181 --alter --entity-name TOPICNAME --entity-type topics --add-config retention.ms=86400000

# FAQ
## high cpu loads
* sysctl -w net.ipv4.tcp_mem='3077562 4103417 16777216'

## disk full
* du -sh /var/lib/kafka/data/topics/*
* kafka-configs.sh --zookeeper ZKHOST:2181 --alter --entity-name TOPICNAME --entity-type topics --add-config retention.ms=86400000


