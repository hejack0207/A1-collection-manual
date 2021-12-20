# move(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

MOVE - position a cursor

<a name="synopsis"></a>

# Synopsis

```


```
    MOVE [ direction [ FROM | IN ] ] cursor_name
    
    where direction can be empty or one of:
    
        NEXT
        PRIOR
        FIRST
        LAST
        ABSOLUTE count
        RELATIVE count
        count
        ALL
        FORWARD
        FORWARD count
        FORWARD ALL
        BACKWARD
        BACKWARD count
        BACKWARD ALL

<a name="description"></a>

# Description


**MOVE**
repositions a cursor without retrieving any data.
**MOVE**
works exactly like the
**FETCH**
command, except it only positions the cursor and does not return rows.

The parameters for the
**MOVE**
command are identical to those of the
**FETCH**
command; refer to
**FETCH**(7)
for details on syntax and usage.

<a name="outputs"></a>

# Outputs


On successful completion, a
**MOVE**
command returns a command tag of the form

.if n \{.RS 4
.\}
    MOVE count
.if n \{.RE
.\}

The
_count_
is the number of rows that a
**FETCH**
command with the same parameters would have returned (possibly zero).

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    BEGIN WORK;
    DECLARE liahona CURSOR FOR SELECT * FROM films;
    
    -- Skip the first 5 rows:
    MOVE FORWARD 5 IN liahona;
    MOVE 5
    
    -- Fetch the 6th row from the cursor liahona:
    FETCH 1 FROM liahona;
     code  | title  | did | date_prod  |  kind  |  len
    -------+--------+-----+------------+--------+-------
     P_303 | 48 Hrs | 103 | 1982-10-22 | Action | 01:37
    (1 row)
    
    -- Close the cursor liahona and end the transaction:
    CLOSE liahona;
    COMMIT WORK;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**MOVE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

**CLOSE**(7), **DECLARE**(7), **FETCH**(7)
