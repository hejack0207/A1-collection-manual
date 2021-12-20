# alter function(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_FUNCTION - change the definition of a function

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        action [ ... ] [ RESTRICT ]
    ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        RENAME TO new_name
    ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        SET SCHEMA new_schema
    ALTER FUNCTION name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ]
        DEPENDS ON EXTENSION extension_name
    
    where action is one of:
    
        CALLED ON NULL INPUT | RETURNS NULL ON NULL INPUT | STRICT
        IMMUTABLE | STABLE | VOLATILE | [ NOT ] LEAKPROOF
        [ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
        PARALLEL { UNSAFE | RESTRICTED | SAFE }
        COST execution_cost
        ROWS result_rows
        SUPPORT support_function
        SET configuration_parameter { TO | = } { value | DEFAULT }
        SET configuration_parameter FROM CURRENT
        RESET configuration_parameter
        RESET ALL

<a name="description"></a>

# Description


**ALTER FUNCTION**
changes the definition of a function.

You must own the function to use
**ALTER FUNCTION**. To change a functions schema, you must also have
CREATE
privilege on the new schema. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the functions schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the function. However, a superuser can alter ownership of any function anyway.)

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing function. If no argument list is specified, the name must be unique in its schema.

_argmode_
The mode of an argument:
IN,
OUT,
INOUT, or
VARIADIC. If omitted, the default is
IN. Note that
**ALTER FUNCTION**
does not actually pay any attention to
OUT
arguments, since only the input arguments are needed to determine the functions identity. So it is sufficient to list the
IN,
INOUT, and
VARIADIC
arguments.

_argname_
The name of an argument. Note that
**ALTER FUNCTION**
does not actually pay any attention to argument names, since only the argument data types are needed to determine the functions identity.

_argtype_
The data type(s) of the functions arguments (optionally schema-qualified), if any.

_new\_name_
The new name of the function.

_new\_owner_
The new owner of the function. Note that if the function is marked
SECURITY DEFINER, it will subsequently execute as the new owner.

_new\_schema_
The new schema for the function.

_extension\_name_
The name of the extension that the function is to depend on.

CALLED ON NULL INPUT  
RETURNS NULL ON NULL INPUT  
STRICT
CALLED ON NULL INPUT
changes the function so that it will be invoked when some or all of its arguments are null.
RETURNS NULL ON NULL INPUT
or
STRICT
changes the function so that it is not invoked if any of its arguments are null; instead, a null result is assumed automatically. See
CREATE FUNCTION (**CREATE\_FUNCTION**(7))
for more information.

IMMUTABLE  
STABLE  
VOLATILE
Change the volatility of the function to the specified setting. See
CREATE FUNCTION (**CREATE\_FUNCTION**(7))
for details.

[ EXTERNAL ] SECURITY INVOKER  
[ EXTERNAL ] SECURITY DEFINER
Change whether the function is a security definer or not. The key word
EXTERNAL
is ignored for SQL conformance. See
CREATE FUNCTION (**CREATE\_FUNCTION**(7))
for more information about this capability.

PARALLEL
Change whether the function is deemed safe for parallelism. See
CREATE FUNCTION (**CREATE\_FUNCTION**(7))
for details.

LEAKPROOF
Change whether the function is considered leakproof or not. See
CREATE FUNCTION (**CREATE\_FUNCTION**(7))
for more information about this capability.

COST _execution\_cost_
Change the estimated execution cost of the function. See
CREATE FUNCTION (**CREATE\_FUNCTION**(7))
for more information.

ROWS _result\_rows_
Change the estimated number of rows returned by a set-returning function. See
CREATE FUNCTION (**CREATE\_FUNCTION**(7))
for more information.

SUPPORT _support\_function_
Set or change the planner support function to use for this function. See
Section&nbsp;37.11
for details. You must be superuser to use this option.

This option cannot be used to remove the support function altogether, since it must name a new support function. Use
**CREATE OR REPLACE FUNCTION**
if you need to do that.

_configuration\_parameter_  
_value_
Add or change the assignment to be made to a configuration parameter when the function is called. If
_value_
is
DEFAULT
or, equivalently,
RESET
is used, the function-local setting is removed, so that the function executes with the value present in its environment. Use
RESET ALL
to clear all function-local settings.
SET FROM CURRENT
saves the value of the parameter that is current when
**ALTER FUNCTION**
is executed as the value to be applied when the function is entered.

See
**SET**(7)
and
Chapter&nbsp;19
for more information about allowed parameter names and values.

RESTRICT
Ignored for conformance with the SQL standard.

<a name="examples"></a>

# Examples


To rename the function
sqrt
for type
integer
to
square_root:

.if n \{.RS 4
.\}
    ALTER FUNCTION sqrt(integer) RENAME TO square_root;
.if n \{.RE
.\}

To change the owner of the function
sqrt
for type
integer
to
joe:

.if n \{.RS 4
.\}
    ALTER FUNCTION sqrt(integer) OWNER TO joe;
.if n \{.RE
.\}

To change the schema of the function
sqrt
for type
integer
to
maths:

.if n \{.RS 4
.\}
    ALTER FUNCTION sqrt(integer) SET SCHEMA maths;
.if n \{.RE
.\}

To mark the function
sqrt
for type
integer
as being dependent on the extension
mathlib:

.if n \{.RS 4
.\}
    ALTER FUNCTION sqrt(integer) DEPENDS ON EXTENSION mathlib;
.if n \{.RE
.\}

To adjust the search path that is automatically set for a function:

.if n \{.RS 4
.\}
    ALTER FUNCTION check_password(text) SET search_path = admin, pg_temp;
.if n \{.RE
.\}

To disable automatic setting of
_search\_path_
for a function:

.if n \{.RS 4
.\}
    ALTER FUNCTION check_password(text) RESET search_path;
.if n \{.RE
.\}

The function will now execute with whatever search path is used by its caller.

<a name="compatibility"></a>

# Compatibility


This statement is partially compatible with the
**ALTER FUNCTION**
statement in the SQL standard. The standard allows more properties of a function to be modified, but does not provide the ability to rename a function, make a function a security definer, attach configuration parameter values to a function, or change the owner, schema, or volatility of a function. The standard also requires the
RESTRICT
key word, which is optional in
PostgreSQL.

<a name="see-also"></a>

# See Also

CREATE FUNCTION (**CREATE\_FUNCTION**(7)), DROP FUNCTION (**DROP\_FUNCTION**(7)), ALTER PROCEDURE (**ALTER\_PROCEDURE**(7)), ALTER ROUTINE (**ALTER\_ROUTINE**(7))
