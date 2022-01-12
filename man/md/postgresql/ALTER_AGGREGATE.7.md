# alter aggregate(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_AGGREGATE - change the definition of an aggregate function

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER AGGREGATE name ( aggregate_signature ) RENAME TO new_name
    ALTER AGGREGATE name ( aggregate_signature )
                    OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER AGGREGATE name ( aggregate_signature ) SET SCHEMA new_schema
    
    where aggregate_signature is:
    
    * |
    [ argmode ] [ argname ] argtype [ , ... ] |
    [ [ argmode ] [ argname ] argtype [ , ... ] ] ORDER BY [ argmode ] [ argname ] argtype [ , ... ]

<a name="description"></a>

# Description


**ALTER AGGREGATE**
changes the definition of an aggregate function.

You must own the aggregate function to use
**ALTER AGGREGATE**. To change the schema of an aggregate function, you must also have
CREATE
privilege on the new schema. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the aggregate functions schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the aggregate function. However, a superuser can alter ownership of any aggregate function anyway.)

<a name="parameters"></a>

# Parameters


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
**ALTER AGGREGATE**
does not actually pay any attention to argument names, since only the argument data types are needed to determine the aggregate functions identity.

_argtype_
An input data type on which the aggregate function operates. To reference a zero-argument aggregate function, write
*
in place of the list of argument specifications. To reference an ordered-set aggregate function, write
ORDER BY
between the direct and aggregated argument specifications.

_new\_name_
The new name of the aggregate function.

_new\_owner_
The new owner of the aggregate function.

_new\_schema_
The new schema for the aggregate function.

<a name="notes"></a>

# Notes


The recommended syntax for referencing an ordered-set aggregate is to write
ORDER BY
between the direct and aggregated argument specifications, in the same style as in
CREATE AGGREGATE (**CREATE\_AGGREGATE**(7)). However, it will also work to omit
ORDER BY
and just run the direct and aggregated argument specifications into a single list. In this abbreviated form, if
VARIADIC "any"
was used in both the direct and aggregated argument lists, write
VARIADIC "any"
only once.

<a name="examples"></a>

# Examples


To rename the aggregate function
myavg
for type
integer
to
my_average:

.if n \{.RS 4
.\}
    ALTER AGGREGATE myavg(integer) RENAME TO my_average;
.if n \{.RE
.\}

To change the owner of the aggregate function
myavg
for type
integer
to
joe:

.if n \{.RS 4
.\}
    ALTER AGGREGATE myavg(integer) OWNER TO joe;
.if n \{.RE
.\}

To move the ordered-set aggregate
mypercentile
with direct argument of type
float8
and aggregated argument of type
integer
into schema
myschema:

.if n \{.RS 4
.\}
    ALTER AGGREGATE mypercentile(float8 ORDER BY integer) SET SCHEMA myschema;
.if n \{.RE
.\}

This will work too:

.if n \{.RS 4
.\}
    ALTER AGGREGATE mypercentile(float8, integer) SET SCHEMA myschema;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER AGGREGATE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE AGGREGATE (**CREATE\_AGGREGATE**(7)), DROP AGGREGATE (**DROP\_AGGREGATE**(7))
