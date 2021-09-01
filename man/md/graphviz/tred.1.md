# tred(1) - transitive reduction filter for directed graphs

21 March 2001

```
tred [  files  ]
```

<a name="description"></a>

# Description

**tred**
computes the transitive reduction of directed graphs,
and prints the resulting graphs to standard output.
This removes edges implied by transitivity.
Nodes and subgraphs are not otherwise affected.
The \`\`meaning'' and validity of the reduced graphs
is application dependent.
**tred**
is particularly useful as a preprocessor to 
_dot_
to reduce clutter in dense layouts.

Undirected graphs are silently ignored.

<a name="operands"></a>

# Operands

The following operand is supported:

* _files_  
  Names of files containing 1 or more graphs in dot format.
  If no
  _files_
  operand is specified,
  the standard input will be used.

<a name="bugs"></a>

# Bugs

Using bitmaps internally would substantially decrease running time.

<a name="diagnostics"></a>

# Diagnostics

If a graph has cycles, its transitive reduction is not uniquely defined.
In this case _tred_ emits a warning.

<a name="authors"></a>

# Authors

Stephen C. North &lt;[north@research.att](mailto:north@research.att).com&gt;  
Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

gc(1), dot(1), acyclic(1), gvpr(1), gvcolor(1), ccomps(1), sccmap(1), libgraph(3)
