# drop function(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_FUNCTION - remove a function

<a name="synopsis"></a>

# Synopsis

```


```
    DROP FUNCTION [ IF EXISTS ] name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] [, ...]
        [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP FUNCTION**
removes the definition of an existing function. To execute this command the user must be the owner of the function. The argument types to the function must be specified, since several different functions can exist with the same name and different argument lists.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the function does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing function. If no argument list is specified, the name must be unique in its schema.

_argmode_
The mode of an argument:
IN,
OUT,
INOUT, or
VARIADIC. If omitted, the default is
IN. Note that
**DROP FUNCTION**
does not actually pay any attention to
OUT
arguments, since only the input arguments are needed to determine the functions identity. So it is sufficient to list the
IN,
INOUT, and
VARIADIC
arguments.

_argname_
The name of an argument. Note that
**DROP FUNCTION**
does not actually pay any attention to argument names, since only the argument data types are needed to determine the functions identity.

_argtype_
The data type(s) of the functions arguments (optionally schema-qualified), if any.

CASCADE
Automatically drop objects that depend on the function (such as operators or triggers), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the function if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


This command removes the square root function:

.if n \{.RS 4
.\}
    DROP FUNCTION sqrt(integer);
.if n \{.RE
.\}

Drop multiple functions in one command:

.if n \{.RS 4
.\}
    DROP FUNCTION sqrt(integer), sqrt(bigint);
.if n \{.RE
.\}

If the function name is unique in its schema, it can be referred to without an argument list:

.if n \{.RS 4
.\}
    DROP FUNCTION update_employee_salaries;
.if n \{.RE
.\}

Note that this is different from

.if n \{.RS 4
.\}
    DROP FUNCTION update_employee_salaries();
.if n \{.RE
.\}

which refers to a function with zero arguments, whereas the first variant can refer to a function with any number of arguments, including zero, as long as the name is unique.

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
  The standard only allows one function to be dropped per command.

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

CREATE FUNCTION (**CREATE\_FUNCTION**(7)), ALTER FUNCTION (**ALTER\_FUNCTION**(7)), DROP PROCEDURE (**DROP\_PROCEDURE**(7)), DROP ROUTINE (**DROP\_ROUTINE**(7))
