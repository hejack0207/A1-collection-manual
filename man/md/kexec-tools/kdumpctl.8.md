# kdumpctl(8) - control interface for kdump

kexec-tools, 2015-07-13

```
kdumpctl COMMAND
```


<a name="description"></a>

# Description

**kdumpctl**
is used to check or control the kdump service.
In most cases, you should use
**systemctl**
to start / stop / enable kdump service instead. However,
**kdumpctl**
provides more details for debug and a helper to setup ssh key authentication.


<a name="commands"></a>

# Commands


* _start_  
  Start the service.
* _stop_  
  Stop the service.
* _status_  
  Prints the current status of kdump service.
  It returns non-zero value if kdump is not operational.
* _restart_  
  Is equal to
  _start; stop_
* _propagate_  
  Helps to setup key authentication for ssh storage since it's
  impossible to use password authentication during kdump.
* _showmem_  
  Prints the size of reserved memory for crash kernel in megabytes.
  

<a name="see-also"></a>

# See Also

**kdump.conf**(5),
**mkdumprd**(8)
