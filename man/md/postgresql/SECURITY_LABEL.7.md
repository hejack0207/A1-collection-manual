# security label(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

SECURITY_LABEL - define or change a security label applied to an object

<a name="synopsis"></a>

# Synopsis

```


```
    SECURITY LABEL [ FOR provider ] ON
    {
      TABLE object_name |
      COLUMN table_name.column_name |
      AGGREGATE aggregate_name ( aggregate_signature ) |
      DATABASE object_name |
      DOMAIN object_name |
      EVENT TRIGGER object_name |
      FOREIGN TABLE object_name
      FUNCTION function_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
      LARGE OBJECT large_object_oid |
      MATERIALIZED VIEW object_name |
      [ PROCEDURAL ] LANGUAGE object_name |
      PROCEDURE procedure_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
      PUBLICATION object_name |
      ROLE object_name |
      ROUTINE routine_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
      SCHEMA object_name |
      SEQUENCE object_name |
      SUBSCRIPTION object_name |
      TABLESPACE object_name |
      TYPE object_name |
      VIEW object_name
    } IS label*(Aq
    
    where aggregate_signature is:
    
    * |
    [ argmode ] [ argname ] argtype [ , ... ] |
    [ [ argmode ] [ argname ] argtype [ , ... ] ] ORDER BY [ argmode ] [ argname ] argtype [ , ... ]

<a name="description"></a>

# Description


**SECURITY LABEL**
applies a security label to a database object. An arbitrary number of security labels, one per label provider, can be associated with a given database object. Label providers are loadable modules which register themselves by using the function
**register\_label\_provider**.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

**register\_label\_provider**
is not an SQL function; it can only be called from C code loaded into the backend.


The label provider determines whether a given label is valid and whether it is permissible to assign that label to a given object. The meaning of a given label is likewise at the discretion of the label provider.
PostgreSQL
places no restrictions on whether or how a label provider must interpret security labels; it merely provides a mechanism for storing them. In practice, this facility is intended to allow integration with label-based mandatory access control (MAC) systems such as
SELinux. Such systems make all access control decisions based on object labels, rather than traditional discretionary access control (DAC) concepts such as users and groups.

<a name="parameters"></a>

# Parameters


_object\_name_  
_table\_name.column\_name_  
_aggregate\_name_  
_function\_name_  
_procedure\_name_  
_routine\_name_
The name of the object to be labeled. Names of tables, aggregates, domains, foreign tables, functions, procedures, routines, sequences, types, and views can be schema-qualified.

_provider_
The name of the provider with which this label is to be associated. The named provider must be loaded and must consent to the proposed labeling operation. If exactly one provider is loaded, the provider name may be omitted for brevity.

_argmode_
The mode of a function, procedure, or aggregate argument:
IN,
OUT,
INOUT, or
VARIADIC. If omitted, the default is
IN. Note that
**SECURITY LABEL**
does not actually pay any attention to
OUT
arguments, since only the input arguments are needed to determine the functions identity. So it is sufficient to list the
IN,
INOUT, and
VARIADIC
arguments.

_argname_
The name of a function, procedure, or aggregate argument. Note that
**SECURITY LABEL**
does not actually pay any attention to argument names, since only the argument data types are needed to determine the functions identity.

_argtype_
The data type of a function, procedure, or aggregate argument.

_large\_object\_oid_
The OID of the large object.

PROCEDURAL
This is a noise word.

_label_
The new security label, written as a string literal; or
NULL
to drop the security label.

<a name="examples"></a>

# Examples


The following example shows how the security label of a table might be changed.

.if n \{.RS 4
.\}
    SECURITY LABEL FOR selinux ON TABLE mytable IS system_u:object_r:sepgsql_table_t:s0*(Aq;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**SECURITY LABEL**
command in the SQL standard.

<a name="see-also"></a>

# See Also

sepgsql, src/test/modules/dummy_seclabel
