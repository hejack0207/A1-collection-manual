# drop language(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_LANGUAGE - remove a procedural language

<a name="synopsis"></a>

# Synopsis

```


```
    DROP [ PROCEDURAL ] LANGUAGE [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP LANGUAGE**
removes the definition of a previously registered procedural language. You must be a superuser or the owner of the language to use
**DROP LANGUAGE**.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

As of
PostgreSQL
9.1, most procedural languages have been made into
“extensions”, and should therefore be removed with
DROP EXTENSION (**DROP\_EXTENSION**(7))
not
**DROP LANGUAGE**.


<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the language does not exist. A notice is issued in this case.

_name_
The name of an existing procedural language. For backward compatibility, the name can be enclosed by single quotes.

CASCADE
Automatically drop objects that depend on the language (such as functions in the language), and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the language if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


This command removes the procedural language
plsample:

.if n \{.RS 4
.\}
    DROP LANGUAGE plsample;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**DROP LANGUAGE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER LANGUAGE (**ALTER\_LANGUAGE**(7)), CREATE LANGUAGE (**CREATE\_LANGUAGE**(7))
