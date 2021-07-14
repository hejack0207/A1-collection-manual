# git\-check\-attr(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-check-attr - Display gitattributes information

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git check-attr [-a | --all | <attr>...] [--] <pathname>...
    git check-attr --stdin [-z] [-a | --all | <attr>...]
<synopsis>


```

<a name="description"></a>

# Description


For every pathname, this command will list if each attribute is _unspecified_, _set_, or _unset_ as a gitattribute on that pathname.

<a name="options"></a>

# Options


-a, --all
List all attributes that are associated with the specified paths. If this option is used, then
_unspecified_
attributes will not be included in the output.

--cached
Consider
**.gitattributes**
in the index only, ignoring the working tree.

--stdin
Read pathnames from the standard input, one per line, instead of from the command-line.

-z
The output format is modified to be machine-parseable. If
**--stdin**
is also given, input paths are separated with a NUL character instead of a linefeed character.

--
Interpret all preceding arguments as attributes and all following arguments as path names.

If none of **--stdin**, **--all**, or **--** is used, the first argument will be treated as an attribute and the rest of the arguments as pathnames.

<a name="output"></a>

# Output


The output is of the form: &lt;path&gt; COLON SP &lt;attribute&gt; COLON SP &lt;info&gt; LF

unless **-z** is in effect, in which case NUL is used as delimiter: &lt;path&gt; NUL &lt;attribute&gt; NUL &lt;info&gt; NUL

&lt;path&gt; is the path of a file being queried, &lt;attribute&gt; is an attribute being queried and &lt;info&gt; can be either:

_unspecified_
when the attribute is not defined for the path.

_unset_
when the attribute is defined as false.

_set_
when the attribute is defined as true.

&lt;value&gt;
when a value has been assigned to the attribute.

Buffering happens as documented under the **GIT\_FLUSH** option in **git**(1). The caller is responsible for avoiding deadlocks caused by overfilling an input buffer or reading from an empty output buffer.

<a name="examples"></a>

# Examples


In the examples, the following _.gitattributes_ file is used:

.if n \{.RS 4
.\}
    *.java diff=java -crlf myAttr
    NoMyAttr.java !myAttr
    README caveat=unspecified
.if n \{.RE
.\}



.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Listing a single attribute:

.if n \{.RS 4
.\}
    $ git check-attr diff org/example/MyClass.java
    org/example/MyClass.java: diff: java
.if n \{.RE
.\}



.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Listing multiple attributes for a file:

.if n \{.RS 4
.\}
    $ git check-attr crlf diff myAttr -- org/example/MyClass.java
    org/example/MyClass.java: crlf: unset
    org/example/MyClass.java: diff: java
    org/example/MyClass.java: myAttr: set
.if n \{.RE
.\}



.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Listing all attributes for a file:

.if n \{.RS 4
.\}
    $ git check-attr --all -- org/example/MyClass.java
    org/example/MyClass.java: diff: java
    org/example/MyClass.java: myAttr: set
.if n \{.RE
.\}



.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Listing an attribute for multiple files:

.if n \{.RS 4
.\}
    $ git check-attr myAttr -- org/example/MyClass.java org/example/NoMyAttr.java
    org/example/MyClass.java: myAttr: set
    org/example/NoMyAttr.java: myAttr: unspecified
.if n \{.RE
.\}



.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Not all values are equally unambiguous:

.if n \{.RS 4
.\}
    $ git check-attr caveat README
    README: caveat: unspecified
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**gitattributes**(5).

<a name="git"></a>

# Git


Part of the **git**(1) suite
