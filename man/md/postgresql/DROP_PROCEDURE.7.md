# drop procedure(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_PROCEDURE - remove a procedure

<a name="synopsis"></a>

# Synopsis

```


```
    DROP PROCEDURE [ IF EXISTS ] name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] [, ...]
        [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP PROCEDURE**
removes the definition of an existing procedure. To execute this command the user must be the owner of the procedure. The argument types to the procedure must be specified, since several different procedures can exist with the same name and different argument lists.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the procedure does not exist. A notice is issued in this case.

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
**DROP PROCEDURE**
does not actually pay any attention to argument names, since only the argument data types are needed to determine the procedures identity.

_argtype_
The data type(s) of the procedures arguments (optionally schema-qualified), if any.

CASCADE
Automatically drop objects that depend on the procedure, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the procedure if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    DROP PROCEDURE do_db_maintenance();
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


This command conforms to the SQL standard, with these
PostgreSQL
extensions:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The standard only allows one procedure to be dropped per command.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The
  IF EXISTS
  option

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The ability to specify argument modes and names


<a name="see-also"></a>

# See Also

CREATE PROCEDURE (**CREATE\_PROCEDURE**(7)), ALTER PROCEDURE (**ALTER\_PROCEDURE**(7)), DROP FUNCTION (**DROP\_FUNCTION**(7)), DROP ROUTINE (**DROP\_ROUTINE**(7))
