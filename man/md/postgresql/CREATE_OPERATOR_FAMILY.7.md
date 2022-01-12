# create operator family(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_OPERATOR_FAMILY - define a new operator family

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE OPERATOR FAMILY name USING index_method

<a name="description"></a>

# Description


**CREATE OPERATOR FAMILY**
creates a new operator family. An operator family defines a collection of related operator classes, and perhaps some additional operators and support functions that are compatible with these operator classes but not essential for the functioning of any individual index. (Operators and functions that are essential to indexes should be grouped within the relevant operator class, rather than being
“loose”
in the operator family. Typically, single-data-type operators are bound to operator classes, while cross-data-type operators can be loose in an operator family containing operator classes for both data types.)

The new operator family is initially empty. It should be populated by issuing subsequent
**CREATE OPERATOR CLASS**
commands to add contained operator classes, and optionally
**ALTER OPERATOR FAMILY**
commands to add
“loose”
operators and their corresponding support functions.

If a schema name is given then the operator family is created in the specified schema. Otherwise it is created in the current schema. Two operator families in the same schema can have the same name only if they are for different index methods.

The user who defines an operator family becomes its owner. Presently, the creating user must be a superuser. (This restriction is made because an erroneous operator family definition could confuse or even crash the server.)

Refer to
Section&nbsp;37.16
for further information.

<a name="parameters"></a>

# Parameters


_name_
The name of the operator family to be created. The name can be schema-qualified.

_index\_method_
The name of the index method this operator family is for.

<a name="compatibility"></a>

# Compatibility


**CREATE OPERATOR FAMILY**
is a
PostgreSQL
extension. There is no
**CREATE OPERATOR FAMILY**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER OPERATOR FAMILY (**ALTER\_OPERATOR\_FAMILY**(7)), DROP OPERATOR FAMILY (**DROP\_OPERATOR\_FAMILY**(7)), CREATE OPERATOR CLASS (**CREATE\_OPERATOR\_CLASS**(7)), ALTER OPERATOR CLASS (**ALTER\_OPERATOR\_CLASS**(7)), DROP OPERATOR CLASS (**DROP\_OPERATOR\_CLASS**(7))
