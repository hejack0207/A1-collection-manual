# alter table(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_TABLE - change the definition of a table

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
        action [, ... ]
    ALTER TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
        RENAME [ COLUMN ] column_name TO new_column_name
    ALTER TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
        RENAME CONSTRAINT constraint_name TO new_constraint_name
    ALTER TABLE [ IF EXISTS ] name
        RENAME TO new_name
    ALTER TABLE [ IF EXISTS ] name
        SET SCHEMA new_schema
    ALTER TABLE ALL IN TABLESPACE name [ OWNED BY role_name [, ... ] ]
        SET TABLESPACE new_tablespace [ NOWAIT ]
    ALTER TABLE [ IF EXISTS ] name
        ATTACH PARTITION partition_name { FOR VALUES partition_bound_spec | DEFAULT }
    ALTER TABLE [ IF EXISTS ] name
        DETACH PARTITION partition_name
    
    where action is one of:
    
        ADD [ COLUMN ] [ IF NOT EXISTS ] column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
        DROP [ COLUMN ] [ IF EXISTS ] column_name [ RESTRICT | CASCADE ]
        ALTER [ COLUMN ] column_name [ SET DATA ] TYPE data_type [ COLLATE collation ] [ USING expression ]
        ALTER [ COLUMN ] column_name SET DEFAULT expression
        ALTER [ COLUMN ] column_name DROP DEFAULT
        ALTER [ COLUMN ] column_name { SET | DROP } NOT NULL
        ALTER [ COLUMN ] column_name ADD GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ]
        ALTER [ COLUMN ] column_name { SET GENERATED { ALWAYS | BY DEFAULT } | SET sequence_option | RESTART [ [ WITH ] restart ] } [...]
        ALTER [ COLUMN ] column_name DROP IDENTITY [ IF EXISTS ]
        ALTER [ COLUMN ] column_name SET STATISTICS integer
        ALTER [ COLUMN ] column_name SET ( attribute_option = value [, ... ] )
        ALTER [ COLUMN ] column_name RESET ( attribute_option [, ... ] )
        ALTER [ COLUMN ] column_name SET STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN }
        ADD table_constraint [ NOT VALID ]
        ADD table_constraint_using_index
        ALTER CONSTRAINT constraint_name [ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]
        VALIDATE CONSTRAINT constraint_name
        DROP CONSTRAINT [ IF EXISTS ]  constraint_name [ RESTRICT | CASCADE ]
        DISABLE TRIGGER [ trigger_name | ALL | USER ]
        ENABLE TRIGGER [ trigger_name | ALL | USER ]
        ENABLE REPLICA TRIGGER trigger_name
        ENABLE ALWAYS TRIGGER trigger_name
        DISABLE RULE rewrite_rule_name
        ENABLE RULE rewrite_rule_name
        ENABLE REPLICA RULE rewrite_rule_name
        ENABLE ALWAYS RULE rewrite_rule_name
        DISABLE ROW LEVEL SECURITY
        ENABLE ROW LEVEL SECURITY
        FORCE ROW LEVEL SECURITY
        NO FORCE ROW LEVEL SECURITY
        CLUSTER ON index_name
        SET WITHOUT CLUSTER
        SET WITHOUT OIDS
        SET TABLESPACE new_tablespace
        SET { LOGGED | UNLOGGED }
        SET ( storage_parameter [= value] [, ... ] )
        RESET ( storage_parameter [, ... ] )
        INHERIT parent_table
        NO INHERIT parent_table
        OF type_name
        NOT OF
        OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
        REPLICA IDENTITY { DEFAULT | USING INDEX index_name | FULL | NOTHING }
    
    and partition_bound_spec is:
    
    IN ( partition_bound_expr [, ...] ) |
    FROM ( { partition_bound_expr | MINVALUE | MAXVALUE } [, ...] )
      TO ( { partition_bound_expr | MINVALUE | MAXVALUE } [, ...] ) |
    WITH ( MODULUS numeric_literal, REMAINDER numeric_literal )
    
    and column_constraint is:
    
    [ CONSTRAINT constraint_name ]
    { NOT NULL |
      NULL |
      CHECK ( expression ) [ NO INHERIT ] |
      DEFAULT default_expr |
      GENERATED ALWAYS AS ( generation_expr ) STORED |
      GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ] |
      UNIQUE index_parameters |
      PRIMARY KEY index_parameters |
      REFERENCES reftable [ ( refcolumn ) ] [ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ]
        [ ON DELETE referential_action ] [ ON UPDATE referential_action ] }
    [ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]
    
    and table_constraint is:
    
    [ CONSTRAINT constraint_name ]
    { CHECK ( expression ) [ NO INHERIT ] |
      UNIQUE ( column_name [, ... ] ) index_parameters |
      PRIMARY KEY ( column_name [, ... ] ) index_parameters |
      EXCLUDE [ USING index_method ] ( exclude_element WITH operator [, ... ] ) index_parameters [ WHERE ( predicate ) ] |
      FOREIGN KEY ( column_name [, ... ] ) REFERENCES reftable [ ( refcolumn [, ... ] ) ]
        [ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ] [ ON DELETE referential_action ] [ ON UPDATE referential_action ] }
    [ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]
    
    and table_constraint_using_index is:
    
        [ CONSTRAINT constraint_name ]
        { UNIQUE | PRIMARY KEY } USING INDEX index_name
        [ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]
    
    index_parameters in UNIQUE, PRIMARY KEY, and EXCLUDE constraints are:
    
    [ INCLUDE ( column_name [, ... ] ) ]
    [ WITH ( storage_parameter [= value] [, ... ] ) ]
    [ USING INDEX TABLESPACE tablespace_name ]
    
    exclude_element in an EXCLUDE constraint is:
    
    { column_name | ( expression ) } [ opclass ] [ ASC | DESC ] [ NULLS { FIRST | LAST } ]

