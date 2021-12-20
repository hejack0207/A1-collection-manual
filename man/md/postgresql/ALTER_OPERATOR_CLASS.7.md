# alter operator class(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_OPERATOR_CLASS - change the definition of an operator class

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER OPERATOR CLASS name USING index_method
        RENAME TO new_name
    
    ALTER OPERATOR CLASS name USING index_method
        OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    
    ALTER OPERATOR CLASS name USING index_method
        SET SCHEMA new_schema

<a name="description"></a>

# Description


**ALTER OPERATOR CLASS**
changes the definition of an operator class.

You must own the operator class to use
**ALTER OPERATOR CLASS**. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the operator classs schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the operator class. However, a superuser can alter ownership of any operator class anyway.)

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing operator class.

_index\_method_
The name of the index method this operator class is for.

_new\_name_
The new name of the operator class.

_new\_owner_
The new owner of the operator class.

_new\_schema_
The new schema for the operator class.

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER OPERATOR CLASS**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE OPERATOR CLASS (**CREATE\_OPERATOR\_CLASS**(7)), DROP OPERATOR CLASS (**DROP\_OPERATOR\_CLASS**(7)), ALTER OPERATOR FAMILY (**ALTER\_OPERATOR\_FAMILY**(7))
