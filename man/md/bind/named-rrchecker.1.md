# named\-rrchecker(1)

ISC, 2013\-11\-12

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

named-rrchecker - syntax checker for individual DNS resource records

<a name="synopsis"></a>

# Synopsis

```
.HP \w'named-rrchecker&nbsp;'u named-rrchecker [-h] [-o&nbsp;origin] [-p] [-u] [-C] [-T] [-P]
```

<a name="description"></a>

# Description


**named-rrchecker**
read a individual DNS resource record from standard input and checks if it is syntactically correct.

The
**-h**
prints out the help menu.

The
**-o ****origin**
option specifies a origin to be used when interpreting the record.

The
**-p**
prints out the resulting record in canonical form. If there is no canonical form defined then the record will be printed in unknown record format.

The
**-u**
prints out the resulting record in unknown record form.

The
**-C**,
**-T**
and
**-P**
print out the known class, standard type and private type mnemonics respectively.

<a name="see-also"></a>

# See Also


RFC 1034,
RFC 1035,
**named**(8)

<a name="author"></a>

# Author


**Internet Systems Consortium, Inc.**

<a name="copyright"></a>

# Copyright
  
Copyright © 2013-2016, 2018-2021 Internet Systems Consortium, Inc. ("ISC")  
