# drop aggregate(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_AGGREGATE - remove an aggregate function

<a name="synopsis"></a>

# Synopsis

```


```
    DROP AGGREGATE [ IF EXISTS ] name ( aggregate_signature ) [, ...] [ CASCADE | RESTRICT ]
    
    where aggregate_signature is:
    
    * |
    [ argmode ] [ argname ] argtype [ , ... ] |
    [ [ argmode ] [ argname ] argtype [ , ... ] ] ORDER BY [ argmode ] [ argname ] argtype [ , ... ]

<a name="description"></a>

# Description


**DROP AGGREGATE**
removes an existing aggregate function. To execute this command the current user must be the owner of the aggregate function.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the aggregate does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing aggregate function.

_argmode_
The mode of an argument:
IN
or
VARIADIC. If omitted, the default is
IN.

_argname_
The name of an argument. Note that
**DROP AGGREGATE**
does not actually pay any attention to argument names, since only the argument data types are needed to determine the aggregate functions identity.

_argtype_
An input data type on which the aggregate function operates. To reference a zero-argument aggregate function, write
*
in place of the list of argument specifications. To reference an ordered-set aggregate function, write
ORDER BY
between the direct and aggregated argument specifications.

CASCADE
Automatically drop objects that depend on the aggregate function (such as views using it), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the aggregate function if any objects depend on it. This is the default.

<a name="notes"></a>

# Notes


Alternative syntaxes for referencing ordered-set aggregates are described under
ALTER AGGREGATE (**ALTER\_AGGREGATE**(7)).

<a name="examples"></a>

# Examples


To remove the aggregate function
myavg
for type
integer:

.if n \{.RS 4
.\}
    DROP AGGREGATE myavg(integer);
.if n \{.RE
.\}

To remove the hypothetical-set aggregate function
myrank, which takes an arbitrary list of ordering columns and a matching list of direct arguments:

.if n \{.RS 4
.\}
    DROP AGGREGATE myrank(VARIADIC "any" ORDER BY VARIADIC "any");
.if n \{.RE
.\}

To remove multiple aggregate functions in one command:

.if n \{.RS 4
.\}
    DROP AGGREGATE myavg(integer), myavg(bigint);
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**DROP AGGREGATE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER AGGREGATE (**ALTER\_AGGREGATE**(7)), CREATE AGGREGATE (**CREATE\_AGGREGATE**(7))
