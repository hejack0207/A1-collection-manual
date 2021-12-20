# create statistics(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_STATISTICS - define extended statistics

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE STATISTICS [ IF NOT EXISTS ] statistics_name
        [ ( statistics_kind [, ... ] ) ]
        ON column_name, column_name [, ...]
        FROM table_name

<a name="description"></a>

# Description


**CREATE STATISTICS**
will create a new extended statistics object tracking data about the specified table, foreign table or materialized view. The statistics object will be created in the current database and will be owned by the user issuing the command.

If a schema name is given (for example,
CREATE STATISTICS myschema.mystat ...) then the statistics object is created in the specified schema. Otherwise it is created in the current schema. The name of the statistics object must be distinct from the name of any other statistics object in the same schema.

<a name="parameters"></a>

# Parameters


IF NOT EXISTS
Do not throw an error if a statistics object with the same name already exists. A notice is issued in this case. Note that only the name of the statistics object is considered here, not the details of its definition.

_statistics\_name_
The name (optionally schema-qualified) of the statistics object to be created.

_statistics\_kind_
A statistics kind to be computed in this statistics object. Currently supported kinds are
ndistinct, which enables n-distinct statistics,
dependencies, which enables functional dependency statistics, and
mcv
which enables most-common values lists. If this clause is omitted, all supported statistics kinds are included in the statistics object. For more information, see
Section&nbsp;14.2.2
and
Section&nbsp;70.2.

_column\_name_
The name of a table column to be covered by the computed statistics. At least two column names must be given; the order of the column names is insignificant.

_table\_name_
The name (optionally schema-qualified) of the table containing the column(s) the statistics are computed on.

<a name="notes"></a>

# Notes


You must be the owner of a table to create a statistics object reading it. Once created, however, the ownership of the statistics object is independent of the underlying table(s).

<a name="examples"></a>

# Examples


Create table
t1
with two functionally dependent columns, i.e., knowledge of a value in the first column is sufficient for determining the value in the other column. Then functional dependency statistics are built on those columns:

.if n \{.RS 4
.\}
    CREATE TABLE t1 (
        a   int,
        b   int
    );
    
    INSERT INTO t1 SELECT i/100, i/500
                     FROM generate_series(1,1000000) s(i);
    
    ANALYZE t1;
    
    -- the number of matching rows will be drastically underestimated:
    EXPLAIN ANALYZE SELECT * FROM t1 WHERE (a = 1) AND (b = 0);
    
    CREATE STATISTICS s1 (dependencies) ON a, b FROM t1;
    
    ANALYZE t1;
    
    -- now the row count estimate is more accurate:
    EXPLAIN ANALYZE SELECT * FROM t1 WHERE (a = 1) AND (b = 0);
.if n \{.RE
.\}

Without functional-dependency statistics, the planner would assume that the two
WHERE
conditions are independent, and would multiply their selectivities together to arrive at a much-too-small row count estimate. With such statistics, the planner recognizes that the
WHERE
conditions are redundant and does not underestimate the row count.

Create table
t2
with two perfectly correlated columns (containing identical data), and a MCV list on those columns:

.if n \{.RS 4
.\}
    CREATE TABLE t2 (
        a   int,
        b   int
    );
    
    INSERT INTO t2 SELECT mod(i,100), mod(i,100)
                     FROM generate_series(1,1000000) s(i);
    
    CREATE STATISTICS s2 (mcv) ON a, b FROM t2;
    
    ANALYZE t2;
    
    -- valid combination (found in MCV)
    EXPLAIN ANALYZE SELECT * FROM t2 WHERE (a = 1) AND (b = 1);
    
    -- invalid combination (not found in MCV)
    EXPLAIN ANALYZE SELECT * FROM t2 WHERE (a = 1) AND (b = 2);
.if n \{.RE
.\}

The MCV list gives the planner more detailed information about the specific values that commonly appear in the table, as well as an upper bound on the selectivities of combinations of values that do not appear in the table, allowing it to generate better estimates in both cases.

<a name="compatibility"></a>

# Compatibility


There is no
**CREATE STATISTICS**
command in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER STATISTICS (**ALTER\_STATISTICS**(7)), DROP STATISTICS (**DROP\_STATISTICS**(7))
