# named\-journalprint(8)

ISC, 2009\-12\-04

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

named-journalprint - print zone journal in human-readable form

<a name="synopsis"></a>

# Synopsis

```
.HP \w'named-journalprint&nbsp;'u named-journalprint {journal}
```

<a name="description"></a>

# Description


**named-journalprint**
prints the contents of a zone journal file in a human-readable form.

Journal files are automatically created by
**named**
when changes are made to dynamic zones (e.g., by
**nsupdate**). They record each addition or deletion of a resource record, in binary format, allowing the changes to be re-applied to the zone when the server is restarted after a shutdown or crash. By default, the name of the journal file is formed by appending the extension
.jnl
to the name of the corresponding zone file.

**named-journalprint**
converts the contents of a given journal file into a human-readable text format. Each line begins with "add" or "del", to indicate whether the record was added or deleted, and continues with the resource record in master-file format.

<a name="see-also"></a>

# See Also


**named**(8),
**nsupdate**(1),
BIND 9 Administrator Reference Manual.

<a name="author"></a>

# Author


**Internet Systems Consortium, Inc.**

<a name="copyright"></a>

# Copyright
  
Copyright © 2009, 2014-2021 Internet Systems Consortium, Inc. ("ISC")  
