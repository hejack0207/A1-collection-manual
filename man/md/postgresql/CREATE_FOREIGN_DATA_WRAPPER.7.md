# create foreign data wrapper(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_FOREIGN_DATA_WRAPPER - define a new foreign-data wrapper

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE FOREIGN DATA WRAPPER name
        [ HANDLER handler_function | NO HANDLER ]
        [ VALIDATOR validator_function | NO VALIDATOR ]
        [ OPTIONS ( option value*(Aq [, ... ] ) ]

<a name="description"></a>

# Description


**CREATE FOREIGN DATA WRAPPER**
creates a new foreign-data wrapper. The user who defines a foreign-data wrapper becomes its owner.

The foreign-data wrapper name must be unique within the database.

Only superusers can create foreign-data wrappers.

<a name="parameters"></a>

# Parameters


_name_
The name of the foreign-data wrapper to be created.

HANDLER _handler\_function_
_handler\_function_
is the name of a previously registered function that will be called to retrieve the execution functions for foreign tables. The handler function must take no arguments, and its return type must be
fdw_handler.

It is possible to create a foreign-data wrapper with no handler function, but foreign tables using such a wrapper can only be declared, not accessed.

VALIDATOR _validator\_function_
_validator\_function_
is the name of a previously registered function that will be called to check the generic options given to the foreign-data wrapper, as well as options for foreign servers, user mappings and foreign tables using the foreign-data wrapper. If no validator function or
NO VALIDATOR
is specified, then options will not be checked at creation time. (Foreign-data wrappers will possibly ignore or reject invalid option specifications at run time, depending on the implementation.) The validator function must take two arguments: one of type
text[], which will contain the array of options as stored in the system catalogs, and one of type
oid, which will be the OID of the system catalog containing the options. The return type is ignored; the function should report invalid options using the
**ereport(ERROR)**
function.

OPTIONS ( _option_ _value_\*(Aq [, ... ] )
This clause specifies options for the new foreign-data wrapper. The allowed option names and values are specific to each foreign data wrapper and are validated using the foreign-data wrappers validator function. Option names must be unique.

<a name="notes"></a>

# Notes


PostgreSQLs foreign-data functionality is still under active development. Optimization of queries is primitive (and mostly left to the wrapper, too). Thus, there is considerable room for future performance improvements.

<a name="examples"></a>

# Examples


Create a useless foreign-data wrapper
dummy:

.if n \{.RS 4
.\}
    CREATE FOREIGN DATA WRAPPER dummy;
.if n \{.RE
.\}

Create a foreign-data wrapper
file
with handler function
file_fdw_handler:

.if n \{.RS 4
.\}
    CREATE FOREIGN DATA WRAPPER file HANDLER file_fdw_handler;
.if n \{.RE
.\}

Create a foreign-data wrapper
mywrapper
with some options:

.if n \{.RS 4
.\}
    CREATE FOREIGN DATA WRAPPER mywrapper
        OPTIONS (debug true*(Aq);
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CREATE FOREIGN DATA WRAPPER**
conforms to ISO/IEC 9075-9 (SQL/MED), with the exception that the
HANDLER
and
VALIDATOR
clauses are extensions and the standard clauses
LIBRARY
and
LANGUAGE
are not implemented in
PostgreSQL.

Note, however, that the SQL/MED functionality as a whole is not yet conforming.

<a name="see-also"></a>

# See Also

ALTER FOREIGN DATA WRAPPER (**ALTER\_FOREIGN\_DATA\_WRAPPER**(7)), DROP FOREIGN DATA WRAPPER (**DROP\_FOREIGN\_DATA\_WRAPPER**(7)), CREATE SERVER (**CREATE\_SERVER**(7)), CREATE USER MAPPING (**CREATE\_USER\_MAPPING**(7)), CREATE FOREIGN TABLE (**CREATE\_FOREIGN\_TABLE**(7))
