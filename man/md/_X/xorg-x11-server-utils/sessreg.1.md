# sessreg(1) - manage utmp (5)/wtmp (5) entries for non-init clients

X Version 11, sessreg 1.1.0

```
sessreg [-w wtmp (5)-file] [-u utmp (5)-file] [-L lastlog-file] [-l line-name] [-h host-name] [-s slot-number] [-x Xservers-file] [-t ttys-file] [-V] [-a] [-d] user-name
```

<a name="description"></a>

# Description


_Sessreg_ is a simple program for managing utmp (5)/wtmp (5) and lastlog
entries for xdm sessions.


System V has a better interface to utmp than BSD; it
dynamically allocates entries in the file, instead of writing them at fixed
positions indexed by position in
**/etc/ttys**.

To manage BSD-style utmp files, _sessreg_ has two strategies.  In
conjunction with xdm, the -x option counts the number of lines in
**/etc/ttys**
and then adds to that the number of the line in the Xservers file which
specifies the display.  The display name must be specified as the
"line-name" using the -l option.  This sum is used as the "slot-number" in
the utmp file that this entry will be written at.  In the more general case,
the -s option specifies the slot-number directly.  If for some strange reason
your system uses a file other than
**/etc/ttys**
to manage init, the -t option can direct
_sessreg_ to look elsewhere for a count of terminal sessions.

Conversely, System V managers will not ever need to use these options (-x,
-s and -t).  To make the program easier to document and explain,
_sessreg_ accepts the BSD-specific flags in the System V
environment and ignores them.

BSD and Linux also have a host-name field in the utmp file which doesn't
exist in System V.  This option is also ignored by the System V version of
_sessreg_.



This version of _sessreg_ is built using the modern POSIX
**pututxline**(3c)
interfaces, which no longer require the slot-number, ttys-file, or
Xservers-file mappings.  For compatibility with older versions and other
operating systems, the **-s**, **-t**, and **-x** flags are accepted,
but ignored.


<a name="usage"></a>

# Usage


In Xstartup, place a call like:
    
           sessreg -a -l $DISPLAY -x /etc/X11/xdm/Xservers $USER
    
and in Xreset:
    
           sessreg -d -l $DISPLAY -x /etc/X11/xdm/Xservers $USER

<a name="options"></a>

# Options


* **-w** _wtmp (5)-file_  
  This specifies an alternate wtmp (5) file, instead of
  **/var/log/wtmp**.
  The special name "none" disables writing records to the wtmp (5) file.
* **-u** _utmp (5)-file_  
  This specifies an alternate utmp (5) file, instead of
  **/var/run/utmp**.
  The special name "none" disables writing records to the utmp (5) file.
* **-L** _lastlog-file_  
  This specifies an alternate lastlog file, instead of
  **/var/log/lastlog**,
  if the platform supports lastlog files.
  The special name "none" disables writing records to the lastlog file.
* **-l** _line-name_  
  This describes the "line" name of the entry.  For terminal sessions,
  this is the final pathname segment of the terminal device filename
  (e.g. ttyd0).  For X sessions, it should probably be the local display name
  given to the users session (e.g. :0).  If none is specified, the
  terminal name will be determined with ttyname(3) and stripped of leading
  components.
* **-h** _host-name_  
  This is set to indicate that the session was initiated from
  a remote host.  In typical xdm usage, this options is not used.
* **-s** _slot-number_  
  
  Each potential session has a unique slot number in BSD systems, most are
  identified by the position of the _line-name_ in the
  **/etc/ttys**file.
  This option overrides the default position determined with ttyslot(3).
  This option is inappropriate for use with xdm, the -x option is more useful.
  
  
  This option is accepted for compatibility, but does nothing in
  this version of _sessreg_.
  
* **-x** _Xservers-file_  
  
  As X sessions are one-per-display, and each display is entered in this file,
  this options sets the _slot-number_ to be the number of lines in
  the _ttys-file_ plus the index into this file that the _line-name_
  is found.
  
  
  This option is accepted for compatibility, but does nothing in
  this version of _sessreg_.
  
* **-t** _ttys-file_  
  
  This specifies an alternate file which the _-x_ option will use to count
  the number of terminal sessions on a host.
  
  
  This option is accepted for compatibility, but does nothing in
  this version of _sessreg_.
  
* **-V**  
  This option causes the command to print its version and exit.
* **-a**  
  This session should be added to utmp/wtmp.
* **-d**  
  This session should be deleted from utmp/wtmp.  One of -a/-d must
  be specified.

<a name="see-also"></a>

# See Also

**xdm**(1),
**utmp**(5),
**wtmp**(5)

<a name="author"></a>

# Author

Keith Packard, MIT X Consortium
