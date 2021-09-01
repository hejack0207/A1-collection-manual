# cluster(1) - find clusters in a graph and augment the graph with this information.

3 March 2011

```
cluster [-v?] [ -Ck ] [ -ck ] [ -o outfile ] [  files ]
```

<a name="description"></a>

# Description

**cluster**
takes as input a graph in DOT format, finds node clusters and augments 
the graph with this information. 
The clusters are specified by the "cluster" attribute attached to nodes; cluster
values are non-negative integers.
**cluster**
attempts to maximize the modularity of the clustering.
If the edge attribute "weight" is defined, this will be used in 
computing the clustering.

<a name="options"></a>

# Options

The following options are supported:

* **-C**_k_  
  specifies a targeted number of clusters that should be generated.
  The specified number _k_ is only a suggestion and may not be realisable. 
  If _k == 0_, the default, the number of clusters that approximately optimizes the modularity is returned.
* **-c**_k_  
  specifies clustering method.
  If _k == 0_, the default, modularity clustering will be used. 
  If _k == 1_ modularity quality will be used.
* **-o**_outfile_  
  Specifies that output should go into the file _outfile_. By default,
  _stdout_ is used.
* **-v**  
  Verbose mode.

<a name="examples"></a>

# Examples


Applying 
**cluster**
to the following graph,

       graph {
           1--2 [weight=10.]
           2--3 [weight=1]
           3--4 [weight=10.]
           4--5 [weight=10]
           5--6 [weight=10]
           3--6 [weight=0.1]
           4--6 [weight=10.]
          }

gives

       graph {
             node [cluster="-1"];
             1 [cluster=1];
             2 [cluster=1];
             3 [cluster=2];
             4 [cluster=2];
             5 [cluster=2];
             6 [cluster=2];
             1 -- 2 [weight="10."];
             2 -- 3 [weight=1];
             3 -- 4 [weight="10."];
             4 -- 5 [weight=10];
             5 -- 6 [weight=10];
             3 -- 6 [weight="0.1"];
             4 -- 6 [weight="10."];
       }



<a name="author"></a>

# Author

Yifan Hu &lt;[yifanhu@yahoo.com](mailto:yifanhu@yahoo.com)&gt;

<a name="see-also"></a>

# See Also


gvmap(1)


Blondel, V.D., Guillaume, J.L., Lambiotte, R., Lefebvre, E.: Fast unfolding of communities in large networks. Journal of Statistical Mechanics: Theory and Experiment (2008), P10008.
