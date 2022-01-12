# drop rule(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_RULE - remove a rewrite rule

<a name="synopsis"></a>

# Synopsis

```


```
    DROP RULE [ IF EXISTS ] name ON table_name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP RULE**
drops a rewrite rule.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the rule does not exist. A notice is issued in this case.

_name_
The name of the rule to drop.

_table\_name_
The name (optionally schema-qualified) of the table or view that the rule applies to.

CASCADE
Automatically drop objects that depend on the rule, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the rule if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


To drop the rewrite rule
newrule:

.if n \{.RS 4
.\}
    DROP RULE newrule ON mytable;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP RULE**
is a
PostgreSQL
language extension, as is the entire query rewrite system.

<a name="see-also"></a>

# See Also

CREATE RULE (**CREATE\_RULE**(7)), ALTER RULE (**ALTER\_RULE**(7))