<a name="description"></a>

# Description


**ALTER TABLE**
changes the definition of an existing table. There are several subforms described below. Note that the lock level required may differ for each subform. An
ACCESS EXCLUSIVE
lock is acquired unless explicitly noted. When multiple subcommands are given, the lock acquired will be the strictest one required by any subcommand.

ADD COLUMN [ IF NOT EXISTS ]
This form adds a new column to the table, using the same syntax as
CREATE TABLE (**CREATE\_TABLE**(7)). If
IF NOT EXISTS
is specified and a column already exists with this name, no error is thrown.

DROP COLUMN [ IF EXISTS ]
This form drops a column from a table. Indexes and table constraints involving the column will be automatically dropped as well. Multivariate statistics referencing the dropped column will also be removed if the removal of the column would cause the statistics to contain data for only a single column. You will need to say
CASCADE
if anything outside the table depends on the column, for example, foreign key references or views. If
IF EXISTS
is specified and the column does not exist, no error is thrown. In this case a notice is issued instead.

SET DATA TYPE
This form changes the type of a column of a table. Indexes and simple table constraints involving the column will be automatically converted to use the new column type by reparsing the originally supplied expression. The optional
COLLATE
clause specifies a collation for the new column; if omitted, the collation is the default for the new column type. The optional
USING
clause specifies how to compute the new column value from the old; if omitted, the default conversion is the same as an assignment cast from old data type to new. A
USING
clause must be provided if there is no implicit or assignment cast from old to new type.

SET/DROP DEFAULT
These forms set or remove the default value for a column. Default values only apply in subsequent
**INSERT**
or
**UPDATE**
commands; they do not cause rows already in the table to change.

SET/DROP NOT NULL
These forms change whether a column is marked to allow null values or to reject null values.

SET NOT NULL
may only be applied to a column provided none of the records in the table contain a
NULL
value for the column. Ordinarily this is checked during the
ALTER TABLE
by scanning the entire table; however, if a valid
CHECK
constraint is found which proves no
NULL
can exist, then the table scan is skipped.

If this table is a partition, one cannot perform
DROP NOT NULL
on a column if it is marked
NOT NULL
in the parent table. To drop the
NOT NULL
constraint from all the partitions, perform
DROP NOT NULL
on the parent table. Even if there is no
NOT NULL
constraint on the parent, such a constraint can still be added to individual partitions, if desired; that is, the children can disallow nulls even if the parent allows them, but not the other way around.

ADD GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY  
SET GENERATED { ALWAYS | BY DEFAULT }  
DROP IDENTITY [ IF EXISTS ]
These forms change whether a column is an identity column or change the generation attribute of an existing identity column. See
CREATE TABLE (**CREATE\_TABLE**(7))
for details.

If
DROP IDENTITY IF EXISTS
is specified and the column is not an identity column, no error is thrown. In this case a notice is issued instead.

SET _sequence\_option_  
RESTART
These forms alter the sequence that underlies an existing identity column.
_sequence\_option_
is an option supported by
ALTER SEQUENCE (**ALTER\_SEQUENCE**(7))
such as
INCREMENT BY.

SET STATISTICS
This form sets the per-column statistics-gathering target for subsequent
**ANALYZE**(7)
operations. The target can be set in the range 0 to 10000; alternatively, set it to -1 to revert to using the system default statistics target (default_statistics_target). For more information on the use of statistics by the
PostgreSQL
query planner, refer to
Section&nbsp;14.2.

SET STATISTICS
acquires a
SHARE UPDATE EXCLUSIVE
lock.

SET ( _attribute\_option_ = _value_ [, ... ] )  
RESET ( _attribute\_option_ [, ... ] )
This form sets or resets per-attribute options. Currently, the only defined per-attribute options are
n_distinct
and
n_distinct_inherited, which override the number-of-distinct-values estimates made by subsequent
**ANALYZE**(7)
operations.
n_distinct
affects the statistics for the table itself, while
n_distinct_inherited
affects the statistics gathered for the table plus its inheritance children. When set to a positive value,
**ANALYZE**
will assume that the column contains exactly the specified number of distinct nonnull values. When set to a negative value, which must be greater than or equal to -1,
**ANALYZE**
will assume that the number of distinct nonnull values in the column is linear in the size of the table; the exact count is to be computed by multiplying the estimated table size by the absolute value of the given number. For example, a value of -1 implies that all values in the column are distinct, while a value of -0.5 implies that each value appears twice on the average. This can be useful when the size of the table changes over time, since the multiplication by the number of rows in the table is not performed until query planning time. Specify a value of 0 to revert to estimating the number of distinct values normally. For more information on the use of statistics by the
PostgreSQL
query planner, refer to
Section&nbsp;14.2.

