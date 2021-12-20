# create operator(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_OPERATOR - define a new operator

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE OPERATOR name (
        {FUNCTION|PROCEDURE} = function_name
        [, LEFTARG = left_type ] [, RIGHTARG = right_type ]
        [, COMMUTATOR = com_op ] [, NEGATOR = neg_op ]
        [, RESTRICT = res_proc ] [, JOIN = join_proc ]
        [, HASHES ] [, MERGES ]
    )

<a name="description"></a>

# Description


**CREATE OPERATOR**
defines a new operator,
_name_. The user who defines an operator becomes its owner. If a schema name is given then the operator is created in the specified schema. Otherwise it is created in the current schema.

The operator name is a sequence of up to
NAMEDATALEN-1 (63 by default) characters from the following list:

.if n \{.RS 4
.\}
    + - * / < > = ~ ! @ # % ^ & | ` ?
.if n \{.RE
.\}

There are a few restrictions on your choice of name:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  --
  and
  /*
  cannot appear anywhere in an operator name, since they will be taken as the start of a comment.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A multicharacter operator name cannot end in
  +
  or
  -, unless the name also contains at least one of these characters:

.if n \{.RS 4
.\}
    ~ ! @ # % ^ & | ` ?
.if n \{.RE
.\}

For example,
@-
is an allowed operator name, but
*-
is not. This restriction allows
PostgreSQL
to parse SQL-compliant commands without requiring spaces between tokens.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The use of
  =&gt;
  as an operator name is deprecated. It may be disallowed altogether in a future release.

The operator
!=
is mapped to
&lt;&gt;
on input, so these two names are always equivalent.

At least one of
LEFTARG
and
RIGHTARG
must be defined. For binary operators, both must be defined. For right unary operators, only
LEFTARG
should be defined, while for left unary operators only
RIGHTARG
should be defined.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

Right unary, also called postfix, operators are deprecated and will be removed in
PostgreSQL
version 14.


The
_function\_name_
function must have been previously defined using
**CREATE FUNCTION**
and must be defined to accept the correct number of arguments (either one or two) of the indicated types.

In the syntax of
CREATE OPERATOR, the keywords
FUNCTION
and
PROCEDURE
are equivalent, but the referenced function must in any case be a function, not a procedure. The use of the keyword
PROCEDURE
here is historical and deprecated.

The other clauses specify optional operator optimization clauses. Their meaning is detailed in
Section&nbsp;37.15.

To be able to create an operator, you must have
USAGE
privilege on the argument types and the return type, as well as
EXECUTE
privilege on the underlying function. If a commutator or negator operator is specified, you must own these operators.

<a name="parameters"></a>

# Parameters


_name_
The name of the operator to be defined. See above for allowable characters. The name can be schema-qualified, for example
CREATE OPERATOR myschema.+ (...). If not, then the operator is created in the current schema. Two operators in the same schema can have the same name if they operate on different data types. This is called
overloading.

_function\_name_
The function used to implement this operator.

_left\_type_
The data type of the operators left operand, if any. This option would be omitted for a left-unary operator.

_right\_type_
The data type of the operators right operand, if any. This option would be omitted for a right-unary operator.

_com\_op_
The commutator of this operator.

_neg\_op_
The negator of this operator.

_res\_proc_
The restriction selectivity estimator function for this operator.

_join\_proc_
The join selectivity estimator function for this operator.

HASHES
Indicates this operator can support a hash join.

MERGES
Indicates this operator can support a merge join.

To give a schema-qualified operator name in
_com\_op_
or the other optional arguments, use the
OPERATOR()
syntax, for example:

.if n \{.RS 4
.\}
    COMMUTATOR = OPERATOR(myschema.===) ,
.if n \{.RE
.\}

<a name="notes"></a>

# Notes


Refer to
Section&nbsp;37.14
for further information.

It is not possible to specify an operators lexical precedence in
**CREATE OPERATOR**, because the parsers precedence behavior is hard-wired. See
Section&nbsp;4.1.6
for precedence details.

The obsolete options
SORT1,
SORT2,
LTCMP, and
GTCMP
were formerly used to specify the names of sort operators associated with a merge-joinable operator. This is no longer necessary, since information about associated operators is found by looking at B-tree operator families instead. If one of these options is given, it is ignored except for implicitly setting
MERGES
true.

Use
DROP OPERATOR (**DROP\_OPERATOR**(7))
to delete user-defined operators from a database. Use
ALTER OPERATOR (**ALTER\_OPERATOR**(7))
to modify operators in a database.

<a name="examples"></a>

# Examples


The following command defines a new operator, area-equality, for the data type
box:

.if n \{.RS 4
.\}
    CREATE OPERATOR === (
        LEFTARG = box,
        RIGHTARG = box,
        FUNCTION = area_equal_function,
        COMMUTATOR = ===,
        NEGATOR = !==,
        RESTRICT = area_restriction_function,
        JOIN = area_join_function,
        HASHES, MERGES
    );
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CREATE OPERATOR**
is a
PostgreSQL
extension. There are no provisions for user-defined operators in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER OPERATOR (**ALTER\_OPERATOR**(7)), CREATE OPERATOR CLASS (**CREATE\_OPERATOR\_CLASS**(7)), DROP OPERATOR (**DROP\_OPERATOR**(7))
