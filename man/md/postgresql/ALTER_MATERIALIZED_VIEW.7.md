# alter materialized view(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_MATERIALIZED_VIEW - change the definition of a materialized view

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER MATERIALIZED VIEW [ IF EXISTS ] name
        action [, ... ]
    ALTER MATERIALIZED VIEW name
        DEPENDS ON EXTENSION extension_name
    ALTER MATERIALIZED VIEW [ IF EXISTS ] name
        RENAME [ COLUMN ] column_name TO new_column_name
    ALTER MATERIALIZED VIEW [ IF EXISTS ] name
        RENAME TO new_name
    ALTER MATERIALIZED VIEW [ IF EXISTS ] name
        SET SCHEMA new_schema
    ALTER MATERIALIZED VIEW ALL IN TABLESPACE name [ OWNED BY role_name [, ... ] ]
        SET TABLESPACE new_tablespace [ NOWAIT ]
    
    where action is one of:
    
        ALTER [ COLUMN ] column_name SET STATISTICS integer
        ALTER [ COLUMN ] column_name SET ( attribute_option = value [, ... ] )
        ALTER [ COLUMN ] column_name RESET ( attribute_option [, ... ] )
        ALTER [ COLUMN ] column_name SET STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN }
        CLUSTER ON index_name
        SET WITHOUT CLUSTER
        SET ( storage_parameter [= value] [, ... ] )
        RESET ( storage_parameter [, ... ] )
        OWNER TO { new_owner | CURRENT_USER | SESSION_USER }

<a name="description"></a>

# Description


**ALTER MATERIALIZED VIEW**
changes various auxiliary properties of an existing materialized view.

You must own the materialized view to use
**ALTER MATERIALIZED VIEW**. To change a materialized views schema, you must also have
CREATE
privilege on the new schema. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the materialized views schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the materialized view. However, a superuser can alter ownership of any view anyway.)

The
DEPENDS ON EXTENSION
form marks the materialized view as dependent on an extension, such that the materialized view will automatically be dropped if the extension is dropped.

The statement subforms and actions available for
**ALTER MATERIALIZED VIEW**
are a subset of those available for
**ALTER TABLE**, and have the same meaning when used for materialized views. See the descriptions for
ALTER TABLE (**ALTER\_TABLE**(7))
for details.

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing materialized view.

_column\_name_
Name of a new or existing column.

_extension\_name_
The name of the extension that the materialized view is to depend on.

_new\_column\_name_
New name for an existing column.

_new\_owner_
The user name of the new owner of the materialized view.

_new\_name_
The new name for the materialized view.

_new\_schema_
The new schema for the materialized view.

<a name="examples"></a>

# Examples


To rename the materialized view
foo
to
bar:

.if n \{.RS 4
.\}
    ALTER MATERIALIZED VIEW foo RENAME TO bar;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**ALTER MATERIALIZED VIEW**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE MATERIALIZED VIEW (**CREATE\_MATERIALIZED\_VIEW**(7)), DROP MATERIALIZED VIEW (**DROP\_MATERIALIZED\_VIEW**(7)), REFRESH MATERIALIZED VIEW (**REFRESH\_MATERIALIZED\_VIEW**(7))
