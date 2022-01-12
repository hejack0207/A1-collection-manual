# delete(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DELETE - delete rows of a table

<a name="synopsis"></a>

# Synopsis

```


```
    [ WITH [ RECURSIVE ] with_query [, ...] ]
    DELETE FROM [ ONLY ] table_name [ * ] [ [ AS ] alias ]
        [ USING from_item [, ...] ]
        [ WHERE condition | WHERE CURRENT OF cursor_name ]
        [ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]

<a name="description"></a>

# Description


**DELETE**
deletes rows that satisfy the
WHERE
clause from the specified table. If the
WHERE
clause is absent, the effect is to delete all rows in the table. The result is a valid, but empty table.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Tip**
.ps -1  

**TRUNCATE**(7)
provides a faster mechanism to remove all rows from a table.


There are two ways to delete rows in a table using information contained in other tables in the database: using sub-selects, or specifying additional tables in the
USING
clause. Which technique is more appropriate depends on the specific circumstances.

The optional
RETURNING
clause causes
**DELETE**
to compute and return value(s) based on each row actually deleted. Any expression using the tables columns, and/or columns of other tables mentioned in
USING, can be computed. The syntax of the
RETURNING
list is identical to that of the output list of
**SELECT**.

You must have the
DELETE
privilege on the table to delete from it, as well as the
SELECT
privilege for any table in the
USING
clause or whose values are read in the
_condition_.

<a name="parameters"></a>

# Parameters


_with\_query_
The
WITH
clause allows you to specify one or more subqueries that can be referenced by name in the
**DELETE**
query. See
Section&nbsp;7.8
and
**SELECT**(7)
for details.

_table\_name_
The name (optionally schema-qualified) of the table to delete rows from. If
ONLY
is specified before the table name, matching rows are deleted from the named table only. If
ONLY
is not specified, matching rows are also deleted from any tables inheriting from the named table. Optionally,
*
can be specified after the table name to explicitly indicate that descendant tables are included.

_alias_
A substitute name for the target table. When an alias is provided, it completely hides the actual name of the table. For example, given
DELETE FROM foo AS f, the remainder of the
**DELETE**
statement must refer to this table as
f
not
foo.

_from\_item_
A table expression allowing columns from other tables to appear in the
WHERE
condition. This uses the same syntax as the
FROM Clause
of a
**SELECT**
statement; for example, an alias for the table name can be specified. Do not repeat the target table as a
_from\_item_
unless you wish to set up a self-join (in which case it must appear with an alias in the
_from\_item_).

_condition_
An expression that returns a value of type
boolean. Only rows for which this expression returns
true
will be deleted.

_cursor\_name_
The name of the cursor to use in a
WHERE CURRENT OF
condition. The row to be deleted is the one most recently fetched from this cursor. The cursor must be a non-grouping query on the
**DELETE**s target table. Note that
WHERE CURRENT OF
cannot be specified together with a Boolean condition. See
**DECLARE**(7)
for more information about using cursors with
WHERE CURRENT OF.

_output\_expression_
An expression to be computed and returned by the
**DELETE**
command after each row is deleted. The expression can use any column names of the table named by
_table\_name_
or table(s) listed in
USING. Write
*
to return all columns.

_output\_name_
A name to use for a returned column.

<a name="outputs"></a>

# Outputs


On successful completion, a
**DELETE**
command returns a command tag of the form

.if n \{.RS 4
.\}
    DELETE count
.if n \{.RE
.\}

The
_count_
is the number of rows deleted. Note that the number may be less than the number of rows that matched the
_condition_
when deletes were suppressed by a
BEFORE DELETE
trigger. If
_count_
is 0, no rows were deleted by the query (this is not considered an error).

If the
**DELETE**
command contains a
RETURNING
clause, the result will be similar to that of a
**SELECT**
statement containing the columns and values defined in the
RETURNING
list, computed over the row(s) deleted by the command.

<a name="notes"></a>

# Notes


PostgreSQL
lets you reference columns of other tables in the
WHERE
condition by specifying the other tables in the
USING
clause. For example, to delete all films produced by a given producer, one can do:

.if n \{.RS 4
.\}
    DELETE FROM films USING producers
      WHERE producer_id = producers.id AND producers.name = foo*(Aq;
.if n \{.RE
.\}

What is essentially happening here is a join between
films
and
producers, with all successfully joined
films
rows being marked for deletion. This syntax is not standard. A more standard way to do it is:

.if n \{.RS 4
.\}
    DELETE FROM films
      WHERE producer_id IN (SELECT id FROM producers WHERE name = foo*(Aq);
.if n \{.RE
.\}

In some cases the join style is easier to write or faster to execute than the sub-select style.

<a name="examples"></a>

# Examples


Delete all films but musicals:

.if n \{.RS 4
.\}
    DELETE FROM films WHERE kind <> Musical*(Aq;
.if n \{.RE
.\}

Clear the table
films:

.if n \{.RS 4
.\}
    DELETE FROM films;
.if n \{.RE
.\}

Delete completed tasks, returning full details of the deleted rows:

.if n \{.RS 4
.\}
    DELETE FROM tasks WHERE status = DONE*(Aq RETURNING *;
.if n \{.RE
.\}

Delete the row of
tasks
on which the cursor
c_tasks
is currently positioned:

.if n \{.RS 4
.\}
    DELETE FROM tasks WHERE CURRENT OF c_tasks;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


This command conforms to the
SQL
standard, except that the
USING
and
RETURNING
clauses are
PostgreSQL
extensions, as is the ability to use
WITH
with
**DELETE**.

<a name="see-also"></a>

# See Also

**TRUNCATE**(7)
