# crushtool(8) - CRUSH map manipulation tool

dev, Apr 21, 2020

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

    crushtool ( -d map | -c map.txt | --build --num_osds numosds
    layer1 ... | --test ) [ -o outfile ]
```


```

<a name="description"></a>

# Description


**crushtool** is a utility that lets you create, compile, decompile
and test CRUSH map files.

CRUSH is a pseudo-random data distribution algorithm that efficiently
maps input values (which, in the context of Ceph, correspond to Placement
Groups) across a heterogeneous, hierarchically structured device map.
The algorithm was originally described in detail in the following paper
(although it has evolved some since then):
.INDENT 0.0
.INDENT 3.5

    .ft C
    http://www.ssrc.ucsc.edu/Papers/weil-sc06.pdf
    .ft P
.UNINDENT
.UNINDENT

The tool has four modes of operation.
.INDENT 0.0

* **--compile|-c map.txt**  
  will compile a plaintext map.txt into a binary map file.
  .UNINDENT
  .INDENT 0.0
* **--decompile|-d map**  
  will take the compiled map and decompile it into a plaintext source
  file, suitable for editing.
  .UNINDENT
  .INDENT 0.0
* **--build --num_osds {num-osds} layer1 ...**  
  will create map with the given layer structure. See below for a
  detailed explanation.
  .UNINDENT
  .INDENT 0.0
* **--test**  
  will perform a dry run of a CRUSH mapping for a range of input
  values **[--min-x,--max-x]** (default **[0,1023]**) which can be
  thought of as simulated Placement Groups. See below for a more
  detailed explanation.
  .UNINDENT

Unlike other Ceph tools, **crushtool** does not accept generic options
such as **--debug-crush** from the command line. They can, however, be
provided via the CEPH_ARGS environment variable. For instance, to
silence all output from the CRUSH subsystem:
.INDENT 0.0
.INDENT 3.5

    .ft C
    CEPH_ARGS="--debug-crush 0" crushtool ...
    .ft P
.UNINDENT
.UNINDENT

<a name="running-tests-with-test"></a>

# Running Tests with --Test


The test mode will use the input crush map ( as specified with -i
map ) and perform a dry run of CRUSH mapping or random placement
(if **--simulate** is set ). On completion, two kinds of reports can be
created.
1) The **--show-...** option outputs human readable information
on stderr.
2) The **--output-csv** option creates CSV files that are
documented by the **--help-output** option.

Note: Each Placement Group (PG) has an integer ID which can be obtained
from **ceph pg dump** (for example PG 2.2f means pool id 2, PG id 32).
The pool and PG IDs are combined by a function to get a value which is
given to CRUSH to map it to OSDs. crushtool does not know about PGs or
pools; it only runs simulations by mapping values in the range
**[--min-x,--max-x]**.
.INDENT 0.0

* **--show-statistics**  
  Displays a summary of the distribution. For instance:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    rule 1 (metadata) num_rep 5 result size == 5:    1024/1024
    .ft P
.UNINDENT
.UNINDENT

shows that rule **1** which is named **metadata** successfully
mapped **1024** values to **result size == 5** devices when trying
to map them to **num_rep 5** replicas. When it fails to provide the
required mapping, presumably because the number of **tries** must
be increased, a breakdown of the failures is displayed. For instance:
.INDENT 7.0
.INDENT 3.5

    .ft C
    rule 1 (metadata) num_rep 10 result size == 8:   4/1024
    rule 1 (metadata) num_rep 10 result size == 9:   93/1024
    rule 1 (metadata) num_rep 10 result size == 10:  927/1024
    .ft P
.UNINDENT
.UNINDENT

shows that although **num_rep 10** replicas were required, **4**
out of **1024** values ( **4/1024** ) were mapped to result size
== 8 devices only.
.UNINDENT
.INDENT 0.0

* **--show-mappings**  
  Displays the mapping of each value in the range **[--min-x,--max-x]**.
  For instance:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    CRUSH rule 1 x 24 [11,6]
    .ft P
.UNINDENT
.UNINDENT

shows that value **24** is mapped to devices **[11,6]** by rule
**1**.
.UNINDENT
.INDENT 0.0

* **--show-bad-mappings**  
  Displays which value failed to be mapped to the required number of
  devices. For instance:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    bad mapping rule 1 x 781 num_rep 7 result [8,10,2,11,6,9]
    .ft P
.UNINDENT
.UNINDENT

shows that when rule **1** was required to map **7** devices, it
could map only six : **[8,10,2,11,6,9]**.
.UNINDENT
.INDENT 0.0

* **--show-utilization**  
  Displays the expected and actual utilization for each device, for
  each number of replicas. For instance:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    device 0: stored : 951      expected : 853.333
    device 1: stored : 963      expected : 853.333
    ...
    .ft P
.UNINDENT
.UNINDENT

shows that device **0** stored **951** values and was expected to store **853**.
Implies **--show-statistics**.
.UNINDENT
.INDENT 0.0

