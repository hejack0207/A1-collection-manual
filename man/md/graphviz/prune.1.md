# prune(1) - Prune directed graphs

```
prune [ -n node ] [ -N attrspec ] [ -v ] [ -(h|?) ] [ files ... ]
```

<a name="description"></a>

# Description

**prune**
reads directed graphs in the same format used by 
**dot(1)**
and removes subgraphs rooted at nodes specified on the
command line via options. These nodes themselves will not be removed,
but can be given attributes so that they can be easily located by a
graph stream editor such as
**gvpr(1).**
**prune**
correctly handles cycles, loops and multi-edges.

Both options can appear multiple times on the command line. All
subgraphs rooted at the respective nodes given will then be
processed. If a node does not exist,
**prune**
will skip it and print a warning message to stderr.
If multiple attributes are given, they will be applied to
all nodes that have been processed.
**prune**
writes the result to the stdout.

<a name="options"></a>

# Options


* **-n**_ name_  
  Specifies name of node to prune.
* **-N**_ attrspec_  
  Specifies attribute that will be set (or changed if it exists) for any
  pruned node.
  _attrspec_
  is a string of the form
  _attr_=_value._
* **-v**  
  Verbose output.
* **-h** **-?**  
  Prints the usage and exits.

<a name="examples"></a>

# Examples

An input graph
_test.gv_
of the form

	digraph DG {  
	  A -&gt; B;  
	  A -&gt; C;  
  
	  B -&gt; D;  
	  B -&gt; E;  
	}  

, processed by the command

	prune -n B test.gv

would produce the following output (the actual code might be formatted
in a slightly different way).

	digraph DG {  
	  A -&gt; B;  
	  A -&gt; C;  
	}  

Another input graph
_test.gv_
of the form

	digraph DG {  
	  A -&gt; B;  
	  A -&gt; C;  
  
	  B -&gt; D;  
	  B -&gt; E;  
  
	  C -&gt; E;  
	}  

(note the additional edge from
_C_
to
_E_
), processed by the command

	prune -n B -N color=red test.gv

results in

	digraph DG {  
	  B [color=red];  
	  A -&gt; B;  
	  A -&gt; C;  
	  C -&gt; E;  
	}  

Node
_E_
has not been removed since its second parent
_C_
is not being pruned.


<a name="exit-status"></a>

# Exit Status

**prune**
returns 0 on successful completion.
It returns 1 if an error occurs.

<a name="see-also"></a>

# See Also

**dot**(1),
**gvpr**(1)


<a name="author"></a>

# Author

Marcus Harnisch &lt;[marcus.harnisch@gmx.net](mailto:marcus.harnisch@gmx.net)&gt;
