# drop operator class(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_OPERATOR_CLASS - remove an operator class

<a name="synopsis"></a>

# Synopsis

```


```
    DROP OPERATOR CLASS [ IF EXISTS ] name USING index_method [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP OPERATOR CLASS**
drops an existing operator class. To execute this command you must be the owner of the operator class.

**DROP OPERATOR CLASS**
does not drop any of the operators or functions referenced by the class. If there are any indexes depending on the operator class, you will need to specify
CASCADE
for the drop to complete.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the operator class does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing operator class.

_index\_method_
The name of the index access method the operator class is for.

CASCADE
Automatically drop objects that depend on the operator class (such as indexes), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the operator class if any objects depend on it. This is the default.

<a name="notes"></a>

# Notes


**DROP OPERATOR CLASS**
will not drop the operator family containing the class, even if there is nothing else left in the family (in particular, in the case where the family was implicitly created by
**CREATE OPERATOR CLASS**). An empty operator family is harmless, but for the sake of tidiness you might wish to remove the family with
**DROP OPERATOR FAMILY**; or perhaps better, use
**DROP OPERATOR FAMILY**
in the first place.

<a name="examples"></a>

# Examples


Remove the B-tree operator class
widget_ops:

.if n \{.RS 4
.\}
    DROP OPERATOR CLASS widget_ops USING btree;
.if n \{.RE
.\}

This command will not succeed if there are any existing indexes that use the operator class. Add
CASCADE
to drop such indexes along with the operator class.

<a name="compatibility"></a>

# Compatibility


There is no
**DROP OPERATOR CLASS**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER OPERATOR CLASS (**ALTER\_OPERATOR\_CLASS**(7)), CREATE OPERATOR CLASS (**CREATE\_OPERATOR\_CLASS**(7)), DROP OPERATOR FAMILY (**DROP\_OPERATOR\_FAMILY**(7))
