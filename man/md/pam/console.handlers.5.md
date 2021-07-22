# console.handlers(5) - file specifying handlers of console lock and unlock events

Red Hat, 2005/3/18


<a name="description"></a>

# Description

/etc/security/console.handlers determines which programs will be run when an
user obtains the console lock at login time, and when the user loses it
on log out. It is read by the pam_console module.

The format is:

**handler-filename** **lock**_|_**unlock** _[_**flag ...**_]_

Where **handler-filename** is a name of the executable to be run, **lock** or
**unlock** specifies on which event it should be run, and flags specify how
should pam_console call it.

Additionally there should be a line which specifies glob patterns of console devices.

The format of this line is:
**console-name** **consoledevs** **regex** _[_**regex ...**_]_

Where **console-name** is a name of the console class - currently ignored - and
regexes are regular expression patterns which specify the name of the tty device.
Only the first such line is consulted.


<a name="flags"></a>

# Flags


* logfail  
  The pam_console module should log error to the system log if the return value of the
  handler is not zero or if the handler can not be executed.
* wait  
  The pam_console should wait for the handler to exit before continuing.
* setuid  
  The handler should be executed with uid/gid of the user which obtained the
  console lock.
* tty  
  The handler will get a tty name as obtained from PAM as a parameter.
* user  
  The handler will get an user name as obtained from PAM as a parameter.

Anything else will be added directly as a parameter to the handler executable.

<a name="see-also"></a>

# See Also

**pam_console**(8)

<a name="author"></a>

# Author

Tomas Mraz &lt;[tmraz@redhat.com](mailto:tmraz@redhat.com)&gt;
