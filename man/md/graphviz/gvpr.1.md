# gvpr(1) - graph pattern scanning and processing language

29 August 2013
  

<a name="synopsis"></a>

# Synopsis

```
gvpr [-icnqV?] [ -o outfile ] [ -a args ] [ 'prog' | -f progfile ] [  files  ]
```

<a name="description"></a>

# Description

**gvpr**
(previously known as
**gpr**)
is a graph stream editor inspired by **awk**.
It copies input graphs to its
output, possibly transforming their structure and attributes,
creating new graphs, or printing arbitrary information.
The graph model is that provided by
_libcgraph_(3).
In particular, **gvpr** reads and writes graphs using the
dot language.

Basically,
**gvpr**
traverses each input graph, denoted by **$G**, visiting each node and edge,
matching it with the predicate-action rules supplied in the input program.
The rules are evaluated in order.
For each predicate evaluating to true, the corresponding 
action is performed. 
During the traversal, the current node or edge being visited
is denoted by **$**.

For each input graph, there is a target subgraph, denoted by
**$T**, initially empty and used to accumulate
chosen entities, and an output graph, **$O**, used for final processing
and then written to output. 
By default, the output graph is the target graph.
The output graph can be set in the program or, in a limited sense,
on the command line.

<a name="options"></a>

# Options

The following options are supported:

* **-a**_ args_  
  The string _args_ is split into whitespace-separated tokens, 
  with the individual tokens
  available as strings in the **gvpr** program 
  as **ARGV[_0**],...,ARGV[ARGC-1]_.
  Whitespace characters within single or double quoted substrings, or
  preceded by a backslash, are ignored as separators. 
  In general, a backslash character turns off any special meaning of the
  following character.
  Note that the tokens derived from multiple **-a** flags are concatenated.
* **-c**  
  Use the source graph as the output graph.
* **-i**  
  Derive the node-induced subgraph extension of the output graph in the context 
  of its root graph.
* **-o**_ outfile_  
  Causes the output stream to be written to the specified file; by default,
  output is written to **stdout**.
* **-f**_ progfile_  
  Use the contents of the specified file as the program to execute
  on the input. If _progfile_ contains a slash character, the name is taken
  as the pathname of the file. Otherwise, **gvpr** will use the
  directories specified in the environment variable **GVPRPATH** to look
  for the file. If 
  **-f**
  is not given,
  **gvpr**
  will use the first non-option argument as the program.
* **-q**  
  Turns off warning messages.
* **-n**  
  Turns off graph read-ahead. By default, the variable **$NG** is set to the next
  graph to be processed. This requires a read of the next graph before processing the
  current graph, which may block if the next graph is only generated in response to
  some action pertaining to the processing of the current graph.
* **-V**  
  Causes the program to print version information and exit.
* **-?**  
  Causes the program to print usage information and exit.

<a name="operands"></a>

# Operands

The following operand is supported:

* _files_  
  Names of files containing 1 or more graphs in the dot language.
  If no
  **-f**
  option is given, the first name is removed from the list and used 
  as the input program. If the list of files is empty, **stdin** will be used.

<a name="programs"></a>

# Programs

A
**gvpr**
program consists of a list of predicate-action clauses, having one
of the forms:

* **BEGIN { **_action_** }**
* **BEG_G { **_action_** }**
* **N [ **_predicate_** ] { **_action_**}**
* **E [ **_predicate_** ] { **_action_**}**
* **END_G { **_action_** }**
* **END { **_action_** }**

A program can contain at most one of each of the **BEGIN**, 
**END\_G** and **END** clauses. 
There can be any number of **BEG\_G**, **N** and **E** statements,
the first applied to graphs, the second to nodes, the third to edges.
These are separated into blocks, a block consisting of an optional
**BEG\_G** statement and all **N** and **E** statements up to 
the next **BEG\_G** statement, if any.
The top-level semantics of a **gvpr** program are:

    Evaluate the BEGIN clause, if any.
    For each input graph G {
        For each block {
            Set G as the current graph and current object.
            Evaluate the BEG_G clause, if any.
            For each node and edge in G {
                Set the node or edge as the current object.
                Evaluate the N or E clauses, as appropriate.
            } 
        } 
        Set G as the current object.
        Evaluate the END_G clause, if any.
    } 
    Evaluate the END clause, if any.
.DT

The actions of the **BEGIN**, **BEG\_G**, **END\_G** and **END** clauses
are performed when the clauses are evaluated.
For **N** or **E** clauses,
either the predicate or action may be omitted. 
If there is no predicate with an action, the action is 
performed on every node or edge, as appropriate.
If there is no action and the predicate evaluates to true,
the associated node or edge is added to the target graph. 

The blocks are evaluated in the order in which they occur.
Within a block, the **N** clauses 
(**E** clauses, respectively) are evaluated in the
order in which the occur. Note, though, that within a block, 
**N** or **E** clauses may be interlaced, depending on the
traversal order.

Predicates and actions are sequences of statements in the C dialect 
supported by the
_expr_(3)
library.
The only difference between predicates and actions is that the former
must have a type that may interpreted as either true or false.
Here the usual C convention is followed, in which a non-zero value is
considered true. This would include non-empty strings and non-empty
references to nodes, edges, etc. However, if a string can be 
converted to an integer, this value is used.

In addition to the usual C base types
(**void**, **int**, **char**, **float**, **long**, 
**unsigned** and **double**), 
**gvpr** provides **string** as a synonym for **char***, and 
the graph-based types **node\_t**,
**edge\_t**, **graph\_t** and **obj\_t**.
The **obj\_t** type can be viewed as a supertype of the other 3 concrete types;
the correct base type is maintained dynamically.
Besides these base types, the only other supported type expressions
are (associative) arrays. 

