# alter procedure(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_PROCEDURE - change the definition of a procedure

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        action [ ... ] [ RESTRICT ]
    ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        RENAME TO new_name
    ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        SET SCHEMA new_schema
    ALTER PROCEDURE name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        DEPENDS ON EXTENSION extension_name
    
    where action is one of:
    
        [ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
        SET configuration_parameter { TO | = } { value | DEFAULT }
        SET configuration_parameter FROM CURRENT
        RESET configuration_parameter
        RESET ALL

<a name="description"></a>

# Description


**ALTER PROCEDURE**
changes the definition of a procedure.

You must own the procedure to use
**ALTER PROCEDURE**. To change a procedures schema, you must also have
CREATE
privilege on the new schema. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the procedures schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the procedure. However, a superuser can alter ownership of any procedure anyway.)

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing procedure. If no argument list is specified, the name must be unique in its schema.

_argmode_
The mode of an argument:
IN
or
VARIADIC. If omitted, the default is
IN.

_argname_
The name of an argument. Note that
**ALTER PROCEDURE**
does not actually pay any attention to argument names, since only the argument data types are needed to determine the procedures identity.

_argtype_
The data type(s) of the procedures arguments (optionally schema-qualified), if any.

_new\_name_
The new name of the procedure.

_new\_owner_
The new owner of the procedure. Note that if the procedure is marked
SECURITY DEFINER, it will subsequently execute as the new owner.

_new\_schema_
The new schema for the procedure.

_extension\_name_
The name of the extension that the procedure is to depend on.

[ EXTERNAL ] SECURITY INVOKER  
[ EXTERNAL ] SECURITY DEFINER
Change whether the procedure is a security definer or not. The key word
EXTERNAL
is ignored for SQL conformance. See
CREATE PROCEDURE (**CREATE\_PROCEDURE**(7))
for more information about this capability.

_configuration\_parameter_  
_value_
Add or change the assignment to be made to a configuration parameter when the procedure is called. If
_value_
is
DEFAULT
or, equivalently,
RESET
is used, the procedure-local setting is removed, so that the procedure executes with the value present in its environment. Use
RESET ALL
to clear all procedure-local settings.
SET FROM CURRENT
saves the value of the parameter that is current when
**ALTER PROCEDURE**
is executed as the value to be applied when the procedure is entered.

See
**SET**(7)
and
Chapter&nbsp;19
for more information about allowed parameter names and values.

RESTRICT
Ignored for conformance with the SQL standard.

<a name="examples"></a>

# Examples


To rename the procedure
insert_data
with two arguments of type
integer
to
insert_record:

.if n \{.RS 4
.\}
    ALTER PROCEDURE insert_data(integer, integer) RENAME TO insert_record;
.if n \{.RE
.\}

To change the owner of the procedure
insert_data
with two arguments of type
integer
to
joe:

.if n \{.RS 4
.\}
    ALTER PROCEDURE insert_data(integer, integer) OWNER TO joe;
.if n \{.RE
.\}

To change the schema of the procedure
insert_data
with two arguments of type
integer
to
accounting:

.if n \{.RS 4
.\}
    ALTER PROCEDURE insert_data(integer, integer) SET SCHEMA accounting;
.if n \{.RE
.\}

To mark the procedure
insert_data(integer, integer)
as being dependent on the extension
myext:

.if n \{.RS 4
.\}
    ALTER PROCEDURE insert_data(integer, integer) DEPENDS ON EXTENSION myext;
.if n \{.RE
.\}

To adjust the search path that is automatically set for a procedure:

.if n \{.RS 4
.\}
    ALTER PROCEDURE check_password(text) SET search_path = admin, pg_temp;
.if n \{.RE
.\}

To disable automatic setting of
_search\_path_
for a procedure:

.if n \{.RS 4
.\}
    ALTER PROCEDURE check_password(text) RESET search_path;
.if n \{.RE
.\}

The procedure will now execute with whatever search path is used by its caller.

<a name="compatibility"></a>

# Compatibility


This statement is partially compatible with the
**ALTER PROCEDURE**
statement in the SQL standard. The standard allows more properties of a procedure to be modified, but does not provide the ability to rename a procedure, make a procedure a security definer, attach configuration parameter values to a procedure, or change the owner, schema, or volatility of a procedure. The standard also requires the
RESTRICT
key word, which is optional in
PostgreSQL.

<a name="see-also"></a>

# See Also

CREATE PROCEDURE (**CREATE\_PROCEDURE**(7)), DROP PROCEDURE (**DROP\_PROCEDURE**(7)), ALTER FUNCTION (**ALTER\_FUNCTION**(7)), ALTER ROUTINE (**ALTER\_ROUTINE**(7))
