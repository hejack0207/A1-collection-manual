# getsebool(8) - get SELinux boolean value(s) 

dwalsh@redhat.com, 11 Aug 2004


<a name="synopsis"></a>

# Synopsis

```
getsebool [-a] [boolean]
```

<a name="description"></a>

# Description

**getsebool**
reports where a particular SELinux boolean or
all SELinux booleans are on or off
In certain situations a boolean can be in one state with a pending 
change to the other state.  getsebool will report this as a pending change.
The pending value indicates
the value that will be applied upon the next boolean commit.

The setting of boolean values occurs in two stages; first the pending
value is changed, then the booleans are committed, causing their
active values to become their pending values.  This allows a group of
booleans to be changed in a single transaction, by setting all of
their pending values as desired and then committing once.

<a name="options"></a>

# Options


* **-a**  
  Show all SELinux booleans.

<a name="author"></a>

# Author

This manual page was written by Dan Walsh &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;.
The program was written by Tresys Technology.

<a name="see-also"></a>

# See Also

**selinux**(8),
**setsebool**(8),
**booleans**(8)
