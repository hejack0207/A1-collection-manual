# drop view(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_VIEW - remove a view

<a name="synopsis"></a>

# Synopsis

```


```
    DROP VIEW [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP VIEW**
drops an existing view. To execute this command you must be the owner of the view.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the view does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of the view to remove.

CASCADE
Automatically drop objects that depend on the view (such as other views), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the view if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


This command will remove the view called
kinds:

.if n \{.RS 4
.\}
    DROP VIEW kinds;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


This command conforms to the SQL standard, except that the standard only allows one view to be dropped per command, and apart from the
IF EXISTS
option, which is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

ALTER VIEW (**ALTER\_VIEW**(7)), CREATE VIEW (**CREATE\_VIEW**(7))