Changing per-attribute options acquires a
SHARE UPDATE EXCLUSIVE
lock.

SET STORAGE
This form sets the storage mode for a column. This controls whether this column is held inline or in a secondary
TOAST
table, and whether the data should be compressed or not.
PLAIN
must be used for fixed-length values such as
integer
and is inline, uncompressed.
MAIN
is for inline, compressible data.
EXTERNAL
is for external, uncompressed data, and
EXTENDED
is for external, compressed data.
EXTENDED
is the default for most data types that support non-PLAIN
storage. Use of
EXTERNAL
will make substring operations on very large
text
and
bytea
values run faster, at the penalty of increased storage space. Note that
SET STORAGE
doesnt itself change anything in the table, it just sets the strategy to be pursued during future table updates. See
Section&nbsp;68.2
for more information.

ADD _table\_constraint_ [ NOT VALID ]
This form adds a new constraint to a table using the same constraint syntax as
CREATE TABLE (**CREATE\_TABLE**(7)), plus the option
NOT VALID, which is currently only allowed for foreign key and CHECK constraints.

Normally, this form will cause a scan of the table to verify that all existing rows in the table satisfy the new constraint. But if the
NOT VALID
option is used, this potentially-lengthy scan is skipped. The constraint will still be enforced against subsequent inserts or updates (that is, theyll fail unless there is a matching row in the referenced table, in the case of foreign keys, or they\*(Aqll fail unless the new row matches the specified check condition). But the database will not assume that the constraint holds for all rows in the table, until it is validated by using the
VALIDATE CONSTRAINT
option. See
NOTES
below for more information about using the
NOT VALID
option.

Although most forms of
ADD _table\_constraint_
require an
ACCESS EXCLUSIVE
lock,
ADD FOREIGN KEY
requires only a
SHARE ROW EXCLUSIVE
lock. Note that
ADD FOREIGN KEY
also acquires a
SHARE ROW EXCLUSIVE
lock on the referenced table, in addition to the lock on the table on which the constraint is declared.

Additional restrictions apply when unique or primary key constraints are added to partitioned tables; see
CREATE TABLE (**CREATE\_TABLE**(7)). Also, foreign key constraints on partitioned tables may not be declared
NOT VALID
at present.

ADD _table\_constraint\_using\_index_
This form adds a new
PRIMARY KEY
or
UNIQUE
constraint to a table based on an existing unique index. All the columns of the index will be included in the constraint.

The index cannot have expression columns nor be a partial index. Also, it must be a b-tree index with default sort ordering. These restrictions ensure that the index is equivalent to one that would be built by a regular
ADD PRIMARY KEY
or
ADD UNIQUE
command.

If
PRIMARY KEY
is specified, and the indexs columns are not already marked
NOT NULL, then this command will attempt to do
ALTER COLUMN SET NOT NULL
against each such column. That requires a full table scan to verify the column(s) contain no nulls. In all other cases, this is a fast operation.

If a constraint name is provided then the index will be renamed to match the constraint name. Otherwise the constraint will be named the same as the index.

After this command is executed, the index is
“owned”
by the constraint, in the same way as if the index had been built by a regular
ADD PRIMARY KEY
or
ADD UNIQUE
command. In particular, dropping the constraint will make the index disappear too.

This form is not currently supported on partitioned tables.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
Adding a constraint using an existing index can be helpful in situations where a new constraint needs to be added without blocking table updates for a long time. To do that, create the index using
**CREATE INDEX CONCURRENTLY**, and then install it as an official constraint using this syntax. See the example below.


ALTER CONSTRAINT
This form alters the attributes of a constraint that was previously created. Currently only foreign key constraints may be altered.

VALIDATE CONSTRAINT
This form validates a foreign key or check constraint that was previously created as
NOT VALID, by scanning the table to ensure there are no rows for which the constraint is not satisfied. Nothing happens if the constraint is already marked valid. (See
NOTES
below for an explanation of the usefulness of this command.)

This command acquires a
SHARE UPDATE EXCLUSIVE
lock.

DROP CONSTRAINT [ IF EXISTS ]
This form drops the specified constraint on a table, along with any index underlying the constraint. If
IF EXISTS
is specified and the constraint does not exist, no error is thrown. In this case a notice is issued instead.

DISABLE/ENABLE [ REPLICA | ALWAYS ] TRIGGER
These forms configure the firing of trigger(s) belonging to the table. A disabled trigger is still known to the system, but is not executed when its triggering event occurs. For a deferred trigger, the enable status is checked when the event occurs, not when the trigger function is actually executed. One can disable or enable a single trigger specified by name, or all triggers on the table, or only user triggers (this option excludes internally generated constraint triggers such as those that are used to implement foreign key constraints or deferrable uniqueness and exclusion constraints). Disabling or enabling internally generated constraint triggers requires superuser privileges; it should be done with caution since of course the integrity of the constraint cannot be guaranteed if the triggers are not executed.

The trigger firing mechanism is also affected by the configuration variable
session_replication_role. Simply enabled triggers (the default) will fire when the replication role is
“origin”
(the default) or
“local”. Triggers configured as
ENABLE REPLICA
will only fire if the session is in
“replica”
mode, and triggers configured as
ENABLE ALWAYS
will fire regardless of the current replication role.

The effect of this mechanism is that in the default configuration, triggers do not fire on replicas. This is useful because if a trigger is used on the origin to propagate data between tables, then the replication system will also replicate the propagated data, and the trigger should not fire a second time on the replica, because that would lead to duplication. However, if a trigger is used for another purpose such as creating external alerts, then it might be appropriate to set it to
ENABLE ALWAYS
so that it is also fired on replicas.

This command acquires a
SHARE ROW EXCLUSIVE
lock.

DISABLE/ENABLE [ REPLICA | ALWAYS ] RULE
These forms configure the firing of rewrite rules belonging to the table. A disabled rule is still known to the system, but is not applied during query rewriting. The semantics are as for disabled/enabled triggers. This configuration is ignored for
ON SELECT
rules, which are always applied in order to keep views working even if the current session is in a non-default replication role.

The rule firing mechanism is also affected by the configuration variable
session_replication_role, analogous to triggers as described above.

DISABLE/ENABLE ROW LEVEL SECURITY
These forms control the application of row security policies belonging to the table. If enabled and no policies exist for the table, then a default-deny policy is applied. Note that policies can exist for a table even if row level security is disabled - in this case, the policies will NOT be applied and the policies will be ignored. See also
CREATE POLICY (**CREATE\_POLICY**(7)).

NO FORCE/FORCE ROW LEVEL SECURITY
These forms control the application of row security policies belonging to the table when the user is the table owner. If enabled, row level security policies will be applied when the user is the table owner. If disabled (the default) then row level security will not be applied when the user is the table owner. See also
CREATE POLICY (**CREATE\_POLICY**(7)).

CLUSTER ON
This form selects the default index for future
**CLUSTER**(7)
operations. It does not actually re-cluster the table.

Changing cluster options acquires a
SHARE UPDATE EXCLUSIVE
lock.

SET WITHOUT CLUSTER
This form removes the most recently used
**CLUSTER**(7)
index specification from the table. This affects future cluster operations that dont specify an index.

Changing cluster options acquires a
SHARE UPDATE EXCLUSIVE
lock.

SET WITHOUT OIDS
Backward-compatible syntax for removing the
oid
system column. As
oid
system columns cannot be added anymore, this never has an effect.

SET TABLESPACE
This form changes the tables tablespace to the specified tablespace and moves the data file(s) associated with the table to the new tablespace. Indexes on the table, if any, are not moved; but they can be moved separately with additional
SET TABLESPACE
commands. When applied to a partitioned table, nothing is moved, but any partitions created afterwards with
**CREATE TABLE PARTITION OF**
will use that tablespace, unless the
TABLESPACE
clause is used to override it.

All tables in the current database in a tablespace can be moved by using the
ALL IN TABLESPACE
form, which will lock all tables to be moved first and then move each one. This form also supports
OWNED BY, which will only move tables owned by the roles specified. If the
NOWAIT
option is specified then the command will fail if it is unable to acquire all of the locks required immediately. Note that system catalogs are not moved by this command; use
**ALTER DATABASE**
or explicit
**ALTER TABLE**
invocations instead if desired. The
information_schema
relations are not considered part of the system catalogs and will be moved. See also
CREATE TABLESPACE (**CREATE\_TABLESPACE**(7)).

SET { LOGGED | UNLOGGED }
This form changes the table from unlogged to logged or vice-versa (see
UNLOGGED). It cannot be applied to a temporary table.

SET ( _storage\_parameter_ [= _value_] [, ... ] )
This form changes one or more storage parameters for the table. See
Storage Parameters
for details on the available parameters. Note that the table contents will not be modified immediately by this command; depending on the parameter you might need to rewrite the table to get the desired effects. That can be done with
VACUUM FULL,
**CLUSTER**(7)
or one of the forms of
**ALTER TABLE**
that forces a table rewrite. For planner related parameters, changes will take effect from the next time the table is locked so currently executing queries will not be affected.

SHARE UPDATE EXCLUSIVE
lock will be taken for fillfactor, toast and autovacuum storage parameters, as well as the planner parameter
_parallel\_workers_.

RESET ( _storage\_parameter_ [, ... ] )
This form resets one or more storage parameters to their defaults. As with
SET, a table rewrite might be needed to update the table entirely.

INHERIT _parent\_table_
This form adds the target table as a new child of the specified parent table. Subsequently, queries against the parent will include records of the target table. To be added as a child, the target table must already contain all the same columns as the parent (it could have additional columns, too). The columns must have matching data types, and if they have
NOT NULL
constraints in the parent then they must also have
NOT NULL
constraints in the child.

There must also be matching child-table constraints for all
CHECK
constraints of the parent, except those marked non-inheritable (that is, created with
ALTER TABLE ... ADD CONSTRAINT ... NO INHERIT) in the parent, which are ignored; all child-table constraints matched must not be marked non-inheritable. Currently
UNIQUE,
PRIMARY KEY, and
FOREIGN KEY
constraints are not considered, but this might change in the future.

NO INHERIT _parent\_table_
This form removes the target table from the list of children of the specified parent table. Queries against the parent table will no longer include records drawn from the target table.

OF _type\_name_
This form links the table to a composite type as though
**CREATE TABLE OF**
had formed it. The tables list of column names and types must precisely match that of the composite type. The table must not inherit from any other table. These restrictions ensure that
**CREATE TABLE OF**
would permit an equivalent table definition.

NOT OF
This form dissociates a typed table from its type.

OWNER TO
This form changes the owner of the table, sequence, view, materialized view, or foreign table to the specified user.

REPLICA IDENTITY
This form changes the information which is written to the write-ahead log to identify rows which are updated or deleted. This option has no effect except when logical replication is in use.
DEFAULT
(the default for non-system tables) records the old values of the columns of the primary key, if any.
USING INDEX
records the old values of the columns covered by the named index, which must be unique, not partial, not deferrable, and include only columns marked
NOT NULL.
FULL
records the old values of all columns in the row.
NOTHING
records no information about the old row. (This is the default for system tables.) In all cases, no old values are logged unless at least one of the columns that would be logged differs between the old and new versions of the row.

RENAME
The
RENAME
forms change the name of a table (or an index, sequence, view, materialized view, or foreign table), the name of an individual column in a table, or the name of a constraint of the table. When renaming a constraint that has an underlying index, the index is renamed as well. There is no effect on the stored data.

SET SCHEMA
This form moves the table into another schema. Associated indexes, constraints, and sequences owned by table columns are moved as well.

ATTACH PARTITION _partition\_name_ { FOR VALUES _partition\_bound\_spec_ | DEFAULT }
This form attaches an existing table (which might itself be partitioned) as a partition of the target table. The table can be attached as a partition for specific values using
FOR VALUES
or as a default partition by using
DEFAULT. For each index in the target table, a corresponding one will be created in the attached table; or, if an equivalent index already exists, it will be attached to the target tables index, as if
**ALTER INDEX ATTACH PARTITION**
had been executed. Note that if the existing table is a foreign table, it is currently not allowed to attach the table as a partition of the target table if there are
UNIQUE
indexes on the target table. (See also
CREATE FOREIGN TABLE (**CREATE\_FOREIGN\_TABLE**(7)).) For each user-defined row-level trigger that exists in the target table, a corresponding one is created in the attached table.

A partition using
FOR VALUES
uses same syntax for
_partition\_bound\_spec_
as
CREATE TABLE (**CREATE\_TABLE**(7)). The partition bound specification must correspond to the partitioning strategy and partition key of the target table. The table to be attached must have all the same columns as the target table and no more; moreover, the column types must also match. Also, it must have all the
NOT NULL
and
CHECK
constraints of the target table. Currently
FOREIGN KEY
constraints are not considered.
UNIQUE
and
PRIMARY KEY
constraints from the parent table will be created in the partition, if they dont already exist. If any of the
CHECK
constraints of the table being attached are marked
NO INHERIT, the command will fail; such constraints must be recreated without the
NO INHERIT
clause.

If the new partition is a regular table, a full table scan is performed to check that existing rows in the table do not violate the partition constraint. It is possible to avoid this scan by adding a valid
CHECK
constraint to the table that allows only rows satisfying the desired partition constraint before running this command. The
CHECK
constraint will be used to determine that the table need not be scanned to validate the partition constraint. This does not work, however, if any of the partition keys is an expression and the partition does not accept
NULL
values. If attaching a list partition that will not accept
NULL
values, also add
NOT NULL
constraint to the partition key column, unless its an expression.

If the new partition is a foreign table, nothing is done to verify that all the rows in the foreign table obey the partition constraint. (See the discussion in
CREATE FOREIGN TABLE (**CREATE\_FOREIGN\_TABLE**(7))
about constraints on the foreign table.)

When a table has a default partition, defining a new partition changes the partition constraint for the default partition. The default partition cant contain any rows that would need to be moved to the new partition, and will be scanned to verify that none are present. This scan, like the scan of the new partition, can be avoided if an appropriate
CHECK
constraint is present. Also like the scan of the new partition, it is always skipped when the default partition is a foreign table.

Attaching a partition acquires a
SHARE UPDATE EXCLUSIVE
lock on the parent table, in addition to
ACCESS EXCLUSIVE
locks on the table to be attached and on the default partition (if any).

DETACH PARTITION _partition\_name_
This form detaches the specified partition of the target table. The detached partition continues to exist as a standalone table, but no longer has any ties to the table from which it was detached. Any indexes that were attached to the target tables indexes are detached. Any triggers that were created as clones of those in the target table are removed.
SHARE
lock is obtained on any tables that reference this partitioned table in foreign key constraints.

All the forms of ALTER TABLE that act on a single table, except
RENAME,
SET SCHEMA,
ATTACH PARTITION, and
DETACH PARTITION
can be combined into a list of multiple alterations to be applied together. For example, it is possible to add several columns and/or alter the type of several columns in a single command. This is particularly useful with large tables, since only one pass over the table need be made.

You must own the table to use
**ALTER TABLE**. To change the schema or tablespace of a table, you must also have
CREATE
privilege on the new schema or tablespace. To add the table as a new child of a parent table, you must own the parent table as well. Also, to attach a table as a new partition of the table, you must own the table being attached. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the tables schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the table. However, a superuser can alter ownership of any table anyway.) To add a column or alter a column type or use the
OF
clause, you must also have
USAGE
privilege on the data type.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the table does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing table to alter. If
ONLY
is specified before the table name, only that table is altered. If
ONLY
is not specified, the table and all its descendant tables (if any) are altered. Optionally,
*
can be specified after the table name to explicitly indicate that descendant tables are included.

