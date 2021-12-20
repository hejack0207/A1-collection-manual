# create conversion(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_CONVERSION - define a new encoding conversion

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE [ DEFAULT ] CONVERSION name
        FOR source_encoding TO dest_encoding FROM function_name

<a name="description"></a>

# Description


**CREATE CONVERSION**
defines a new conversion between character set encodings. Also, conversions that are marked
DEFAULT
can be used for automatic encoding conversion between client and server. For this purpose, two conversions, from encoding A to B
_and_
from encoding B to A, must be defined.

To be able to create a conversion, you must have
EXECUTE
privilege on the function and
CREATE
privilege on the destination schema.

<a name="parameters"></a>

# Parameters


DEFAULT
The
DEFAULT
clause indicates that this conversion is the default for this particular source to destination encoding. There should be only one default encoding in a schema for the encoding pair.

_name_
The name of the conversion. The conversion name can be schema-qualified. If it is not, the conversion is defined in the current schema. The conversion name must be unique within a schema.

_source\_encoding_
The source encoding name.

_dest\_encoding_
The destination encoding name.

_function\_name_
The function used to perform the conversion. The function name can be schema-qualified. If it is not, the function will be looked up in the path.

The function must have the following signature:

.if n \{.RS 4
.\}
    conv_proc(
        integer,  -- source encoding ID
        integer,  -- destination encoding ID
        cstring,  -- source string (null terminated C string)
        internal, -- destination (fill with a null terminated C string)
        integer   -- source string length
    ) RETURNS void;
.if n \{.RE
.\}

<a name="notes"></a>

# Notes


Use
**DROP CONVERSION**
to remove user-defined conversions.

The privileges required to create a conversion might be changed in a future release.

<a name="examples"></a>

# Examples


To create a conversion from encoding
UTF8
to
LATIN1
using
**myfunc**:

.if n \{.RS 4
.\}
    CREATE CONVERSION myconv FOR UTF8*(Aq TO *(AqLATIN1*(Aq FROM myfunc;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CREATE CONVERSION**
is a
PostgreSQL
extension. There is no
**CREATE CONVERSION**
statement in the SQL standard, but a
**CREATE TRANSLATION**
statement that is very similar in purpose and syntax.

<a name="see-also"></a>

# See Also

ALTER CONVERSION (**ALTER\_CONVERSION**(7)), CREATE FUNCTION (**CREATE\_FUNCTION**(7)), DROP CONVERSION (**DROP\_CONVERSION**(7))
