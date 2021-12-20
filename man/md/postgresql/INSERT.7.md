# insert(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

INSERT - create new rows in a table

<a name="synopsis"></a>

# Synopsis

```


```
    [ WITH [ RECURSIVE ] with_query [, ...] ]
    INSERT INTO table_name [ AS alias ] [ ( column_name [, ...] ) ]
        [ OVERRIDING { SYSTEM | USER } VALUE ]
        { DEFAULT VALUES | VALUES ( { expression | DEFAULT } [, ...] ) [, ...] | query }
        [ ON CONFLICT [ conflict_target ] conflict_action ]
        [ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]
    
    where conflict_target can be one of:
    
        ( { index_column_name | ( index_expression ) } [ COLLATE collation ] [ opclass ] [, ...] ) [ WHERE index_predicate ]
        ON CONSTRAINT constraint_name
    
    and conflict_action is one of:
    
        DO NOTHING
        DO UPDATE SET { column_name = { expression | DEFAULT } |
                        ( column_name [, ...] ) = [ ROW ] ( { expression | DEFAULT } [, ...] ) |
                        ( column_name [, ...] ) = ( sub-SELECT )
                      } [, ...]
                  [ WHERE condition ]

<a name="description"></a>

# Description


**INSERT**
inserts new rows into a table. One can insert one or more rows specified by value expressions, or zero or more rows resulting from a query.

The target column names can be listed in any order. If no list of column names is given at all, the default is all the columns of the table in their declared order; or the first
_N_
column names, if there are only
_N_
columns supplied by the
VALUES
clause or
_query_. The values supplied by the
VALUES
clause or
_query_
are associated with the explicit or implicit column list left-to-right.

Each column not present in the explicit or implicit column list will be filled with a default value, either its declared default value or null if there is none.

If the expression for any column is not of the correct data type, automatic type conversion will be attempted.

ON CONFLICT
can be used to specify an alternative action to raising a unique constraint or exclusion constraint violation error. (See
ON CONFLICT Clause
below.)

The optional
RETURNING
clause causes
**INSERT**
to compute and return value(s) based on each row actually inserted (or updated, if an
ON CONFLICT DO UPDATE
clause was used). This is primarily useful for obtaining values that were supplied by defaults, such as a serial sequence number. However, any expression using the tables columns is allowed. The syntax of the
RETURNING
list is identical to that of the output list of
**SELECT**. Only rows that were successfully inserted or updated will be returned. For example, if a row was locked but not updated because an
ON CONFLICT DO UPDATE ... WHERE
clause
_condition_
was not satisfied, the row will not be returned.

You must have
INSERT
privilege on a table in order to insert into it. If
ON CONFLICT DO UPDATE
is present,
UPDATE
privilege on the table is also required.

If a column list is specified, you only need
INSERT
privilege on the listed columns. Similarly, when
ON CONFLICT DO UPDATE
is specified, you only need
UPDATE
privilege on the column(s) that are listed to be updated. However,
ON CONFLICT DO UPDATE
also requires
SELECT
privilege on any column whose values are read in the
ON CONFLICT DO UPDATE
expressions or
_condition_.

Use of the
RETURNING
clause requires
SELECT
privilege on all columns mentioned in
RETURNING. If you use the
_query_
clause to insert rows from a query, you of course need to have
SELECT
privilege on any table or column used in the query.

<a name="parameters"></a>

# Parameters


<a name="inserting"></a>

### Inserting


This section covers parameters that may be used when only inserting new rows. Parameters
_exclusively_
used with the
ON CONFLICT
clause are described separately.

_with\_query_
The
WITH
clause allows you to specify one or more subqueries that can be referenced by name in the
**INSERT**
query. See
Section&nbsp;7.8
and
**SELECT**(7)
for details.

It is possible for the
_query_
(**SELECT**
statement) to also contain a
WITH
clause. In such a case both sets of
_with\_query_
can be referenced within the
_query_, but the second one takes precedence since it is more closely nested.

_table\_name_
The name (optionally schema-qualified) of an existing table.

_alias_
A substitute name for
_table\_name_. When an alias is provided, it completely hides the actual name of the table. This is particularly useful when
ON CONFLICT DO UPDATE
targets a table named
_excluded_, since that will otherwise be taken as the name of the special table representing rows proposed for insertion.

_column\_name_
The name of a column in the table named by
_table\_name_. The column name can be qualified with a subfield name or array subscript, if needed. (Inserting into only some fields of a composite column leaves the other fields null.) When referencing a column with
ON CONFLICT DO UPDATE, do not include the tables name in the specification of a target column. For example,
INSERT INTO table_name ... ON CONFLICT DO UPDATE SET table_name.col = 1
is invalid (this follows the general behavior for
**UPDATE**).

