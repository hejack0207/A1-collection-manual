# alter operator(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_OPERATOR - change the definition of an operator

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER OPERATOR name ( { left_type | NONE } , { right_type | NONE } )
        OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    
    ALTER OPERATOR name ( { left_type | NONE } , { right_type | NONE } )
        SET SCHEMA new_schema
    
    ALTER OPERATOR name ( { left_type | NONE } , { right_type | NONE } )
        SET ( {  RESTRICT = { res_proc | NONE }
               | JOIN = { join_proc | NONE }
             } [, ... ] )

<a name="description"></a>

# Description


**ALTER OPERATOR**
changes the definition of an operator.

You must own the operator to use
**ALTER OPERATOR**. To alter the owner, you must also be a direct or indirect member of the new owning role, and that role must have
CREATE
privilege on the operators schema. (These restrictions enforce that altering the owner doesn\*(Aqt do anything you couldn\*(Aqt do by dropping and recreating the operator. However, a superuser can alter ownership of any operator anyway.)

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing operator.

_left\_type_
The data type of the operators left operand; write
NONE
if the operator has no left operand.

_right\_type_
The data type of the operators right operand; write
NONE
if the operator has no right operand.

_new\_owner_
The new owner of the operator.

_new\_schema_
The new schema for the operator.

_res\_proc_
The restriction selectivity estimator function for this operator; write NONE to remove existing selectivity estimator.

_join\_proc_
The join selectivity estimator function for this operator; write NONE to remove existing selectivity estimator.

<a name="examples"></a>

# Examples


Change the owner of a custom operator
a @@ b
for type
text:

.if n \{.RS 4
.\}
    ALTER OPERATOR @@ (text, text) OWNER TO joe;
.if n \{.RE
.\}

Change the restriction and join selectivity estimator functions of a custom operator
a && b
for type
int[]:

.if n \{.RS 4
.\}
    ALTER OPERATOR && (_int4, _int4) SET (RESTRICT = _int_contsel, JOIN = _int_contjoinsel);
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER OPERATOR**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE OPERATOR (**CREATE\_OPERATOR**(7)), DROP OPERATOR (**DROP\_OPERATOR**(7))
