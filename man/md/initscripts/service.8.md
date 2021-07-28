# service(8) - run a System V init script

Jan 2006

```
service SCRIPT COMMAND [OPTIONS]
</synopsis>

<synopsis>
service --status-all
</synopsis>

<synopsis>
service --help | -h | --version
```


<a name="description"></a>

# Description

**service**
runs a System V init script in as predictable environment as possible,
removing most environment variables
and with current working directory set to **/**.

The
_SCRIPT_
parameter specifies a System V init script,
located in **/etc/init.d/SCRIPT**.
The supported values of
_COMMAND_
depend on the invoked script,
**service**
passes
_COMMAND_
and
_OPTIONS_
it to the init script unmodified.
All scripts should support at least the
**start**
and
**stop**
commands.
As a special case, if
_COMMAND_
is **--full-restart**, the script is run twice, first with the
**stop**
command, then with the
**start**
command.

**service --status-all**
runs all init scripts, in alphabetical order, with the
**status**
command.

If the init script file does not exist, the script tries to use
**legacy actions.**
If there is no suitable legacy action found and
_COMMAND_
is one of actions specified in LSB Core Specification, input is redirected to the
**systemctl.**
Otherwise the command fails with return code 2.


<a name="files"></a>

# Files


* **/etc/init.d**  
  The directory containing System V init scripts.
  

<a name="environment"></a>

# Environment


* **PATH**, **TERM**  
  The only environment variables passed to the init scripts.
  

<a name="see-also"></a>

# See Also

**chkconfig**(8),
**ntsysv(8),**
**systemd**(1),
**systemctl**(8),
**systemd.service**(5)
