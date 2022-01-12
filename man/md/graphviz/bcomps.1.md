# bcomps(1) - biconnected components filter for graphs

18 November 2003

```
bcomps [ -stvx? ] [ -ooutfile ] [  files ]
```

<a name="description"></a>

# Description

**bcomps**
decomposes graphs into their biconnected components,
printing the components to standard output.

<a name="options"></a>

# Options

The following options are supported:

* **-s**  
  No output graph is printed. Implies the
  **-v**
  flag.
* **-t**  
  Print the underlying block-cutvertex tree.
* **-x**  
  Each biconnected component is printed as a separate root graph.
* **-v**  
  Prints number of blocks and cutvertices.
* **-o**_ outfile_  
  If specified, each root graph will be written to a different file
  with the names derived from _outfile_. In particular, 
  if both **-o** and **-x** flags are used, then each
  block is written to a different file. If _outfile_ does
  not have a suffix, the nth block of the ith graph is written 
  to _outfile\_n\_i_. However, the 0th block of the 0th graph is written to
  _outfile_.

If _outfile_ has a suffix, i.e., has the form _base.sfx_,
then the files will have the same name as above, except appended with _.sfx_.

The block-cutvertex tree of ith graph is written to _outfile\_n\_T_,
with an appended suffix if specified.

By default, each input graph is printed, with each
block given as a subgraph whose name is a concatenation of
the name of the input graph, the string "_bcc_" and the
number of the block.

<a name="operands"></a>

# Operands

The following operand is supported:

* _files_  
  Names of files containing 1 or more graphs in dot format.
  If no
  _files_
  operand is specified,
  the standard input will be used.

<a name="return-codes"></a>

# Return Codes

**bcomps**
returns
**0**
if all the input graphs are biconnected; and
non-zero if any graph has multiple blocks, or any error occurred.

<a name="bugs"></a>

# Bugs

It is possible, though unlikely, that the names used for connected
components and their subgraphs may conflict with existing subgraph names.

<a name="authors"></a>

# Authors

Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

ccomps(1), gc(1), dot(1), gvpr(1), gvcolor(1), acyclic(1), sccmap(1), tred(1), libgraph(3)
