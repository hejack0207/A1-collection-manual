# create access method(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_ACCESS_METHOD - define a new access method

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE ACCESS METHOD name
        TYPE access_method_type
        HANDLER handler_function

<a name="description"></a>

# Description


**CREATE ACCESS METHOD**
creates a new access method.

The access method name must be unique within the database.

Only superusers can define new access methods.

<a name="parameters"></a>

# Parameters


_name_
The name of the access method to be created.

_access\_method\_type_
This clause specifies the type of access method to define. Only
TABLE
and
INDEX
are supported at present.

_handler\_function_
_handler\_function_
is the name (possibly schema-qualified) of a previously registered function that represents the access method. The handler function must be declared to take a single argument of type
internal, and its return type depends on the type of access method; for
TABLE
access methods, it must be
table_am_handler
and for
INDEX
access methods, it must be
index_am_handler. The C-level API that the handler function must implement varies depending on the type of access method. The table access method API is described in
Chapter&nbsp;60
and the index access method API is described in
Chapter&nbsp;61.

<a name="examples"></a>

# Examples


Create an index access method
heptree
with handler function
heptree_handler:

.if n \{.RS 4
.\}
    CREATE ACCESS METHOD heptree TYPE INDEX HANDLER heptree_handler;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


**CREATE ACCESS METHOD**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

DROP ACCESS METHOD (**DROP\_ACCESS\_METHOD**(7)), CREATE OPERATOR CLASS (**CREATE\_OPERATOR\_CLASS**(7)), CREATE OPERATOR FAMILY (**CREATE\_OPERATOR\_FAMILY**(7))
