# clarify(1) - edge coloring to disambiguate crossing edges

26 February 2014

```
 [ options ] [ -o outfile ] [  files ]
```

<a name="description"></a>

# Description

**edgepaint**
takes as input a graph in DOT format with node position information (the _pos_ attribute) and
colors the edges in a manner making it easier to tell them apart.

<a name="options"></a>

# Options

The following options are supported:

* **-accuracy=**_e_  
  accuracy with which to find the maximally different coloring for each node with regard to its neighbors. Default e = 0.01. 
* **-angle=**_a_  
  color two edges differently if their incidence angle is less than _a_ degrees. Default _a_=15.
* **-random_seed=**_s_  
  random seed to use. _s_ must be an integer. If _s_ is negative, we do |_s_| iterations with different seeds and pick the best. 
* **-lightness=**_l1,l2j_  
  only applies for the "lab" color scheme: _l1_ and _l2_ must integers, with 0 &lt;= _l1_ &lt;= l2 &lt;=100. By default, we use "0,70" 
* **-share_endpoint**  
  if this option is specified, edges that shares an node are not considered in conflict if they are close to parallel but 
  are on the opposite sides of the node (around 180 degree). 
* **-o**_ f_  
  write output to file f (default: stdout).
* **-color_scheme=**_c_  
  specifies the color scheme.  This can be "rgb", "gray", "lab" (default);
  or a comma-separated list of RGB colors in hex (e.g., "#ff0000,#aabbed,#eeffaa") representing a palette;
  or a string specifying a Brewer color scheme (e.g., "accent7"; see http://www.graphviz.org/content/color-names#brewer).
* **-v**  
  turns on verbose mode.
* **-?**  
  Print usage and exit.
  

<a name="bugs"></a>

# Bugs

At present, **edgepaint** does not handle graphs with loops or directed multiedges. So, a graph with edges
_a -&gt; b_ and _b -&gt; a_ is acceptable, but not if it has edges _a -&gt; b_ and _a -&gt; b_ or
_a -- b_ and _a -- b_. Ports are ignored in this analysis, so having
_a.x -&gt; b_ and _a.y -&gt; b_ is also not supported.

<a name="author"></a>

# Author

Yifan Hu &lt;[yifanhu@yahoo.com](mailto:yifanhu@yahoo.com)&gt;

<a name="see-also"></a>

# See Also


gvmap(1), sfdp(1), neato (1), dot(1)


