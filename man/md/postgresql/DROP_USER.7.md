# drop user(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_USER - remove a database role

<a name="synopsis"></a>

# Synopsis

```


```
    DROP USER [ IF EXISTS ] name [, ...]

<a name="description"></a>

# Description


**DROP USER**
is simply an alternate spelling of
DROP ROLE (**DROP\_ROLE**(7)).

<a name="compatibility"></a>

# Compatibility


The
**DROP USER**
statement is a
PostgreSQL
extension. The SQL standard leaves the definition of users to the implementation.

<a name="see-also"></a>

# See Also

DROP ROLE (**DROP\_ROLE**(7))
