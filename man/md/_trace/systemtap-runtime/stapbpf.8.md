# stapbpf(8) - systemtap bpf runtime




<a name="synopsis"></a>

# Synopsis


```

stapbpf [ OPTIONS ] MODULE
```


<a name="description"></a>

# Description


The
_stapbpf_
program is the BPF back-end of the Systemtap tool.  It expects a 
bpf-elf file produced by the front-end
_stap_
tool, when run with
_--runtime=bpf_.


Splitting the systemtap tool into a front-end and a back-end allows a
user to compile a systemtap script on a development machine that has
the debugging information needed to compile the script and then
transfer the resulting shared object to a production machine that
doesn't have any development tools or debugging information installed.

Please refer to
_stappaths_(7)
for the version number, or run

 $ rpm -q systemtap # (for Fedora/RHEL)  
 $ apt-get -v systemtap # (for Ubuntu)


<a name="options"></a>

# Options

The
_stapbpf_
program supports the following options.  Any other option
prints a list of supported options.

* **-v**  
  Verbose mode.
* **-V**  
  Print version number and exit.
* **-w**  
  Suppress warnings from the script.
* **-h**  
  Print help message.
* **-x PID**  
  The '_stp_target' variable will be set to PID.
* **-o FILE**  
  Send output to FILE.
  

<a name="arguments"></a>

# Arguments

**MODULE**
is the path of a bpf-elf file produced by the front-end
_stap_
tool, when run with
_--runtime=bpf_.


<a name="examples"></a>

# Examples

Here is a very basic example of how to generate a
_stapbpf_
module.
First, use
_stap_
to compile a script.  The
_stap_
program will report the name of the resulting module in the current
working directory.

 $ stap --runtime=bpf -p4 -e \[aq]probe begin { printf("Hello World!\\n"); exit() }\[aq]  
 stap_28784.bo

Run
_stapbpf_
with the pathname to the module as an argument.

 $ stapbpf ./stap_28784.bo  
 Hello World!

If the
_-p4_
option is omitted,
_stap_
will invoke
_stapbpf_
automatically.


<a name="limitations"></a>

# Limitations

This runtime is in an early stage of development and it currently lacks
support for a number of features available in the default runtime.
A subset of the following probe points is supported:

.SAMPLE
begin
end
kernel.*
process.*
timer.*
perf.*
procfs.*
.ESAMPLE

In general, probes based on the kprobes, uprobes, tracepoint and perf
infrastructures are supported. See
_stapprobes_(3stap)
for more information on the probe points and which tracing infrastructures
they are based on.

**for**
loops,
**foreach**
loops and
**while**
loops are usable only in 
**begin**
and
**end**
probes. 
**try**
statements are not supported.

There is limited support for string
operations. String variables and literals are limited to
64 characters, except for
**printf**
format strings, which are limited to 256 characters.

A subset of the statistical aggregate functionality is available,
with support only for the
_@count()_, _@sum()_, _@avg()_
extractor functions.

The name
of the bpf-elf file produced by the front-end 
_stap_
tool should not be changed.


<a name="safety-and-security"></a>

# Safety and Security

See the 
_stap_(1)
manual page for additional information on safety and security.


<a name="see-also"></a>

# See Also

_stap_(1),
_stapprobes_(3stap),
_staprun_(8),
_stapex_(3stap)


<a name="bugs"></a>

# Bugs

Use the Bugzilla link of the project web page or our mailing list.
.nh
**http://sourceware.org/systemtap/**, **&lt;systemtap@sourceware.org&gt;**.
