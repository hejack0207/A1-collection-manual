# pkaction(1)

polkit, May 2009

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pkaction - Get details about a registered action

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pkaction&nbsp;'u pkaction [--version] [--help] .HP \w'pkaction&nbsp;'u pkaction [--verbose] .HP \w'pkaction&nbsp;'u pkaction --action-id&nbsp;action [--verbose]
```

<a name="description"></a>

# Description


**pkaction**
is used to obtain information about registered polkit actions. If called without
**--action-id**
then all actions are displayed. Otherwise the action
_action_. If called without the
**--verbose**
option only the name of the action is shown. Otherwise details about the actions are shown.

<a name="return-value"></a>

# Return Value


On success
**pkaction**
returns 0. Otherwise a non-zero value is returned and a diagnostic message is printed on standard error.

<a name="author"></a>

# Author


Written by David Zeuthen
&lt;[davidz@redhat.com](mailto:davidz@redhat.com)&gt;
with a lot of help from many others.

<a name="bugs"></a>

# Bugs


Please send bug reports to either the distribution or the polkit-devel mailing list, see the link
\m[blue]**http://lists.freedesktop.org/mailman/listinfo/polkit-devel**\m[]
on how to subscribe.

<a name="see-also"></a>

# See Also


**polkit**(8),
**polkitd**(8),
**pkcheck**(1),
**pkexec**(1),
**pkttyagent**(1)
