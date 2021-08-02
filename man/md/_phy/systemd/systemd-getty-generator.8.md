# systemd\-getty\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-getty-generator - Generator for enabling getty instances on the console

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-getty-generator
```

<a name="description"></a>

# Description


systemd-getty-generator
is a generator that automatically instantiates
serial-getty@.service
on the kernel console(s), if they can function as ttys and are not provided by the virtual console subsystem. It will also instantiate
serial-getty@.service
instances for virtualizer consoles, if execution in a virtualized environment is detected. If execution in a container environment is detected, it will instead enable
console-getty.service
for
/dev/console, and
container-getty@.service
instances for additional container pseudo TTYs as requested by the container manager (see
\m[blue]**Container Interface**\m[]\s-2\u[1]\d\s+2). This should ensure that the user is shown a login prompt at the right place, regardless of which environment the system is started in. For example, it is sufficient to redirect the kernel console with a kernel command line argument such as
_console=_
to get both kernel messages and a getty prompt on a serial TTY. See
\m[blue]**kernel-parameters.txt**\m[]\s-2\u[2]\d\s+2
for more information on the
_console=_
kernel parameter.

systemd-getty-generator
implements
**systemd.generator**(7).

Further information about configuration of gettys can be found in
\m[blue]**systemd for Administrators, Part XVI: Gettys on Serial Consoles (and Elsewhere)**\m[]\s-2\u[3]\d\s+2.

<a name="see-also"></a>

# See Also


**systemd**(1),
**agetty**(8)

<a name="notes"></a>

# Notes


*  1.  
  Container
      Interface
      https://www.freedesktop.org/wiki/Software/systemd/ContainerInterface/
*  2.  
  kernel-parameters.txt
      https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt
*  3.  
  systemd for Administrators, Part XVI: Gettys on Serial Consoles (and Elsewhere)
      http://0pointer.de/blog/projects/serial-console.html
