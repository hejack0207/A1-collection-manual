# alter policy(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_POLICY - change the definition of a row level security policy

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER POLICY name ON table_name RENAME TO new_name
    
    ALTER POLICY name ON table_name
        [ TO { role_name | PUBLIC | CURRENT_USER | SESSION_USER } [, ...] ]
        [ USING ( using_expression ) ]
        [ WITH CHECK ( check_expression ) ]

<a name="description"></a>

# Description


**ALTER POLICY**
changes the definition of an existing row-level security policy. Note that
**ALTER POLICY**
only allows the set of roles to which the policy applies and the
USING
and
WITH CHECK
expressions to be modified. To change other properties of a policy, such as the command to which it applies or whether it is permissive or restrictive, the policy must be dropped and recreated.

To use
**ALTER POLICY**, you must own the table that the policy applies to.

In the second form of
**ALTER POLICY**, the role list,
_using\_expression_, and
_check\_expression_
are replaced independently if specified. When one of those clauses is omitted, the corresponding part of the policy is unchanged.

<a name="parameters"></a>

# Parameters


_name_
The name of an existing policy to alter.

_table\_name_
The name (optionally schema-qualified) of the table that the policy is on.

_new\_name_
The new name for the policy.

_role\_name_
The role(s) to which the policy applies. Multiple roles can be specified at one time. To apply the policy to all roles, use
PUBLIC.

_using\_expression_
The
USING
expression for the policy. See
CREATE POLICY (**CREATE\_POLICY**(7))
for details.

_check\_expression_
The
WITH CHECK
expression for the policy. See
CREATE POLICY (**CREATE\_POLICY**(7))
for details.

<a name="compatibility"></a>

# Compatibility


**ALTER POLICY**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE POLICY (**CREATE\_POLICY**(7)), DROP POLICY (**DROP\_POLICY**(7))
