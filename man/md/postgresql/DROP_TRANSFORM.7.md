# drop transform(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_TRANSFORM - remove a transform

<a name="synopsis"></a>

# Synopsis

```


```
    DROP TRANSFORM [ IF EXISTS ] FOR type_name LANGUAGE lang_name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP TRANSFORM**
removes a previously defined transform.

To be able to drop a transform, you must own the type and the language. These are the same privileges that are required to create a transform.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the transform does not exist. A notice is issued in this case.

_type\_name_
The name of the data type of the transform.

_lang\_name_
The name of the language of the transform.

CASCADE
Automatically drop objects that depend on the transform, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the transform if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


To drop the transform for type
hstore
and language
plpythonu:

.if n \{.RS 4
.\}
    DROP TRANSFORM FOR hstore LANGUAGE plpythonu;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


This form of
**DROP TRANSFORM**
is a
PostgreSQL
extension. See
CREATE TRANSFORM (**CREATE\_TRANSFORM**(7))
for details.

<a name="see-also"></a>

# See Also

CREATE TRANSFORM (**CREATE\_TRANSFORM**(7))
