# fexe(1)

Frysk 0\&.4\-63\&.fc30, April 2008

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

fexe - print a process or corefiles executable path

<a name="synopsis"></a>

# Synopsis

```
.HP \w'fexe&nbsp;'u fexe [options] {program&nbsp;arg&nbsp;...  | pid... | core-file&nbsp;[&nbsp;core-executable&nbsp;]... }
```

<a name="description"></a>

# Description


**fexe**
prints a processe or corefiles full executable path to standard output.

-v
Use more verbose output, the process, executable, and /proc/PID/exe contents are displayed.

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


In this sequence a copy of bash is created and then executed, the running processes path examined:

.if n \{.RS 4
.\}
    $ cp /bin/bash /tmp/sh
    $ PS1=sh$ *(Aq /tmp/sh
    sh$ fexe $$
    /tmp/sh
    sh$ rm /tmp/sh
    sh$ fexe -v $$
    1234 null /tmp/sh (deleted)
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


frysk(7)

<a name="bugs"></a>

# Bugs


Report bugs to
\m[blue]**http://sourceware.org/frysk**\m[]
