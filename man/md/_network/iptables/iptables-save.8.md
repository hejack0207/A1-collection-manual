# iptables-save(8) - dump iptables rules

iptables 1.8.0, ""


ip6tables-save — dump iptables rules

<a name="synopsis"></a>

# Synopsis

```
iptables-save [-M modprobe] [-c] [-t table] [-f filename] 
 ip6tables-save [-M modprobe] [-c] [-t table] [-f filename]
```

<a name="description"></a>

# Description


**iptables-save**
and
**ip6tables-save**
are used to dump the contents of IP or IPv6 Table in easily parseable format
either to STDOUT or to a specified file.

* **-M**, **--modprobe** _modprobe\_program_  
  Specify the path to the modprobe program. By default, iptables-save will
  inspect /proc/sys/kernel/modprobe to determine the executable's path.
* **-f**, **--file** _filename_  
  Specify a filename to log the output to. If not specified, iptables-save
  will log to STDOUT.
* **-c**, **--counters**  
  include the current values of all packet and byte counters in the output
* **-t**, **--table** _tablename_  
  restrict output to only one table. If not specified, output includes all
  available tables.

<a name="bugs"></a>

# Bugs

None known as of iptables-1.2.1 release

<a name="authors"></a>

# Authors

Harald Welte &lt;[laforge@gnumonks.org](mailto:laforge@gnumonks.org)&gt;  
Rusty Russell &lt;[rusty@rustcorp.com](mailto:rusty@rustcorp.com).au&gt;  
Andras Kis-Szabo &lt;[kisza@sch.bme](mailto:kisza@sch.bme).hu&gt; contributed ip6tables-save.

<a name="see-also"></a>

# See Also

**iptables-restore**(8), **iptables**(8)

The iptables-HOWTO, which details more iptables usage, the NAT-HOWTO,
which details NAT, and the netfilter-hacking-HOWTO which details the
internals.
