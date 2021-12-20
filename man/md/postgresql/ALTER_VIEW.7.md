# alter view(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_VIEW - change the definition of a view

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER VIEW [ IF EXISTS ] name ALTER [ COLUMN ] column_name SET DEFAULT expression
    ALTER VIEW [ IF EXISTS ] name ALTER [ COLUMN ] column_name DROP DEFAULT
    ALTER VIEW [ IF EXISTS ] name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER VIEW [ IF EXISTS ] name RENAME TO new_name
    ALTER VIEW [ IF EXISTS ] name SET SCHEMA new_schema
    ALTER VIEW [ IF EXISTS ] name SET ( view_option_name [= view_option_value] [, ... ] )
    ALTER VIEW [ IF EXISTS ] name RESET ( view_option_name [, ... ] )

<a name="description"></a>

# Description


**ALTER VIEW**
changes various auxiliary properties of a view. (If you want to modify the views defining query, use
**CREATE OR REPLACE VIEW**.)

You must own the view to use
**ALTER VIEW**. To change a views schema, you must also have
CREATE
privilege on the new schema. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the views schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the view. However, a superuser can alter ownership of any view anyway.)

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing view.

IF EXISTS
Do not throw an error if the view does not exist. A notice is issued in this case.

SET/DROP DEFAULT
These forms set or remove the default value for a column. A view columns default value is substituted into any
**INSERT**
or
**UPDATE**
command whose target is the view, before applying any rules or triggers for the view. The views default will therefore take precedence over any default values from underlying relations.

_new\_owner_
The user name of the new owner of the view.

_new\_name_
The new name for the view.

_new\_schema_
The new schema for the view.

SET ( _view\_option\_name_ [= _view\_option\_value_] [, ... ] )  
RESET ( _view\_option\_name_ [, ... ] )
Sets or resets a view option. Currently supported options are:

check_option (string)
Changes the check option of the view. The value must be
local
or
cascaded.

security_barrier (boolean)
Changes the security-barrier property of the view. The value must be Boolean value, such as
true
or
false.


<a name="notes"></a>

# Notes


For historical reasons,
**ALTER TABLE**
can be used with views too; but the only variants of
**ALTER TABLE**
that are allowed with views are equivalent to the ones shown above.

<a name="examples"></a>

# Examples


To rename the view
foo
to
bar:

.if n \{.RS 4
.\}
    ALTER VIEW foo RENAME TO bar;
.if n \{.RE
.\}

To attach a default column value to an updatable view:

.if n \{.RS 4
.\}
    CREATE TABLE base_table (id int, ts timestamptz);
    CREATE VIEW a_view AS SELECT * FROM base_table;
    ALTER VIEW a_view ALTER COLUMN ts SET DEFAULT now();
    INSERT INTO base_table(id) VALUES(1);  -- ts will receive a NULL
    INSERT INTO a_view(id) VALUES(2);  -- ts will receive the current time
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**ALTER VIEW**
is a
PostgreSQL
extension of the SQL standard.

<a name="see-also"></a>

# See Also

CREATE VIEW (**CREATE\_VIEW**(7)), DROP VIEW (**DROP\_VIEW**(7))
