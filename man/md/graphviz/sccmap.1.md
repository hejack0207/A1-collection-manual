# sccmap(1) - extract strongly connected components of directed graphs

21 March 2001

```
sccmap [-dsv] [ -ooutfile ] [ files ]
```

<a name="description"></a>

# Description

_sccmap_
decomposes digraphs into strongly connected components
and an auxiliary map of the relationship between components.
In this map, each component is collapsed into a node.
The resulting graphs are printed to standard out.
The number of nodes, edges and strongly connected components
are printed to standard error.
**sccmap**
is a way of partitioning large graphs into more manageable pieces.

<a name="options"></a>

# Options

The following options are supported:

* **-d**  
  Preserve degenerate components of only one node.
* **-s**  
  Do not print the resulting graphs. Only the statistics are
  important.
* **-S**  
  Just print the resulting graphs. No statistics are printed.
* **-o**_output_  
  Prints output to the file _output_. If not given, **sccmap**
  uses stdout.
* **-v**  
  Generate additional statistics. In particular,
  **sccmap**
  prints the number of nodes, edges, connected components,
  and strongly connected components, followed by the fraction of
  nodes in a non-trivial strongly connected components,
  the maximum degree of the graph, and fraction of non-tree edges
  in the graph.

<a name="operands"></a>

# Operands

The following operand is supported:

* _files_  
  Names of files containing 1 or more graphs in dot format.
  If no
  _files_
  operand is specified,
  the standard input will be used.

<a name="diagnostics"></a>

# Diagnostics

**sccmap** emits a warning if it encounters an undirected graph,
and ignores it.

<a name="authors"></a>

# Authors

Stephen C. North &lt;[north@research.att](mailto:north@research.att).com&gt;  
Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

gc(1), dot(1), acyclic(1), gvpr(1), gvcolor(1), ccomps(1), tred(1), libgraph(3)
