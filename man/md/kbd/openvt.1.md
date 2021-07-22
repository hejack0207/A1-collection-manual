# openvt(1) - start a program on a new virtual terminal (VT).

19 Jul 1996, V1.4

```
openvt  [-c vtnumber] [OPTIONS] [--] command
```

<a name="description"></a>

# Description

**openvt**
will find the first available VT, and run on it the given 
**command**
with the given 
**command options**,
standard input, output and error are directed to that terminal. The current
search path ($PATH) is used to find the requested command. If no command is
specified then the environment variable $SHELL is used.

<a name="options"></a>

### OPTIONS


* _-c, --console=VTNUMBER_  
  Use the given VT number and not the first available. Note you
  must have write access to the supplied VT for this to work;
* _-f, --force_  
  Force opening a VT without checking whether it is already in use;
* _-e, --exec_  
  Directly execute the given command, without forking.
  This option is meant for use in
  _/etc/inittab_;
* _-s, --switch_  
  Switch to the new VT when starting the command. The VT of the new command
  will be made the new current VT;
* _-u, --user_  
  Figure out the owner of the current VT, and run login as that user.
  Suitable to be called by init. Shouldn't be used with -c or -l;
* _-l, --login_  
  Make the command a login shell. A - is prepended to the name of the command
  to be executed;
* _-v, --verbose_  
  Be a bit more verbose;
* _-w, --wait_  
  wait for command to complete. If -w and -s are used together then
  **openvt**
  will switch back to the controlling terminal when the command completes;
* _-V, --version_  
  print program version and exit;
* _-h, --help_  
  show this text and exit.
* _--_  
  end of options to
  **openvt**.

<a name="note"></a>

# Note

If
**openvt**
is compiled with a getopt_long() and you wish to set
options to the command to be run, then you must supply
the end of options -- flag before the command.  

<a name="examples"></a>

# Examples

**openvt**
can be used to start a shell on the next free VT, by using the command:

* _openvt bash_  
*   
  To start the shell as a login shell, use:
* _openvt -l bash_  
*   
  To get a long listing you must supply the -- separator:
* _openvt -- ls -l_    
  

<a name="history"></a>

# History

Earlier,
**openvt**
was called
**open**.
It was written by Jon Tombs &lt;jon@gtex02.us.es or jon@robots.ox.ac.uk&gt;.
The -w idea is from "sam".


<a name="see-also"></a>

# See Also

**chvt**(1),
**doshell**(8),
**login**(1)
