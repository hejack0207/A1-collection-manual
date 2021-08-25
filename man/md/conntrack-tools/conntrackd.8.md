# conntrackd(8) - netfilter connection tracking user-space daemon

"", Apr 16, 2018

```
conntrackd [options]
```


<a name="description"></a>

# Description

**conntrackd** is the user-space daemon for the netfilter connection
tracking system. This daemon synchronizes connection tracking states between
several replica firewalls. Thus, **conntrackd** can be used to deploy highly
available stateful firewalls.

The daemon supports Primary-Backup and Multiprimary setups and can also be used
as statistics collector.


<a name="options"></a>

# Options

The options recognized by **conntrackd** can be divided into two different
groups.


<a name="gemeral-options"></a>

### GEMERAL OPTIONS

General options for the **conntrackd** daemon.


* **-d**  
  Run **conntrackd** in daemon mode (fork to background).
  
* **-C &lt;path&gt;**  
  Load config file specified in _path_. See **conntrackd.conf(5)** for
  details.
  
* **-v**  
  Display version information.
  
* **-h**  
  Display help information.
  

<a name="client-commands"></a>

### CLIENT COMMANDS

**conntrackd** can be used in client mode to request several information and
operations to a running instance of the daemon.


* **-i [ct|expect]**  
  Dump the internal cache, i.e. show local states
  
* **-e [ct|expect]**  
  Dump the external cache, i.e. show foreign states
  
* **-x**  
  Display output in XML format. This option is only valid in combination
  with **-i** and **-e** parameters.
  
* **-f [internal|external]**  
  Flush the internal and/or external cache
  
* **-F [ct|expect]**  
  Flush the kernel conntrack table (if you use a Linux kernel &gt;= 2.6.29, this
  option will not flush your internal and external cache).
* **-c**  
  Commit external cache to conntrack table.
* **-B**  
  Force a bulk send to other replica firewalls. With this command, you will
  ask conntrackd to send the state-entries that it owns to others.
* **-n**  
  Request resync with other node (only FT-FW and NOTRACK modes).
* **-k**  
  Kill the daemon
* **-s [network|cache|runtime|link|rsqueue|process|queue|ct|expect]**  
  Dump statistics. If no parameter is passed, it displays the general statistics.  
  If "network" is passed as parameter it displays the networking statistics.  
  If "cache" is passed as parameter, it shows the extended cache statistics.  
  If "runtime" is passed as parameter, it shows the run-time statistics.  
  If "process" is passed as parameter, it shows existing child processes (if any).  
  If "queue" is passed as parameter, it shows queue statistics.  
  If "ct" is passed, it displays the general statistics.  
  If "expect" is passed as parameter, it shows expectation statistics.
* **-R [ct|expect]**  
  Force a resync against the kernel connection tracking table
* **-t**  
  Reset the in-kernel timers (See PurgeTimeout clause)
  

<a name="diagnostics"></a>

# Diagnostics

The exit code is 0 for correct function. Errors cause an exit code of 1.


<a name="examples"></a>

# Examples

The following example are illustrative, for a real use in a firewall fail-over,
check the primary-backup.sh script that comes with the sources.

* **conntrackd -d**  
  Runs conntrackd in daemon and synchronization mode
* **conntrackd -i**  
  Dumps the states held in the internal cache, i.e. those handled by this
  firewall
* **conntrackd -e**  
  Dumps the states held in the external cache, i.e. those handled by other
  replica firewalls
* **conntrackd -c**  
  Commits the external cache into the kernel connection tracking system.
  This is used to inject the state so that the connections can be recovered
  during the failover.
  

<a name="dependencies"></a>

# Dependencies

This daemon requires a Linux kernel version &gt;= 2.6.18. TCP window tracking
support requires &gt;= 2.6.22, otherwise you have to disable it.
Helpers are fully supported since &gt;= 2.6.25, however, if you use any previous
version, depending on the protocol helper and your setup (e.g. if you setup
performs NAT sequence adjustments or not), your help connection may be
successfully recovered.

There are several unsupported stateful iptables matches such as recent,
connbytes and the quota matches which gather internal
information to operate. Since that information does not belong to the
domain of the connection tracking system, connections affected by
those matches may not be fully recovered during the takeover.

The daemon requires a Linux kernel version &gt;= 2.6.26 to support kernel-space
event filtering. Otherwise, all the event filtering is done in userspace with
the corresponding extra overhead. If you are not using the Filter clause in
the configuration file, ignore this notice.


<a name="systemd-integration"></a>

# Systemd Integration

Starting with the 1.4.4 release, **conntrackd** includes integration with
**systemd(1)** to use an unit file of _Type=notify_ and watchdog support.


<a name="incompatibilities"></a>

# Incompatibilities

During the 0.9.9 development, some important changes in the replication message
format were introduced. Therefore, **conntrackd** &gt;= 0.9.9 will not work
appropriately with **conntrackd** &lt;= 0.9.8.

This should not be a problem if you use the same conntrackd version in all
the firewall replica nodes.


<a name="see-also"></a>

# See Also

**conntrackd.conf(5)**
**conntrack(8)**
**iptables(8)**
**nft(8)**  
**http://conntrack-tools.netfilter.org**


<a name="bugs"></a>

# Bugs

Please, report them to netfilter-devel@vger.kernel.org (subscription required)
or file a bug in Netfilter's bugzilla (https://bugzilla.netfilter.org).


<a name="authors"></a>

# Authors

Pablo Neira Ayuso wrote and maintains the conntrackd tool

Man page written by Pablo Neira Ayuso &lt;[pablo@netfilter.org](mailto:pablo@netfilter.org)&gt;.
