# iptables-restore(8) - Restore IP Tables

iptables 1.8.0, ""


ip6tables-restore — Restore IPv6 Tables

<a name="synopsis"></a>

# Synopsis

```
iptables-restore [-chntvV] [-w secs] [-W usecs] [-M modprobe] [-T name] [file] 
 ip6tables-restore [-chntvV] [-w secs] [-W usecs] [-M modprobe] [-T name] [file]
```

<a name="description"></a>

# Description


**iptables-restore**
and
**ip6tables-restore**
are used to restore IP and IPv6 Tables from data specified on STDIN or in
_file_. Use I/O redirection provided by your shell to read from a file or
specify _file_ as an argument.

* **-c**, **--counters**  
  restore the values of all packet and byte counters
* **-h**, **--help**  
  Print a short option summary.
* **-n**, **--noflush**  
  don't flush the previous contents of the table. If not specified,
  both commands flush (delete) all previous contents of the respective table.
* **-t**, **--test**  
  Only parse and construct the ruleset, but do not commit it.
* **-v**, **--verbose**  
  Print additional debug info during ruleset processing.
* **-V**, **--version**  
  Print the program version number.
* **-w**, **--wait** [_seconds_]  
  Wait for the xtables lock.
  To prevent multiple instances of the program from running concurrently,
  an attempt will be made to obtain an exclusive lock at launch.  By default,
  the program will exit if the lock cannot be obtained.  This option will
  make the program wait (indefinitely or for optional _seconds_) until
  the exclusive lock can be obtained.
* **-W**, **--wait-interval** _microseconds_  
  Interval to wait per each iteration.
  When running latency sensitive applications, waiting for the xtables lock
  for extended durations may not be acceptable. This option will make each
  iteration take the amount of time specified. The default interval is
  1 second. This option only works with **-w**.
* **-M**, **--modprobe** _modprobe\_program_  
  Specify the path to the modprobe program. By default, iptables-restore will
  inspect /proc/sys/kernel/modprobe to determine the executable's path.
* **-T**, **--table** _name_  
  Restore only the named table even if the input stream contains other ones.

<a name="bugs"></a>

# Bugs

None known as of iptables-1.2.1 release

<a name="authors"></a>

# Authors

Harald Welte &lt;[laforge@gnumonks.org](mailto:laforge@gnumonks.org)&gt; wrote iptables-restore based on code
from Rusty Russell.  
Andras Kis-Szabo &lt;[kisza@sch.bme](mailto:kisza@sch.bme).hu&gt; contributed ip6tables-restore.

<a name="see-also"></a>

# See Also

**iptables-save**(8), **iptables**(8)

The iptables-HOWTO, which details more iptables usage, the NAT-HOWTO,
which details NAT, and the netfilter-hacking-HOWTO which details the
internals.
