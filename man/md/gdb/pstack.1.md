# gstack(1) - print a stack trace of a running process

Red Hat Linux, Feb 15 2008

```
gstack pid
```


<a name="description"></a>

# Description


**gstack** attaches to the active process named by the **pid** on
the command line, and prints out an execution stack trace.  If ELF
symbols exist in the binary (usually the case unless you have run
strip(1)), then symbolic addresses are printed as well.

If the process is part of a thread group, then **gstack** will print
out a stack trace for each of the threads in the group.


<a name="see-also"></a>

# See Also

nm(1), ptrace(2), gdb(1)


<a name="authors"></a>

# Authors

Ross Thompson &lt;[ross@whatsis.com](mailto:ross@whatsis.com)&gt;

Red Hat, Inc. &lt;http://bugzilla.redhat.com/bugzilla&gt;
