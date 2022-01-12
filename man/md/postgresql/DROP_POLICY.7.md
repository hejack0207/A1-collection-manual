# drop policy(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_POLICY - remove a row level security policy from a table

<a name="synopsis"></a>

# Synopsis

```


```
    DROP POLICY [ IF EXISTS ] name ON table_name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP POLICY**
removes the specified policy from the table. Note that if the last policy is removed for a table and the table still has row level security enabled via
**ALTER TABLE**, then the default-deny policy will be used.
ALTER TABLE ... DISABLE ROW LEVEL SECURITY
can be used to disable row level security for a table, whether policies for the table exist or not.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the policy does not exist. A notice is issued in this case.

_name_
The name of the policy to drop.

_table\_name_
The name (optionally schema-qualified) of the table that the policy is on.

CASCADE  
RESTRICT
These key words do not have any effect, since there are no dependencies on policies.

<a name="examples"></a>

# Examples


To drop the policy called
p1
on the table named
my_table:

.if n \{.RS 4
.\}
    DROP POLICY p1 ON my_table;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**DROP POLICY**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

CREATE POLICY (**CREATE\_POLICY**(7)), ALTER POLICY (**ALTER\_POLICY**(7))
