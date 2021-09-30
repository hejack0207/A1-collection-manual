# named\-checkconf(8)

ISC, 2014\-01\-10

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

named-checkconf - named configuration file syntax checking tool

<a name="synopsis"></a>

# Synopsis

```
.HP \w'named-checkconf&nbsp;'u named-checkconf [-hjvz] [-p&nbsp;[-x&nbsp;]] [-t&nbsp;directory] {filename}
```

<a name="description"></a>

# Description


**named-checkconf**
checks the syntax, but not the semantics, of a
**named**
configuration file. The file is parsed and checked for syntax errors, along with all files included by it. If no file is specified,
/etc/named.conf
is read by default.

Note: files that
**named**
reads in separate parser contexts, such as
rndc.key
and
bind.keys, are not automatically read by
**named-checkconf**. Configuration errors in these files may cause
**named**
to fail to run, even if
**named-checkconf**
was successful.
**named-checkconf**
can be run on these files explicitly, however.

<a name="options"></a>

# Options


-h
Print the usage summary and exit.

-j
When loading a zonefile read the journal if it exists.

-p
Print out the
named.conf
and included files in canonical form if no errors were detected. See also the
**-x**
option.

-t _directory_
Chroot to
directory
so that include directives in the configuration file are processed as if run by a similarly chrooted
**named**.

-v
Print the version of the
**named-checkconf**
program and exit.

-x
When printing the configuration files in canonical form, obscure shared secrets by replacing them with strings of question marks (?\*(Aq). This allows the contents of
named.conf
and related files to be shared — for example, when submitting bug reports — without compromising private data. This option cannot be used without
**-p**.

-z
Perform a test load of all master zones found in
named.conf.

filename
The name of the configuration file to be checked. If not specified, it defaults to
/etc/named.conf.

<a name="return-values"></a>

# Return Values


**named-checkconf**
returns an exit status of 1 if errors were detected and 0 otherwise.

<a name="see-also"></a>

# See Also


**named**(8),
**named-checkzone**(8),
BIND 9 Administrator Reference Manual.

<a name="author"></a>

# Author


**Internet Systems Consortium, Inc.**

<a name="copyright"></a>

# Copyright
  
Copyright © 2000-2002, 2004, 2005, 2007, 2009, 2014-2016, 2018-2021 Internet Systems Consortium, Inc. ("ISC")  
