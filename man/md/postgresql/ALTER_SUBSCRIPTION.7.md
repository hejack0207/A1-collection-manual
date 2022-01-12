# alter subscription(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_SUBSCRIPTION - change the definition of a subscription

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER SUBSCRIPTION name CONNECTION conninfo*(Aq
    ALTER SUBSCRIPTION name SET PUBLICATION publication_name [, ...] [ WITH ( set_publication_option [= value] [, ... ] ) ]
    ALTER SUBSCRIPTION name REFRESH PUBLICATION [ WITH ( refresh_option [= value] [, ... ] ) ]
    ALTER SUBSCRIPTION name ENABLE
    ALTER SUBSCRIPTION name DISABLE
    ALTER SUBSCRIPTION name SET ( subscription_parameter [= value] [, ... ] )
    ALTER SUBSCRIPTION name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER SUBSCRIPTION name RENAME TO new_name

<a name="description"></a>

# Description


**ALTER SUBSCRIPTION**
can change most of the subscription properties that can be specified in
CREATE SUBSCRIPTION (**CREATE\_SUBSCRIPTION**(7)).

You must own the subscription to use
**ALTER SUBSCRIPTION**. To alter the owner, you must also be a direct or indirect member of the new owning role. The new owner has to be a superuser. (Currently, all subscription owners must be superusers, so the owner checks will be bypassed in practice. But this might change in the future.)

<a name="parameters"></a>

# Parameters


_name_
The name of a subscription whose properties are to be altered.

CONNECTION _conninfo_\*(Aq
This clause alters the connection property originally set by
CREATE SUBSCRIPTION (**CREATE\_SUBSCRIPTION**(7)). See there for more information.

SET PUBLICATION _publication\_name_
Changes list of subscribed publications. See
CREATE SUBSCRIPTION (**CREATE\_SUBSCRIPTION**(7))
for more information. By default this command will also act like
REFRESH PUBLICATION.

_set\_publication\_option_
specifies additional options for this operation. The supported options are:

refresh (boolean)
When false, the command will not try to refresh table information.
REFRESH PUBLICATION
should then be executed separately. The default is
true.

Additionally, refresh options as described under
REFRESH PUBLICATION
may be specified.

REFRESH PUBLICATION
Fetch missing table information from publisher. This will start replication of tables that were added to the subscribed-to publications since the last invocation of
**REFRESH PUBLICATION**
or since
**CREATE SUBSCRIPTION**.

_refresh\_option_
specifies additional options for the refresh operation. The supported options are:

copy_data (boolean)
Specifies whether the existing data in the publications that are being subscribed to should be copied once the replication starts. The default is
true. (Previously subscribed tables are not copied.)


ENABLE
Enables the previously disabled subscription, starting the logical replication worker at the end of transaction.

DISABLE
Disables the running subscription, stopping the logical replication worker at the end of transaction.

SET ( _subscription\_parameter_ [= _value_] [, ... ] )
This clause alters parameters originally set by
CREATE SUBSCRIPTION (**CREATE\_SUBSCRIPTION**(7)). See there for more information. The allowed options are
slot_name
and
synchronous_commit

_new\_owner_
The user name of the new owner of the subscription.

_new\_name_
The new name for the subscription.

<a name="examples"></a>

# Examples


Change the publication subscribed by a subscription to
insert_only:

.if n \{.RS 4
.\}
    ALTER SUBSCRIPTION mysub SET PUBLICATION insert_only;
.if n \{.RE
.\}

Disable (stop) the subscription:

.if n \{.RS 4
.\}
    ALTER SUBSCRIPTION mysub DISABLE;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**ALTER SUBSCRIPTION**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE SUBSCRIPTION (**CREATE\_SUBSCRIPTION**(7)), DROP SUBSCRIPTION (**DROP\_SUBSCRIPTION**(7)), CREATE PUBLICATION (**CREATE\_PUBLICATION**(7)), ALTER PUBLICATION (**ALTER\_PUBLICATION**(7))
