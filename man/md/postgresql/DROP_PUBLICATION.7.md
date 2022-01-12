# drop publication(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_PUBLICATION - remove a publication

<a name="synopsis"></a>

# Synopsis

```


```
    DROP PUBLICATION [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP PUBLICATION**
removes an existing publication from the database.

A publication can only be dropped by its owner or a superuser.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the publication does not exist. A notice is issued in this case.

_name_
The name of an existing publication.

CASCADE  
RESTRICT
These key words do not have any effect, since there are no dependencies on publications.

<a name="examples"></a>

# Examples


Drop a publication:

.if n \{.RS 4
.\}
    DROP PUBLICATION mypublication;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP PUBLICATION**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE PUBLICATION (**CREATE\_PUBLICATION**(7)), ALTER PUBLICATION (**ALTER\_PUBLICATION**(7))