OVERRIDING SYSTEM VALUE
Without this clause, it is an error to specify an explicit value (other than
DEFAULT) for an identity column defined as
GENERATED ALWAYS. This clause overrides that restriction.

OVERRIDING USER VALUE
If this clause is specified, then any values supplied for identity columns defined as
GENERATED BY DEFAULT
are ignored and the default sequence-generated values are applied.

This clause is useful for example when copying values between tables. Writing
INSERT INTO tbl2 OVERRIDING USER VALUE SELECT * FROM tbl1
will copy from
tbl1
all columns that are not identity columns in
tbl2
while values for the identity columns in
tbl2
will be generated by the sequences associated with
tbl2.

DEFAULT VALUES
All columns will be filled with their default values. (An
OVERRIDING
clause is not permitted in this form.)

_expression_
An expression or value to assign to the corresponding column.

DEFAULT
The corresponding column will be filled with its default value.

_query_
A query (**SELECT**
statement) that supplies the rows to be inserted. Refer to the
**SELECT**(7)
statement for a description of the syntax.

_output\_expression_
An expression to be computed and returned by the
**INSERT**
command after each row is inserted or updated. The expression can use any column names of the table named by
_table\_name_. Write
*
to return all columns of the inserted or updated row(s).

_output\_name_
A name to use for a returned column.

<a name="on-conflict-clause"></a>

### ON CONFLICT Clause


The optional
ON CONFLICT
clause specifies an alternative action to raising a unique violation or exclusion constraint violation error. For each individual row proposed for insertion, either the insertion proceeds, or, if an
_arbiter_
constraint or index specified by
_conflict\_target_
is violated, the alternative
_conflict\_action_
is taken.
ON CONFLICT DO NOTHING
simply avoids inserting a row as its alternative action.
ON CONFLICT DO UPDATE
updates the existing row that conflicts with the row proposed for insertion as its alternative action.

_conflict\_target_
can perform
_unique index inference_. When performing inference, it consists of one or more
_index\_column\_name_
columns and/or
_index\_expression_
expressions, and an optional
_index\_predicate_. All
_table\_name_
unique indexes that, without regard to order, contain exactly the
_conflict\_target_-specified columns/expressions are inferred (chosen) as arbiter indexes. If an
_index\_predicate_
is specified, it must, as a further requirement for inference, satisfy arbiter indexes. Note that this means a non-partial unique index (a unique index without a predicate) will be inferred (and thus used by
ON CONFLICT) if such an index satisfying every other criteria is available. If an attempt at inference is unsuccessful, an error is raised.

ON CONFLICT DO UPDATE
guarantees an atomic
**INSERT**
or
**UPDATE**
outcome; provided there is no independent error, one of those two outcomes is guaranteed, even under high concurrency. This is also known as
UPSERT
—
“UPDATE or INSERT”.

_conflict\_target_
Specifies which conflicts
ON CONFLICT
takes the alternative action on by choosing
arbiter indexes. Either performs
_unique index inference_, or names a constraint explicitly. For
ON CONFLICT DO NOTHING, it is optional to specify a
_conflict\_target_; when omitted, conflicts with all usable constraints (and unique indexes) are handled. For
ON CONFLICT DO UPDATE, a
_conflict\_target_
_must_
be provided.

_conflict\_action_
_conflict\_action_
specifies an alternative
ON CONFLICT
action. It can be either
DO NOTHING, or a
DO UPDATE
clause specifying the exact details of the
UPDATE
action to be performed in case of a conflict. The
SET
and
WHERE
clauses in
ON CONFLICT DO UPDATE
have access to the existing row using the tables name (or an alias), and to rows proposed for insertion using the special
_excluded_
table.
SELECT
privilege is required on any column in the target table where corresponding
_excluded_
columns are read.

Note that the effects of all per-row
BEFORE INSERT
triggers are reflected in
_excluded_
values, since those effects may have contributed to the row being excluded from insertion.

_index\_column\_name_
The name of a
_table\_name_
column. Used to infer arbiter indexes. Follows
**CREATE INDEX**
format.
SELECT
privilege on
_index\_column\_name_
is required.

_index\_expression_
Similar to
_index\_column\_name_, but used to infer expressions on
_table\_name_
columns appearing within index definitions (not simple columns). Follows
**CREATE INDEX**
format.
SELECT
privilege on any column appearing within
_index\_expression_
is required.

_collation_
When specified, mandates that corresponding
_index\_column\_name_
or
_index\_expression_
use a particular collation in order to be matched during inference. Typically this is omitted, as collations usually do not affect whether or not a constraint violation occurs. Follows
**CREATE INDEX**
format.

