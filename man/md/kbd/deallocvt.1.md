# deallocvt(1) - deallocate unused virtual consoles

17 Mar 1997

```
deallocvt [N ...]
```

<a name="description"></a>

# Description


The command
**deallocvt**
deallocates kernel memory and data structures
for all unused virtual consoles.
If one or more arguments
_N_ ...
are given, only the corresponding consoles
_/dev/ttyN_
are deallocated.

A virtual console is unused if it is not the foreground console,
and no process has it open for reading or writing, and no text
has been selected on its screen.

<a name="see-also"></a>

# See Also

**chvt**(1),
**openvt**(1)


