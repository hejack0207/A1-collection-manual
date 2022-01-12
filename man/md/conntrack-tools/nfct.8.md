# nfct(8) - command line tool to configure with the connection tracking system

"", Feb 29, 2012

```
nfct command subsystem [parameters]
```

<a name="description"></a>

# Description

**nfct**
is the command line tool that allows to configure the Connection Tracking
System.

<a name="commands"></a>

# Commands


* **list **  
  List the existing objects.
* **add **  
  Add new object.
* **delete **  
  Delete an object.
* **get **  
  Get an existing object.
* **flush **  
  Flush the accounting object table.
* **disable **  
  This command is for the helper subsystem. It allows you to disable enqueueing packets to userspace for helper inspection.
* **default-set **  
  This command is for the timeout subsystem. It allows you to set default protocol timeouts.
* **default-get **  
  This command is for the timeout subsystem. It allows you to get the default protocol timeouts.

<a name="subsys"></a>

# Subsys

By the time this manpage has been written, the supported subsystems are
**timeout**
and
**helper.**

* **timeout **  
  The timeout subsystem allows you to define fine-grain timeout policies.
* **helper **  
  The helper subsystem allows you to configure userspace helpers.
* **version **  
  Displays the version information.
* **help **  
  Displays the help message.

<a name="example"></a>

# Example


* **nfct add timeout test-tcp inet tcp established 100 close 10 close_wait 10**  
* This creates a timeout policy for tcp using 100 seconds for the ESTABLISHED state, 10 seconds for CLOSE state and 10 seconds for the CLOSE_WAIT state.  
* Then, you can attach the timeout policy with the iptables CT target:  
* **iptables -I PREROUTING -t raw -p tcp -j CT --timeout test-tcp**  
* **iptables -I OUTPUT -t raw -p tcp -j CT --timeout test-tcp**  
* You can test that the timeout policy with:  
* **conntrack -E -p tcp**  
* It should display:  
* **[UPDATE] tcp 6 100 ESTABLISHED src=192.168.39.100 dst=57.126.1.20 sport=56463 dport=80 src=57.126.1.20 dst=192.168.39.100 sport=80 dport=56463 [ASSURED]**  

<a name="see-also"></a>

# See Also

**iptables**(8),**conntrack**(8)

<a name="bugs"></a>

# Bugs

Please, report them to netfilter-devel@vger.kernel.org or file a bug in
Netfilter's bugzilla (https://bugzilla.netfilter.org).

<a name="authors"></a>

# Authors

Pablo Neira Ayuso wrote and maintains the nfct tool.

Man page written by Pablo Neira Ayuso &lt;[pablo@netfilter.org](mailto:pablo@netfilter.org)&gt;.
