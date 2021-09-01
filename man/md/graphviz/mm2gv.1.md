# mm2gv(1) - Matrix Market-DOT converters

31 July 2008

```
mm2gv [ -cluv? ] [ -Ui ] [ -ooutfile ] [  file ]

```

<a name="description"></a>

# Description

**mm2gv**
converts a sparse matrix of the Matrix Market format to a graph in the GV (formerly DOT) format. 
If the matrix _M_ is not square, the graph is considered bipartite and the matrix is viewed
as a bipartite graph adjacency matrix, with the rows and columns of the matrix specifying the
two sets of vertices. Equivalently, the matrix is converted into a symmetric square matrix
.TS
c c.
0	_M_
$_M_ sup _T_$	0
.TE
a block matrix with square blocks of 0's in the upper left and lower right, the upper right
block being _M_ and the lower left block being the transpose of _M_.
This matrix is then viewed as the adjacency matrix of the graph.

For a square matrix, **mm2gv** uses it directly as an adjacency matrix if its pattern of non-zero
entries is symmetric; otherwise, it will treat it as a bipartite graph as with the case of non-square
matrices. This behavior can be modified by the **-U** flag.

<a name="options"></a>

# Options

The following options are supported:

* **-c**  
  This flag causes **mm2gv** to assign colors to the edges. The matrix element is scaled to the
  range [0,1] depending on where it lies between the minimum and maximum set matrix values. This
  scaled value is used as the _"wt"_ attribute of the corresponding edge. 
  In addition, this scalar value is mapped to an RGB value, which is stored as the edge _"color"_.
* **-l**  
  If set, **mm2gv** attaches a label to the graph indicating the base name of the input file,
  and the number of nodes and edges.
* **-u**  
  If specified, the graph is assumed to be undirected. By default, the graph generated is directed. 
* **-v**  
  This flag causes **mm2gv** to store the matrix values as the _"len"_ attribute of the
  corresponding edge.
* **-U**_bflag_  
  Specifies how square matrices are handled. If _bflag_ is 0, a square matrix will always be treated
  as an adjacency matrix.  
  If _bflag_ is 1 (the default), a square matrix with a symmetric pattern
  of non-zero entries will be used as an adjacency matrix; otherwise, it will be used a bipartite graph.
  If _bflag_ is 2, a symmetric matrix
  will be used as an adjacency matrix; otherwise, it will be used a bipartite graph.
  If _bflag_ is 3, any input matrix will be treated like a bipartite graph.
* **-o**_outfile_  
  Prints output to the file _outfile_. If not given, **mm2gv**
  uses stdout.
* 
<a name="operands"></a>

# Operands

The following operand is supported:

* _file_  
  Name of the file in MatrixMarket format.
  If no
  _file_
  operand is specified,
  the standard input will be used.

<a name="return-codes"></a>

# Return Codes

Return **0**
if there were no problems during conversion;
and non-zero if any error occurred.

<a name="authors"></a>

# Authors

Yifan Hu &lt;[yifanhu@yahoo.com](mailto:yifanhu@yahoo.com)&gt;  
Emden R. Gansner &lt;[erg@graphviz.com](mailto:erg@graphviz.com)&gt;

<a name="additional-info"></a>

# Additional Info

See http://math.nist.gov/MatrixMarket/ for description of the format and http://www.cise.ufl.edu/research/sparse/matrices/ for a large collection of sparse matrices in this format.