Constants follow C syntax, but strings may be quoted with either
**"..."** or **'...'**.
**gvpr** accepts C++ comments as well as cpp-type comments.
For the latter, if a line begins with a '#' character, the rest of
the line is ignored.

A statement can be a declaration of a function, a variable
or an array, or an executable statement. For declarations, there
is a single scope. Array declarations have the form: 

     type array [ type0 ]
.DT

where _ type0 _ is optional. If it is supplied, the parser will 
enforce that all array subscripts have the specified type. If it is
not supplied, objects of all types can be used as subscripts.
As in C, variables and arrays must
be declared. In particular, an undeclared variable will be interpreted
as the name of an attribute of a node, edge or graph, depending on the
context.

Executable statements can be one of the following:
.TS
l l.
**{** [_ statement ... _] **}**
_expression_	// commonly_ var **=** expression_
**if(_ expression **) statement _[ **else statement **]
**for(_ expression **; expression _;_ expression _)_ statement_
**for(_ array **[ var _])_ statement_
**forr(_ array **[ var _])_ statement_
**while(_ expression **) statement_
**switch(_ expression **) case statements_
**break [ expression **]
**continue [ expression **]
**return [_ expression **]_
.TE
.SM
Items in brackets are optional.

In the second form of the **for** statement and the **forr** statement, the variable _var_
is set to each value used as an index in the specified array and then
the associated _statement_ is evaluated. For numeric and string indices, the indices are 
returned in increasing (decreasing) numeric or lexicographic order for 
**for** (**forr**, respectively). This can be used for sorting.

Function definitions can only appear in the **BEGIN** clause.

