# gvgen(1) - generate graphs

5 June 2012

```
gvgen [ -dv? ] [ -in ] [ -cn ] [ -Cx,y ] [ -g[f]x,y ] [ -G[f]x,y ] [ -hn ] [ -kn ] [ -bx,y ] [ -Bx,y ] [ -mn ] [ -Mx,y ] [ -pn ] [ -rx,y ] [ -Rx ] [ -sn ] [ -Sn ] [ -Sn,d ] [ -tn ] [ -td,n ] [ -Tx,y ] [ -Tx,y,u,v ] [ -wn ] [ -nprefix ] [ -Nname ] [ -ooutfile ]
```

<a name="description"></a>

# Description

**gvgen**
generates a variety of simple, regularly-structured abstract
graphs.

<a name="options"></a>

# Options

The following options are supported:

* **-c**_ n_  
  Generate a cycle with _n_ vertices and edges.
* **-C**_ x,y_  
  Generate an _x_ by _y_ cylinder.
  This will have _x*y_ vertices and 
  _2*x*y - y_ edges.
* **-g**_ [**f**]x,y_  
  Generate an _x_ by _y_ grid.
  If **f** is given, the grid is folded, with an edge
  attaching each pair of opposing corner vertices.
  This will have _x*y_ vertices and 
  _2*x*y - y - x_ edges if unfolded and
  _2*x*y - y - x + 2_ edges if folded.
* **-G**_ [**f**]x,y_  
  Generate an _x_ by _y_ partial grid.
  If **f** is given, the grid is folded, with an edge
  attaching each pair of opposing corner vertices.
  This will have _x*y_ vertices.
* **-h**_ n_  
  Generate a hypercube of degree _n_.
  This will have _2^n_ vertices and _n*2^(n-1)_ edges.
* **-k**_ n_  
  Generate a complete graph on _n_ vertices with 
  _n*(n-1)/2_ edges.
* **-b**_ x,y_  
  Generate a complete _x_ by _y_ bipartite graph.
  This will have _x+y_ vertices and
  _x*y_ edges.
* **-B**_ x,y_  
  Generate an _x_ by _y_ ball, i.e., an _x_ by _y_ cylinder
  with two "cap" nodes closing the ends. 
  This will have _x*y + 2_ vertices
  and _2*x*y + y_ edges.
* **-m**_ n_  
  Generate a triangular mesh with _n_ vertices on a side.
  This will have _(n+1)*n/2_ vertices
  and _3*(n-1)*n/2_ edges.
* **-M**_ x,y_  
  Generate an x by y Moebius strip.
  This will have _x*y_ vertices
  and _2*x*y - y_ edges.
* **-p**_ n_  
  Generate a path on _n_ vertices.
  This will have _n-1_ edges.
* **-r**_ x,y_  
  Generate a random graph.
  The number of vertices will be the largest value of the form _2^n-1_ less than or
  equal to _x_. Larger values of _y_ increase the density of the graph.
* **-R**_ x_  
  Generate a random rooted tree on _x_ vertices.
* **-s**_ n_  
  Generate a star on _n_ vertices.
  This will have _n-1_ edges.
* **-S**_ n_  
  Generate a Sierpinski graph of order _n_.
  This will have _3*(3^(n-1) + 1)/2_ vertices and
  _3^n_ edges.
* **-S**_ n,d_  
  Generate a _d_-dimensional Sierpinski graph of order _n_.
  At present, _d_ must be 2 or 3.
  For d equal to 3, there will be _4*(4^(n-1) + 1)/2_ vertices and
  _6 * 4^(n-1)_ edges.
* **-t**_ n_  
  Generate a binary tree of height _n_.
  This will have _2^n-1_ vertices and
  _2^n-2_ edges.
* **-t**_ h,n_  
  Generate a n-ary tree of height _h_.
* **-T**_ x,y_  
* **-T**_ x,y,u,v_  
  Generate an _x_ by _y_ torus.
  This will have _x*y_ vertices and
  _2*x*y_ edges.
  If _u_ and _v_ are given, they specify twists of that amount in
  the horizontal and vertical directions, respectively.
* **-w**_ n_  
  Generate a path on _n_ vertices.
  This will have _n-1_ edges.
* **-i**_ n_  
  Generate _n_ graphs of the requested type. At present, only available if 
  the **-R** flag is used. 
* **-n**_ prefix_  
  Normally, integers are used as node names. If _prefix_ is specified,
  this will be prepended to the integer to create the name.
* **-N**_ name_  
  Use _name_ as the name of the graph.
  By default, the graph is anonymous.
* **-o**_ outfile_  
  If specified, the generated graph is written into the file
  _outfile._
  Otherwise, the graph is written to standard out.
* **-d**  
  Make the generated graph directed.
* **-v**  
  Verbose output.
* **-?**  
  Print usage information.

<a name="exit-status"></a>

# Exit Status

**gvgen**
exits with 0 on successful completion, 
and exits with 1 if given an ill-formed or incorrect flag,
or if the specified output file could not be opened.

<a name="author"></a>

# Author

Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

gc(1), acyclic(1), gvpr(1), gvcolor(1), ccomps(1), sccmap(1), tred(1), libgraph(3)