_column\_name_
Name of a new or existing column.

_new\_column\_name_
New name for an existing column.

_new\_name_
New name for the table.

_data\_type_
Data type of the new column, or new data type for an existing column.

_table\_constraint_
New table constraint for the table.

_constraint\_name_
Name of a new or existing constraint.

CASCADE
Automatically drop objects that depend on the dropped column or constraint (for example, views referencing the column), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the column or constraint if there are any dependent objects. This is the default behavior.

_trigger\_name_
Name of a single trigger to disable or enable.

ALL
Disable or enable all triggers belonging to the table. (This requires superuser privilege if any of the triggers are internally generated constraint triggers such as those that are used to implement foreign key constraints or deferrable uniqueness and exclusion constraints.)

USER
Disable or enable all triggers belonging to the table except for internally generated constraint triggers such as those that are used to implement foreign key constraints or deferrable uniqueness and exclusion constraints.

_index\_name_
The name of an existing index.

_storage\_parameter_
The name of a table storage parameter.

_value_
The new value for a table storage parameter. This might be a number or a word depending on the parameter.

_parent\_table_
A parent table to associate or de-associate with this table.

_new\_owner_
The user name of the new owner of the table.

_new\_tablespace_
The name of the tablespace to which the table will be moved.

_new\_schema_
The name of the schema to which the table will be moved.

