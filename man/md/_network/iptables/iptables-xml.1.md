# iptables-xml(1) - Convert iptables-save format to XML

iptables 1.8.0, ""

```
iptables-xml [-c] [-v]
```

<a name="description"></a>

# Description


**iptables-xml**
is used to convert the output of iptables-save into an easily manipulatable
XML format to STDOUT.  Use I/O-redirection provided by your shell to write to 
a file.

* **-c**, **--combine**  
  combine consecutive rules with the same matches but different targets. iptables
  does not currently support more than one target per match, so this simulates 
  that by collecting the targets from consecutive iptables rules into one action
  tag, but only when the rule matches are identical. Terminating actions like
  RETURN, DROP, ACCEPT and QUEUE are not combined with subsequent targets.
* **-v**, **--verbose**  
  Output xml comments containing the iptables line from which the XML is derived
  

iptables-xml does a mechanistic conversion to a very expressive xml
format; the only semantic considerations are for -g and -j targets in
order to discriminate between &lt;call&gt; &lt;goto&gt; and &lt;nane-of-target&gt; as it
helps xml processing scripts if they can tell the difference between a
target like SNAT and another chain.

Some sample output is:

&lt;iptables-rules&gt;
  &lt;table name="mangle"&gt;
    &lt;chain name="PREROUTING" policy="ACCEPT" packet-count="63436"
byte-count="7137573"&gt;
      &lt;rule&gt;
       &lt;conditions&gt;
        &lt;match&gt;
          &lt;p&gt;tcp&lt;/p&gt;
        &lt;/match&gt;
        &lt;tcp&gt;
          &lt;sport&gt;8443&lt;/sport&gt;
        &lt;/tcp&gt;
       &lt;/conditions&gt;
       &lt;actions&gt;
        &lt;call&gt;
          &lt;check_ip/&gt;
        &lt;/call&gt;
        &lt;ACCEPT/&gt;
       &lt;/actions&gt;
      &lt;/rule&gt;
    &lt;/chain&gt;
  &lt;/table&gt;
&lt;/iptables-rules&gt;


Conversion from XML to iptables-save format may be done using the 
iptables.xslt script and xsltproc, or a custom program using
libxsltproc or similar; in this fashion:

xsltproc iptables.xslt my-iptables.xml | iptables-restore


<a name="bugs"></a>

# Bugs

None known as of iptables-1.3.7 release

<a name="author"></a>

# Author

Sam Liddicott &lt;[azez@ufomechanic.net](mailto:azez@ufomechanic.net)&gt;

<a name="see-also"></a>

# See Also

**iptables-save**(8), **iptables-restore**(8), **iptables**(8)
