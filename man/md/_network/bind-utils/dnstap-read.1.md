# dnstap\-read(1)

ISC, 2015\-09\-13

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dnstap-read - print dnstap data in human-readable form

<a name="synopsis"></a>

# Synopsis

```
.HP \w'dnstap-read&nbsp;'u dnstap-read [-m] [-p] [-y] {file}
```

<a name="description"></a>

# Description


**dnstap-read**
reads
**dnstap**
data from a specified file and prints it in a human-readable format. By default,
**dnstap**
data is printed in a short summary format, but if the
**-y**
option is specified, then a longer and more detailed YAML format is used instead.

<a name="options"></a>

# Options


-m
Trace memory allocations; used for debugging memory leaks.

-p
After printing the
**dnstap**
data, print the text form of the DNS message that was encapsulated in the
**dnstap**
frame.

-y
Print
**dnstap**
data in a detailed YAML format.

<a name="see-also"></a>

# See Also


**named**(8),
**rndc**(8),
BIND 9 Administrator Reference Manual.

<a name="author"></a>

# Author


**Internet Systems Consortium, Inc.**

<a name="copyright"></a>

# Copyright
  
Copyright © 2015, 2016, 2018, 2019 Internet Systems Consortium, Inc. ("ISC")  
