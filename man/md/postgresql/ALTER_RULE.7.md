# alter rule(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_RULE - change the definition of a rule

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER RULE name ON table_name RENAME TO new_name

<a name="description"></a>

# Description


**ALTER RULE**
changes properties of an existing rule. Currently, the only available action is to change the rules name.

To use
**ALTER RULE**, you must own the table or view that the rule applies to.

<a name="parameters"></a>

# Parameters


_name_
The name of an existing rule to alter.

_table\_name_
The name (optionally schema-qualified) of the table or view that the rule applies to.

_new\_name_
The new name for the rule.

<a name="examples"></a>

# Examples


To rename an existing rule:

.if n \{.RS 4
.\}
    ALTER RULE notify_all ON emp RENAME TO notify_me;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**ALTER RULE**
is a
PostgreSQL
language extension, as is the entire query rewrite system.

<a name="see-also"></a>

# See Also

CREATE RULE (**CREATE\_RULE**(7)), DROP RULE (**DROP\_RULE**(7))
