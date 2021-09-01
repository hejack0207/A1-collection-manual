# gvpack(1) - merge and pack disjoint graphs

27 May 2010

```
gvpack [ -nguv? ] [ -mmargin ] [ -array[_flags][n] ] [ -ooutfile ] [ -sgraph_name ] [ -Gname=value ] [  files ]
```

<a name="description"></a>

# Description

**gvpack**
reads in a stream of graphs, combines the graphs into a single
layout, and produces a single graph serving as the union of the
input graphs. The input graphs must be in dot format, and must have
all necessary layout information. Acceptable input is produced
by applying a Graphviz layout program, such as **dot** or **neato**, 
with no **-T** flag.

By default, the packing is done at the cluster level. Thus, parts of
one graph will not intrude into any top-level clusters or overlap
any nodes or edges of another.

The output of **gvpack** can be used to produce concrete output
by applying **neato -s -n2** with the desired **-T** flag.

<a name="options"></a>

# Options

The following options are supported:

* **-g**  
  Combines the graphs at the graph level. This uses more space, but prevents
  parts of one graph from occurring between parts of another. 
* **-array_[\_flags][n]_**  
  Combines the graphs at the graph level, placing them in an array.
  By default, the layout is done in row-major order. The number of columns
  used is roughly the square root of the number of graphs. If the optional
  integer _n_ is supplied, this indicates the number of columns to use.
*   
  If optional flags are supplied, these consist of an underscore followed
  by any of the letters "c", "t", "b", "l", "r", "u" or "i".
  If "c" is supplied, the graphs are packed in column-major order, in which
  case a final integer specifies the number of rows.
  The flags "t", "b", "l", "r" indicate that components are aligned
  along the top, bottom, left or right, respectively.
  By default, the insertion order is determined by sorting the graphs by size,
  largest to smallest. If
  the "u" flag is set, the graphs are sorted based on the non-negative integer
  _sortv_ attribute attached to each graph.
  The "i" flag indicates that no sorting is done, with the graphs inserted in
  input order.
* **-G**_name**=**value_  
  Specifies attributes to be added to the resulting union graph. For
  example, this can be used to specify a graph label.
* **-m**_margin_  
  Packs the graphs allowing a margin of _output_ points around
  the parts.
* **-n**  
  Combines the graphs at the node level. Clusters are ignored in the packing.
* **-o**_output_  
  Prints output to the file _output_. If not given, **gvpack**
  uses stdout.
* **-s**_graph_name_  
  Use _graph\_name_ as the name of the root graph. By default, "root"
  is used.
* **-u**  
  Don't pack the graphs. Just combine them into a single graph.
* **-v**  
  Verbose mode.
* **-?**  
  Prints usage information and exit.

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

**gvpack**
returns
**0**
if there were no problems, and non-zero otherwise.

<a name="examples"></a>

# Examples

.EX
ccomps -x abc.gv | dot | gvpack | neato -s -n2 -Tps
.EE
This pipeline decomposes the graph in _abc.gv_ into its
connected components, lays out each using **dot**, packs them all together
again, and produces the final drawing in PostScript. Of course, 
there is nothing to prevent one from using different layouts for
each component.

<a name="bugs"></a>

# Bugs

All the input graphs must be directed or undirected.

An input graph should not have a label, since this will be used in its
layout. Since **gvpack** ignores root graph labels, resulting layout
may contain some extra space.

**gvpack** unsets the bounding box attribute of all non-cluster
subgraphs.

<a name="authors"></a>

# Authors

Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

gvpr(1), dot(1), neato(1), twopi(1), ccomps(1), libpack(3)
