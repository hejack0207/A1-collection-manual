# dijkstra(1) - single-source distance filter

21 March 2001

```
dijkstra [ -adp? ] [  sourcenode file ]
```

<a name="description"></a>

# Description

**dijkstra**
reads a stream of graphs and for each computes the distance of every
node from
_sourcenode._
Edge length is given in the 
_len_
attribute, and the default is 1.  The 
_dist_
attribute of every node is set to its distance from
_sourcenode._
If the **-p** flag is used, the
_prev_
attribute of each node reachable from
_sourcenode_
is set to the name of the previous node on a shortest path.
The graph attribute
_maxdist_
is set to the maximum 
_dist_
of all nodes in the graph.

If the **-d** flag is used, the graph is treated as directed and 
only forward edges are used.

By default, if the graph is disconnected, the
_dist_
attribute of nodes unreachable from
_sourcenode_
are left untouched, and
_maxdist_
is set to the maximum of any previous value and the largest
distance recorded in this run. On the other hand, if
the **-a** flag is used, the
_dist_
attribute of an unreachable node is assigned a very large value,
and
_maxdist_
records the maximum distance found in the component containing
_sourcenode._

Any number of
_sourcenode file_
pairs may be given.
If the last 
_file_
is missing, **stdin** is used.
All output is written to **stdout**.

In a typical application,
_dist_
and 
_maxdist_
can drive a downstream calculation of color or some other attribute.

<a name="see-also"></a>

# See Also

gvpr(1), gvcolor(1), libgraph(3)
