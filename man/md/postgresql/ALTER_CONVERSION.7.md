# alter conversion(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_CONVERSION - change the definition of a conversion

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER CONVERSION name RENAME TO new_name
    ALTER CONVERSION name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER CONVERSION name SET SCHEMA new_schema

<a name="description"></a>

# Description


**ALTER CONVERSION**
changes the definition of a conversion.

You must own the conversion to use
**ALTER CONVERSION**. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the conversions schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the conversion. However, a superuser can alter ownership of any conversion anyway.)

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing conversion.

_new\_name_
The new name of the conversion.

_new\_owner_
The new owner of the conversion.

_new\_schema_
The new schema for the conversion.

<a name="examples"></a>

# Examples


To rename the conversion
iso_8859_1_to_utf8
to
latin1_to_unicode:

.if n \{.RS 4
.\}
    ALTER CONVERSION iso_8859_1_to_utf8 RENAME TO latin1_to_unicode;
.if n \{.RE
.\}

To change the owner of the conversion
iso_8859_1_to_utf8
to
joe:

.if n \{.RS 4
.\}
    ALTER CONVERSION iso_8859_1_to_utf8 OWNER TO joe;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER CONVERSION**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE CONVERSION (**CREATE\_CONVERSION**(7)), DROP CONVERSION (**DROP\_CONVERSION**(7))
