# alter type(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_TYPE - change the definition of a type

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER TYPE name action [, ... ]
    ALTER TYPE name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER TYPE name RENAME ATTRIBUTE attribute_name TO new_attribute_name [ CASCADE | RESTRICT ]
    ALTER TYPE name RENAME TO new_name
    ALTER TYPE name SET SCHEMA new_schema
    ALTER TYPE name ADD VALUE [ IF NOT EXISTS ] new_enum_value [ { BEFORE | AFTER } neighbor_enum_value ]
    ALTER TYPE name RENAME VALUE existing_enum_value TO new_enum_value
    
    where action is one of:
    
        ADD ATTRIBUTE attribute_name data_type [ COLLATE collation ] [ CASCADE | RESTRICT ]
        DROP ATTRIBUTE [ IF EXISTS ] attribute_name [ CASCADE | RESTRICT ]
        ALTER ATTRIBUTE attribute_name [ SET DATA ] TYPE data_type [ COLLATE collation ] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**ALTER TYPE**
changes the definition of an existing type. There are several subforms:

ADD ATTRIBUTE
This form adds a new attribute to a composite type, using the same syntax as
CREATE TYPE (**CREATE\_TYPE**(7)).

DROP ATTRIBUTE [ IF EXISTS ]
This form drops an attribute from a composite type. If
IF EXISTS
is specified and the attribute does not exist, no error is thrown. In this case a notice is issued instead.

SET DATA TYPE
This form changes the type of an attribute of a composite type.

OWNER
This form changes the owner of the type.

RENAME
This form changes the name of the type or the name of an individual attribute of a composite type.

SET SCHEMA
This form moves the type into another schema.

ADD VALUE [ IF NOT EXISTS ] [ BEFORE | AFTER ]
This form adds a new value to an enum type. The new values place in the enum\*(Aqs ordering can be specified as being
BEFORE
or
AFTER
one of the existing values. Otherwise, the new item is added at the end of the list of values.

If
IF NOT EXISTS
is specified, it is not an error if the type already contains the new value: a notice is issued but no other action is taken. Otherwise, an error will occur if the new value is already present.

RENAME VALUE
This form renames a value of an enum type. The values place in the enum\*(Aqs ordering is not affected. An error will occur if the specified value is not present or the new name is already present.

The
ADD ATTRIBUTE,
DROP ATTRIBUTE, and
ALTER ATTRIBUTE
actions can be combined into a list of multiple alterations to apply in parallel. For example, it is possible to add several attributes and/or alter the type of several attributes in a single command.

You must own the type to use
**ALTER TYPE**. To change the schema of a type, you must also have
CREATE
privilege on the new schema. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the types schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the type. However, a superuser can alter ownership of any type anyway.) To add an attribute or alter an attribute type, you must also have
USAGE
privilege on the data type.

<a name="parameters"></a>

# Parameters



_name_
The name (possibly schema-qualified) of an existing type to alter.

_new\_name_
The new name for the type.

_new\_owner_
The user name of the new owner of the type.

_new\_schema_
The new schema for the type.

_attribute\_name_
The name of the attribute to add, alter, or drop.

_new\_attribute\_name_
The new name of the attribute to be renamed.

_data\_type_
The data type of the attribute to add, or the new type of the attribute to alter.

_new\_enum\_value_
The new value to be added to an enum types list of values, or the new name to be given to an existing value. Like all enum literals, it needs to be quoted.

_neighbor\_enum\_value_
The existing enum value that the new value should be added immediately before or after in the enum types sort ordering. Like all enum literals, it needs to be quoted.

_existing\_enum\_value_
The existing enum value that should be renamed. Like all enum literals, it needs to be quoted.

CASCADE
Automatically propagate the operation to typed tables of the type being altered, and their descendants.

RESTRICT
Refuse the operation if the type being altered is the type of a typed table. This is the default.

<a name="notes"></a>

# Notes


If
**ALTER TYPE ... ADD VALUE**
(the form that adds a new value to an enum type) is executed inside a transaction block, the new value cannot be used until after the transaction has been committed.

Comparisons involving an added enum value will sometimes be slower than comparisons involving only original members of the enum type. This will usually only occur if
BEFORE
or
AFTER
is used to set the new values sort position somewhere other than at the end of the list. However, sometimes it will happen even though the new value is added at the end (this occurs if the OID counter
“wrapped around”
since the original creation of the enum type). The slowdown is usually insignificant; but if it matters, optimal performance can be regained by dropping and recreating the enum type, or by dumping and reloading the database.

<a name="examples"></a>

# Examples


To rename a data type:

.if n \{.RS 4
.\}
    ALTER TYPE electronic_mail RENAME TO email;
.if n \{.RE
.\}

To change the owner of the type
email
to
joe:

.if n \{.RS 4
.\}
    ALTER TYPE email OWNER TO joe;
.if n \{.RE
.\}

To change the schema of the type
email
to
customers:

.if n \{.RS 4
.\}
    ALTER TYPE email SET SCHEMA customers;
.if n \{.RE
.\}

To add a new attribute to a type:

.if n \{.RS 4
.\}
    ALTER TYPE compfoo ADD ATTRIBUTE f3 int;
.if n \{.RE
.\}

To add a new value to an enum type in a particular sort position:

.if n \{.RS 4
.\}
    ALTER TYPE colors ADD VALUE orange*(Aq AFTER *(Aqred*(Aq;
.if n \{.RE
.\}

To rename an enum value:

.if n \{.RS 4
.\}
    ALTER TYPE colors RENAME VALUE purple*(Aq TO *(Aqmauve*(Aq;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The variants to add and drop attributes are part of the SQL standard; the other variants are PostgreSQL extensions.

<a name="see-also"></a>

# See Also

CREATE TYPE (**CREATE\_TYPE**(7)), DROP TYPE (**DROP\_TYPE**(7))
