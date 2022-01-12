# drop operator(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_OPERATOR - remove an operator

<a name="synopsis"></a>

# Synopsis

```


```
    DROP OPERATOR [ IF EXISTS ] name ( { left_type | NONE } , { right_type | NONE } ) [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP OPERATOR**
drops an existing operator from the database system. To execute this command you must be the owner of the operator.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the operator does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing operator.

_left\_type_
The data type of the operators left operand; write
NONE
if the operator has no left operand.

_right\_type_
The data type of the operators right operand; write
NONE
if the operator has no right operand.

CASCADE
Automatically drop objects that depend on the operator (such as views using it), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the operator if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Remove the power operator
a^b
for type
integer:

.if n \{.RS 4
.\}
    DROP OPERATOR ^ (integer, integer);
.if n \{.RE
.\}

Remove the left unary bitwise complement operator
~b
for type
bit:

.if n \{.RS 4
.\}
    DROP OPERATOR ~ (none, bit);
.if n \{.RE
.\}

Remove the right unary factorial operator
x!
for type
bigint:

.if n \{.RS 4
.\}
    DROP OPERATOR ! (bigint, none);
.if n \{.RE
.\}

Remove multiple operators in one command:

.if n \{.RS 4
.\}
    DROP OPERATOR ~ (none, bit), ! (bigint, none);
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**DROP OPERATOR**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE OPERATOR (**CREATE\_OPERATOR**(7)), ALTER OPERATOR (**ALTER\_OPERATOR**(7))
