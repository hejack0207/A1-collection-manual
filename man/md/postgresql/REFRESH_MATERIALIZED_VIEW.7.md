# refresh materialized view(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

REFRESH_MATERIALIZED_VIEW - replace the contents of a materialized view

<a name="synopsis"></a>

# Synopsis

```


```
    REFRESH MATERIALIZED VIEW [ CONCURRENTLY ] name
        [ WITH [ NO ] DATA ]

<a name="description"></a>

# Description


**REFRESH MATERIALIZED VIEW**
completely replaces the contents of a materialized view. To execute this command you must be the owner of the materialized view. The old contents are discarded. If
WITH DATA
is specified (or defaults) the backing query is executed to provide the new data, and the materialized view is left in a scannable state. If
WITH NO DATA
is specified no new data is generated and the materialized view is left in an unscannable state.

CONCURRENTLY
and
WITH NO DATA
may not be specified together.

<a name="parameters"></a>

# Parameters


CONCURRENTLY
Refresh the materialized view without locking out concurrent selects on the materialized view. Without this option a refresh which affects a lot of rows will tend to use fewer resources and complete more quickly, but could block other connections which are trying to read from the materialized view. This option may be faster in cases where a small number of rows are affected.

This option is only allowed if there is at least one
UNIQUE
index on the materialized view which uses only column names and includes all rows; that is, it must not be an expression index or include a
WHERE
clause.

This option may not be used when the materialized view is not already populated.

Even with this option only one
REFRESH
at a time may run against any one materialized view.

_name_
The name (optionally schema-qualified) of the materialized view to refresh.

<a name="notes"></a>

# Notes


While the default index for future
**CLUSTER**(7)
operations is retained,
**REFRESH MATERIALIZED VIEW**
does not order the generated rows based on this property. If you want the data to be ordered upon generation, you must use an
ORDER BY
clause in the backing query.

<a name="examples"></a>

# Examples


This command will replace the contents of the materialized view called
order_summary
using the query from the materialized views definition, and leave it in a scannable state:

.if n \{.RS 4
.\}
    REFRESH MATERIALIZED VIEW order_summary;
.if n \{.RE
.\}

This command will free storage associated with the materialized view
annual_statistics_basis
and leave it in an unscannable state:

.if n \{.RS 4
.\}
    REFRESH MATERIALIZED VIEW annual_statistics_basis WITH NO DATA;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**REFRESH MATERIALIZED VIEW**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE MATERIALIZED VIEW (**CREATE\_MATERIALIZED\_VIEW**(7)), ALTER MATERIALIZED VIEW (**ALTER\_MATERIALIZED\_VIEW**(7)), DROP MATERIALIZED VIEW (**DROP\_MATERIALIZED\_VIEW**(7))
