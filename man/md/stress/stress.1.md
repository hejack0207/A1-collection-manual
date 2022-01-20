# stress(1) - tool to impose load on and stress test systems

Version 1.0.4, March 2010

```
stress [OPTION [ARG]] ...
```

<a name="description"></a>

# Description

\`stress' imposes certain types of compute stress on your system

* -?, **--help**  
  show this help statement
* **--version**  
  show version statement
* **-v**, **--verbose**  
  be verbose
* **-q**, **--quiet**  
  be quiet
* **-n**, **--dry-run**  
  show what would have been done
* **-t**, **--timeout** N  
  timeout after N seconds
* **--backoff** N  
  wait factor of N microseconds before work starts
* **-c**, **--cpu** N  
  spawn N workers spinning on sqrt()
* **-i**, **--io** N  
  spawn N workers spinning on sync()
* **-m**, **--vm** N  
  spawn N workers spinning on malloc()/free()
* **--vm-bytes** B  
  malloc B bytes per vm worker (default is 256MB)
* **--vm-stride** B  
  touch a byte every B bytes (default is 4096)
* **--vm-hang** N  
  sleep N secs before free (default none, 0 is inf)
* **--vm-keep**  
  redirty memory instead of freeing and reallocating
* **-d**, **--hdd** N  
  spawn N workers spinning on write()/unlink()
* **--hdd-bytes** B  
  write B bytes per hdd worker (default is 1GB)

Example: stress **--cpu** 8 **--io** 4 **--vm** 2 **--vm-bytes** 128M **--timeout** 10s

Note: Numbers may be suffixed with s,m,h,d,y (time) or B,K,M,G (size).

<a name="see-also"></a>

# See Also

The full documentation for
**stress**
is maintained as a Texinfo manual.  If the
**info**
and
**stress**
programs are properly installed at your site, the command

* **info stress**

should give you access to the complete manual.
