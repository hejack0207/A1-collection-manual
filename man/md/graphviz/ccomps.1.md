# ccomps(1) - connected components filter for graphs

30 April 2011

```
ccomps [ -sxvenzC? ] [ -X[#%]s[-f] ] [ -ooutfile ] [  files ]
```

<a name="description"></a>

# Description

**ccomps**
decomposes graphs into their connected components,
printing the components to standard output.

<a name="options"></a>

# Options

The following options are supported:

* **-e**  
  Do not induce edges in the connected components.
* **-s**  
  No output graph is printed. The return value can be used to
  check if the graph is connected or not.
* **-x**  
  Only the connected components are printed, as separate graphs.
* **-v**  
  Counts of nodes, edges and connected components are printed.
* **-z**  
  Sort components by size, with the largest first. This is only
  effective if either **-x** or **-X#** is present.
  Thus, **-zX#0** will cause the largest component to be printed.
* **-C**  
  Use clusters in computing components in addition to normal edge
  connectivity. In essence, this gives the connected components of the
  derived graph in which nodes top-level clusters and nodes in the
  original graph. This maintains all subgraph structure within a
  component, even if a subgraph does not contain any nodes.
* **-n**  
  Do not project subgraph structure. Normally, if 
  **ccomps**
  produces components as graphs distinct from the input graph, it will
  define subgraphs which are projections of subgraphs of the input graph
  onto the component. (If the projection is empty, no subgraph is produced.)
  If this flag is set, the component contains only the relevant nodes and
  edges.
* **-X**_ node_name_  
  Prints only the component containing the node _node\_name_,
  if any.
* **-X#**_ start_  
* **-X#**_ start-_  
* **-X#**_ start-last_  
  Prints only components in the given range of indices. In the first form, only
  the component whose index is _start_, if any, is printed.
  In the second form, each component whose index is at least _start_
  is printed. In the last form, only those components whose indices are
  in the range **[**_Istart_**,**_last_**]** are printed.
  Thus, the flag **-x** is equivalent to **-X#0-**.
* **-X#**_ min_  
* **-X#**_ min-_  
* **-X#**_ min-max_  
  Prints only components in the given range of sizes. In the first form, only
  a component whose size is _min_, if any, is printed.
  In the second form, each component whose size is at least _min_
  is printed. In the last form, only those components whose sizes are
  in the range **[**_Imin_**,**_max_**]** are printed.
* **-o**_ outfile_  
  If specified, each graph will be written to a different file
  with the names derived from _outfile_. In particular, 
  if both **-o** and **-x** flags are used, then each connected
  component is written to a different file. If _outfile_ does
  not have a suffix, the first file will have the name _outfile_;
  then next _outfile\_1_, then next _outfile\_2_, and so on.
  If _outfile_ has a suffix, i.e., has the form _base.sfx_,
  then the files will be named _base.sfx_, _base\_1.sfx_, 
  _base\_2.sfx_, etc.

By default, each input graph is printed, with each connected
component given as a subgraph whose name is a concatenation of
the name of the input graph, the string "_cc_" and the
number of the component.

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

Unless used to extract a single connected component,
**ccomps**
returns
**0**
if all the input graphs are connected; and
non-zero if any graph has multiple components, or any error occurred.
If just extracting a single component,
**ccomps**
returns
**0**
on success and non-zero if an error occurred.

<a name="bugs"></a>

# Bugs

It is possible, though unlikely, that the names used for connected
components and their subgraphs may conflict with existing subgraph names.

<a name="authors"></a>

# Authors

Stephen C. North &lt;[north@research.att](mailto:north@research.att).com&gt;  
Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

gc(1), dot(1), gvpr(1), gvcolor(1), acyclic(1), sccmap(1), tred(1), libgraph(3)
