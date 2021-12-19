# ausearch-expression(5) - audit search expression format

Red Hat, Feb 2008


<a name="overview"></a>

# Overview

This man page describes the format of "ausearch expressions".
Parsing and evaluation of these expressions is provided by libauparse
and is common to applications that use this library.


<a name="lexical-structure"></a>

# Lexical Structure


White space (ASCII space, tab and new-line characters) between tokens is
ignored.
The following tokens are recognized:


* Punctuation  
  **( ) \e**
  
* Logical operators  
  **! && ||**
  
* Comparison operators  
  **&lt; &lt;= == &gt; &gt;= !== i= i!= r= r!=**
  
* Unquoted strings  
  Any non-empty sequence of ASCII letters, digits, and the
  **_**
  symbol.
  
* Quoted strings  
  A sequence of characters surrounded by the
  **"**
  quotes.
  The
  **\e**
  character starts an escape sequence.
  The only defined escape sequences are
  **\e\e**
  and **\e"**.
  The semantics of other escape sequences is undefined.
  
* Regexps  
  A sequence of characters surrounded by the
  **/**
  characters.
  The
  **\e**
  character starts an escape sequence.
  The only defined escape sequences are
  **\e\e**
  and **\e/**.
  The semantics of other escape sequences is undefined.
  

Anywhere an unquoted string is valid, a quoted string is valid as well,
and vice versa.
In particular, field names may be specified using quoted strings,
and field values may be specified using unquoted strings.


<a name="expression-syntax"></a>

# Expression Syntax


The primary expression has one of the following forms:

* _field comparison-operator value_
  
  **\eregexp**
  _string-or-regexp_


_field_
is either a string,
which specifies the first field with that name within the current audit record,
or the
**\e**
escape character followed by a string,
which specifies a virtual field with the specified name
(virtual fields are defined in a later section).

_field_
is a string.
_operator_
specifies the comparison to perform


* **r= r!=**  
  Get the "raw" string of _field_,
  and compare it to _value_.
  For fields in audit records,
  the "raw" string is the exact string stored in the audit record
  (with all escaping and unprintable character encoding left alone);
  applications can read the "raw" string using
  **auparse_get_field_str**(3).
  Each virtual field may define a "raw" string.
  If
  _field_
  is not present or does not define a "raw" string,
  the result of the comparison is
  **false**
  (regardless of the operator).
  
* **i= i!=**  
  Get the "interpreted" string of _field_,
  and compare it to _value_.
  For fields in audit records,
  the "interpreted" string is an "user-readable" interpretation of the field
  value;
  applications can read the "interpreted" string using
  **auparse_interpret_field**(3).
  Each virtual field may define an "interpreted" string.
  If
  _field_
  is not present or does not define an "interpreted" string,
  the result of the comparison is
  **false**
  (regardless of the operator).
  
* **&lt; &lt;= == &gt; &gt;= !==**  
  Evaluate the "value" of _field_, and compare it to _value_.
  A "value" may be defined for any field or virtual field,
  but no "value" is currently defined for any audit record field.
  The rules of parsing _value_ for comparing it with the "value" of
  _field_
  are specific for each _field_.
  If
  _field_
  is not present,
  the result of the comparison is
  **false**
  (regardless of the operator).
  If
  _field_
  does not define a "value", an error is reported when parsing the expression.


In the special case of
**\eregexp**
_regexp-or-string_,
the current audit record is taken as a string
(without interpreting field values),
and matched against _regexp-or-string_.
_regexp-or-string_
is an extended regular expression, using a string or regexp token
(in other words, delimited by
**"**
or **/**).

If
_E1_
and
_E2_
are valid expressions,
then
**!**
_E1_,
_E1_
**&&**
_E2_, and
_E1_
**||**
_E2_
are valid expressions as well, with the usual C semantics and evaluation
priorities.
Note that
**!**
_field op value_
is interpreted as **!(field op value)**, not as
**(!field) op value**.


<a name="virtual-fields"></a>

# Virtual Fields


The following virtual fields are defined:


* **\etimestamp**  
  The value is the timestamp of the current event.
  _value_
  must be formatted as:

.in +5
    .na
    ts:seconds.milli
    .ad
.in -5

where
_seconds_
and
_milli_
are decimal numbers specifying the seconds and milliseconds part of the
timestamp, respectively.


* **\etimestamp_ex**  
  This is similar to
  **\etimestamp**
  but also includes the event's serial number.
  _value_
  must be formatted as:

.in +5
    .na
    ts:seconds.milli:serial
    .ad
.in -5

where
_serial_
is a decimal number specifying the event's serial number.


* **\erecord_type**  
  The value is the type of the current record.
  _value_
  is either the record type name, or a decimal number specifying the type.
  

<a name="semantics"></a>

# Semantics

The expression as a whole applies to a single record.
The expression is
**true**
for a specified event if it is
**true**
for any record associated with the event.


<a name="examples"></a>

# Examples


As a demonstration of the semantics of handling missing fields, the following
expression is
**true**
if
_field_
is present:

* **(field r= "") || (field r!= "")**

and the same expression surrounded by
**!(**
and
**)**
is
**true**
if
_field_
is not present.


<a name="future-directions"></a>

# Future Directions

New escape sequences for quoted strings may be defined.

For currently defined virtual fields that do not define a "raw" or
"interpreted" string, the definition may be added.
Therefore, don't rely on the fact
that comparing the "raw" or "interpreted" string of the field with any value
is **false**.

New formats of value constants for the
**\etimestamp**
virtual field may be added.


<a name="author"></a>

# Author

Miloslav Trmac
