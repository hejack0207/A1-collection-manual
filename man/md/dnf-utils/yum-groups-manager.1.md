# yum-groups-manager(1) - redirecting to DNF groups-manager Plugin

4.0.22, Jun 15, 2021

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

Create and edit groups repository metadata files.

<a name="synopsis"></a>

# Synopsis

```

 dnf groups-manager [options] [package-name-spec [package-name-spec ...]]
```

<a name="description"></a>

# Description


groups-manager plugin is used to create or edit a group metadata file for a repository. This is often much easier than writing/editing the XML by hand. The groups-manager can load an entire file of groups metadata and either create a new group or edit an existing group and then write all of the groups metadata back out.

<a name="arguments"></a>

# Arguments

.INDENT 0.0

* <b>**&lt;package-name-spec&gt;**</b>  
  Package to add to a group or remove from a group.
  .UNINDENT

<a name="options"></a>

# Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.
.INDENT 0.0

* <b>**--load=&lt;path\_to\_comps.xml&gt;**</b>  
  Load the groups metadata information from the specified file before performing any operations. Metadata from all files are merged together if the option is specified multiple times.
* <b>**--save=&lt;path\_to\_comps.xml&gt;**</b>  
  Save the result to this file. You can specify the name of a file you are loading from as the data will only be saved when all the operations have been performed. This option can also be specified multiple times.
* <b>**--merge=&lt;path\_to\_comps.xml&gt;**</b>  
  This is the same as loading and saving a file, however the "merge" file is loaded before any others and saved last.
* <b>**--print**</b>  
  Also print the result to stdout.
* <b>**--id=&lt;id&gt;**</b>  
  The id to lookup/use for the group. If you don't specify an **&lt;id&gt;**, but do specify a name that doesn't refer to an existing group, then an id for the group is generated based on the name.
* <b>**-n &lt;name&gt;, --name=&lt;name&gt;**</b>  
  The name to lookup/use for the group. If you specify an existing group id, then the group with that id will have it's name changed to this value.
* <b>**--description=&lt;description&gt;**</b>  
  The description to use for the group.
* <b>**--display-order=&lt;display\_order&gt;**</b>  
  Change the integer which controls the order groups are presented in, for example in **dnf grouplist**.
* <b>**--translated-name=&lt;lang:text&gt;**</b>  
  A translation of the group name in the given language. The syntax is **lang:text**. Eg. **en:my-group-name-in-english**
* <b>**--translated-description=&lt;lang:text&gt;**</b>  
  A translation of the group description in the given language. The syntax is **lang:text**. Eg. **en:my-group-description-in-english**.
* <b>**--user-visible**</b>  
  Make the group visible in **dnf grouplist** (this is the default).
* <b>**--not-user-visible**</b>  
  Make the group not visible in **dnf grouplist**.
* <b>**--mandatory**</b>  
  Store the package names specified within the mandatory section of the specified group, the default is to use the default section.
* <b>**--optional**</b>  
  Store the package names specified within the optional section of the specified group, the default is to use the default section.
* <b>**--remove**</b>  
  Instead of adding packages remove them. Note that the packages are removed from all sections (default, mandatory and optional).
* <b>**--dependencies**</b>  
  Also include the names of the direct dependencies for each package specified.
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