_partition\_name_
The name of the table to attach as a new partition or to detach from this table.

_partition\_bound\_spec_
The partition bound specification for a new partition. Refer to
CREATE TABLE (**CREATE\_TABLE**(7))
for more details on the syntax of the same.

<a name="notes"></a>

# Notes


The key word
COLUMN
is noise and can be omitted.

When a column is added with
ADD COLUMN
and a non-volatile
DEFAULT
is specified, the default is evaluated at the time of the statement and the result stored in the tables metadata. That value will be used for the column for all existing rows. If no
DEFAULT
is specified, NULL is used. In neither case is a rewrite of the table required.

Adding a column with a volatile
DEFAULT
or changing the type of an existing column will require the entire table and its indexes to be rewritten. As an exception, when changing the type of an existing column, if the
USING
clause does not change the column contents and the old type is either binary coercible to the new type or an unconstrained domain over the new type, a table rewrite is not needed; but any indexes on the affected columns must still be rebuilt. Table and/or index rebuilds may take a significant amount of time for a large table; and will temporarily require as much as double the disk space.

Adding a
CHECK
or
NOT NULL
constraint requires scanning the table to verify that existing rows meet the constraint, but does not require a table rewrite.

Similarly, when attaching a new partition it may be scanned to verify that existing rows meet the partition constraint.

