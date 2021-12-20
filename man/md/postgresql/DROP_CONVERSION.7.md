# drop conversion(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_CONVERSION - remove a conversion

<a name="synopsis"></a>

# Synopsis

```


```
    DROP CONVERSION [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP CONVERSION**
removes a previously defined conversion. To be able to drop a conversion, you must own the conversion.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the conversion does not exist. A notice is issued in this case.

_name_
The name of the conversion. The conversion name can be schema-qualified.

CASCADE  
RESTRICT
These key words do not have any effect, since there are no dependencies on conversions.

<a name="examples"></a>

# Examples


To drop the conversion named
myname:

.if n \{.RS 4
.\}
    DROP CONVERSION myname;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**DROP CONVERSION**
statement in the SQL standard, but a
**DROP TRANSLATION**
statement that goes along with the
**CREATE TRANSLATION**
statement that is similar to the
**CREATE CONVERSION**
statement in PostgreSQL.

<a name="see-also"></a>

# See Also

ALTER CONVERSION (**ALTER\_CONVERSION**(7)), CREATE CONVERSION (**CREATE\_CONVERSION**(7))
