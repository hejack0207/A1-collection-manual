# rpmspec(8) - RPM Spec Tool

Red Hat, Inc, 29 October 2010


<a name="querying-spec-files"></a>

### QUERYING SPEC FILES:

```


</synopsis>

<synopsis>
rpmspec {-q|--query} [select-options] [query-options] SPEC_FILE ...
</synopsis>


<a name="parsing-spec-files-to-stdout"></a>

### PARSING SPEC FILES TO STDOUT:

<synopsis>


</synopsis>

<synopsis>
rpmspec {-P|--parse} SPEC_FILE ...
```


<a name="description"></a>

# Description


**rpmspec** is a tool for querying a spec file. More specifically for querying hypothetical packages which would be created from the given spec file. So querying a spec file with **rpmspec** is similar to querying a package built from that spec file. But is is not identical. With **rpmspec** you can't query all fields which you can query from a built package. E. g. you can't query BUILDTIME with **rpmspec** for obvious reasons. You also cannot query other fields automatically generated during a build of a package like auto generated dependencies.


<a name="select-options"></a>

### select-options



 [**--rpms**]
 [**--srpm**]


<a name="query-options"></a>

### query-options



 [**--qf,--queryformat QUERYFMT**]
 [**--target TARGET\_PLATFORM**]
 

<a name="query-options"></a>

### QUERY OPTIONS


The general form of an rpm spec query command is 


**rpm** {**-q|--query**} [**select-options**] [**query-options**]


You may specify the format that the information should be
printed in. To do this, you use the

 **--qf|--queryformat** **QUERYFMT**

option, followed by the _QUERYFMT_ format string.
See **rpm(8)** for details.



<a name="select-options"></a>

### SELECT OPTIONS


 **--rpms**
Operate on the all binary package headers generated from spec.
 **--builtrpms**
Operate only on the binary package headers of packages which would be built from spec. That means ignoring package headers of packages that won't be built from spec i. e. ignoring package headers of packages without file section.
 **--srpm**
Operate on the source package header(s) generated from spec.


<a name="examples"></a>

# Examples


Get list of binary packages which would be generated from the rpm spec file:

     $ rpmspec -q rpm.spec
     rpm-4.11.3-3.fc20.x86_64
     rpm-libs-4.11.3-3.fc20.x86_64
     rpm-build-libs-4.11.3-3.fc20.x86_64
     ...
    .RE
    
    Get summary infos for single binary packages generated from the rpm spec file:
    
    .RS 4
    .nf
     $ rpmspec -q --qf "%{name}: %{summary}\n" rpm.spec
     rpm: The RPM package management system
     rpm-libs: Libraries for manipulating RPM packages
     rpm-build-libs: Libraries for building and signing RPM packages
     ...
    .RE
    
    Get the source package which would be generated from the rpm spec file:
    
    .RS 4
    .nf
     $ rpmspec -q --srpm rpm.spec
     rpm-4.11.3-3.fc20.x86_64
    .RE
    
    Parse the rpm spec file to stdout:
    
    .RS 4
    .nf
     $ rpmspec -P rpm.spec
     Summary: The RPM package management system
     Name: rpm
     Version: 4.14.0
     ...
    .RE

<a name="see-also"></a>

# See Also

    popt(3),
    rpm(8),
    rpmdb(8),
    rpmkeys(8),
    rpmsign(8),
    rpm2cpio(8),
    rpmbuild(8),

**rpmspec --help** - as rpm supports customizing the options via popt aliases 
it's impossible to guarantee that what's described in the manual matches 
what's available.


http://www.rpm.org/ &lt;URL:http://www.rpm.org/&gt;


<a name="authors"></a>

# Authors


    Marc Ewing <marc@redhat.com>
    Jeff Johnson <jbj@redhat.com>
    Erik Troan <ewt@redhat.com>
    Panu Matilainen <pmatilai@redhat.com>
