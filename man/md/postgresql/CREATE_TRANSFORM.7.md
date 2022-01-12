# create transform(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_TRANSFORM - define a new transform

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE [ OR REPLACE ] TRANSFORM FOR type_name LANGUAGE lang_name (
        FROM SQL WITH FUNCTION from_sql_function_name [ (argument_type [, ...]) ],
        TO SQL WITH FUNCTION to_sql_function_name [ (argument_type [, ...]) ]
    );

<a name="description"></a>

# Description


**CREATE TRANSFORM**
defines a new transform.
**CREATE OR REPLACE TRANSFORM**
will either create a new transform, or replace an existing definition.

A transform specifies how to adapt a data type to a procedural language. For example, when writing a function in PL/Python using the
hstore
type, PL/Python has no prior knowledge how to present
hstore
values in the Python environment. Language implementations usually default to using the text representation, but that is inconvenient when, for example, an associative array or a list would be more appropriate.

A transform specifies two functions:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A
  “from SQL”
  function that converts the type from the SQL environment to the language. This function will be invoked on the arguments of a function written in the language.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A
  “to SQL”
  function that converts the type from the language to the SQL environment. This function will be invoked on the return value of a function written in the language.

It is not necessary to provide both of these functions. If one is not specified, the language-specific default behavior will be used if necessary. (To prevent a transformation in a certain direction from happening at all, you could also write a transform function that always errors out.)

To be able to create a transform, you must own and have
USAGE
privilege on the type, have
USAGE
privilege on the language, and own and have
EXECUTE
privilege on the from-SQL and to-SQL functions, if specified.

<a name="parameters"></a>

# Parameters


_type\_name_
The name of the data type of the transform.

_lang\_name_
The name of the language of the transform.

_from\_sql\_function\_name_[(_argument\_type_ [, ...])]
The name of the function for converting the type from the SQL environment to the language. It must take one argument of type
internal
and return type
internal. The actual argument will be of the type for the transform, and the function should be coded as if it were. (But it is not allowed to declare an SQL-level function returning
internal
without at least one argument of type
internal.) The actual return value will be something specific to the language implementation. If no argument list is specified, the function name must be unique in its schema.

_to\_sql\_function\_name_[(_argument\_type_ [, ...])]
The name of the function for converting the type from the language to the SQL environment. It must take one argument of type
internal
and return the type that is the type for the transform. The actual argument value will be something specific to the language implementation. If no argument list is specified, the function name must be unique in its schema.

<a name="notes"></a>

# Notes


Use
DROP TRANSFORM (**DROP\_TRANSFORM**(7))
to remove transforms.

<a name="examples"></a>

# Examples


To create a transform for type
hstore
and language
plpythonu, first set up the type and the language:

.if n \{.RS 4
.\}
    CREATE TYPE hstore ...;
    
    CREATE EXTENSION plpythonu;
.if n \{.RE
.\}

Then create the necessary functions:

.if n \{.RS 4
.\}
    CREATE FUNCTION hstore_to_plpython(val internal) RETURNS internal
    LANGUAGE C STRICT IMMUTABLE
    AS ...;
    
    CREATE FUNCTION plpython_to_hstore(val internal) RETURNS hstore
    LANGUAGE C STRICT IMMUTABLE
    AS ...;
.if n \{.RE
.\}

And finally create the transform to connect them all together:

.if n \{.RS 4
.\}
    CREATE TRANSFORM FOR hstore LANGUAGE plpythonu (
        FROM SQL WITH FUNCTION hstore_to_plpython(internal),
        TO SQL WITH FUNCTION plpython_to_hstore(internal)
    );
.if n \{.RE
.\}

In practice, these commands would be wrapped up in an extension.

The
contrib
section contains a number of extensions that provide transforms, which can serve as real-world examples.

<a name="compatibility"></a>

# Compatibility


This form of
**CREATE TRANSFORM**
is a
PostgreSQL
extension. There is a
**CREATE TRANSFORM**
command in the
SQL
standard, but it is for adapting data types to client languages. That usage is not supported by
PostgreSQL.

<a name="see-also"></a>

# See Also


CREATE FUNCTION (**CREATE\_FUNCTION**(7)),
CREATE LANGUAGE (**CREATE\_LANGUAGE**(7)),
CREATE TYPE (**CREATE\_TYPE**(7)),
DROP TRANSFORM (**DROP\_TRANSFORM**(7))
