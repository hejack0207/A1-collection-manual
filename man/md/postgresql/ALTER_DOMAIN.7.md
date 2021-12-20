# alter domain(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_DOMAIN - change the definition of a domain

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER DOMAIN name
        { SET DEFAULT expression | DROP DEFAULT }
    ALTER DOMAIN name
        { SET | DROP } NOT NULL
    ALTER DOMAIN name
        ADD domain_constraint [ NOT VALID ]
    ALTER DOMAIN name
        DROP CONSTRAINT [ IF EXISTS ] constraint_name [ RESTRICT | CASCADE ]
    ALTER DOMAIN name
         RENAME CONSTRAINT constraint_name TO new_constraint_name
    ALTER DOMAIN name
        VALIDATE CONSTRAINT constraint_name
    ALTER DOMAIN name
        OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER DOMAIN name
        RENAME TO new_name
    ALTER DOMAIN name
        SET SCHEMA new_schema

<a name="description"></a>

# Description


**ALTER DOMAIN**
changes the definition of an existing domain. There are several sub-forms:

SET/DROP DEFAULT
These forms set or remove the default value for a domain. Note that defaults only apply to subsequent
**INSERT**
commands; they do not affect rows already in a table using the domain.

SET/DROP NOT NULL
These forms change whether a domain is marked to allow NULL values or to reject NULL values. You can only
SET NOT NULL
when the columns using the domain contain no null values.

ADD _domain\_constraint_ [ NOT VALID ]
This form adds a new constraint to a domain using the same syntax as
CREATE DOMAIN (**CREATE\_DOMAIN**(7)). When a new constraint is added to a domain, all columns using that domain will be checked against the newly added constraint. These checks can be suppressed by adding the new constraint using the
NOT VALID
option; the constraint can later be made valid using
**ALTER DOMAIN ... VALIDATE CONSTRAINT**. Newly inserted or updated rows are always checked against all constraints, even those marked
NOT VALID.
NOT VALID
is only accepted for
CHECK
constraints.

DROP CONSTRAINT [ IF EXISTS ]
This form drops constraints on a domain. If
IF EXISTS
is specified and the constraint does not exist, no error is thrown. In this case a notice is issued instead.

RENAME CONSTRAINT
This form changes the name of a constraint on a domain.

VALIDATE CONSTRAINT
This form validates a constraint previously added as
NOT VALID, that is, it verifies that all values in table columns of the domain type satisfy the specified constraint.

OWNER
This form changes the owner of the domain to the specified user.

RENAME
This form changes the name of the domain.

SET SCHEMA
This form changes the schema of the domain. Any constraints associated with the domain are moved into the new schema as well.

You must own the domain to use
**ALTER DOMAIN**. To change the schema of a domain, you must also have
CREATE
privilege on the new schema. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the domains schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the domain. However, a superuser can alter ownership of any domain anyway.)

<a name="parameters"></a>

# Parameters



_name_
The name (possibly schema-qualified) of an existing domain to alter.

_domain\_constraint_
New domain constraint for the domain.

_constraint\_name_
Name of an existing constraint to drop or rename.

NOT VALID
Do not verify existing stored data for constraint validity.

CASCADE
Automatically drop objects that depend on the constraint, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the constraint if there are any dependent objects. This is the default behavior.

_new\_name_
The new name for the domain.

_new\_constraint\_name_
The new name for the constraint.

_new\_owner_
The user name of the new owner of the domain.

_new\_schema_
The new schema for the domain.

<a name="notes"></a>

# Notes


Although
**ALTER DOMAIN ADD CONSTRAINT**
attempts to verify that existing stored data satisfies the new constraint, this check is not bulletproof, because the command cannot
“see”
table rows that are newly inserted or updated and not yet committed. If there is a hazard that concurrent operations might insert bad data, the way to proceed is to add the constraint using the
NOT VALID
option, commit that command, wait until all transactions started before that commit have finished, and then issue
**ALTER DOMAIN VALIDATE CONSTRAINT**
to search for data violating the constraint. This method is reliable because once the constraint is committed, all new transactions are guaranteed to enforce it against new values of the domain type.

Currently,
**ALTER DOMAIN ADD CONSTRAINT**,
**ALTER DOMAIN VALIDATE CONSTRAINT**, and
**ALTER DOMAIN SET NOT NULL**
will fail if the named domain or any derived domain is used within a container-type column (a composite, array, or range column) in any table in the database. They should eventually be improved to be able to verify the new constraint for such nested values.

<a name="examples"></a>

# Examples


To add a
NOT NULL
constraint to a domain:

.if n \{.RS 4
.\}
    ALTER DOMAIN zipcode SET NOT NULL;
.if n \{.RE
.\}

To remove a
NOT NULL
constraint from a domain:

.if n \{.RS 4
.\}
    ALTER DOMAIN zipcode DROP NOT NULL;
.if n \{.RE
.\}

To add a check constraint to a domain:

.if n \{.RS 4
.\}
    ALTER DOMAIN zipcode ADD CONSTRAINT zipchk CHECK (char_length(VALUE) = 5);
.if n \{.RE
.\}

To remove a check constraint from a domain:

.if n \{.RS 4
.\}
    ALTER DOMAIN zipcode DROP CONSTRAINT zipchk;
.if n \{.RE
.\}

To rename a check constraint on a domain:

.if n \{.RS 4
.\}
    ALTER DOMAIN zipcode RENAME CONSTRAINT zipchk TO zip_check;
.if n \{.RE
.\}

To move the domain into a different schema:

.if n \{.RS 4
.\}
    ALTER DOMAIN zipcode SET SCHEMA customers;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**ALTER DOMAIN**
conforms to the
SQL
standard, except for the
OWNER,
RENAME,
SET SCHEMA, and
VALIDATE CONSTRAINT
variants, which are
PostgreSQL
extensions. The
NOT VALID
clause of the
ADD CONSTRAINT
variant is also a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE DOMAIN (**CREATE\_DOMAIN**(7)), DROP DOMAIN (**DROP\_DOMAIN**(7))
