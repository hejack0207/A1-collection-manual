# ceph-conf(8) - ceph conf file tool

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

    ceph-conf -c conffile --list-all-sections
    ceph-conf -c conffile -L
    ceph-conf -c conffile -l prefix
    ceph-conf key -s section1 ...
    ceph-conf [-s section ] [-r] --lookup key
    ceph-conf [-s section ] key
```


```

<a name="description"></a>

# Description


**ceph-conf** is a utility for getting information from a ceph
configuration file. As with most Ceph programs, you can specify which
Ceph configuration file to use with the **-c** flag.

Note that unlike other ceph tools, **ceph-conf** will _only_ read from
config files (or return compiled-in default values)--it will _not_
fetch config values from the monitor cluster.  For this reason it is
recommended that **ceph-conf** only be used in legacy environments
that are strictly config-file based.  New deployments and tools should
instead rely on either querying the monitor explicitly for
configuration (e.g., **ceph config get &lt;daemon&gt; &lt;option&gt;**) or use
daemons themselves to fetch effective config options (e.g.,
**ceph-osd -i 123 --show-config-value osd\_data**).  The latter option
has the advantages of drawing from compiled-in defaults (which
occasionally vary between daemons), config files, and the monitor's
config database, providing the exact value that that daemon would be
using if it were started.

<a name="actions"></a>

# Actions


**ceph-conf** performs one of the following actions:
.INDENT 0.0

* **-L, --list-all-sections**  
  list all sections in the configuration file.
  .UNINDENT
  .INDENT 0.0
* **-l, --list-sections *prefix***  
  list the sections with the given _prefix_. For example, **--list-sections mon**
  would list all sections beginning with **mon**.
  .UNINDENT
  .INDENT 0.0
* **--lookup *key***  
  search and print the specified configuration setting. Note:  **--lookup** is
  the default action. If no other actions are given on the command line, we will
  default to doing a lookup.
  .UNINDENT
  .INDENT 0.0
* **-h, --help**  
  print a summary of usage.
  .UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* **-c *conffile***  
  the Ceph configuration file.
  .UNINDENT
  .INDENT 0.0
* **--filter-key *key***  
  filter section list to only include sections with given _key_ defined.
  .UNINDENT
  .INDENT 0.0
* **--filter-key-value *key* \`\`=\`\` *value***  
  filter section list to only include sections with given _key_/_value_ pair.
  .UNINDENT
  .INDENT 0.0
* **--name *type.id***  
  the Ceph name in which the sections are searched (default 'client.admin').
  For example, if we specify **--name osd.0**, the following sections will be
  searched: [osd.0], [osd], [global]
  .UNINDENT
  .INDENT 0.0
* **-r, --resolve-search**  
  search for the first file that exists and can be opened in the resulted
  comma delimited search list.
  .UNINDENT
  .INDENT 0.0
* **-s, --section**  
  additional sections to search.  These additional sections will be searched
  before the sections that would normally be searched. As always, the first
  matching entry we find will be returned.
  .UNINDENT

<a name="examples"></a>

# Examples


To find out what value osd 0 will use for the "osd data" option:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-conf -c foo.conf  --name osd.0 --lookup "osd data"
    .ft P
.UNINDENT
.UNINDENT

To find out what value will mds a use for the "log file" option:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-conf -c foo.conf  --name mds.a "log file"
    .ft P
.UNINDENT
.UNINDENT

To list all sections that begin with "osd":
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-conf -c foo.conf -l osd
    .ft P
.UNINDENT
.UNINDENT

To list all sections:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-conf -c foo.conf -L
    .ft P
.UNINDENT
.UNINDENT

To print the path of the "keyring" used by "client.0":
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-conf --name client.0 -r -l keyring
    .ft P
.UNINDENT
.UNINDENT

<a name="files"></a>

# Files


**/etc/ceph/$cluster.conf**, **~/.ceph/$cluster.conf**, **$cluster.conf**

the Ceph configuration files to use if not specified.

<a name="availability"></a>

# Availability


**ceph-conf** is part of Ceph, a massively scalable, open-source, distributed storage system.  Please refer
to the Ceph documentation at _http://ceph.com/docs_ for more
information.

<a name="see-also"></a>

# See Also


ceph(8),

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

