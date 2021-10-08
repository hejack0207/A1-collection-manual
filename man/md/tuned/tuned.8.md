# tuned(8) - dynamic adaptive system tuning daemon

Fedora Power Management SIG, 28 Mar 2012

```
tuned [options]
```

<a name="description"></a>

# Description

**tuned** is a dynamic adaptive system tuning daemon
that tunes system settings dynamically depending on
usage. 


<a name="options"></a>

# Options


* **-d**_, _**--daemon**  
  This options starts **tuned** as a daemon as opposed to
  in the foreground without forking at startup.
* **-D**_, _**--debug**  
  Sets the highest logging level. This could be very useful when having trouble with **tuned**.
* **-h**_, _**--help**  
  Show this help.
* **-l**_ [_**_LOG**__], _****--log**_**[_****=_LOG**]_**  
  Log to the file _LOG_. If no _LOG_ file is specified **/var/log/tuned/tuned.log** is used.
* **--no-dbus**  
  Do not attach to DBus.
* **-P**_ [_**_PID**__], _****--pid**_**[_****=_PID**]_**  
  Write process ID to the **PID** file. If no _PID_ file is specified **/run/tuned/tuned.pid** is used.
* **-p**_ _**_PROFILE_**_, _**--profile**_ _**_PROFILE_**  
  Tunning profile to be activated. It will override other settings (e.g. from **tuned-adm**).
  This is intended for debugging purposes.
* **-v**_, _**--version**  
  Show version information.

<a name="files"></a>

# Files

    /etc/tuned

<a name="see-also"></a>

# See Also


tuned.conf(5)
tuned-adm(8)

<a name="author"></a>

# Author

    Jan Kaluža <jkaluza@redhat.com>
    Jan Včelák <jvcelak@redhat.com>
    Jaroslav Škarvada <jskarvad@redhat.com>
    Phil Knirsch <pknirsch@redhat.com>

<a name="reporting-bugs"></a>

# Reporting Bugs

Report bugs to https://bugzilla.redhat.com/.
