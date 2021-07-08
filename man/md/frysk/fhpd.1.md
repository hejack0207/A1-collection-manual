# fhpd(1)

Frysk 0\&.4\-63\&.fc30, April 2008

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

fhpd - a command line debugger

<a name="synopsis"></a>

# Synopsis

```
.HP \w'fhpd&nbsp;'u fhpd [options] {program&nbsp;arg&nbsp;...  | pid... | core-file&nbsp;[&nbsp;core-executable&nbsp;]... }
```

<a name="description"></a>

# Description


**fhpd**
is a command line oriented debugger implemented using the frysk(7) framework with a command set loosely based on the High Performance Debugger Forums Version 1 standard.

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
    fhpd 1234
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


frysk(7)

<a name="standards"></a>

# Standards


High Performance Debugging Forum Version 1 Standard

<a name="bugs"></a>

# Bugs


Report bugs to
\m[blue]**http://sourceware.org/frysk**\m[]
