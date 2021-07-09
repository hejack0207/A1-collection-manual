# iptables\-apply(8)

iptables 1.8.0, ""

.nh

<a name="name"></a>

# Name

iptables-apply - a safer way to update iptables remotely

<a name="synopsis"></a>

# Synopsis

```
iptables-apply [-hV] [-t timeout] ruleset-file
```

<a name="description"></a>

# Description


iptables-apply will try to apply a new ruleset (as output by
iptables-save/read by iptables-restore) to iptables, then prompt the
user whether the changes are okay. If the new ruleset cut the existing
connection, the user will not be able to answer affirmatively. In this
case, the script rolls back to the previous ruleset after the timeout
expired. The timeout can be set with **-t**.

When called as **ip6tables-apply**, the script will use
ip6tables-save/-restore instead.

<a name="options"></a>

# Options


* **-t** _seconds_, **--timeout** _seconds_  
  Sets the timeout after which the script will roll back to the previous
  ruleset.
* **-h**, **--help**  
  Display usage information.
* **-V**, **--version**  
  Display version information.

<a name="see-also"></a>

# See Also


**iptables-restore**(8), **iptables-save**(8), **iptables**(8).

<a name="legalese"></a>

# Legalese


iptables-apply is copyright by Martin F. Krafft.

This manual page was written by Martin F. Krafft &lt;madduck@madduck.net&gt;

Permission is granted to copy, distribute and/or modify this document
under the terms of the Artistic License 2.0.
