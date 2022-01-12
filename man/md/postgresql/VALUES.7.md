# values(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

VALUES - compute a set of rows

<a name="synopsis"></a>

# Synopsis

```


```
    VALUES ( expression [, ...] ) [, ...]
        [ ORDER BY sort_expression [ ASC | DESC | USING operator ] [, ...] ]
        [ LIMIT { count | ALL } ]
        [ OFFSET start [ ROW | ROWS ] ]
        [ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]

<a name="description"></a>

# Description


**VALUES**
computes a row value or set of row values specified by value expressions. It is most commonly used to generate a
“constant table”
within a larger command, but it can be used on its own.

When more than one row is specified, all the rows must have the same number of elements. The data types of the resulting tables columns are determined by combining the explicit or inferred types of the expressions appearing in that column, using the same rules as for
UNION
(see
Section&nbsp;10.5).

Within larger commands,
**VALUES**
is syntactically allowed anywhere that
**SELECT**
is. Because it is treated like a
**SELECT**
by the grammar, it is possible to use the
ORDER BY,
LIMIT
(or equivalently
FETCH FIRST), and
OFFSET
clauses with a
**VALUES**
command.

<a name="parameters"></a>

# Parameters


_expression_
A constant or expression to compute and insert at the indicated place in the resulting table (set of rows). In a
**VALUES**
list appearing at the top level of an
**INSERT**, an
_expression_
can be replaced by
DEFAULT
to indicate that the destination columns default value should be inserted.
DEFAULT
cannot be used when
**VALUES**
appears in other contexts.

_sort\_expression_
An expression or integer constant indicating how to sort the result rows. This expression can refer to the columns of the
**VALUES**
result as
column1,
column2, etc. For more details see
ORDER BY Clause.

_operator_
A sorting operator. For details see
ORDER BY Clause.

_count_
The maximum number of rows to return. For details see
LIMIT Clause.

_start_
The number of rows to skip before starting to return rows. For details see
LIMIT Clause.

<a name="notes"></a>

# Notes


**VALUES**
lists with very large numbers of rows should be avoided, as you might encounter out-of-memory failures or poor performance.
**VALUES**
appearing within
**INSERT**
is a special case (because the desired column types are known from the
**INSERT**s target table, and need not be inferred by scanning the
**VALUES**
list), so it can handle larger lists than are practical in other contexts.

<a name="examples"></a>

# Examples


A bare
**VALUES**
command:

.if n \{.RS 4
.\}
    VALUES (1, one*(Aq), (2, *(Aqtwo*(Aq), (3, *(Aqthree*(Aq);
.if n \{.RE
.\}

This will return a table of two columns and three rows. Its effectively equivalent to:

.if n \{.RS 4
.\}
    SELECT 1 AS column1, one*(Aq AS column2
    UNION ALL
    SELECT 2, two*(Aq
    UNION ALL
    SELECT 3, three*(Aq;
.if n \{.RE
.\}

More usually,
**VALUES**
is used within a larger SQL command. The most common use is in
**INSERT**:

.if n \{.RS 4
.\}
    INSERT INTO films (code, title, did, date_prod, kind)
        VALUES (T_601*(Aq, *(AqYojimbo*(Aq, 106, *(Aq1961-06-16*(Aq, *(AqDrama*(Aq);
.if n \{.RE
.\}

In the context of
**INSERT**, entries of a
**VALUES**
list can be
DEFAULT
to indicate that the column default should be used here instead of specifying a value:

.if n \{.RS 4
.\}
    INSERT INTO films VALUES
        (UA502*(Aq, *(AqBananas*(Aq, 105, DEFAULT, *(AqComedy*(Aq, *(Aq82 minutes*(Aq),
        (T_601*(Aq, *(AqYojimbo*(Aq, 106, DEFAULT, *(AqDrama*(Aq, DEFAULT);
.if n \{.RE
.\}

**VALUES**
can also be used where a sub-**SELECT**
might be written, for example in a
FROM
clause:

.if n \{.RS 4
.\}
    SELECT f.*
      FROM films f, (VALUES(MGM*(Aq, *(AqHorror*(Aq), (*(AqUA*(Aq, *(AqSci-Fi*(Aq)) AS t (studio, kind)
      WHERE f.studio = t.studio AND f.kind = t.kind;
    
    UPDATE employees SET salary = salary * v.increase
      FROM (VALUES(1, 200000, 1.2), (2, 400000, 1.4)) AS v (depno, target, increase)
      WHERE employees.depno = v.depno AND employees.sales >= v.target;
.if n \{.RE
.\}

Note that an
AS
clause is required when
**VALUES**
is used in a
FROM
clause, just as is true for
**SELECT**. It is not required that the
AS
clause specify names for all the columns, but its good practice to do so. (The default column names for
**VALUES**
are
column1,
column2, etc in
PostgreSQL, but these names might be different in other database systems.)

When
**VALUES**
is used in
**INSERT**, the values are all automatically coerced to the data type of the corresponding destination column. When its used in other contexts, it might be necessary to specify the correct data type. If the entries are all quoted literal constants, coercing the first is sufficient to determine the assumed type for all:

.if n \{.RS 4
.\}
    SELECT * FROM machines
    WHERE ip_address IN (VALUES(192.168.0.1*(Aq::inet), (*(Aq192.168.0.10*(Aq), (*(Aq192.168.1.43*(Aq));
.if n \{.RE
.\}
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Tip**
.ps -1  

For simple
IN
tests, its better to rely on the
list-of-scalars
form of
IN
than to write a
**VALUES**
query as shown above. The list of scalars method requires less writing and is often more efficient.


<a name="compatibility"></a>

# Compatibility


**VALUES**
conforms to the SQL standard.
LIMIT
and
OFFSET
are
PostgreSQL
extensions; see also under
**SELECT**(7).

<a name="see-also"></a>

# See Also

**INSERT**(7), **SELECT**(7)
