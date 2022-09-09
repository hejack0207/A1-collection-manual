* rabbitmqctl status
* rabbitmqctl cluster_status
* rabbitmq-server -detached
* rabbitmqctl stop
* rabbitmqctl list_exchanges
* rabbitmqctl list_bindings
* rabbitmqctl list_queues
* rabbitmqctl environment
* rabbitmqctl list_permissions
* rabbitmqctl list_user_permissions guest
* rabbitmqctl add_user USER PASSWD
* rabbitmqctl set_user_tags USER adminstrator
* curl http://HOST:15672
* rabbitmqctl status
* rabbitmqctl report
* rabbitmqctl list_queues -p XXXX
* cat /usr/local/rabbitmq/etc/rabbitmq/rabbitmq.config
* rabbitmqctl set_policy POLICYNAME "^QUEUENAME$" '{"max-length-bytes":1048576}' --apply-to queues
* rabbitmqctl set_policy POLICYNAME "^QUEUENAME$" '{"max-length":1000,"overflow":"reject-publish"}' --apply-to queues

