# acyclic(1) - make directed graph acyclic

21 March 2001

```
acyclic [ -nv? ] [ -o outfile ] [  file ]
```

<a name="description"></a>

# Description

**acyclic**
is a filter that takes a directed graph as input and outputs
a copy of the graph with sufficient edges reversed to make
the graph acyclic. The reversed edge inherits all of the attributes
of the original edge. The optional file argument specifies where the
the input graph is stored; by default, the program reads from **stdin**.

<a name="options"></a>

# Options

The following options are supported:

* **-n**  
  No output is produced, though the return value
  will indicate whether the graph is acyclic or not.
* **-v**  
  Print information about whether the file is acyclic, has a cycle or
  is undirected.
* **-o**_ outfile_  
  causes the output to be written to the specified file; by default,
  output is written to **stdout**.
* **-?**  
  option causes the program to print usage information.

<a name="return-codes"></a>

# Return Codes

**acyclic**
returns
**0**
if the graph is acyclic;
**1**
if the graph has a cycle;
**2**
if the graph is undirected; and
**255**
if there are any errors.

<a name="bugs"></a>

# Bugs

If the graph is strict and there is a cycle of length 2, 
the attributes of the reversed edge are lost.

Some edge attributes are non-symmetric, referring to either the head
or tail node. At present, there is no mechanism or convention for
correctly switching or renaming these.

<a name="authors"></a>

# Authors

Stephen C. North &lt;[north@research.att](mailto:north@research.att).com&gt;  
Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also

gc(1), dot(1), gvpr(1), gvcolor(1), ccomps(1), sccmap(1), tred(1), libgraph(3)
