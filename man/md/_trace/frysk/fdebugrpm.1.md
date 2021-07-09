# fdebugrpm(1)

Frysk 0\&.4\-63\&.fc30, April 2008

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

fdebugrpm - install missing debuginfo packages

<a name="synopsis"></a>

# Synopsis

```
.HP \w'fdebugrpm&nbsp;'u fdebugrpm [options] {program&nbsp;arg&nbsp;...  | pid... | core-file&nbsp;[&nbsp;core-executable&nbsp;]... }
```

<a name="description"></a>

# Description


**fdebugrpm**
is a bash script that uses the utility fdebuginfo(1) to determine any missing Debug Information, allowing the user to install the missing debuginfo packages. User needs to be in the sudoers(5) file.

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
    fdebugrpm 1234
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


frysk(7) fdebuginfo(1)

<a name="bugs"></a>

# Bugs


Report bugs to
\m[blue]**http://sourceware.org/frysk**\m[]
