# mingle(1) - fast edge bundling

16 August 2013

```
mingle [ options ] [ -o outfile ] [  files ]
```

<a name="description"></a>

# Description

**mingle**
takes as input a graph in DOT format with node position information (the _pos_ attribute) and
bundles the edges.

<a name="options"></a>

# Options

The following options are supported:

* **-m**_ k_  
  indicates which method to use for bundling. A value of 0 corresponds to a force-directed bundling.
  A value of 2 uses a cluster plus ink saving approach. If available, a value 1 denotes 
  an agglomerative ink saving method. Normally, the last is the default.
* **-a**_ k_  
  specifies the maximum turning angle, in degrees, as a non-negative real.
  The larger the value, the more edges may bend. If the value is 0, there is no limitation on
  the turning angle. The default is 40.
  The parameter is not used in force-directed bundling.
* **-c**_ v_  
  specifies which compatability measure to use. The value 0, the default, uses a distance metric,
  while a value of 1 relies on full compatability. This value is only used in force-directed bundling.
* **-i**_ k_  
  gives the maximum number of iterative divisions of edges allowd in force-directed bundling.
  The default is 4.
* **-k**_ k_  
  gives the number of neighbors to be used in forming a nearest neighbor graph. This parameter is
  only used in the agglomerative method. The default is 10.
* **-K**_ k_  
  is a positive real value giving the force constant used in force-directed bundling. By default,
  the value is determined automatically.
* **-o**_ file_  
  puts output in _file_. Default output is stdout
* **-p**_ k_  
  Except for the force-directed method, bundling minimizes $ink * (k - cos(turning angle))$. The larger the
  value of _k_, the less emphasis is put on avoiding sharp turning angles and the faster the bundling.
  The default value is -1.
* **-r**_ k_  
  is a non-negative integer giving the maximum recursion level used in the agglomerative method. The default is 100.
* **-T**_ fmt_  
  specifies the output format. At present, the output is always in the DOT format. If _fmt_ is "simple",
  the output is a simple, schematic representation of the drawing. Only the node positions and edges are
  retained from the original graph. If _fmt_ is "gv", the drawing information is attached to the
  input graph. 
* **-v**_ k_  
  determines the verbose level used for tracing the algorithm. The value _k_ is optional; if not
  provided, the value 1 is used.
* **-?**  
  Print usage and exit.
  

<a name="bugs"></a>

# Bugs

At present, **mingle** does not handle graphs with loops or directed multiedges. So, a graph with edges
_a -&gt; b_ and _b -&gt; a_ is acceptable, but not if it has edges _a -&gt; b_ and _a -&gt; b_ or
_a -- b_ and _a -- b_.

<a name="author"></a>

# Author

Emden R. Gansner &lt;[erg@graphviz.org](mailto:erg@graphviz.org)&gt;,
Yifan Hu &lt;[yifanhu@yahoo.com](mailto:yifanhu@yahoo.com)&gt;

<a name="see-also"></a>

# See Also


sfdp(1), neato(1), gvpr(1)

Emden R. Gansner, Yifan Hu, Stephen C. North and Carlos Scheidegger, 
\`\`Multilevel Agglomerative Edge Bundling for Visualizing Large Graphs'',
IEEE Pacific Visualization Symposium PacificVis, pp. 187-194, 2011.