The main reason for providing the option to specify multiple changes in a single
**ALTER TABLE**
is that multiple table scans or rewrites can thereby be combined into a single pass over the table.

Scanning a large table to verify a new foreign key or check constraint can take a long time, and other updates to the table are locked out until the
**ALTER TABLE ADD CONSTRAINT**
command is committed. The main purpose of the
NOT VALID
constraint option is to reduce the impact of adding a constraint on concurrent updates. With
NOT VALID, the
**ADD CONSTRAINT**
command does not scan the table and can be committed immediately. After that, a
VALIDATE CONSTRAINT
command can be issued to verify that existing rows satisfy the constraint. The validation step does not need to lock out concurrent updates, since it knows that other transactions will be enforcing the constraint for rows that they insert or update; only pre-existing rows need to be checked. Hence, validation acquires only a
SHARE UPDATE EXCLUSIVE
lock on the table being altered. (If the constraint is a foreign key then a
ROW SHARE
lock is also required on the table referenced by the constraint.) In addition to improving concurrency, it can be useful to use
NOT VALID
and
VALIDATE CONSTRAINT
in cases where the table is known to contain pre-existing violations. Once the constraint is in place, no new violations can be inserted, and the existing problems can be corrected at leisure until
VALIDATE CONSTRAINT
finally succeeds.

