# drop subscription(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_SUBSCRIPTION - remove a subscription

<a name="synopsis"></a>

# Synopsis

```


```
    DROP SUBSCRIPTION [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP SUBSCRIPTION**
removes a subscription from the database cluster.

A subscription can only be dropped by a superuser.

**DROP SUBSCRIPTION**
cannot be executed inside a transaction block if the subscription is associated with a replication slot. (You can use
**ALTER SUBSCRIPTION**
to unset the slot.)

<a name="parameters"></a>

# Parameters


_name_
The name of a subscription to be dropped.

CASCADE  
RESTRICT
These key words do not have any effect, since there are no dependencies on subscriptions.

<a name="notes"></a>

# Notes


When dropping a subscription that is associated with a replication slot on the remote host (the normal state),
**DROP SUBSCRIPTION**
will connect to the remote host and try to drop the replication slot as part of its operation. This is necessary so that the resources allocated for the subscription on the remote host are released. If this fails, either because the remote host is not reachable or because the remote replication slot cannot be dropped or does not exist or never existed, the
**DROP SUBSCRIPTION**
command will fail. To proceed in this situation, disassociate the subscription from the replication slot by executing
ALTER SUBSCRIPTION ... SET (slot_name = NONE). After that,
**DROP SUBSCRIPTION**
will no longer attempt any actions on a remote host. Note that if the remote replication slot still exists, it should then be dropped manually; otherwise it will continue to reserve WAL and might eventually cause the disk to fill up. See also
Section&nbsp;30.2.1.

If a subscription is associated with a replication slot, then
**DROP SUBSCRIPTION**
cannot be executed inside a transaction block.

<a name="examples"></a>

# Examples


Drop a subscription:

.if n \{.RS 4
.\}
    DROP SUBSCRIPTION mysub;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP SUBSCRIPTION**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE SUBSCRIPTION (**CREATE\_SUBSCRIPTION**(7)), ALTER SUBSCRIPTION (**ALTER\_SUBSCRIPTION**(7))