* **--show-utilization-all**  
  Displays the same as **--show-utilization** but does not suppress
  output when the weight of a device is zero.
  Implies **--show-statistics**.
  .UNINDENT
  .INDENT 0.0
* **--show-choose-tries**  
  Displays how many attempts were needed to find a device mapping.
  For instance:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    0:     95224
    1:      3745
    2:      2225
    ..
    .ft P
.UNINDENT
.UNINDENT

shows that **95224** mappings succeeded without retries, **3745**
mappings succeeded with one attempts, etc. There are as many rows
as the value of the **--set-choose-total-tries** option.
.UNINDENT
.INDENT 0.0

* **--output-csv**  
  Creates CSV files (in the current directory) containing information
  documented by **--help-output**. The files are named after the rule
  used when collecting the statistics. For instance, if the rule
  : 'metadata' is used, the CSV files will be:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    metadata-absolute_weights.csv
    metadata-device_utilization.csv
    ...
    .ft P
.UNINDENT
.UNINDENT

The first line of the file shortly explains the column layout. For
instance:
.INDENT 7.0
.INDENT 3.5

    .ft C
    metadata-absolute_weights.csv
    Device ID, Absolute Weight
    0,1
    ...
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--output-name NAME**  
  Prepend **NAME** to the file names generated when **--output-csv**
  is specified. For instance **--output-name FOO** will create
  files:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    FOO-metadata-absolute_weights.csv
    FOO-metadata-device_utilization.csv
    ...
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT

The **--set-...** options can be used to modify the tunables of the
input crush map. The input crush map is modified in
memory. For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ crushtool -i mymap --test --show-bad-mappings
    bad mapping rule 1 x 781 num_rep 7 result [8,10,2,11,6,9]
    .ft P
.UNINDENT
.UNINDENT

could be fixed by increasing the **choose-total-tries** as follows:
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* **$ crushtool -i mymap --test**  
  --show-bad-mappings --set-choose-total-tries 500
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="building-a-map-with-build"></a>

# Building a Map with --Build


The build mode will generate hierarchical maps. The first argument
specifies the number of devices (leaves) in the CRUSH hierarchy. Each
layer describes how the layer (or devices) preceding it should be
grouped.

Each layer consists of:
.INDENT 0.0
.INDENT 3.5

    .ft C
    bucket ( uniform | list | tree | straw ) size
    .ft P
.UNINDENT
.UNINDENT

The **bucket** is the type of the buckets in the layer
(e.g. "rack"). Each bucket name will be built by appending a unique
number to the **bucket** string (e.g. "rack0", "rack1"...).

The second component is the type of bucket: **straw** should be used
most of the time.

The third component is the maximum size of the bucket. A size of zero
means a bucket of infinite capacity.

<a name="example"></a>

# Example


Suppose we have two rows with two racks each and 20 nodes per rack. Suppose
each node contains 4 storage devices for Ceph OSD Daemons. This configuration
allows us to deploy 320 Ceph OSD Daemons. Lets assume a 42U rack with 2U nodes,
leaving an extra 2U for a rack switch.

To reflect our hierarchy of devices, nodes, racks and rows, we would execute
the following:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ crushtool -o crushmap --build --num_osds 320 e
           node straw 4 e
           rack straw 20 e
           row straw 2 e
           root straw 0
    # id        weight  type name       reweight
    -87 320     root root
    -85 160             row row0
    -81 80                      rack rack0
    -1  4                               node node0
    0   1                                       osd.0   1
    1   1                                       osd.1   1
    2   1                                       osd.2   1
    3   1                                       osd.3   1
    -2  4                               node node1
    4   1                                       osd.4   1
    5   1                                       osd.5   1
    ...
    .ft P
.UNINDENT
.UNINDENT

CRUSH rules are created so the generated crushmap can be
tested. They are the same rules as the ones created by default when
creating a new Ceph cluster. They can be further edited with:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # decompile
    crushtool -d crushmap -o map.txt
    
    # edit
    emacs map.txt
    
    # recompile
    crushtool -c map.txt -o crushmap
    .ft P
.UNINDENT
.UNINDENT

<a name="reclassify"></a>

# Reclassify


The _reclassify_ function allows users to transition from older maps that
maintain parallel hierarchies for OSDs of different types to a modern CRUSH
map that makes use of the _device class_ feature.  For more information,
see _http://docs.ceph.com/docs/master/rados/operations/crush-map-edits/#migrating-from-a-legacy-ssd-rule-to-device-classes_.

<a name="example-output-from-test"></a>

# Example Output from --Test


See _https://github.com/ceph/ceph/blob/master/src/test/cli/crushtool/set-choose.t_
for sample **crushtool --test** commands and output produced thereby.

<a name="availability"></a>

# Availability


**crushtool** is part of Ceph, a massively scalable, open-source, distributed storage system. Please
refer to the Ceph documentation at _http://ceph.com/docs_ for more
information.

<a name="see-also"></a>

# See Also


ceph(8),
osdmaptool(8),

<a name="authors"></a>

# Authors


John Wilkins, Sage Weil, Loic Dachary

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

