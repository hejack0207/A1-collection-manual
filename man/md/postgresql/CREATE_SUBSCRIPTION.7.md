# create subscription(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_SUBSCRIPTION - define a new subscription

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE SUBSCRIPTION subscription_name
        CONNECTION conninfo*(Aq
        PUBLICATION publication_name [, ...]
        [ WITH ( subscription_parameter [= value] [, ... ] ) ]

<a name="description"></a>

# Description


**CREATE SUBSCRIPTION**
adds a new subscription for the current database. The subscription name must be distinct from the name of any existing subscription in the database.

The subscription represents a replication connection to the publisher. As such this command does not only add definitions in the local catalogs but also creates a replication slot on the publisher.

A logical replication worker will be started to replicate data for the new subscription at the commit of the transaction where this command is run.

Additional information about subscriptions and logical replication as a whole is available at
Section&nbsp;30.2
and
Chapter&nbsp;30.

<a name="parameters"></a>

# Parameters


_subscription\_name_
The name of the new subscription.

CONNECTION _conninfo_\*(Aq
The connection string to the publisher. For details see
Section&nbsp;33.1.1.

PUBLICATION _publication\_name_
Names of the publications on the publisher to subscribe to.

WITH ( _subscription\_parameter_ [= _value_] [, ... ] )
This clause specifies optional parameters for a subscription. The following parameters are supported:

copy_data (boolean)
Specifies whether the existing data in the publications that are being subscribed to should be copied once the replication starts. The default is
true.

create_slot (boolean)
Specifies whether the command should create the replication slot on the publisher. The default is
true.

enabled (boolean)
Specifies whether the subscription should be actively replicating, or whether it should be just setup but not started yet. The default is
true.

slot_name (string)
Name of the replication slot to use. The default behavior is to use the name of the subscription for the slot name.

When
slot_name
is set to
NONE, there will be no replication slot associated with the subscription. This can be used if the replication slot will be created later manually. Such subscriptions must also have both
enabled
and
create_slot
set to
false.

synchronous_commit (enum)
The value of this parameter overrides the
synchronous_commit
setting. The default value is
off.

It is safe to use
off
for logical replication: If the subscriber loses transactions because of missing synchronization, the data will be sent again from the publisher.

A different setting might be appropriate when doing synchronous logical replication. The logical replication workers report the positions of writes and flushes to the publisher, and when using synchronous replication, the publisher will wait for the actual flush. This means that setting
synchronous_commit
for the subscriber to
off
when the subscription is used for synchronous replication might increase the latency for
**COMMIT**
on the publisher. In this scenario, it can be advantageous to set
synchronous_commit
to
local
or higher.

connect (boolean)
Specifies whether the
**CREATE SUBSCRIPTION**
should connect to the publisher at all. Setting this to
false
will change default values of
enabled,
create_slot
and
copy_data
to
false.

It is not allowed to combine
connect
set to
false
and
enabled,
create_slot, or
copy_data
set to
true.

Since no connection is made when this option is set to
false, the tables are not subscribed, and so after you enable the subscription nothing will be replicated. It is required to run
ALTER SUBSCRIPTION ... REFRESH PUBLICATION
in order for tables to be subscribed.


<a name="notes"></a>

# Notes


See
Section&nbsp;30.7
for details on how to configure access control between the subscription and the publication instance.

When creating a replication slot (the default behavior),
**CREATE SUBSCRIPTION**
cannot be executed inside a transaction block.

Creating a subscription that connects to the same database cluster (for example, to replicate between databases in the same cluster or to replicate within the same database) will only succeed if the replication slot is not created as part of the same command. Otherwise, the
**CREATE SUBSCRIPTION**
call will hang. To make this work, create the replication slot separately (using the function
**pg\_create\_logical\_replication\_slot**
with the plugin name
pgoutput) and create the subscription using the parameter
create_slot = false. This is an implementation restriction that might be lifted in a future release.

<a name="examples"></a>

# Examples


Create a subscription to a remote server that replicates tables in the publications
mypublication
and
insert_only
and starts replicating immediately on commit:

.if n \{.RS 4
.\}
    CREATE SUBSCRIPTION mysub
             CONNECTION host=192.168.1.50 port=5432 user=foo dbname=foodb*(Aq
            PUBLICATION mypublication, insert_only;
.if n \{.RE
.\}

Create a subscription to a remote server that replicates tables in the
insert_only
publication and does not start replicating until enabled at a later time.

.if n \{.RS 4
.\}
    CREATE SUBSCRIPTION mysub
             CONNECTION host=192.168.1.50 port=5432 user=foo dbname=foodb*(Aq
            PUBLICATION insert_only
                   WITH (enabled = false);
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CREATE SUBSCRIPTION**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

ALTER SUBSCRIPTION (**ALTER\_SUBSCRIPTION**(7)), DROP SUBSCRIPTION (**DROP\_SUBSCRIPTION**(7)), CREATE PUBLICATION (**CREATE\_PUBLICATION**(7)), ALTER PUBLICATION (**ALTER\_PUBLICATION**(7))
