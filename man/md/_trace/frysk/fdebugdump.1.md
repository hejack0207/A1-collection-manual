# fdebugdump(1)

Frysk 0\&.4\-63\&.fc30, May 2008

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

fdebugdump - dumps a hierarchy of the debug info dies

<a name="synopsis"></a>

# Synopsis

```
.HP \w'fdebugrpm&nbsp;'u fdebugrpm {executable}
```

<a name="description"></a>

# Description


**fdebugdump**
runs the given program and dumps a hierarchical view of libraries loaded at attach time. Does not watch for loading of new modules, but that would be a good extension.

<a name="example"></a>

# Example


.if n \{.RS 4
.\}
    fdebugdump ls
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


frysk(7)

<a name="bugs"></a>

# Bugs


Report bugs to
\m[blue]**http://sourceware.org/frysk**\m[]
