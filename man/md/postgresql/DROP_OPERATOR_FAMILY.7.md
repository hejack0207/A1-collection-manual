# drop operator family(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_OPERATOR_FAMILY - remove an operator family

<a name="synopsis"></a>

# Synopsis

```


```
    DROP OPERATOR FAMILY [ IF EXISTS ] name USING index_method [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP OPERATOR FAMILY**
drops an existing operator family. To execute this command you must be the owner of the operator family.

**DROP OPERATOR FAMILY**
includes dropping any operator classes contained in the family, but it does not drop any of the operators or functions referenced by the family. If there are any indexes depending on operator classes within the family, you will need to specify
CASCADE
for the drop to complete.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the operator family does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing operator family.

_index\_method_
The name of the index access method the operator family is for.

CASCADE
Automatically drop objects that depend on the operator family, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the operator family if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Remove the B-tree operator family
float_ops:

.if n \{.RS 4
.\}
    DROP OPERATOR FAMILY float_ops USING btree;
.if n \{.RE
.\}

This command will not succeed if there are any existing indexes that use operator classes within the family. Add
CASCADE
to drop such indexes along with the operator family.

<a name="compatibility"></a>

# Compatibility


There is no
**DROP OPERATOR FAMILY**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER OPERATOR FAMILY (**ALTER\_OPERATOR\_FAMILY**(7)), CREATE OPERATOR FAMILY (**CREATE\_OPERATOR\_FAMILY**(7)), ALTER OPERATOR CLASS (**ALTER\_OPERATOR\_CLASS**(7)), CREATE OPERATOR CLASS (**CREATE\_OPERATOR\_CLASS**(7)), DROP OPERATOR CLASS (**DROP\_OPERATOR\_CLASS**(7))
