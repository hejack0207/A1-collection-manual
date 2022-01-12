# graphml2gv(1) - GRAPHML-DOT converter

14 July 2011

```
graphml2gv [ -?v ] [ -ggname ] [ -ooutfile ] [  files ]
```

<a name="description"></a>

# Description

**graphml2gv**
converts a graph specified in the GRAPHML format to a graph in the GV (formerly DOT) format.

<a name="options"></a>

# Options

The following options are supported:

* **-v**  
  Turns on verbose mode
* **-?**  
  Prints usage information and exits.
* **-g**_gname_  
  The string _gname_ is used as the name of the generated graph.
  If multiple graphs are generated, subsequent graphs use the name
  _gname_ appended with an integer.
* **-o**_outfile_  
  Prints output to the file _outfile_. If not given, **graphml2gv**
  uses stdout.
* 
<a name="operands"></a>

# Operands

The following operand is supported:

* _files_  
  Names of files containing 1 or more graphs in GRAPHML.
  If no
  _files_
  operand is specified,
  the standard input will be used.

<a name="return-codes"></a>

# Return Codes

Return **0**
if there were no problems during conversion;
and non-zero if any error occurred.

<a name="limitations"></a>

# Limitations

As both the graph and graphics models of GV and GML differ significantly, the
conversion can only be at best approximate.
In particular, GV currently has no notion of hyperedges or edges containing graphs.

At present, 
**graphml2gv**
only supports the basic graph topology. Specifically, the &lt;KEY&gt; and &lt;DATA&gt;
elements are not handled, though they could be.

<a name="authors"></a>

# Authors

Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

dot(1), libcgraph(3)
