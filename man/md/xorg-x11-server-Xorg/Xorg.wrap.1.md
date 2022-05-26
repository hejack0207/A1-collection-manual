# xorg.wrap(1) - Xorg X server binary wrapper

X Version 11, xorg-server 1.20.11


<a name="description"></a>

# Description

The Xorg X server may need root rights to function properly. To start the
Xorg X server with these rights your system is using a suid root wrapper
installed as /usr/libexec/Xorg.wrap which will execute the real
X server which is installed as /usr/libexec/Xorg.

By default Xorg.wrap will autodetect if root rights are necessary, and
if not it will drop its elevated rights before starting the real X server.
By default Xorg.wrap will only allow executing the real X server from login
sessions on a physical console.


<a name="config-file"></a>

# Config File

Xorg.wrap's default behavior can be overridden from the
_/etc/X11/Xwrapper.config_ config file. Lines starting with a
**#** in Xwrapper.config are considered comments and will be ignored. Any
other non empty lines must take the form of **key** = _value_.

* **allowed\_users** = _rootonly_|_console_|_anybody_  
  Specify which users may start the X server through the wrapper. Use
  _rootonly_ to only allow root, use _console_ to only allow users
  logged into a physical console, and use _anybody_ to allow anybody.
  The default is _console_.
* **needs\_root\_rights** = _yes_|_no_|_auto_  
  Configure if the wrapper should drop its elevated (root) rights before starting
  the X server. Use _yes_ to force execution as root, _no_ to force
  execution with all suid rights dropped, and _auto_ to let the wrapper
  auto-detect. The default is _auto_.

When auto-detecting the wrapper will drop rights if kms graphics are available
and not drop them if no kms graphics are detected. If a system has multiple
graphics cards and some are not kms capable auto-detection may fail,
in this case manual configuration should be used.


<a name="see-also"></a>

# See Also

Xorg X server information: _Xorg_(1)