The
DROP COLUMN
form does not physically remove the column, but simply makes it invisible to SQL operations. Subsequent insert and update operations in the table will store a null value for the column. Thus, dropping a column is quick but it will not immediately reduce the on-disk size of your table, as the space occupied by the dropped column is not reclaimed. The space will be reclaimed over time as existing rows are updated.

To force immediate reclamation of space occupied by a dropped column, you can execute one of the forms of
**ALTER TABLE**
that performs a rewrite of the whole table. This results in reconstructing each row with the dropped column replaced by a null value.

The rewriting forms of
**ALTER TABLE**
are not MVCC-safe. After a table rewrite, the table will appear empty to concurrent transactions, if they are using a snapshot taken before the rewrite occurred. See
Section&nbsp;13.5
for more details.

The
USING
option of
SET DATA TYPE
can actually specify any expression involving the old values of the row; that is, it can refer to other columns as well as the one being converted. This allows very general conversions to be done with the
SET DATA TYPE
syntax. Because of this flexibility, the
USING
expression is not applied to the columns default value (if any); the result might not be a constant expression as required for a default. This means that when there is no implicit or assignment cast from old to new type,
SET DATA TYPE
might fail to convert the default even though a
USING
clause is supplied. In such cases, drop the default with
DROP DEFAULT, perform the
ALTER TYPE, and then use
SET DEFAULT
to add a suitable new default. Similar considerations apply to indexes and constraints involving the column.

If a table has any descendant tables, it is not permitted to add, rename, or change the type of a column in the parent table without doing the same to the descendants. This ensures that the descendants always have columns matching the parent. Similarly, a
CHECK
constraint cannot be renamed in the parent without also renaming it in all descendants, so that
CHECK
constraints also match between the parent and its descendants. (That restriction does not apply to index-based constraints, however.) Also, because selecting from the parent also selects from its descendants, a constraint on the parent cannot be marked valid unless it is also marked valid for those descendants. In all of these cases,
**ALTER TABLE ONLY**
will be rejected.

A recursive
DROP COLUMN
operation will remove a descendant tables column only if the descendant does not inherit that column from any other parents and never had an independent definition of the column. A nonrecursive
DROP COLUMN
(i.e.,
**ALTER TABLE ONLY ... DROP COLUMN**) never removes any descendant columns, but instead marks them as independently defined rather than inherited. A nonrecursive
DROP COLUMN
command will fail for a partitioned table, because all partitions of a table must have the same columns as the partitioning root.

The actions for identity columns (ADD GENERATED,
SET
etc.,
DROP IDENTITY), as well as the actions
TRIGGER,
CLUSTER,
OWNER, and
TABLESPACE
never recurse to descendant tables; that is, they always act as though
ONLY
were specified. Adding a constraint recurses only for
CHECK
constraints that are not marked
NO INHERIT.

Changing any part of a system catalog table is not permitted.

Refer to
CREATE TABLE (**CREATE\_TABLE**(7))
for a further description of valid parameters.
Chapter&nbsp;5
has further information on inheritance.

<a name="examples"></a>

# Examples


To add a column of type
varchar
to a table:

.if n \{.RS 4
.\}
    ALTER TABLE distributors ADD COLUMN address varchar(30);
.if n \{.RE
.\}

To drop a column from a table:

.if n \{.RS 4
.\}
    ALTER TABLE distributors DROP COLUMN address RESTRICT;
.if n \{.RE
.\}

To change the types of two existing columns in one operation:

.if n \{.RS 4
.\}
    ALTER TABLE distributors
        ALTER COLUMN address TYPE varchar(80),
        ALTER COLUMN name TYPE varchar(100);
.if n \{.RE
.\}

To change an integer column containing Unix timestamps to
timestamp with time zone
via a
USING
clause:

