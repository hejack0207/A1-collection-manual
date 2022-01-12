# alter foreign data wrapper(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_FOREIGN_DATA_WRAPPER - change the definition of a foreign-data wrapper

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER FOREIGN DATA WRAPPER name
        [ HANDLER handler_function | NO HANDLER ]
        [ VALIDATOR validator_function | NO VALIDATOR ]
        [ OPTIONS ( [ ADD | SET | DROP ] option [value*(Aq] [, ... ]) ]
    ALTER FOREIGN DATA WRAPPER name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER FOREIGN DATA WRAPPER name RENAME TO new_name

<a name="description"></a>

# Description


**ALTER FOREIGN DATA WRAPPER**
changes the definition of a foreign-data wrapper. The first form of the command changes the support functions or the generic options of the foreign-data wrapper (at least one clause is required). The second form changes the owner of the foreign-data wrapper.

Only superusers can alter foreign-data wrappers. Additionally, only superusers can own foreign-data wrappers.

<a name="parameters"></a>

# Parameters


_name_
The name of an existing foreign-data wrapper.

HANDLER _handler\_function_
Specifies a new handler function for the foreign-data wrapper.

NO HANDLER
This is used to specify that the foreign-data wrapper should no longer have a handler function.

Note that foreign tables that use a foreign-data wrapper with no handler cannot be accessed.

VALIDATOR _validator\_function_
Specifies a new validator function for the foreign-data wrapper.

Note that it is possible that pre-existing options of the foreign-data wrapper, or of dependent servers, user mappings, or foreign tables, are invalid according to the new validator.
PostgreSQL
does not check for this. It is up to the user to make sure that these options are correct before using the modified foreign-data wrapper. However, any options specified in this
**ALTER FOREIGN DATA WRAPPER**
command will be checked using the new validator.

NO VALIDATOR
This is used to specify that the foreign-data wrapper should no longer have a validator function.

OPTIONS ( [ ADD | SET | DROP ] _option_ [_value_\*(Aq] [, ... ] )
Change options for the foreign-data wrapper.
ADD,
SET, and
DROP
specify the action to be performed.
ADD
is assumed if no operation is explicitly specified. Option names must be unique; names and values are also validated using the foreign data wrappers validator function, if any.

_new\_owner_
The user name of the new owner of the foreign-data wrapper.

_new\_name_
The new name for the foreign-data wrapper.

<a name="examples"></a>

# Examples


Change a foreign-data wrapper
dbi, add option
foo, drop
bar:

.if n \{.RS 4
.\}
    ALTER FOREIGN DATA WRAPPER dbi OPTIONS (ADD foo 1*(Aq, DROP *(Aqbar*(Aq);
.if n \{.RE
.\}

Change the foreign-data wrapper
dbi
validator to
bob.myvalidator:

.if n \{.RS 4
.\}
    ALTER FOREIGN DATA WRAPPER dbi VALIDATOR bob.myvalidator;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**ALTER FOREIGN DATA WRAPPER**
conforms to ISO/IEC 9075-9 (SQL/MED), except that the
HANDLER,
VALIDATOR,
OWNER TO, and
RENAME
clauses are extensions.

<a name="see-also"></a>

# See Also

CREATE FOREIGN DATA WRAPPER (**CREATE\_FOREIGN\_DATA\_WRAPPER**(7)), DROP FOREIGN DATA WRAPPER (**DROP\_FOREIGN\_DATA\_WRAPPER**(7))
