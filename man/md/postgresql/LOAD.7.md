# load(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

LOAD - load a shared library file

<a name="synopsis"></a>

# Synopsis

```


```
    LOAD filename*(Aq

<a name="description"></a>

# Description


This command loads a shared library file into the
PostgreSQL
servers address space. If the file has been loaded already, the command does nothing. Shared library files that contain C functions are automatically loaded whenever one of their functions is called. Therefore, an explicit
**LOAD**
is usually only needed to load a library that modifies the servers behavior through
“hooks”
rather than providing a set of functions.

The library file name is typically given as just a bare file name, which is sought in the servers library search path (set by
dynamic_library_path). Alternatively it can be given as a full path name. In either case the platforms standard shared library file name extension may be omitted. See
Section&nbsp;37.10.1
for more information on this topic.

Non-superusers can only apply
**LOAD**
to library files located in
$libdir/plugins/
— the specified
_filename_
must begin with exactly that string. (It is the database administrators responsibility to ensure that only
“safe”
libraries are installed there.)

<a name="compatibility"></a>

# Compatibility


**LOAD**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also


CREATE FUNCTION (**CREATE\_FUNCTION**(7))
