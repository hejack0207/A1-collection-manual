# firewalld\&.lockdown(5)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.lockdown-whitelist - firewalld lockdown whitelist configuration file

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    /etc/firewalld/lockdown-whitelists.xml
          
<synopsis>


```

<a name="description"></a>

# Description


The firewalld lockdown-whitelist configuration file contains the selinux contexts, commands, users and user ids that are white-listed when firewalld lockdown feature is enabled (see
**firewalld.conf**(5)
and
**firewall-cmd**(1)).

This example configuration file shows the structure of an lockdown-whitelist file:

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="utf-8"?>
    <whitelist>
      <selinux context="selinuxcontext"/>
      <command name="commandline[*]"/>
      <user {name="username|id="userid"}/>
    </whitelist>
          
.if n \{.RE
.\}


<a name="options"></a>

# Options


The config can contain these tags and attributes. Some of them are mandatory, others optional.

<a name="whitelist"></a>

### whitelist


The mandatory whitelist start and end tag defines the lockdown-whitelist. This tag can only be used once in a lockdown-whitelist configuration file. There are no attributes for this.

<a name="selinux"></a>

### selinux


Is an optional empty-element tag and can be used several times to have more than one selinux contexts entries. A selinux entry has exactly one attribute:

context="_string_"
The context is the security (SELinux) context of a running application or service.

To get the context of a running application use
**ps -e --context**
and search for the application that should be white-listed.

Warning: If the context of an application is unconfined, then this will open access for more than the desired application.

<a name="command"></a>

### command


Is an optional empty-element tag and can be used several times to have more than one command entry. A command entry has exactly one attribute:

name="_string_"
The command
_string_
is a complete command line including path and also attributes.

If a command entry ends with an asterisk *\*(Aq, then all command lines starting with the command will match. If the \*(Aq*\*(Aq is not there the absolute command inclusive arguments must match.

Commands for user root and others is not always the same, the used path depends on the use of the
**PATH**
environment variable.

<a name="user"></a>

### user


Is an optional empty-element tag and can be used several times to white-list more than one user. A user entry has exactly one attribute of these:

name="_string_"
The user with the name
_string_
will be white-listed.

id="_integer_"
The user with the id
_userid_
will be white-listed.

<a name="see-also"></a>

# See Also

**firewall-applet**(1), **firewalld**(1), **firewall-cmd**(1), **firewall-config**(1), **firewalld.conf**(5), **firewalld.direct**(5), **firewalld.dbus**(5), **firewalld.icmptype**(5), **firewalld.lockdown-whitelist**(5), **firewall-offline-cmd**(1), **firewalld.richlanguage**(5), **firewalld.service**(5), **firewalld.zone**(5), **firewalld.zones**(5), **firewalld.ipset**(5), **firewalld.helper**(5)

<a name="notes"></a>

# Notes


firewalld home page:
\m[blue]**http://firewalld.org**\m[]

More documentation with examples:
\m[blue]**http://fedoraproject.org/wiki/FirewallD**\m[]

<a name="authors"></a>

# Authors


**Thomas Woerner** &lt;[twoerner@redhat.com](mailto:twoerner@redhat.com)&gt;
Developer

**Jiri Popelka** &lt;[jpopelka@redhat.com](mailto:jpopelka@redhat.com)&gt;
Developer

**Eric Garver** &lt;[eric@garver.life](mailto:eric@garver.life)&gt;
Developer
