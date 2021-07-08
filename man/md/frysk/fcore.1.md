# fcore(1)

Frysk 0\&.4\-63\&.fc30, April 2008

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

fcore - extract a core file from a process

<a name="synopsis"></a>

# Synopsis

```
.HP \w'fcore&nbsp;'u fcore [options] {pid...}
```

<a name="description"></a>

# Description


**fcore**
constructs a core-file from a running process, and writes it to disk.

**-a**, **-allmaps**
Write all readable segment maps. The default level is to attempt to emulate gcore segment writing strategy. By specifying this option, fcore will write all readable maps.

**-s**, **-segments ****regex**
Writes only the segments that match the regex specified. Elide all other segments.

**-o ****output-file**
Specifies the name of the core file. Default is core. The core-file extension will still use the pid of the process being dumped.

<a name="standard-frysk-options"></a>

### Standard Frysk Options


**-exe**
The full path of the executable to read.

**-noexe**
Do not attempt to read the corresponding executable when loading a core file.

**-sysroot ****directory**
The system root directory under which all executables, libraries, and source are located.

**-debug ****class****=****level****...**
Set internal debug-tracing of the specified Java
_class_
to
_level_
(level can be NONE, INFO, WARNING, FINE, and FINEST). If the
_level_
is absent, FINE is assumed; if the
_class_
is absent, the global level is set.

<a name="example"></a>

# Example


.if n \{.RS 4
.\}
    fcore 1234
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


frysk(7)

<a name="bugs"></a>

# Bugs


Report bugs to
\m[blue]**http://sourceware.org/frysk**\m[]
