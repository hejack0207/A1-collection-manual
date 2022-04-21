# pscap:(8) - a program to see capabilities

Red Hat, Sept 2020

```
pscap [ -a ]
```

<a name="description"></a>

# Description

**pscap** is a program that prints out a report of process capabilities. If the application has any capabilities, it will be in the report with the exception of init. By giving the -a command line option, init will be included, too. If a process is not in the report, it has dropped all capabilities. If the process has partial capabilities, it is further examined to see if it has an open-ended bounding set. If this is found to be true, a '+' symbol is added. If the process has ambient capabilities, a '@' symbols is added.

The command name in the output may be followed by an asterisk mark (*). This mark denotes processes which run in child user namespaces (relative to the user namespace of pscap itself).


<a name="see-also"></a>

# See Also

**netcap**(8),
**filecap**(8),
**capabilities**(7),
**ps**(8).


<a name="author"></a>

# Author

Steve Grubb