_opclass_
When specified, mandates that corresponding
_index\_column\_name_
or
_index\_expression_
use particular operator class in order to be matched during inference. Typically this is omitted, as the
_equality_
semantics are often equivalent across a types operator classes anyway, or because it\*(Aqs sufficient to trust that the defined unique indexes have the pertinent definition of equality. Follows
**CREATE INDEX**
format.

_index\_predicate_
Used to allow inference of partial unique indexes. Any indexes that satisfy the predicate (which need not actually be partial indexes) can be inferred. Follows
**CREATE INDEX**
format.
SELECT
privilege on any column appearing within
_index\_predicate_
is required.

_constraint\_name_
Explicitly specifies an arbiter
_constraint_
by name, rather than inferring a constraint or index.

_condition_
An expression that returns a value of type
boolean. Only rows for which this expression returns
true
will be updated, although all rows will be locked when the
ON CONFLICT DO UPDATE
action is taken. Note that
_condition_
is evaluated last, after a conflict has been identified as a candidate to update.

Note that exclusion constraints are not supported as arbiters with
ON CONFLICT DO UPDATE. In all cases, only
NOT DEFERRABLE
constraints and unique indexes are supported as arbiters.

**INSERT**
with an
ON CONFLICT DO UPDATE
clause is a
“deterministic”
statement. This means that the command will not be allowed to affect any single existing row more than once; a cardinality violation error will be raised when this situation arises. Rows proposed for insertion should not duplicate each other in terms of attributes constrained by an arbiter index or constraint.

Note that it is currently not supported for the
ON CONFLICT DO UPDATE
clause of an
**INSERT**
applied to a partitioned table to update the partition key of a conflicting row such that it requires the row be moved to a new partition.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Tip**
.ps -1  

It is often preferable to use unique index inference rather than naming a constraint directly using
ON CONFLICT ON CONSTRAINT
_ constraint\_name_. Inference will continue to work correctly when the underlying index is replaced by another more or less equivalent index in an overlapping way, for example when using
CREATE UNIQUE INDEX ... CONCURRENTLY
before dropping the index being replaced.


<a name="outputs"></a>

# Outputs


On successful completion, an
**INSERT**
command returns a command tag of the form

.if n \{.RS 4
.\}
    INSERT oid count
.if n \{.RE
.\}

The
_count_
is the number of rows inserted or updated.
_oid_
is always 0 (it used to be the
OID
assigned to the inserted row if
_count_
was exactly one and the target table was declared
WITH OIDS
and 0 otherwise, but creating a table
WITH OIDS
is not supported anymore).

If the
**INSERT**
command contains a
RETURNING
clause, the result will be similar to that of a
**SELECT**
statement containing the columns and values defined in the
RETURNING
list, computed over the row(s) inserted or updated by the command.

<a name="notes"></a>

# Notes


If the specified table is a partitioned table, each row is routed to the appropriate partition and inserted into it. If the specified table is a partition, an error will occur if one of the input rows violates the partition constraint.

<a name="examples"></a>

# Examples


Insert a single row into table
films:

.if n \{.RS 4
.\}
    INSERT INTO films VALUES
        (UA502*(Aq, *(AqBananas*(Aq, 105, *(Aq1971-07-13*(Aq, *(AqComedy*(Aq, *(Aq82 minutes*(Aq);
.if n \{.RE
.\}

In this example, the
len
column is omitted and therefore it will have the default value:

.if n \{.RS 4
.\}
    INSERT INTO films (code, title, did, date_prod, kind)
        VALUES (T_601*(Aq, *(AqYojimbo*(Aq, 106, *(Aq1961-06-16*(Aq, *(AqDrama*(Aq);
.if n \{.RE
.\}

This example uses the
DEFAULT
clause for the date columns rather than specifying a value:

.if n \{.RS 4
.\}
    INSERT INTO films VALUES
        (UA502*(Aq, *(AqBananas*(Aq, 105, DEFAULT, *(AqComedy*(Aq, *(Aq82 minutes*(Aq);
    INSERT INTO films (code, title, did, date_prod, kind)
        VALUES (T_601*(Aq, *(AqYojimbo*(Aq, 106, DEFAULT, *(AqDrama*(Aq);
.if n \{.RE
.\}

To insert a row consisting entirely of default values:

.if n \{.RS 4
.\}
    INSERT INTO films DEFAULT VALUES;
.if n \{.RE
.\}

To insert multiple rows using the multirow
**VALUES**
syntax:

.if n \{.RS 4
.\}
    INSERT INTO films (code, title, did, date_prod, kind) VALUES
        (B6717*(Aq, *(AqTampopo*(Aq, 110, *(Aq1985-02-10*(Aq, *(AqComedy*(Aq),
        (HG120*(Aq, *(AqThe Dinner Game*(Aq, 140, DEFAULT, *(AqComedy*(Aq);
.if n \{.RE
.\}

This example inserts some rows into table
films
from a table
tmp_films
with the same column layout as
films:

.if n \{.RS 4
.\}
    INSERT INTO films SELECT * FROM tmp_films WHERE date_prod < 2004-05-07*(Aq;
.if n \{.RE
.\}

This example inserts into array columns:

.if n \{.RS 4
.\}
    -- Create an empty 3x3 gameboard for noughts-and-crosses
    INSERT INTO tictactoe (game, board[1:3][1:3])
        VALUES (1, {{" "," "," "},{" "," "," "},{" "," "," "}}*(Aq);
    -- The subscripts in the above example arent really needed
    INSERT INTO tictactoe (game, board)
        VALUES (2, {{X," "," "},{" ",O," "},{" ",X," "}}*(Aq);
.if n \{.RE
.\}

Insert a single row into table
distributors, returning the sequence number generated by the
DEFAULT
clause:

.if n \{.RS 4
.\}
    INSERT INTO distributors (did, dname) VALUES (DEFAULT, XYZ Widgets*(Aq)
       RETURNING did;
.if n \{.RE
.\}

Increment the sales count of the salesperson who manages the account for Acme Corporation, and record the whole updated row along with current time in a log table:

.if n \{.RS 4
.\}
    WITH upd AS (
      UPDATE employees SET sales_count = sales_count + 1 WHERE id =
        (SELECT sales_person FROM accounts WHERE name = Acme Corporation*(Aq)
        RETURNING *
    )
    INSERT INTO employees_log SELECT *, current_timestamp FROM upd;
.if n \{.RE
.\}

Insert or update new distributors as appropriate. Assumes a unique index has been defined that constrains values appearing in the
did
column. Note that the special
_excluded_
table is used to reference values originally proposed for insertion:

.if n \{.RS 4
.\}
    INSERT INTO distributors (did, dname)
        VALUES (5, Gizmo Transglobal*(Aq), (6, *(AqAssociated Computing, Inc*(Aq)
        ON CONFLICT (did) DO UPDATE SET dname = EXCLUDED.dname;
.if n \{.RE
.\}

Insert a distributor, or do nothing for rows proposed for insertion when an existing, excluded row (a row with a matching constrained column or columns after before row insert triggers fire) exists. Example assumes a unique index has been defined that constrains values appearing in the
did
column:

.if n \{.RS 4
.\}
    INSERT INTO distributors (did, dname) VALUES (7, Redline GmbH*(Aq)
        ON CONFLICT (did) DO NOTHING;
.if n \{.RE
.\}

Insert or update new distributors as appropriate. Example assumes a unique index has been defined that constrains values appearing in the
did
column.
WHERE
clause is used to limit the rows actually updated (any existing row not updated will still be locked, though):

.if n \{.RS 4
.\}
    -- Dont update existing distributors based in a certain ZIP code
    INSERT INTO distributors AS d (did, dname) VALUES (8, Anvil Distribution*(Aq)
        ON CONFLICT (did) DO UPDATE
        SET dname = EXCLUDED.dname ||  (formerly *(Aq || d.dname || *(Aq)*(Aq
        WHERE d.zipcode <> 21201*(Aq;
    
    -- Name a constraint directly in the statement (uses associated
    -- index to arbitrate taking the DO NOTHING action)
    INSERT INTO distributors (did, dname) VALUES (9, Antwerp Design*(Aq)
        ON CONFLICT ON CONSTRAINT distributors_pkey DO NOTHING;
.if n \{.RE
.\}

Insert new distributor if possible; otherwise
DO NOTHING. Example assumes a unique index has been defined that constrains values appearing in the
did
column on a subset of rows where the
is_active
Boolean column evaluates to
true:

.if n \{.RS 4
.\}
    -- This statement could infer a partial unique index on "did"
    -- with a predicate of "WHERE is_active", but it could also
    -- just use a regular unique constraint on "did"
    INSERT INTO distributors (did, dname) VALUES (10, Conrad International*(Aq)
        ON CONFLICT (did) WHERE is_active DO NOTHING;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**INSERT**
conforms to the SQL standard, except that the
RETURNING
clause is a
PostgreSQL
extension, as is the ability to use
WITH
with
**INSERT**, and the ability to specify an alternative action with
ON CONFLICT. Also, the case in which a column name list is omitted, but not all the columns are filled from the
VALUES
clause or
_query_, is disallowed by the standard.

The SQL standard specifies that
OVERRIDING SYSTEM VALUE
can only be specified if an identity column that is generated always exists. PostgreSQL allows the clause in any case and ignores it if it is not applicable.

Possible limitations of the
_query_
clause are documented under
**SELECT**(7).