.if n \{.RS 4
.\}
    ALTER TABLE foo
        ALTER COLUMN foo_timestamp SET DATA TYPE timestamp with time zone
        USING
            timestamp with time zone epoch*(Aq + foo_timestamp * interval *(Aq1 second*(Aq;
.if n \{.RE
.\}

The same, when the column has a default expression that wont automatically cast to the new data type:

.if n \{.RS 4
.\}
    ALTER TABLE foo
        ALTER COLUMN foo_timestamp DROP DEFAULT,
        ALTER COLUMN foo_timestamp TYPE timestamp with time zone
        USING
            timestamp with time zone epoch*(Aq + foo_timestamp * interval *(Aq1 second*(Aq,
        ALTER COLUMN foo_timestamp SET DEFAULT now();
.if n \{.RE
.\}

To rename an existing column:

.if n \{.RS 4
.\}
    ALTER TABLE distributors RENAME COLUMN address TO city;
.if n \{.RE
.\}

To rename an existing table:

.if n \{.RS 4
.\}
    ALTER TABLE distributors RENAME TO suppliers;
.if n \{.RE
.\}

To rename an existing constraint:

.if n \{.RS 4
.\}
    ALTER TABLE distributors RENAME CONSTRAINT zipchk TO zip_check;
.if n \{.RE
.\}

To add a not-null constraint to a column:

.if n \{.RS 4
.\}
    ALTER TABLE distributors ALTER COLUMN street SET NOT NULL;
.if n \{.RE
.\}

To remove a not-null constraint from a column:

.if n \{.RS 4
.\}
    ALTER TABLE distributors ALTER COLUMN street DROP NOT NULL;
.if n \{.RE
.\}

To add a check constraint to a table and all its children:

.if n \{.RS 4
.\}
    ALTER TABLE distributors ADD CONSTRAINT zipchk CHECK (char_length(zipcode) = 5);
.if n \{.RE
.\}

To add a check constraint only to a table and not to its children:

.if n \{.RS 4
.\}
    ALTER TABLE distributors ADD CONSTRAINT zipchk CHECK (char_length(zipcode) = 5) NO INHERIT;
.if n \{.RE
.\}

(The check constraint will not be inherited by future children, either.)

To remove a check constraint from a table and all its children:

.if n \{.RS 4
.\}
    ALTER TABLE distributors DROP CONSTRAINT zipchk;
.if n \{.RE
.\}

To remove a check constraint from one table only:

.if n \{.RS 4
.\}
    ALTER TABLE ONLY distributors DROP CONSTRAINT zipchk;
.if n \{.RE
.\}

(The check constraint remains in place for any child tables.)

To add a foreign key constraint to a table:

.if n \{.RS 4
.\}
    ALTER TABLE distributors ADD CONSTRAINT distfk FOREIGN KEY (address) REFERENCES addresses (address);
.if n \{.RE
.\}

To add a foreign key constraint to a table with the least impact on other work:

.if n \{.RS 4
.\}
    ALTER TABLE distributors ADD CONSTRAINT distfk FOREIGN KEY (address) REFERENCES addresses (address) NOT VALID;
    ALTER TABLE distributors VALIDATE CONSTRAINT distfk;
.if n \{.RE
.\}

To add a (multicolumn) unique constraint to a table:

.if n \{.RS 4
.\}
    ALTER TABLE distributors ADD CONSTRAINT dist_id_zipcode_key UNIQUE (dist_id, zipcode);
.if n \{.RE
.\}

To add an automatically named primary key constraint to a table, noting that a table can only ever have one primary key:

.if n \{.RS 4
.\}
    ALTER TABLE distributors ADD PRIMARY KEY (dist_id);
.if n \{.RE
.\}

To move a table to a different tablespace:

.if n \{.RS 4
.\}
    ALTER TABLE distributors SET TABLESPACE fasttablespace;
.if n \{.RE
.\}

To move a table to a different schema:

.if n \{.RS 4
.\}
    ALTER TABLE myschema.distributors SET SCHEMA yourschema;
.if n \{.RE
.\}

To recreate a primary key constraint, without blocking updates while the index is rebuilt:

.if n \{.RS 4
.\}
    CREATE UNIQUE INDEX CONCURRENTLY dist_id_temp_idx ON distributors (dist_id);
    ALTER TABLE distributors DROP CONSTRAINT distributors_pkey,
        ADD CONSTRAINT distributors_pkey PRIMARY KEY USING INDEX dist_id_temp_idx;
.if n \{.RE
.\}

To attach a partition to a range-partitioned table:

.if n \{.RS 4
.\}
    ALTER TABLE measurement
        ATTACH PARTITION measurement_y2016m07 FOR VALUES FROM (2016-07-01*(Aq) TO (*(Aq2016-08-01*(Aq);
.if n \{.RE
.\}

To attach a partition to a list-partitioned table:

.if n \{.RS 4
.\}
    ALTER TABLE cities
        ATTACH PARTITION cities_ab FOR VALUES IN (a*(Aq, *(Aqb*(Aq);
.if n \{.RE
.\}

To attach a partition to a hash-partitioned table:

.if n \{.RS 4
.\}
    ALTER TABLE orders
        ATTACH PARTITION orders_p4 FOR VALUES WITH (MODULUS 4, REMAINDER 3);
.if n \{.RE
.\}

To attach a default partition to a partitioned table:

.if n \{.RS 4
.\}
    ALTER TABLE cities
        ATTACH PARTITION cities_partdef DEFAULT;
.if n \{.RE
.\}

To detach a partition from a partitioned table:

.if n \{.RS 4
.\}
    ALTER TABLE measurement
        DETACH PARTITION measurement_y2015m12;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The forms
ADD
(without
USING INDEX),
DROP [COLUMN],
DROP IDENTITY,
RESTART,
SET DEFAULT,
SET DATA TYPE
(without
USING),
SET GENERATED, and
SET _sequence\_option_
conform with the SQL standard. The other forms are
PostgreSQL
extensions of the SQL standard. Also, the ability to specify more than one manipulation in a single
**ALTER TABLE**
command is an extension.

**ALTER TABLE DROP COLUMN**
can be used to drop the only column of a table, leaving a zero-column table. This is an extension of SQL, which disallows zero-column tables.

<a name="see-also"></a>

# See Also

CREATE TABLE (**CREATE\_TABLE**(7))
