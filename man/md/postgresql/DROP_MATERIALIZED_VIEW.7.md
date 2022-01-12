# drop materialized view(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_MATERIALIZED_VIEW - remove a materialized view

<a name="synopsis"></a>

# Synopsis

```


```
    DROP MATERIALIZED VIEW [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP MATERIALIZED VIEW**
drops an existing materialized view. To execute this command you must be the owner of the materialized view.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the materialized view does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of the materialized view to remove.

CASCADE
Automatically drop objects that depend on the materialized view (such as other materialized views, or regular views), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the materialized view if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


This command will remove the materialized view called
order_summary:

.if n \{.RS 4
.\}
    DROP MATERIALIZED VIEW order_summary;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP MATERIALIZED VIEW**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE MATERIALIZED VIEW (**CREATE\_MATERIALIZED\_VIEW**(7)), ALTER MATERIALIZED VIEW (**ALTER\_MATERIALIZED\_VIEW**(7)), REFRESH MATERIALIZED VIEW (**REFRESH\_MATERIALIZED\_VIEW**(7))
