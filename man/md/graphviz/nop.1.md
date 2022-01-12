# nop(1) - pretty-print graph file

21 March 2001

```
nop [ -p? ] [  files  ]
```

<a name="description"></a>

# Description

**nop**
reads a stream of graphs and prints each in pretty-printed (canonical) format
on stdout. If no
_files_
are given, it reads from stdin.

<a name="options"></a>

# Options

The following options are supported:

* **-p**  
  Produce no output - just check the input for valid DOT.
* **-?**  
  Print usage information.

<a name="exit-status"></a>

# Exit Status

If any errors occurred while processing any input, such as a file
not found or a file containing illegal DOT, a non-zero exit value
is returned. Otherwise, zero is returned.

<a name="see-also"></a>

# See Also

wc(1), acyclic(1), gvpr(1), gvcolor(1), ccomps(1), sccmap(1), tred(1), libgraph(3)
