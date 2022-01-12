# unflatten(1) - adjust directed graphs to improve layout aspect ratio

21 January 2001

```
unflatten [-f] [-llen] [-clen ] [ -o outfile ] [ files ]
```

<a name="description"></a>

# Description

**unflatten**
is a preprocessor to 
**dot**
that is
used to improve the aspect ratio of graphs having many leaves 
or disconnected nodes.
The usual layout for such a graph is generally very wide or tall.  
**unflatten**
inserts invisible edges or adjusts the **minlen** on edges
to improve layout compaction.

<a name="options"></a>

# Options

The following options are supported:

* **-l**_ len_  
  The minimum length of leaf edges is staggered
  between 1 and _len_ (a small integer).  
* **-f**  
  Enables the staggering of the **-l** option to fanout nodes whose
  indegree and outdegree are both 1. This helps with structures such
  as _a -&gt; {w x y z} -&gt; b_.
  This option only works if the **-l** flag is set. 
* **-c**_ len_  
  Form disconnected nodes into chains of up to _len_ nodes.
* **-o**_ outfile_  
  causes the output to be written to the specified file; by default,
  output is written to **stdout**.

<a name="operands"></a>

# Operands

The following operand is supported:

* _files_  
  Names of files containing 1 or more graphs in dot format.
  If no
  _files_
  operand is specified,
  the standard input will be used.

<a name="authors"></a>

# Authors

Stephen C. North &lt;[north@research.att](mailto:north@research.att).com&gt;  
Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

gc(1), dot(1), acyclic(1), gvpr(1), gvcolor(1), ccomps(1), tred(1), libgraph(3)
