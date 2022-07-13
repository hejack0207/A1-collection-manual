# i3\-sensible\-pager(1)

i3 4\&.18\&.1, 04/23/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

i3-sensible-pager - launches $PAGER with fallbacks

<a name="synopsis"></a>

# Synopsis

```

 i3-sensible-pager [arguments]
```

<a name="description"></a>

# Description


i3-sensible-pager is used by i3-nagbar(1) when you click on the view button.

It tries to start one of the following (in that order):

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  $PAGER

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  less

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  most

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  w3m

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  i3-sensible-editor(1)

Please don’t complain about the order: If the user has any preference, they will have $PAGER set.

<a name="see-also"></a>

# See Also


i3(1)

<a name="author"></a>

# Author


Michael Stapelberg and contributors