Expressions include the usual C expressions. 
String comparisons using **==** and **!=**
treat the right hand operand as a pattern
for the purpose of regular expression matching.
Patterns use
_ksh_(1)
file match pattern syntax.
(For simple string equality, use the **strcmp** function.

**gvpr** will attempt to use an expression as a string or numeric value 
as appropriate. Both C-like casts and function templates will cause
conversions to be performed, if possible.

Expressions of graphical type (i.e., graph_t, node_t,
edge_t, obj\_t) may be followed by a field reference in the
form of **.**_name_. The resulting value is the value
of the attribute named _name_ of the given object.
In addition, in certain contexts an undeclared, unmodified
identifier is taken to be an
attribute name. Specifically, such identifiers denote attributes
of the current node or edge, respectively, in **N**
and **E** clauses, and the current graph in **BEG\_G** and **END\_G**
clauses.

As usual in the 
_libcgraph_(3)
model, attributes are string-valued.
In addition,
**gvpr**
supports certain pseudo-attributes of graph objects, not necessarily
string-valued. These reflect intrinsic properties of the graph objects
and cannot be set by the user.

* **head** : **node\_t**  
  the head of an edge.
* **tail** : **node\_t**  
  the tail of an edge.
* **name** : **string**  
  the name of an edge, node or graph. The name of an edge has the
  form "&lt;tail-name&gt;&lt;edge-op&gt;&lt;head-name&gt;**[&lt;key&gt;]**",
  where _&lt;edge-op&gt;_ is "**-&gt;**" or "**--**" depending on
  whether the graph is directed or not. The bracket part **[&lt;key&gt;]**
  only appears if the edge has a non-trivial key.
* **indegree** : **int**  
  the indegree of a node.
* **outdegree** : **int**  
  the outdegree of a node.
* **degree** : **int**  
  the degree of a node.
* **X** : **douible**  
  the X coordinate of a node. (Assumes the node has a _pos_ attribute.)
* **Y** : **douible**  
  the Y coordinate of a node. (Assumes the node has a _pos_ attribute.)
* **root** : **graph\_t**  
  the root graph of an object. The root of a root graph
  is itself.
* **parent** : **graph\_t**  
  the parent graph of a subgraph. The parent of a root graph
  is **NULL**
* **n\_edges** : **int**  
  the number of edges in the graph
* **n\_nodes** : **int**  
  the number of nodes in the graph
* **directed** : **int**  
  true (non-zero) if the graph is directed
* **strict** : **int**  
  true (non-zero) if the graph is strict

<a name="builthyin-functions"></a>

# Built\(Hyin Functions


The following functions are built into **gvpr**. Those functions
returning references to graph objects return **NULL** in case of failure.

<a name="graphs-and-subgraph"></a>

### Graphs and subgraph


* **graph**(_s_ : **string**, _t_ : **string**) : **graph\_t**  
  creates a graph whose name is _s_ and whose type is
  specified by the string _t_. Ignoring case, the characters
  **U, D, S, N** have the interpretation undirected, directed,
  strict, and non-strict, respectively. If _t_ is empty,
  a directed, non-strict graph is generated.
* **subg**(_g_ : **graph\_t**, _s_ : **string**) : **graph\_t**  
  creates a subgraph in graph _g_ with name _s_. If the subgraph
  already exists, it is returned.
* **isSubg**(_g_ : **graph\_t**, _s_ : **string**) : **graph\_t**  
  returns the subgraph in graph _g_ with name _s_, if it exists,
  or **NULL** otherwise.
* **fstsubg**(_g_ : **graph\_t**) : **graph\_t**  
  returns the first subgraph in graph _g_, or **NULL** if none exists.
* **nxtsubg**(_sg_ : **graph\_t**) : **graph\_t**  
  returns the next subgraph after _sg_, or **NULL**.
* **isDirect**(_g_ : **graph\_t**) : **int**  
  returns true if and only if _g_ is directed.
* **isStrict**(_g_ : **graph\_t**) : **int**  
  returns true if and only if _g_ is strict.
* **nNodes**(_g_ : **graph\_t**) : **int**  
  returns the number of nodes in _g_.
* **nEdges**(_g_ : **graph\_t**) : **int**  
  returns the number of edges in _g_.

<a name="nodes"></a>

### Nodes


* **node**(_sg_ : **graph\_t**, _s_ : **string**) : **node\_t**  
  creates a node in graph _g_ of name _s_. If such a node
  already exists, it is returned.
* **subnode**(_sg_ : **graph\_t**, _n_ : **node\_t**) : **node\_t**  
  inserts the node _n_ into the subgraph _g_. Returns the node.
* **fstnode**(_g_ : **graph\_t**) : **node\_t**  
  returns the first node in graph _g_, or **NULL** if none exists.
* **nxtnode**(_n_ : **node\_t**) : **node\_t**  
  returns the next node after _n_ in the root graph, or **NULL**.
* **nxtnode\_sg**(_sg_ : **graph\_t**, _n_ : **node\_t**) : **node\_t**  
  returns the next node after _n_ in _sg_, or **NULL**.
* **isNode**(_sg_ : **graph\_t**, _s_ : **string**) : **node\_t**  
  looks for a node in (sub)graph _sg_ of name _s_. If such a node
  exists, it is returned. Otherwise, **NULL** is returned.
* **isSubnode**(_sg_ : **graph\_t**, _n_ : **node\_t**) : **int**  
  returns non-zero if node _n_ is in (sub)graph _sg_, or zero
  otherwise.
* **indegreeOf**(_sg_ : **graph\_t**, _n_ : **node\_t**) : **int**  
  returns the indegree of node _n_ in (sub)graph _sg_.
* **outdegreeOf**(_sg_ : **graph\_t**, _n_ : **node\_t**) : **int**  
  returns the outdegree of node _n_ in (sub)graph _sg_.
* **degreeOf**(_sg_ : **graph\_t**, _n_ : **node\_t**) : **int**  
  returns the degree of node _n_ in (sub)graph _sg_.

<a name="edges"></a>

### Edges


* **edge**(_t_ : **node\_t**, _h_ : **node\_t**, _s_ : **string**) : **edge\_t**  
  creates an edge with tail node _t_, head node _h_ and
  name _s_ in the root graph. If the graph is undirected, the 
  distinction between head and tail nodes is unimportant.
  If such an edge already exists, it is returned.
* **edge\_sg**(_sg_ : **graph\_t**, _t_ : **node\_t**, _h_ : **node\_t**, _s_ : **string**) : **edge\_t**  
  creates an edge with tail node _t_, head node _h_ and name _s_ 
  in (sub)graph _sg_ (and all parent graphs). If the graph is undirected, the distinction between
  head and tail nodes is unimportant.
  If such an edge already exists, it is returned.
* **subedge**(_g_ : **graph\_t**, _e_ : **edge\_t**) : **edge\_t**  
  inserts the edge _e_ into the subgraph _g_. Returns the edge.
* **isEdge**(_t_ : **node\_t**, _h_ : **node\_t**, _s_ : **string**) : **edge\_t**  
  looks for an edge with tail node _t_, head node _h_ and
  name _s_. If the graph is undirected, the distinction between
  head and tail nodes is unimportant.
  If such an edge exists, it is returned. Otherwise, **NULL** is returned.
* **isEdge\_sg**(_sg_ : **graph\_t**, _t_ : **node\_t**, _h_ : **node\_t**, _s_ : **string**) : **edge\_t**  
  looks for an edge with tail node _t_, head node _h_ and
  name _s_ in (sub)graph _sg_. If the graph is undirected, the distinction between
  head and tail nodes is unimportant.
  If such an edge exists, it is returned. Otherwise, **NULL** is returned.
* **isSubedge**(_g_ : **graph\_t**, _e_ : **edge\_t**) : **int**  
  returns non-zero if edge _e_ is in (sub)graph _sg_, or zero
  otherwise.
* **fstout**(_n_ : **node\_t**) : **edge\_t**  
  returns the first outedge of node _n_ in the root graph.
* **fstout\_sg**(_sg_ : **graph\_t**, _n_ : **node\_t**) : **edge\_t**  
  returns the first outedge of node _n_ in (sub)graph _sg_.
* **nxtout**(_e_ : **edge\_t**) : **edge\_t**  
  returns the next outedge after _e_ in the root graph.
* **nxtout\_sg**(_sg_ : **graph\_t**, _e_ : **edge\_t**) : **edge\_t**  
  returns the next outedge after _e_ in graph _sg_.
* **fstin**(_n_ : **node\_t**) : **edge\_t**  
  returns the first inedge of node _n_ in the root graph.
* **fstin\_sg**(_sg_ : **graph\_t**, _n_ : **node\_t**) : **edge\_t**  
  returns the first inedge of node _n_ in graph _sg_.
* **nxtin**(_e_ : **edge\_t**) : **edge\_t**  
  returns the next inedge after _e_ in the root graph.
* **nxtin\_sg**(_sg_ : **graph\_t**, _e_ : **edge\_t**) : **edge\_t**  
  returns the next inedge after _e_ in graph _sg_.
* **fstedge**(_n_ : **node\_t**) : **edge\_t**  
  returns the first edge of node _n_ in the root graph.
* **fstedge\_sg**(_sg_ : **graph\_t**, _n_ : **node\_t**) : **edge\_t**  
  returns the first edge of node _n_ in graph _sg_.
* **nxtedge**(_e_ : **edge\_t**, **node\_t**) : **edge\_t**  
  returns the next edge after _e_ in the root graph.
* **nxtedge\_sg**(_sg_ : **graph\_t**, _e_ : **edge\_t**, **node\_t**) : **edge\_t**  
  returns the next edge after _e_ in the graph _sg_.
* **opp**(_e_ : **edge\_t**, **node\_t**) : **node\_t**  
  returns the node on the edge _e_ not equal to _n_.
  Returns NULL if _n_ is not a node of _e_.
  This can be useful when using **fstedge** and **nxtedge**
  to enumerate the neighbors of _n_.

<a name="graph-io"></a>

### Graph I/O


* **write**(_g_ : **graph\_t**) : **void**  
  prints _g_ in dot format onto the output stream.
* **writeG**(_g_ : **graph\_t**, _fname_ : **string**) : **void**  
  prints _g_ in dot format into the file _fname_.
* **fwriteG**(_g_ : **graph\_t**, _fd_ : **int**) : **void**  
  prints _g_ in dot format onto the open stream denoted
  by the integer _fd_.
* **readG**(_fname_ : **string**) : **graph\_t**  
  returns a graph read from the file _fname_. The graph should be
  in dot format. If no graph can be read, **NULL** is returned.
* **freadG**(_fd_ : **int**) : **graph\_t**  
  returns the next graph read from the open stream _fd_.
  Returns **NULL** at end of file.

<a name="graph-miscellany"></a>

### Graph miscellany


* **delete**(_g_ : **graph\_t**, _x_ : **obj\_t**) : **void**  
  deletes object _x_ from graph _g_.
  If _g_ is **NULL**, the function uses the root graph of _x_.
  If _x_ is a graph or subgraph, it is closed unless _x_ is locked.
* **isIn**(_g_ : **graph\_t**, _x_ : **obj\_t**) : **int**  
  returns true if _x_ is in subgraph _g_.
* **cloneG**(_g_ : **graph\_t**, _s_ : **string**) : **graph\_t**  
  creates a clone of graph _g_ with name of _s_.
  If _s_ is "", the created graph has the same name as _g_.
* **clone**(_g_ : **graph\_t**, _x_ : **obj\_t**) : **obj\_t**  
  creates a clone of object _x_ in graph _g_.
  In particular, the new object has the same name/value attributes
  and structure as the original object.
  If an object with the same key as _x_ already exists, its attributes
  are overlaid by those of _x_ and the object is returned.
  If an edge is cloned, both endpoints are implicitly cloned.
  If a graph is cloned, all nodes, edges and subgraphs are implicitly
  cloned.
  If _x_ is a graph, _g_ may be **NULL**, in which case the cloned
  object will be a new root graph. In this case, the call is equivalent
  to **cloneG(**_x_**,"")**.
* **copy**(_g_ : **graph\_t**, _x_ : **obj\_t**) : **obj\_t**  
  creates a copy of object _x_ in graph _g_,
  where the new object has the same name/value attributes
  as the original object.
  If an object with the same key as _x_ already exists, its attributes
  are overlaid by those of _x_ and the object is returned.
  Note that this is a shallow copy. If _x_ is a graph, none of its nodes, 
  edges or subgraphs are copied into the new graph. If _x_ is an edge,
  the endpoints are created if necessary, but they are not cloned.
  If _x_ is a graph, _g_ may be **NULL**, in which case the cloned
  object will be a new root graph.
* **copyA**(_src_ : **obj\_t**, _tgt_ : **obj\_t**) : **int**  
  copies the attributes of object _src_ to object _tgt_, overwriting
  any attribute values _tgt_ may initially have.
* **induce**(_g_ : **graph\_t**) : **void**  
  extends _g_ to its node-induced subgraph extension in its root graph.
* **hasAttr**(_src_ : **obj\_t**, _name_ : **string**) : **int**  
  returns non-zero if object _src_ has an attribute whose name is
  _name_. It returns 0 otherwise.
* **isAttr**(_g_ : **graph\_t**, _kind_ : **string**, _name_ : **string**) : **int**  
  returns non-zero if an attribute _name_ has been defined in _g_
  for objects of the given _kind_. For nodes, edges, and graphs, _kind_
  should be "N", "E", and "G", respectively.
  It returns 0 otherwise.
* **aget**(_src_ : **obj\_t**, _name_ : **string**) : **string**  
  returns the value of attribute _name_ in object _src_. This is
  useful for those cases when _name_ conflicts with one of the keywords
  such as "head" or "root".
  If the attribute has not been declared in the graph, the function will
  initialize it with a default value of "". To avoid this, one should use
  the **hasAttr** or **isAttr** function to check that the attribute exists.
* **aset**(_src_ : **obj\_t**, _name_ : **string**, _value_ : **string**) : **int**  
  sets the value of attribute _name_ in object _src_ to _value_.
  Returns 0 on success, non-zero on failure. See **aget** above.
* **getDflt**(_g_ : **graph\_t**, _kind_ : **string**, _name_ : **string**) : **string**  
  returns the default value of attribute _name_ in objects in _g_ of
  the given _kind_. For nodes, edges, and graphs, _kind_
  should be "N", "E", and "G", respectively.
  If the attribute has not been declared in the graph, the function will
  initialize it with a default value of "". To avoid this, one should use
  the **isAttr** function to check that the attribute exists.
* **setDflt**(_g_ : **graph\_t**, _kind_ : **string**, _name_ : **string**, _value_ : **string**) : **int**  
  sets the default value of attribute _name_ to _value_ in 
  objects in _g_ of
  the given _kind_. For nodes, edges, and graphs, _kind_
  should be "N", "E", and "G", respectively.
  Returns 0 on success, non-zero on failure. See **getDflt** above.
* **fstAttr**(_g_ : **graph\_t**, _kind_ : **string**) : **string**  
  returns the name of the first attribute of objects in _g_ of
  the given _kind_. For nodes, edges, and graphs, _kind_
  should be "N", "E", and "G", respectively.
  If there are no attributes, the string "" is returned.
* **nxtAttr**(_g_ : **graph\_t**, _kind_ : **string**, _name_ : **string**) : **string**  
  returns the name of the next attribute of objects in _g_ of
  the given _kind_ after the attribute _name_. 
  The argument _name_ must be the name of an existing attribute; it will
  typically be the return value of an previous call to **fstAttr** or
  **nxtAttr**.
  For nodes, edges, and graphs, _kind_
  should be "N", "E", and "G", respectively.
  If there are no attributes left, the string "" is returned.
* **compOf**(_g_ : **graph\_t**, _n_ : **node\_t**) : **graph\_t**  
  returns the connected component of the graph _g_ containing node _n_,
  as a subgraph of _g_. The subgraph only contains the nodes. One can
  use _induce_ to add the edges. The function fails and returns **NULL**
  if _n_ is not in _g_. Connectivity is based on the underlying
  undirected graph of _g_.
* **kindOf**(_obj_ : **obj\_t**) : **string**  
  returns an indication of the type of _obj_.
  For nodes, edges, and graphs, it returns "N", "E", and "G", respectively.
* **lock**(_g_ : **graph\_t**, _v_ : **int**) : **int**  
  implements graph locking on root graphs. If the integer _v_ is positive, the
  graph is set so that future calls to **delete** have no immediate effect.
  If _v_ is zero, the graph is unlocked. If there has been a call
  to delete the graph while it was locked, the graph is closed.
  If _v_ is negative, nothing is done.
  In all cases, the previous lock value is returned.

<a name="strings"></a>

### Strings


* **sprintf**(_fmt_ : **string**, _..._) : **string**  
  returns the string resulting from formatting
  the values of the expressions occurring after _fmt_
  according to the
  _printf_(3)
  format
  _fmt_
* **gsub**(_str_ : **string**, _pat_ : **string**) : **string**  
* **gsub**(_str_ : **string**, _pat_ : **string**, _repl_ : **string**) : **string**  
  returns _str_ with all substrings matching _pat_
  deleted or replaced by _repl_, respectively.
* **sub**(_str_ : **string**, _pat_ : **string**) : **string**  
* **sub**(_str_ : **string**, _pat_ : **string**, _repl_ : **string**) : **string**  
  returns _str_ with the leftmost substring matching _pat_
  deleted or replaced by _repl_, respectively. The 
  characters '^' and '$'
  may be used at the beginning and end, respectively,
  of _pat_ to anchor the pattern to the beginning or end of _str_.
* **substr**(_str_ : **string**, _idx_ : **int**) : **string**  
* **substr**(_str_ : **string**, _idx_ : **int**, _len_ : **int**) : **string**  
  returns the substring of _str_ starting at position _idx_ to
  the end of the string or of length _len_, respectively.
  Indexing starts at 0. If _idx_ is negative or _idx_ is greater than
  the length of _str_, a fatal error occurs. Similarly, in the second
  case, if _len_ is negative or _idx_ + _len_ is greater than the
  length of _str_, a fatal error occurs.
* **strcmp**(_s1_ : **string**, _s2_ : **string**) : **int**  
  provides the standard C function
  _strcmp_(3).
* **length**(_s_ : **string**) : **int**  
  returns the length of string _s_.
* **index**(_s_ : **string**, _t_ : **string**) : **int**  
* **rindex**(_s_ : **string**, _t_ : **string**) : **int**  
  returns the index of the character in string _s_ where the leftmost
  (rightmost) copy of string _t_ can be found, or -1 if _t_ is not a 
  substring of _s_.
* **match**(_s_ : **string**, _p_ : **string**) : **int**  
  returns the index of the character in string _s_ where the leftmost
  match of pattern _p_ can be found, or -1 if no substring of _s_
  matches _p_.
* **toupper**(_s_ : **string**) : **string**  
  returns a version of _s_ with the alphabetic characters converted to upper-case.
* **tolower**(_s_ : **string**) : **string**  
  returns a version of _s_ with the alphabetic characters converted to lower-case.
* **canon**(_s_ : **string**) : **string**  
  returns a version of _s_ appropriate to be used as an identifier
  in a dot file.
* **html**(_g_ : **graph\_t**, _s_ : **string**) : **string**  
  returns a \`\`magic'' version  of _s_ as an HTML string. This will typically be
  used to attach an HTML-like label to a graph object. Note that the returned string
  lives in _g_. In particular, it will be freed when _g_ is closed, and to
  act as an HTML string, it has to be used with an object of _g_. In addition,
  note that the
  angle bracket quotes should not be part of _s_. These will be added if 
  _g_ is written in concrete DOT format.
* **ishtml**(_s_ : **string**) : **int**  
  returns non-zero if and only if _s_ is an HTML string.
* **xOf**(_s_ : **string**) : **string**  
  returns the string "_x_" if _s_ has the form "_x_,_y_", 
  where both _x_ and _y_ are numeric.
* **yOf**(_s_ : **string**) : **string**  
  returns the string "_y_" if _s_ has the form "_x_,_y_", 
  where both _x_ and _y_ are numeric.
* **llOf**(_s_ : **string**) : **string**  
  returns the string "_llx_,_lly_" if _s_ has the form 
  "_llx_,_lly_,_urx_,_ury_",
  where all of _llx_, _lly_, _urx_, and _ury_ are numeric.
* **urOf(**_s_**)**  
  **urOf**(_s_ : **string**) : **string**
  returns the string "_urx_,_ury_" if _s_ has the form 
  "_llx_,_lly_,_urx_,_ury_",
  where all of _llx_, _lly_, _urx_, and _ury_ are numeric.
* **sscanf**(_s_ : **string**, _fmt_ : **string**, _..._) : **int**  
  scans the string _s_, extracting values
  according to the
  _sscanf_(3)
  format
  _fmt_.
  The values are stored in the addresses following _fmt_,
  addresses having the form **&**_v_, where _v_ is some declared
  variable of the correct type.
  Returns the number of items successfully scanned.
* **split**(_s_ : **string**, _arr_ : **array**, _seps_ : **string**) : **int**  
* **split**(_s_ : **string**, _arr_ : **array**) : **int**  
* **tokens**(_s_ : **string**, _arr_ : **array**, _seps_ : **string**) : **int**  
* **tokens**(_s_ : **string**, _arr_ : **array**) : **int**  
  The **split** function breaks the string _s_ into fields, while the **tokens** function
  breaks the string into tokens. 
  A field consists of all non-separator characters between two separator characters or the beginning or
  end of the string. Thus, a field may be the empty string. A
  token is a maximal, non-empty substring not containing a separator character.
  The separator characters are those given in the _seps_ argument.
  If _seps_ is not provided, the default value is " \\t\\n". 
  The functions return the number of fields or tokens.

The fields and tokens are stored in the argument array. The array must be **string**-valued and
have **int** as its index type. The entries are indexed by consecutive
integers, starting at 0. Any values already stored in the array will be either overwritten, or
still be present after the function returns.

<a name="io"></a>

### I/O


* **print**(_..._) : **void**  
  **print(**_ expr_**,**_..._**)**
  prints a string representation of each argument in turn onto
  **stdout**, followed by a newline.
* **printf**(_fmt_ : **string**, _..._) : **int**  
* **printf**(_fd_ : **int**, _fmt_ : **string**, _..._) : **int**  
  prints the string resulting from formatting
  the values of the expressions following _fmt_
  according to the
  _printf_(3)
  format
  _fmt_.
  Returns 0 on success.
  By default, it prints on **stdout**.
  If the optional integer _fd_ is given, output is written on the open
  stream associated with _fd_.
* **scanf**(_fmt_ : **string**, _..._) : **int**  
* **scanf**(_fd_ : **int**, _fmt_ : **string**, _..._) : **int**  
  scans in values from an input stream according to the
  _scanf_(3)
  format
  _fmt_.
  The values are stored in the addresses following _fmt_,
  addresses having the form **&**_v_, where _v_ is some declared
  variable of the correct type.
  By default, it reads from **stdin**.
  If the optional integer _fd_ is given, input is read from the open
  stream associated with _fd_.
  Returns the number of items successfully scanned.
* **openF**(_s_ : **string**, _t_ : **string**) : **int**  
  opens the file _s_ as an I/O stream. The string argument _t_
  specifies how the file is opened. The arguments are the same as for
  the C function
  _fopen_(3).
  It returns an integer denoting the stream, or -1 on error.

As usual, streams 0, 1 and 2 are already open as **stdin**, **stdout**,
and **stderr**, respectively. Since **gvpr** may use **stdin** to
read the input graphs, the user should avoid using this stream.

* **closeF**(_fd_ : **int**) : **int**  
  closes the open stream denoted by the integer _fd_.
  Streams  0, 1 and 2 cannot be closed.
  Returns 0 on success.
* **readL**(_fd_ : **int**) : **string**  
  returns the next line read from the input stream _fd_. It returns
  the empty string "" on end of file. Note that the newline character is
  left in the returned string.

<a name="math"></a>

### Math


* **exp**(_d_ : **double**) : **double**  
  returns e to the _d_th power.
* **log**(_d_ : **double**) : **double**  
  returns the natural log of _d_.
* **sqrt**(_d_ : **double**) : **double**  
  returns the square root of the double _d_.
* **pow**(_d_ : **double**, _x_ : **double**) : **double**  
  returns _d_ raised to the _x_th power.
* **cos**(_d_ : **double**) : **double**  
  returns the cosine of _d_.
* **sin**(_d_ : **double**) : **double**  
  returns the sine of _d_.
* **atan2**(_y_ : **double**, _x_ : **double**) : **double**  
  returns the arctangent of _y/x_ in the range -pi to pi.
* **MIN**(_y_ : **double**, _x_ : **double**) : **double**  
  returns the minimum of _y_ and _x_.
* **MAX**(_y_ : **double**, _x_ : **double**) : **double**  
  returns the maximum of _y_ and _x_.

<a name="associative-arrays"></a>

### Associative Arrays


* **#** _arr_ : **int**  
  returns the number of elements in the array _arr_.
* _idx_ **in** _arr_ : **int**  
  returns 1 if a value has been set for index _idx_ in the array _arr_.
  It returns 0 otherwise.
* **unset**(_v_ : **array**, _idx_) : **int**  
  removes the item indexed by _idx_. It returns 1 if the item existed, 0 otherwise.
* **unset**(_v_ : **array**) : **void**  
  re-initializes the array.

<a name="miscellaneous"></a>

### Miscellaneous


* **exit**(_v_ : **int**) : **void**  
  causes
  **gvpr**
  to exit with the exit code
  _v_.
* **system**(_cmd_ : **string**) : **int**  
  provides the standard C function
  _system_(3).
  It executes _cmd_ in the user's shell environment, and
  returns the exit status of the shell.
* **rand**() : **double**  
  returns a pseudo-random double between 0 and 1.
* **srand**() : **int**  
* **srand**(_v_ : **int**) : **int**  
  sets a seed for the random number generator. The optional argument gives
  the seed; if it is omitted, the current time is used. The previous seed
  value is returned. **srand** should be called before any calls to
  **rand**.
* **colorx**(_color_ : **string**, _fmt_ : **string**) : **string**  
  translates a color from one format to another. The _color_ argument should be
  a color in one of the recognized string representations. The _fmt_ value should
  be one of "RGB", "RGBA", "HSV", or "HSVA".
  An empty string is returned on error.

<a name="builthyin-variables"></a>

# Built\(Hyin Variables


**gvpr**
provides certain special, built-in variables, whose values are set
automatically by **gvpr** depending on the context. Except as noted,
the user cannot modify their values.

* **$** : **obj\_t**  
  denotes the current object (node, edge, graph) depending on the
  context.  It is not available in **BEGIN** or **END** clauses.
* **$F** : **string**  
  is the name of the current input file. 
* **$G** : **graph\_t**  
  denotes the current graph being processed. It is not available
  in **BEGIN** or **END** clauses.
* **$NG** : **graph\_t**  
  denotes the next graph to be processed. If **$NG** is NULL, 
  the current graph **$G** is the last graph. Note that if the input
  comes from stdin, the last graph cannot be determined until the input
  pipe is closed. 
  It is not available in **BEGIN** or **END** clauses, or if the 
  **-n** flag is used.
* **$O** : **graph\_t**  
  denotes the output graph. Before graph traversal, it is initialized
  to the target graph. After traversal and any **END\_G** actions,
  if it refers to a non-empty graph, that graph is printed onto the output stream.
  It is only valid in **N**, **E** and **END\_G** clauses.
  The output graph may be set by the user.
* **$T** : **graph\_t**  
  denotes the current target graph. It is a subgraph of **$G**
  and is available only in **N**, **E** and **END\_G** clauses.
* **$tgtname** : **string**  
  denotes the name of the target graph. 
  By default, it is set to **"gvpr\_result"**.
  If used multiple times during the execution of
  **gvpr**,
  the name will be appended with an integer. 
  This variable may be set by the user.
* **$tvroot** : **node\_t**  
  indicates the starting node for a (directed or undirected)
  depth-first or breadth-first traversal of the
  graph (cf. **$tvtype** below).
  The default value is **NULL** for each input graph.
  After the traversal at the given root, if the value of **$tvroot** has changed,
  a new traversal will begin with the new value of **$tvroot**. Also, set **$tvnext** below.
* **$tvnext** : **node\_t**  
  indicates the next starting node for a (directed or undirected)
  depth-first or breadth-first traversal of the
  graph (cf. **$tvtype** below).
  If a traversal finishes and the **$tvroot** has not been reset but the **$tvnext** has been
  set but not used, this node will be used as the next choice for **$tvroot**.
  The default value is **NULL** for each input graph.
* **$tvedge** : **edge\_t**  
  For BFS and DFS traversals, this is set to the edge used to arrive at the
  current node or edge. At the beginning of a traversal, or for other traversal
  types, the value is **NULL**.
* **$tvtype** : **tvtype\_t**  
  indicates how **gvpr** traverses a graph. It can only take
  one of the constant values with the previx "TV_" described below.
  **TV\_flat** is the default.
* In the underlying graph library
  _cgraph_(3),
  edges in undirected graphs are given an arbitrary direction. This is
  used for traversals, such as **TV\_fwd**, requiring directed edges.
* **ARGC** : **int**  
  denotes the number of arguments specified by the 
  **-a** _args_ command-line argument.
* **ARGV** : **string array**  
  denotes the array of arguments specified by the 
  **-a** _args_
  command-line argument. The _i_th argument is given
  by **ARGV[_i**]_.

<a name="builthyin-constants"></a>

# Built\(Hyin Constants


There are several symbolic constants defined by **gvpr**.

* **NULL** : _obj\_t_  
  a null object reference, equivalent to 0.
* **TV\_flat** : _tvtype\_t_  
  a simple, flat traversal, with graph objects visited in
  seemingly arbitrary order.
* **TV\_ne** : _tvtype\_t_  
  a traversal which first visits all of the nodes, then all
  of the edges.
* **TV\_en** : _tvtype\_t_  
  a traversal which first visits all of the edges, then all
  of the nodes.
* **TV\_dfs** : _tvtype\_t_  
  .TQ
  **TV\_postdfs** : _tvtype\_t_
  .TQ
  **TV\_prepostdfs** : _tvtype\_t_
  a traversal of the graph using a depth-first search on the
  underlying undirected graph. 
  To do the traversal, **gvpr** will check the value of
  **$tvroot**. If this has the same value that it had previously
  (at the start, the previous value is initialized to **NULL**.), **gvpr**
  will simply look for some unvisited node and traverse its connected
  component. On the other hand, if **$tvroot** has changed, its connected
  component will be toured, assuming it has not been previously visited or,
  if **$tvroot** is **NULL**, the traversal will stop. Note that using
  **TV\_dfs** and **$tvroot**, it is possible to create an infinite loop.
* By default, the traversal is done in pre-order. That is, a node is
  visited before all of its unvisited edges. For **TV\_postdfs**,
  all of a node's unvisited edges are visited before the node. For
  **TV\_prepostdfs**, a node is visited twice, before and after all of
  its unvisited edges.
* **TV\_fwd** : _tvtype\_t_  
  .TQ
  **TV\_postfwd** : _tvtype\_t_
  .TQ
  **TV\_prepostfwd** : _tvtype\_t_
  A traversal of the graph using a depth-first search on the
  graph following only forward arcs.
  The choice of roots for the traversal is the
  same as described for **TV\_dfs** above.
  The different order of visitation specified by **TV\_fwd**,
  **TV\_postfwd** and **TV\_prepostfwd** are the same as those
  specified by the analogous traversals **TV\_dfs**,
  **TV\_postdfs** and **TV\_prepostdfs**.
* **TV\_rev** : _tvtype\_t_  
  .TQ
  **TV\_postrev** : _tvtype\_t_
  .TQ
  **TV\_prepostrev** : _tvtype\_t_
  A traversal of the graph using a depth-first search on the
  graph following only reverse arcs.
  The choice of roots for the traversal is the
  same as described for **TV\_dfs** above.
  The different order of visitation specified by **TV\_rev**,
  **TV\_postrev** and **TV\_prepostrev** are the same as those
  specified by the analogous traversals **TV\_dfs**,
  **TV\_postdfs** and **TV\_prepostdfs**.
* **TV\_bfs** : _tvtype\_t_  
  A traversal of the graph using a breadth-first search on the
  graph ignoring edge directions. See the item on **TV\_dfs** above
  for the role of **$tvroot**.

<a name="examples"></a>

# Examples


    gvpr -i 'N[color=="blue"]' file.gv
.DT

Generate the node-induced subgraph of all nodes with color blue.

    gvpr -c 'N[color=="blue"]{color = "red"}' file.gv
.DT

Make all blue nodes red.

    BEGIN { int n, e; int tot_n = 0; int tot_e = 0; }
    BEG_G {
      n = nNodes($G);
      e = nEdges($G);
      printf ("%d nodes %d edges %s\n", n, e, $G.name);
      tot_n += n;
      tot_e += e;
    }
    END { printf ("%d nodes %d edges total\n", tot_n, tot_e) }
.DT

Version of the program **gc**.

    gvpr -c ""
.DT

Equivalent to **nop**.

    BEG_G { graph_t g = graph ("merge", "S"); }
    E {
      node_t h = clone(g,$.head);
      node_t t = clone(g,$.tail);
      edge_t e = edge(t,h,"");
      e.weight = e.weight + 1;
    }
    END_G { $O = g; }
.DT

Produces a strict version of the input graph, where the weight attribute
of an edge indicates how many edges from the input graph the edge represents.

    BEGIN {node_t n; int deg[]}
    E{deg[head]++; deg[tail]++; }
    END_G {
      for (deg[n]) {
        printf ("deg[%s] = %d\n", n.name, deg[n]);
      }
    }
.DT

Computes the degrees of nodes with edges.

    BEGIN {
      int i, indent;
      int seen[string];
      void prInd (int cnt) {
        for (i = 0; i < cnt; i++) printf ("  ");
      }
    }
    BEG_G {
    
       $tvtype = TV_prepostfwd;
       $tvroot = node($,ARGV[0]);
    }
    N {
      if (seen[$.name]) indent--;
      else {
        prInd(indent);
          print ($.name);
        seen[$.name] = 1;
        indent++;
      }
    }
.DT

Prints the depth-first traversal of the graph, starting
with the node whose name is **ARGV[0]**, as an indented list.

<a name="environment"></a>

# Environment


* **GVPRPATH**  
  Colon-separated list of directories to be searched to find
  the file specified by the -f option. **gvpr** has a default list built in. If **GVPRPATH**
  is not defined, the default list is used. If **GVPRPATH** starts with colon, the list is formed
  by appending **GVPRPATH** to the default list. If **GVPRPATH** ends with colon, the list is formed
  by appending the default list to **GVPRPATH**. Otherwise, **GVPRPATH** is used for the list.

On Windows systems, replace \`\`colon'' with \`\`semicolon'' in the previous paragraph.

<a name="bugs-and-warnings"></a>

# Bugs and Warnings

Scripts should be careful deleting nodes during **N{}** and **E{}**
blocks using BFS and DFS traversals as these rely on stacks and queues of
nodes. 

When the program is given as a command line argument, the usual
shell interpretation takes place, which may affect some of the
special names in **gvpr**. To avoid this, it is best to wrap the
program in single quotes.

If string constants contain pattern metacharacters that you want to
escape to avoid pattern matching, two backslashes will probably be
necessary, as a single backslash will be lost when the string is
originally scanned. Usually, it is simpler to use **strcmp** to
avoid pattern matching.

As of 24 April 2008, **gvpr** switched to using a new, underlying
graph library, which uses the simpler model that there is only one
copy of a node, not one copy for each subgraph logically containing
it. This means that iterators such as _nxtnode_ cannot traverse
a subgraph using just a node argument. For this reason, subgraph
traversal requires new functions ending in "_sg", which also take
a subgraph argument. The versions without that suffix will always
traverse the root graph.

There is a single global scope, except for formal function parameters,
and even these can interfere with the type system. Also, the 
extent of all variables is the entire life of the program. 
It might be preferable for scope
to reflect the natural nesting of the clauses, or for the program
to at least reset locally declared variables.
For now, it is advisable to use distinct names for all variables.

If a function ends with a complex statement, such as an
IF statement, with each branch doing a return, type checking may fail. 
Functions should use a return at the end.

The expr library does not support string values of (char*)0.
This means we can't distinguish between "" and (char*)0 edge keys.
For the purposes of looking up and creating edges, we translate "" 
to be (char*)0, since this latter value is
necessary in order to look up any edge with a matching head and tail.

Related to this, strings converted to integers act like char pointers,
getting the value 0 or 1 depending on whether the string consists
solely of zeroes or not. Thus, the ((int)"2") evaluates to 1.

The language inherits the usual C problems such as dangling references
and the confusion between '=' and '=='.

<a name="author"></a>

# Author

Emden R. Gansner &lt;[erg@research.att](mailto:erg@research.att).com&gt;

<a name="see-also"></a>

# See Also


awk(1), gc(1), dot(1), nop(1), expr(3), cgraph(3)
