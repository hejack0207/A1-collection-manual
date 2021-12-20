# alter routine(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_ROUTINE - change the definition of a routine

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        action [ ... ] [ RESTRICT ]
    ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        RENAME TO new_name
    ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        SET SCHEMA new_schema
    ALTER ROUTINE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        DEPENDS ON EXTENSION extension_name
    
    where action is one of:
    
        IMMUTABLE | STABLE | VOLATILE | [ NOT ] LEAKPROOF
        [ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
        PARALLEL { UNSAFE | RESTRICTED | SAFE }
        COST execution_cost
        ROWS result_rows
        SET configuration_parameter { TO | = } { value | DEFAULT }
        SET configuration_parameter FROM CURRENT
        RESET configuration_parameter
        RESET ALL

<a name="description"></a>

# Description


**ALTER ROUTINE**
changes the definition of a routine, which can be an aggregate function, a normal function, or a procedure. See under
ALTER AGGREGATE (**ALTER\_AGGREGATE**(7)),
ALTER FUNCTION (**ALTER\_FUNCTION**(7)), and
ALTER PROCEDURE (**ALTER\_PROCEDURE**(7))
for the description of the parameters, more examples, and further details.

<a name="examples"></a>

# Examples


To rename the routine
foo
for type
integer
to
foobar:

.if n \{.RS 4
.\}
    ALTER ROUTINE foo(integer) RENAME TO foobar;
.if n \{.RE
.\}

This command will work independent of whether
foo
is an aggregate, function, or procedure.

<a name="compatibility"></a>

# Compatibility


This statement is partially compatible with the
**ALTER ROUTINE**
statement in the SQL standard. See under
ALTER FUNCTION (**ALTER\_FUNCTION**(7))
and
ALTER PROCEDURE (**ALTER\_PROCEDURE**(7))
for more details. Allowing routine names to refer to aggregate functions is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

ALTER AGGREGATE (**ALTER\_AGGREGATE**(7)), ALTER FUNCTION (**ALTER\_FUNCTION**(7)), ALTER PROCEDURE (**ALTER\_PROCEDURE**(7)), DROP ROUTINE (**DROP\_ROUTINE**(7))

Note that there is no
CREATE ROUTINE
command.
