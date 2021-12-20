# alter trigger(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_TRIGGER - change the definition of a trigger

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER TRIGGER name ON table_name RENAME TO new_name
    ALTER TRIGGER name ON table_name DEPENDS ON EXTENSION extension_name

<a name="description"></a>

# Description


**ALTER TRIGGER**
changes properties of an existing trigger. The
RENAME
clause changes the name of the given trigger without otherwise changing the trigger definition. The
DEPENDS ON EXTENSION
clause marks the trigger as dependent on an extension, such that if the extension is dropped, the trigger will automatically be dropped as well.

You must own the table on which the trigger acts to be allowed to change its properties.

<a name="parameters"></a>

# Parameters


_name_
The name of an existing trigger to alter.

_table\_name_
The name of the table on which this trigger acts.

_new\_name_
The new name for the trigger.

_extension\_name_
The name of the extension that the trigger is to depend on.

<a name="notes"></a>

# Notes


The ability to temporarily enable or disable a trigger is provided by
ALTER TABLE (**ALTER\_TABLE**(7)), not by
**ALTER TRIGGER**, because
**ALTER TRIGGER**
has no convenient way to express the option of enabling or disabling all of a tables triggers at once.

<a name="examples"></a>

# Examples


To rename an existing trigger:

.if n \{.RS 4
.\}
    ALTER TRIGGER emp_stamp ON emp RENAME TO emp_track_chgs;
.if n \{.RE
.\}

To mark a trigger as being dependent on an extension:

.if n \{.RS 4
.\}
    ALTER TRIGGER emp_stamp ON emp DEPENDS ON EXTENSION emplib;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**ALTER TRIGGER**
is a
PostgreSQL
extension of the SQL standard.

<a name="see-also"></a>

# See Also

ALTER TABLE (**ALTER\_TABLE**(7))
