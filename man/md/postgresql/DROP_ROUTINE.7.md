# drop routine(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_ROUTINE - remove a routine

<a name="synopsis"></a>

# Synopsis

```


```
    DROP ROUTINE [ IF EXISTS ] name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] [, ...]
        [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP ROUTINE**
removes the definition of an existing routine, which can be an aggregate function, a normal function, or a procedure. See under
DROP AGGREGATE (**DROP\_AGGREGATE**(7)),
DROP FUNCTION (**DROP\_FUNCTION**(7)), and
DROP PROCEDURE (**DROP\_PROCEDURE**(7))
for the description of the parameters, more examples, and further details.

<a name="examples"></a>

# Examples


To drop the routine
foo
for type
integer:

.if n \{.RS 4
.\}
    DROP ROUTINE foo(integer);
.if n \{.RE
.\}

This command will work independent of whether
foo
is an aggregate, function, or procedure.

<a name="compatibility"></a>

# Compatibility


This command conforms to the SQL standard, with these
PostgreSQL
extensions:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The standard only allows one routine to be dropped per command.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The
  IF EXISTS
  option

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The ability to specify argument modes and names

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Aggregate functions are an extension.


<a name="see-also"></a>

# See Also

DROP AGGREGATE (**DROP\_AGGREGATE**(7)), DROP FUNCTION (**DROP\_FUNCTION**(7)), DROP PROCEDURE (**DROP\_PROCEDURE**(7)), ALTER ROUTINE (**ALTER\_ROUTINE**(7))

Note that there is no
CREATE ROUTINE
command.
