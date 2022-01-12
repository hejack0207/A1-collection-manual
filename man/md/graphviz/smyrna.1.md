# gc(1) - interactive graph viewer

9 December 2009

```
smyrna [ -v? ] [  file ]
```

<a name="description"></a>

# Description

**smyrna**
is a viewer for graphs in the DOT format.
It is especially designed to handle large graphs, and
allows flat and topological fisheye views.
It is assumed the input graph has position information
associated with all nodes. Using the Graphviz convention,
a node's position is given by its _pos_ attribute
consisting of 2 or 3 floating point numbers separated by commas.
Nodes are drawn as points and edges as line segments.

If **smyrna** detects that the file contains _xdot_ 
attributes, it will use this information when drawing nodes
and edges.

**smyrna** supports panning and zooming; node and edge selection;
setting and retrieving node and edge attributes, especially colors;
and node movement.
The Smyrna Settings dialogue box available under the Edit pull-down
menu gives the user many choices for tailoring the graph view. These
include whether or not nodes/edges are drawn; what labels are 
associated with nodes/edges; node size; transparency settings for
nodes/edges; parameters associated with the topological fisheye view.

For the purposes of exploratory data analysis, **smyrna** provides
access to the **gvpr** library. This allows the user to arbitrarily
query, filter or manipulate a graph. When filtering or manipulating
a graph, the user has the option of performing the changes directly
on the input graph, or to create a new version with the changes. 

<a name="options"></a>

# Options

The following options are supported:

* **-v**  
  Verbose mode.
* **-?**  
  Print usage information.

By default, 
_gc_
returns the number of nodes and edges.

<a name="operands"></a>

# Operands

The following operand is supported:

* _file_  
  Name of file containing a graph in DOT format.
  If no
  _file_
  operand is specified,
  the user can employ the File pull-down menu to select a file
  to be opened.

<a name="exit-status"></a>

# Exit Status

The following exit values are returned:

* **0**
  Successful completion.
* **1**
  If no No appropriate OpenGL-capable visual found,
  or if the default attributes template graph file or
  the default attributes widget graph file could not be read.

<a name="files"></a>

# Files

**smyrna** relies on numerous support files. These are 
usually installed in the "share/graphviz/smyrna" directory
below the installation root. The principal files are:

* _template.dot_  
  A file in DOT format specifying the default **smyrna** settings.
  In particular, these are used to initialize the settings of the
  Smyrna Settings dialogue box. 
* _mouse_actions.txt_  
  A text file specifying the mapping of concrete mouse and keyboard
  events with **smyrna** actions such as panning and selecting.
* _attr_widgets.dot_  
  A file in DOT format specifying the bindings between GUI widgets
  and **smyrna** parameters.

<a name="environment-variables"></a>

# Environment Variables


* **SMYRNA_PATH**  
  allows a user to override the built-in path to the directory
  containing all of **smyrna**'s files described above.

<a name="author"></a>

# Author

Arif Bilgin &lt;[arif@research.att](mailto:arif@research.att).com&gt;  
Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

gvpr(1), dotty(1), libcgraph(3)  
"Smyrna Tutorial and Reference Manual"
