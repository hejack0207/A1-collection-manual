# usleep(1) - sleep some number of microseconds

Red Hat, Inc

```
usleep [number]
```

<a name="description"></a>

# Description

**usleep**
sleeps some number of microseconds.  The default is 1.

<a name="warning"></a>

# Warning

**usleep**
has been deprecated, and will be removed in near future. Use sleep(1) instead.

<a name="options"></a>

# Options

_--usage_
Show short usage message.

* _--help, -?_  
  Print help information.
* _-v, --version_  
  Print version information.

<a name="bugs"></a>

# Bugs

Probably not accurate on many machines down to the microsecond.  Count
on precision only to -4 or maybe -5.

<a name="author"></a>

# Author

Donald Barnes &lt;[djb@redhat.com](mailto:djb@redhat.com)&gt;  
Erik Troan &lt;[ewt@redhat.com](mailto:ewt@redhat.com)&gt;

<a name="see-also"></a>

# See Also

sleep(1)
