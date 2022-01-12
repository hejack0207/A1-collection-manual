# drop cast(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_CAST - remove a cast

<a name="synopsis"></a>

# Synopsis

```


```
    DROP CAST [ IF EXISTS ] (source_type AS target_type) [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP CAST**
removes a previously defined cast.

To be able to drop a cast, you must own the source or the target data type. These are the same privileges that are required to create a cast.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the cast does not exist. A notice is issued in this case.

_source\_type_
The name of the source data type of the cast.

_target\_type_
The name of the target data type of the cast.

CASCADE  
RESTRICT
These key words do not have any effect, since there are no dependencies on casts.

<a name="examples"></a>

# Examples


To drop the cast from type
text
to type
int:

.if n \{.RS 4
.\}
    DROP CAST (text AS int);
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The
**DROP CAST**
command conforms to the SQL standard.

<a name="see-also"></a>

# See Also

CREATE CAST (**CREATE\_CAST**(7))
