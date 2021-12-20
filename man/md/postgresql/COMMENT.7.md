# comment(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

COMMENT - define or change the comment of an object

<a name="synopsis"></a>

# Synopsis

```


```
    COMMENT ON
    {
      ACCESS METHOD object_name |
      AGGREGATE aggregate_name ( aggregate_signature ) |
      CAST (source_type AS target_type) |
      COLLATION object_name |
      COLUMN relation_name.column_name |
      CONSTRAINT constraint_name ON table_name |
      CONSTRAINT constraint_name ON DOMAIN domain_name |
      CONVERSION object_name |
      DATABASE object_name |
      DOMAIN object_name |
      EXTENSION object_name |
      EVENT TRIGGER object_name |
      FOREIGN DATA WRAPPER object_name |
      FOREIGN TABLE object_name |
      FUNCTION function_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
      INDEX object_name |
      LARGE OBJECT large_object_oid |
      MATERIALIZED VIEW object_name |
      OPERATOR operator_name (left_type, right_type) |
      OPERATOR CLASS object_name USING index_method |
      OPERATOR FAMILY object_name USING index_method |
      POLICY policy_name ON table_name |
      [ PROCEDURAL ] LANGUAGE object_name |
      PROCEDURE procedure_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
      PUBLICATION object_name |
      ROLE object_name |
      ROUTINE routine_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
      RULE rule_name ON table_name |
      SCHEMA object_name |
      SEQUENCE object_name |
      SERVER object_name |
      STATISTICS object_name |
      SUBSCRIPTION object_name |
      TABLE object_name |
      TABLESPACE object_name |
      TEXT SEARCH CONFIGURATION object_name |
      TEXT SEARCH DICTIONARY object_name |
      TEXT SEARCH PARSER object_name |
      TEXT SEARCH TEMPLATE object_name |
      TRANSFORM FOR type_name LANGUAGE lang_name |
      TRIGGER trigger_name ON table_name |
      TYPE object_name |
      VIEW object_name
    } IS text*(Aq
    
    where aggregate_signature is:
    
    * |
    [ argmode ] [ argname ] argtype [ , ... ] |
    [ [ argmode ] [ argname ] argtype [ , ... ] ] ORDER BY [ argmode ] [ argname ] argtype [ , ... ]

<a name="description"></a>

# Description


**COMMENT**
stores a comment about a database object.

Only one comment string is stored for each object, so to modify a comment, issue a new
**COMMENT**
command for the same object. To remove a comment, write
NULL
in place of the text string. Comments are automatically dropped when their object is dropped.

For most kinds of object, only the objects owner can set the comment. Roles don\*(Aqt have owners, so the rule for
COMMENT ON ROLE
is that you must be superuser to comment on a superuser role, or have the
CREATEROLE
privilege to comment on non-superuser roles. Likewise, access methods dont have owners either; you must be superuser to comment on an access method. Of course, a superuser can comment on anything.

Comments can be viewed using
psqls
**\ed**
family of commands. Other user interfaces to retrieve comments can be built atop the same built-in functions that
psql
uses, namely
**obj\_description**,
**col\_description**, and
**shobj\_description**
(see
Table&nbsp;9.73).

<a name="parameters"></a>

# Parameters


_object\_name_  
_relation\_name_._column\_name_  
_aggregate\_name_  
_constraint\_name_  
_function\_name_  
_operator\_name_  
_policy\_name_  
_procedure\_name_  
_routine\_name_  
_rule\_name_  
_trigger\_name_
The name of the object to be commented. Names of tables, aggregates, collations, conversions, domains, foreign tables, functions, indexes, operators, operator classes, operator families, procedures, routines, sequences, statistics, text search objects, types, and views can be schema-qualified. When commenting on a column,
_relation\_name_
must refer to a table, view, composite type, or foreign table.

_table\_name_  
_domain\_name_
When creating a comment on a constraint, a trigger, a rule or a policy these parameters specify the name of the table or domain on which that object is defined.

_source\_type_
The name of the source data type of the cast.

_target\_type_
The name of the target data type of the cast.

_argmode_
The mode of a function, procedure, or aggregate argument:
IN,
OUT,
INOUT, or
VARIADIC. If omitted, the default is
IN. Note that
**COMMENT**
does not actually pay any attention to
OUT
arguments, since only the input arguments are needed to determine the functions identity. So it is sufficient to list the
IN,
INOUT, and
VARIADIC
arguments.

_argname_
The name of a function, procedure, or aggregate argument. Note that
**COMMENT**
does not actually pay any attention to argument names, since only the argument data types are needed to determine the functions identity.

_argtype_
The data type of a function, procedure, or aggregate argument.

_large\_object\_oid_
The OID of the large object.

_left\_type_  
_right\_type_
The data type(s) of the operators arguments (optionally schema-qualified). Write
NONE
for the missing argument of a prefix or postfix operator.

PROCEDURAL
This is a noise word.

_type\_name_
The name of the data type of the transform.

_lang\_name_
The name of the language of the transform.

_text_
The new comment, written as a string literal; or
NULL
to drop the comment.

<a name="notes"></a>

# Notes


There is presently no security mechanism for viewing comments: any user connected to a database can see all the comments for objects in that database. For shared objects such as databases, roles, and tablespaces, comments are stored globally so any user connected to any database in the cluster can see all the comments for shared objects. Therefore, dont put security-critical information in comments.

<a name="examples"></a>

# Examples


Attach a comment to the table
mytable:

.if n \{.RS 4
.\}
    COMMENT ON TABLE mytable IS This is my table.*(Aq;
.if n \{.RE
.\}

Remove it again:

.if n \{.RS 4
.\}
    COMMENT ON TABLE mytable IS NULL;
.if n \{.RE
.\}

Some more examples:

.if n \{.RS 4
.\}
    COMMENT ON ACCESS METHOD gin IS GIN index access method*(Aq;
    COMMENT ON AGGREGATE my_aggregate (double precision) IS Computes sample variance*(Aq;
    COMMENT ON CAST (text AS int4) IS Allow casts from text to int4*(Aq;
    COMMENT ON COLLATION "fr_CA" IS Canadian French*(Aq;
    COMMENT ON COLUMN my_table.my_column IS Employee ID number*(Aq;
    COMMENT ON CONVERSION my_conv IS Conversion to UTF8*(Aq;
    COMMENT ON CONSTRAINT bar_col_cons ON bar IS Constrains column col*(Aq;
    COMMENT ON CONSTRAINT dom_col_constr ON DOMAIN dom IS Constrains col of domain*(Aq;
    COMMENT ON DATABASE my_database IS Development Database*(Aq;
    COMMENT ON DOMAIN my_domain IS Email Address Domain*(Aq;
    COMMENT ON EVENT TRIGGER abort_ddl IS Aborts all DDL commands*(Aq;
    COMMENT ON EXTENSION hstore IS implements the hstore data type*(Aq;
    COMMENT ON FOREIGN DATA WRAPPER mywrapper IS my foreign data wrapper*(Aq;
    COMMENT ON FOREIGN TABLE my_foreign_table IS Employee Information in other database*(Aq;
    COMMENT ON FUNCTION my_function (timestamp) IS Returns Roman Numeral*(Aq;
    COMMENT ON INDEX my_index IS Enforces uniqueness on employee ID*(Aq;
    COMMENT ON LANGUAGE plpython IS Python support for stored procedures*(Aq;
    COMMENT ON LARGE OBJECT 346344 IS Planning document*(Aq;
    COMMENT ON MATERIALIZED VIEW my_matview IS Summary of order history*(Aq;
    COMMENT ON OPERATOR ^ (text, text) IS Performs intersection of two texts*(Aq;
    COMMENT ON OPERATOR - (NONE, integer) IS Unary minus*(Aq;
    COMMENT ON OPERATOR CLASS int4ops USING btree IS 4 byte integer operators for btrees*(Aq;
    COMMENT ON OPERATOR FAMILY integer_ops USING btree IS all integer operators for btrees*(Aq;
    COMMENT ON POLICY my_policy ON mytable IS Filter rows by users*(Aq;
    COMMENT ON PROCEDURE my_proc (integer, integer) IS Runs a report*(Aq;
    COMMENT ON PUBLICATION alltables IS Publishes all operations on all tables*(Aq;
    COMMENT ON ROLE my_role IS Administration group for finance tables*(Aq;
    COMMENT ON ROUTINE my_routine (integer, integer) IS Runs a routine (which is a function or procedure)*(Aq;
    COMMENT ON RULE my_rule ON my_table IS Logs updates of employee records*(Aq;
    COMMENT ON SCHEMA my_schema IS Departmental data*(Aq;
    COMMENT ON SEQUENCE my_sequence IS Used to generate primary keys*(Aq;
    COMMENT ON SERVER myserver IS my foreign server*(Aq;
    COMMENT ON STATISTICS my_statistics IS Improves planner row estimations*(Aq;
    COMMENT ON SUBSCRIPTION alltables IS Subscription for all operations on all tables*(Aq;
    COMMENT ON TABLE my_schema.my_table IS Employee Information*(Aq;
    COMMENT ON TABLESPACE my_tablespace IS Tablespace for indexes*(Aq;
    COMMENT ON TEXT SEARCH CONFIGURATION my_config IS Special word filtering*(Aq;
    COMMENT ON TEXT SEARCH DICTIONARY swedish IS Snowball stemmer for Swedish language*(Aq;
    COMMENT ON TEXT SEARCH PARSER my_parser IS Splits text into words*(Aq;
    COMMENT ON TEXT SEARCH TEMPLATE snowball IS Snowball stemmer*(Aq;
    COMMENT ON TRANSFORM FOR hstore LANGUAGE plpythonu IS Transform between hstore and Python dict*(Aq;
    COMMENT ON TRIGGER my_trigger ON my_table IS Used for RI*(Aq;
    COMMENT ON TYPE complex IS Complex number data type*(Aq;
    COMMENT ON VIEW my_view IS View of departmental costs*(Aq;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**COMMENT**
command in the SQL standard.
