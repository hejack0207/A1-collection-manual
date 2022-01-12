# stapdyn(8) - systemtap dyninst runtime

```

stapdyn [ OPTIONS ] MODULE [ MODULE-OPTIONS ]
```


<a name="description"></a>

# Description


The
_stapdyn_
program is the dyninst back-end of the Systemtap tool.  It expects a 
shared library produced by the front-end
_stap_
tool, when run with
_--dyninst_.


Splitting the systemtap tool into a front-end and a back-end allows a
user to compile a systemtap script on a development machine that has
the debugging information (need to compile the script) and then
transfer the resulting shared object to a production machine that
doesn't have any development tools or debugging information installed.

Please refer to stappaths (7) for the version number, or run
rpm -q systemtap (fedora/red hat)
apt-get -v systemtap (ubuntu)


<a name="options"></a>

# Options

The
_stapdyn_
program supports the following options.  Any other option
prints a list of supported options.

* **-v**  
  Verbose mode.
* **-V**  
  Print version number and exit.
* **-w**  
  Suppress warnings from the script.
* **-c CMD**  
  Command CMD will be run and the
  _stapdyn_
  program will exit when CMD
  does.  The '_stp_target' variable will contain the pid for CMD.
* **-x PID**  
  The '_stp_target' variable will be set to PID.
* **-o FILE**  
  Send output to FILE. If the module uses bulk mode, the output will
  be in percpu files FILE_x(FILE_cpux in background and bulk mode)
  where 'x' is the cpu number. This supports strftime(3) formats
  for FILE.
* **-C WHEN**  
  Control coloring of error messages. WHEN must be either
  .nh
  "never", "always", or "auto"
  (i.e. enable only if at a terminal). If the option is missing, then "auto"
  is assumed. Colors can be modified using the SYSTEMTAP_COLORS environment
  variable. See the
  _stap_(1)
  manual page for more information on syntax and behaviour.
* **var1=val**  
  Sets the value of global variable var1 to val. Global variables contained 
  within a script are treated as options and can be set from the 
  stapdyn command line.
  

<a name="arguments"></a>

# Arguments

**MODULE**
is either a module path or a module name.  If it is a module name,
the module will be looked for in the following directory
(where 'VERSION' is the output of "uname -r"):

* /lib/modules/VERSION/systemtap


 $ stap --dyninst -p4 -m mod1 -e&nbsp;\[aq]global var1="foo"; probe begin{printf("%s\\n", var1); exit()}\[aq]  

Running this with an additional module argument:


 $ stapdyn mod1.so var1="HelloWorld"  
 HelloWorld

Spaces and exclamation marks currently cannot be passed into global variables 
this way.


<a name="examples"></a>

# Examples

See the 
_stapex_(3stap)
manual page for a collection of sample scripts.

Here is a very basic example of how to use
_stapdyn._
First, use
_stap_
to compile a script.  The
_stap_
program will report the pathname to the resulting module.

 $ stap --dyninst -p4 -e \[aq]probe begin { printf("Hello World!\\n"); exit() }\[aq]  
 /home/user/.systemtap/cache/85/stap_8553d83f78c_265.so

Run
_stapdyn_
with the pathname to the module as an argument.

 $ stapdyn /home/user/.systemtap/cache/85/stap_8553d83f78c_265.so  
 Hello World!


<a name="safety-and-security"></a>

# Safety and Security

Systemtap, in DynInst mode, is a developer tool, and runs completely
unprivileged.  The Linux kernel will only permit one's own processes
to be accessed, which is enforced by the
_ptrace_(2)
system call.
See the 
_stap_(1)
manual page for additional information on safety and security.


<a name="see-also"></a>

# See Also

_stap_(1),
_stapprobes_(3stap),
_stap-server_(8),
_staprun_(8),
_stapex_(3stap)


<a name="bugs"></a>

# Bugs

Use the Bugzilla link of the project web page or our mailing list.
.nh
**http://sourceware.org/systemtap/**, **&lt;systemtap@sourceware.org&gt;**.

