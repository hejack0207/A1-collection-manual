# graphviz(7) - rich set of graph drawing tools

November 19, 2006

```
This manpage has been written to fulfil the need of a centralized documentation presenting all available tools in the graphviz package.
```


<a name="available-tools"></a>

# Available Tools



<a name="graph-layout-programs"></a>

### Graph layout programs


* **dot**  
  filter for hierarchical layouts of graphs
* **neato**  
  filter for symmetric layouts of graphs
* **twopi**  
  filter for radial layouts of graphs
* **circo**  
  filter for circular layout of graphs
* **fdp**  
  filter for symmetric layouts of graphs

All of the filters work with either directed or undirected graphs, though
**dot**
is typically used for directed graphs and
**neato**
for undirected graphs.
Note also that **neato -n[2]** can be used to render layouts produced
by the other filters.

<a name="graph-drawing-programs"></a>

### Graph drawing programs


* **lefty**  
  A Programmable Graphics Editor
* **lneato**  
  lefty + neato
* **dotty**  
  lefty + dot
  
  

<a name="graph-layout-enhancement"></a>

### Graph layout enhancement


* **gvcolor**  
  flow colors through a ranked digraph
* **unflatten**  
  adjust directed graphs to improve layout aspect ratio
* **gvpack**  
  merge and pack disjoint graphs
  

<a name="graph-information-and-transformation"></a>

### Graph information and transformation


* **gc**  
  count graph components
* **acyclic**  
  make directed graph acyclic
* **nop**  
  pretty-print graph file
* **ccomps**  
  connected components filter for graphs
* **sccmap**  
  extract strongly connected components of directed graphs
* **tred**  
  transitive reduction filter for directed graphs
* **dijkstra**  
  single-source distance filter
* **bcomps**  
  biconnected components filter for graphs
* **gvpr**  
  graph pattern scanning and processing language
* **prune**  
  prune directed graphs
  

<a name="other"></a>

### Other


* **gxl2dot, dot2gxl**  
  GXL-DOT converters
  

<a name="author"></a>

# Author

This manual page was written by Cyril Brulebois
&lt;[cyril.brulebois@enst-bretagne.fr](mailto:cyril.brulebois@enst-bretagne.fr)&gt; in november 2006, based on an initial
documentation effort by Joachim Berdal Haga &lt;[jbh@lupus.ig3](mailto:jbh@lupus.ig3).net&gt;. It can be
distributed under the same terms as the graphviz package.

