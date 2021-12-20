# alter collation(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_COLLATION - change the definition of a collation

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER COLLATION name REFRESH VERSION
    
    ALTER COLLATION name RENAME TO new_name
    ALTER COLLATION name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER COLLATION name SET SCHEMA new_schema

<a name="description"></a>

# Description


**ALTER COLLATION**
changes the definition of a collation.

You must own the collation to use
**ALTER COLLATION**. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the collations schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the collation. However, a superuser can alter ownership of any collation anyway.)

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing collation.

_new\_name_
The new name of the collation.

_new\_owner_
The new owner of the collation.

_new\_schema_
The new schema for the collation.

REFRESH VERSION
Update the collations version. See
NOTES
below.

<a name="notes"></a>

# Notes


When using collations provided by the ICU library, the ICU-specific version of the collator is recorded in the system catalog when the collation object is created. When the collation is used, the current version is checked against the recorded version, and a warning is issued when there is a mismatch, for example:

.if n \{.RS 4
.\}
    WARNING:  collation "xx-x-icu" has version mismatch
    DETAIL:  The collation in the database was created using version 1.2.3.4, but the operating system provides version 2.3.4.5.
    HINT:  Rebuild all objects affected by this collation and run ALTER COLLATION pg_catalog."xx-x-icu" REFRESH VERSION, or build PostgreSQL with the right library version.
.if n \{.RE
.\}

A change in collation definitions can lead to corrupt indexes and other problems because the database system relies on stored objects having a certain sort order. Generally, this should be avoided, but it can happen in legitimate circumstances, such as when using
**pg\_upgrade**
to upgrade to server binaries linked with a newer version of ICU. When this happens, all objects depending on the collation should be rebuilt, for example, using
**REINDEX**. When that is done, the collation version can be refreshed using the command
ALTER COLLATION ... REFRESH VERSION. This will update the system catalog to record the current collator version and will make the warning go away. Note that this does not actually check whether all affected objects have been rebuilt correctly.

The following query can be used to identify all collations in the current database that need to be refreshed and the objects that depend on them:

.if n \{.RS 4
.\}
    SELECT pg_describe_object(refclassid, refobjid, refobjsubid) AS "Collation",
           pg_describe_object(classid, objid, objsubid) AS "Object"
      FROM pg_depend d JOIN pg_collation c
           ON refclassid = pg_collation*(Aq::regclass AND refobjid = c.oid
      WHERE c.collversion <> pg_collation_actual_version(c.oid)
      ORDER BY 1, 2;
.if n \{.RE
.\}


<a name="examples"></a>

# Examples


To rename the collation
de_DE
to
german:

.if n \{.RS 4
.\}
    ALTER COLLATION "de_DE" RENAME TO german;
.if n \{.RE
.\}

To change the owner of the collation
en_US
to
joe:

.if n \{.RS 4
.\}
    ALTER COLLATION "en_US" OWNER TO joe;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER COLLATION**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE COLLATION (**CREATE\_COLLATION**(7)), DROP COLLATION (**DROP\_COLLATION**(7))
