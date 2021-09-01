# gml2gv,gv2gml(1) - GML-DOT converters

24 June 2011

```
gml2gv [ -?v ] [ -ggname ] [ -ooutfile ] [  files ]
gv2gml [ -? ] [ -ooutfile ] [  files ]
```


<a name="description"></a>

# Description

**gml2gv**
converts a graph specified in the GML format to a graph in the GV (formerly DOT) format. 
**gv2gml**
converts a graph specified in the GV format to a graph in the GML format.

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
  Prints output to the file _outfile_. If not given, **gml2gv**
  uses stdout.
* 
<a name="operands"></a>

# Operands

The following operand is supported:

* _files_  
  Names of files containing 1 or more graphs in GML.
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
conversion is at best approximate. In particular, it is not clear how multiedges
are differentiated in GML, so multiedges are created in GV with no user-available
key. Also, no attribute information is lost, in that
any GML attributes that aren't converted to GV equivalents are retained as
attributes in the output graph.

At present, 
**gv2gml**
does not support subgraphs and clusters. In addition, there does not appear to be
a standard mechanism for specifying default node and edge attributes in GML, so
any attributes are repeated for every node and edge.

<a name="authors"></a>

# Authors

Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

dot(1), libcgraph(3)
