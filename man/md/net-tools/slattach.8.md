# slattach(8) - attach a network interface to a serial line

net\-tools, 2011\-12\-31

```
"slattach [-dehlLmnqv] [-c command] [-p proto] [-s speed] [tty]"

```

<a name="description"></a>

# Description

**Slattach**
is a tiny little program that can be used to put a normal terminal
("serial") line into one of several "network" modes, thus allowing
you to use it for point-to-point links to other computers.

<a name="options"></a>

# Options


* **tty**  
  Path to a serial device like
  _/dev/ttyS*_, _/dev/cua*_ or _/dev/ptmx_
  to spawn a new pseudo tty.
* **[-c command]**  
  Execute
  **command**
  when the line is hung up. This can be used to run scripts or re-establish
  connections when a link goes down.
* **[-d]**  
  Enable debugging output.  Useful when determining why a given
  setup doesn't work.
* **[-h]**  
  Exit when the carrier is lost. This works on both /dev/tty and /dev/cua
  devices by directly monitoring the carrier status every 15 seconds.
* **[-v]**  
  Enable verbose output.  Useful in shell scripts.
* **[-q]**  
  Operate in quiet mode - no messages at all.
* **[-l]**  
  Create an UUCP-style lockfile for the device in /var/lock.
* **[-n]**  
  Equivalent to the "mesg n" command.
* **[-m]**  
  Do **not** initialize the line into 8 bits raw mode.
* **[-e]**  
  Exit right after initializing device, instead of waiting for the
  line to hang up.
* **[-L]**  
  Enable 3 wire operation. The terminal is moved into CLOCAL mode, 
  carrier watching is disabled.
* **[-p proto]**  
  Set a specific kind of protocol to use on the line.  The default
  is set to
  **cslip**,
  i.e. compressed SLIP.  Other possible values are
  **slip**
  (normal SLIP), 
  **adaptive**
  (adaptive CSLIP/SLIP),
  **ppp**
  (Point-to-Point Protocol)
  and
  **kiss**
  (a protocol used for communicating with AX.25 packet radio terminal node controllers).
  The special argument
  **tty**
  can be used to put the device back into normal serial operation.
  Using 'ppp' mode is not normally useful as ppp requires an additional ppp daemon
  **pppd**
  to be active on the line. For kiss connections the 
  **axattach**
  program should be used.
* **[-s speed]**  
  Set a specific line speed, other than the default.

If no arguments are given, the current terminal line (usually: the
login device) is used.  Otherwise, an attempt is made to claim the
indicated terminal port, lock it, and open it.

<a name="files"></a>

# Files

_/dev/cua* /var/lock/LCK.* /dev/ttyS* /dev/ptmx_

<a name="bugs"></a>

# Bugs

None known.

<a name="see-also"></a>

# See Also

axattach(8), dip(8) pppd(8), sliplogin(8).

<a name="authors"></a>

# Authors

Fred N. van Kempen, &lt;[waltje@uwalt.nl](mailto:waltje@uwalt.nl).mugnet.org&gt;  
Alan Cox, &lt;[Alan.Cox@linux.org](mailto:Alan.Cox@linux.org)&gt;  
Miquel van Smoorenburg, &lt;[miquels@drinkel.ow](mailto:miquels@drinkel.ow).org&gt;  
George Shearer, &lt;[gshearer@one.net](mailto:gshearer@one.net)&gt;  
Yossi Gottlieb, &lt;[yogo@math.tau](mailto:yogo@math.tau).ac.il&gt;  
