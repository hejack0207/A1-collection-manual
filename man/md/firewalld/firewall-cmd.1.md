# firewall\-cmd(1)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewall-cmd - firewalld command line client

<a name="synopsis"></a>

# Synopsis

```
.HP \w'firewall-cmd&nbsp;'u firewall-cmd [OPTIONS...]
```

<a name="description"></a>

# Description


firewall-cmd is the command line client of the firewalld daemon. It provides interface to manage runtime and permanent configuration.

The runtime configuration in firewalld is separated from the permanent configuration. This means that things can get changed in the runtime or permanent configuration.

<a name="options"></a>

# Options


Sequence options are the options that can be specified multiple times, the exit code is 0 if there is at least one item that succeeded. The
_ALREADY\_ENABLED_
(11),
_NOT\_ENABLED_
(12) and also
_ZONE\_ALREADY\_SET_
(16) errors are treated as succeeded. If there are issues while parsing the items, then these are treated as warnings and will not change the result as long as there is a succeeded one. Without any succeeded item, the exit code will depend on the error codes. If there is exactly one error code, then this is used. If there are more than one then
_UNKNOWN\_ERROR_
(254) will be used.

The following options are supported:

<a name="general-options"></a>

### General Options


**-h**, **--help**
Prints a short help text and exits.

**-V**, **--version**
Print the version string of firewalld. This option is not combinable with other options.

**-q**, **--quiet**
Do not print status messages.

<a name="status-options"></a>

### Status Options


**--state**
Check whether the firewalld daemon is active (i.e. running). Returns an exit code 0 if it is active,
_RUNNING\_BUT\_FAILED_
if failure occurred on startup,
_NOT\_RUNNING_
otherwise. See
the section called “EXIT CODES”. This will also print the state to
_STDOUT_.

**--reload**
Reload firewall rules and keep state information. Current permanent configuration will become new runtime configuration, i.e. all runtime only changes done until reload are lost with reload if they have not been also in permanent configuration.

Note: Runtime changes applied via the direct interface are not affected and will therefore stay in place until firewalld daemon is restarted completely.

**--complete-reload**
Reload firewall completely, even netfilter kernel modules. This will most likely terminate active connections, because state information is lost. This option should only be used in case of severe firewall problems. For example if there are state information problems that no connection can be established with correct firewall rules.

Note: Runtime changes applied via the direct interface are not affected and will therefore stay in place until firewalld daemon is restarted completely.

**--runtime-to-permanent**
Save active runtime configuration and overwrite permanent configuration with it. The way this is supposed to work is that when configuring firewalld you do runtime changes only and once youre happy with the configuration and you tested that it works the way you want, you save the configuration to disk.

**--check-config**
Run checks on the permanent configuration. This includes XML validity and semantics.

<a name="log-denied-options"></a>

### Log Denied Options


**--get-log-denied**
Print the log denied setting.

**--set-log-denied**=_value_
Add logging rules right before reject and drop rules in the INPUT, FORWARD and OUTPUT chains for the default rules and also final reject and drop rules in zones for the configured link-layer packet type. The possible values are:
_all_,
_unicast_,
_broadcast_,
_multicast_
and
_off_. The default setting is
_off_, which disables the logging.

This is a runtime and permanent change and will also reload the firewall to be able to add the logging rules.

<a name="permanent-options"></a>

### Permanent Options


**--permanent**
The permanent option
**--permanent**
can be used to set options permanently. These changes are not effective immediately, only after service restart/reload or system reboot. Without the
**--permanent**
option, a change will only be part of the runtime configuration.

If you want to make a change in runtime and permanent configuration, use the same call with and without the
**--permanent**
option.

The
**--permanent**
option can be optionally added to all options further down where it is supported.

<a name="zone-options"></a>

### Zone Options


**--get-default-zone**
Print default zone for connections and interfaces.

**--set-default-zone**=_zone_
Set default zone for connections and interfaces where no zone has been selected. Setting the default zone changes the zone for the connections or interfaces, that are using the default zone.

This is a runtime and permanent change.

**--get-active-zones**
Print currently active zones altogether with interfaces and sources used in these zones. Active zones are zones, that have a binding to an interface or source. The output format is:

.if n \{.RS 4
.\}
    zone1
      interfaces: interface1 interface2 ..
      sources: source1 ..
    zone2
      interfaces: interface3 ..
    zone3
      sources: source2 ..
    	      
.if n \{.RE
.\}

If there are no interfaces or sources bound to the zone, the corresponding line will be omitted.

[**--permanent**] **--get-zones**
Print predefined zones as a space separated list.

[**--permanent**] **--get-services**
Print predefined services as a space separated list.

[**--permanent**] **--get-icmptypes**
Print predefined icmptypes as a space separated list.

[**--permanent**] **--get-zone-of-interface**=_interface_
Print the name of the zone the
_interface_
is bound to or
_no zone_.

[**--permanent**] **--get-zone-of-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Print the name of the zone the source is bound to or
_no zone_.

[**--permanent**] **--info-zone=****zone**
Print information about the zone
_zone_. The output format is:

.if n \{.RS 4
.\}
    zone
      interfaces: interface1 ..
      sources: source1 ..
      services: service1 ..
      ports: port1 ..
      protocols: protocol1 ..
      forward-ports:
            forward-port1
            ..
      source-ports: source-port1 ..
      icmp-blocks: icmp-type1 ..
      rich rules:
            rich-rule1
            ..
                  
.if n \{.RE
.\}


[**--permanent**] **--list-all-zones**
List everything added for or enabled in all zones. The output format is:

.if n \{.RS 4
.\}
    zone1
      interfaces: interface1 ..
      sources: source1 ..
      services: service1 ..
      ports: port1 ..
      protocols: protocol1 ..
      forward-ports:
            forward-port1
            ..
      icmp-blocks: icmp-type1 ..
      rich rules:
            rich-rule1
            ..
    ..
                  
.if n \{.RE
.\}


**--permanent** **--new-zone**=_zone_
Add a new permanent and empty zone.

Zone names must be alphanumeric and may additionally include characters: _\*(Aq and \*(Aq-\*(Aq.

**--permanent** **--new-zone-from-file**=_filename_ [**--name**=_zone_]
Add a new permanent zone from a prepared zone file with an optional name override.

**--permanent** **--delete-zone**=_zone_
Delete an existing permanent zone.

**--permanent** **--load-zone-defaults**=_zone_
Load zone default settings or report NO_DEFAULTS error.

**--permanent** **--path-zone=****zone**
Print path of the zone configuration file.

**--permanent** **--zone**=_zone_ **--set-description**=_description_
Set new description to zone

**--permanent** **--zone**=_zone_ **--get-description**
Print description for zone

**--permanent** **--zone**=_zone_ **--set-short**=_description_
Set short description to zone

**--permanent** **--zone**=_zone_ **--get-short**
Print short description for zone

**--permanent** [**--zone**=_zone_] **--get-target**
Get the target of a permanent zone.

**--permanent** [**--zone**=_zone_] **--set-target**=_target_
Set the target of a permanent zone.
_target_
is one of:
_default_,
_ACCEPT_,
_DROP_,
_REJECT_

_default_
is similar to
_REJECT_, but has special meaning in the following scenarios:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  ICMP explicitly allowed

At the end of the zones ruleset ICMP packets are explicitly allowed.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  forwarded packets follow the
  _target_
  of the egress zone

In the case of forwarded packets, if the ingress zone uses
_default_
then whether or not the packet will be allowed is determined by the egress zone.

For a forwarded packet that ingresses zoneA and egresses zoneB:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  if zoneAs
  _target_
  is
  _ACCEPT_,
  _DROP_, or
  _REJECT_
  then the packet is accepted, dropped, or rejected respectively.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  if zoneAs
  _target_
  is
  _default_, then the packet is accepted, dropped, or rejected based on zoneBs
  _target_. If zoneBs
  _target_
  is also
  _default_, then the packet will be rejected by firewallds catchall reject.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Zone drifting from source-based zone to interface-based zone

This only applies if
**AllowZoneDrifting**
is enabled. See
**firewalld.conf**(5).

If a packet ingresses a source-based zone with a
_target_
of
_default_, it may still enter an interface-based zone (including the default zone).


<a name="options-to-adapt-and-query-zones"></a>

### Options to Adapt and Query Zones


Options in this section affect only one particular zone. If used with
**--zone**=_zone_
option, they affect the zone
_zone_. If the option is omitted, they affect default zone (see
**--get-default-zone**).

[**--permanent**] [**--zone**=_zone_] **--list-all**
List everything added for or enabled in
_zone_. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--list-services**
List services added for
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--add-service**=_service_ [**--timeout**=_timeval_]
Add a service for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times. If a timeout is supplied, the rule will be active for the specified amount of time and will be removed automatically afterwards.
_timeval_
is either a number (of seconds) or number followed by one of characters
_s_
(seconds),
_m_
(minutes),
_h_
(hours), for example
_20m_
or
_1h_.

The service is one of the firewalld provided services. To get a list of the supported services, use
**firewall-cmd --get-services**.

The
**--timeout**
option is not combinable with the
**--permanent**
option.

[**--permanent**] [**--zone**=_zone_] **--remove-service**=_service_
Remove a service from
_zone_. This option can be specified multiple times. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--query-service**=_service_
Return whether
_service_
has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--permanent**] [**--zone**=_zone_] **--list-ports**
List ports added for
_zone_
as a space separated list. A port is of the form
_portid_[-_portid_]/_protocol_, it can be either a port and protocol pair or a port range with a protocol. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--add-port**=_portid_[-_portid_]/_protocol_ [**--timeout**=_timeval_]
Add the port for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times. If a timeout is supplied, the rule will be active for the specified amount of time and will be removed automatically afterwards.
_timeval_
is either a number (of seconds) or number followed by one of characters
_s_
(seconds),
_m_
(minutes),
_h_
(hours), for example
_20m_
or
_1h_.

The port can either be a single port number or a port range
_portid_-_portid_. The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

The
**--timeout**
option is not combinable with the
**--permanent**
option.

[**--permanent**] [**--zone**=_zone_] **--remove-port**=_portid_[-_portid_]/_protocol_
Remove the port from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

[**--permanent**] [**--zone**=_zone_] **--query-port**=_portid_[-_portid_]/_protocol_
Return whether the port has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--permanent**] [**--zone**=_zone_] **--list-protocols**
List protocols added for
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--add-protocol**=_protocol_ [**--timeout**=_timeval_]
Add the protocol for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times. If a timeout is supplied, the rule will be active for the specified amount of time and will be removed automatically afterwards.
_timeval_
is either a number (of seconds) or number followed by one of characters
_s_
(seconds),
_m_
(minutes),
_h_
(hours), for example
_20m_
or
_1h_.

The protocol can be any protocol supported by the system. Please have a look at
_/etc/protocols_
for supported protocols.

The
**--timeout**
option is not combinable with the
**--permanent**
option.

[**--permanent**] [**--zone**=_zone_] **--remove-protocol**=_protocol_
Remove the protocol from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

[**--permanent**] [**--zone**=_zone_] **--query-protocol**=_protocol_
Return whether the protocol has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--permanent**] [**--zone**=_zone_] **--list-source-ports**
List source ports added for
_zone_
as a space separated list. A port is of the form
_portid_[-_portid_]/_protocol_. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--add-source-port**=_portid_[-_portid_]/_protocol_ [**--timeout**=_timeval_]
Add the source port for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times. If a timeout is supplied, the rule will be active for the specified amount of time and will be removed automatically afterwards.
_timeval_
is either a number (of seconds) or number followed by one of characters
_s_
(seconds),
_m_
(minutes),
_h_
(hours), for example
_20m_
or
_1h_.

The port can either be a single port number or a port range
_portid_-_portid_. The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

The
**--timeout**
option is not combinable with the
**--permanent**
option.

[**--permanent**] [**--zone**=_zone_] **--remove-source-port**=_portid_[-_portid_]/_protocol_
Remove the source port from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

[**--permanent**] [**--zone**=_zone_] **--query-source-port**=_portid_[-_portid_]/_protocol_
Return whether the source port has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--permanent**] [**--zone**=_zone_] **--list-icmp-blocks**
List Internet Control Message Protocol (ICMP) type blocks added for
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--add-icmp-block**=_icmptype_ [**--timeout**=_timeval_]
Add an ICMP block for
_icmptype_
for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times. If a timeout is supplied, the rule will be active for the specified amount of time and will be removed automatically afterwards.
_timeval_
is either a number (of seconds) or number followed by one of characters
_s_
(seconds),
_m_
(minutes),
_h_
(hours), for example
_20m_
or
_1h_.

The
_icmptype_
is the one of the icmp types firewalld supports. To get a listing of supported icmp types:
**firewall-cmd --get-icmptypes**

The
**--timeout**
option is not combinable with the
**--permanent**
option.

[**--permanent**] [**--zone**=_zone_] **--remove-icmp-block**=_icmptype_
Remove the ICMP block for
_icmptype_
from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

[**--permanent**] [**--zone**=_zone_] **--query-icmp-block**=_icmptype_
Return whether an ICMP block for
_icmptype_
has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--permanent**] [**--zone**=_zone_] **--list-forward-ports**
List
_IPv4_
forward ports added for
_zone_
as a space separated list. If zone is omitted, default zone will be used.

For
_IPv6_
forward ports, please use the rich language.

[**--permanent**] [**--zone**=_zone_] **--add-forward-port**=port=_portid_[-_portid_]:proto=_protocol_[:toport=_portid_[-_portid_]][:toaddr=_address_[/_mask_]] [**--timeout**=_timeval_]
Add the
_IPv4_
forward port for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times. If a timeout is supplied, the rule will be active for the specified amount of time and will be removed automatically afterwards.
_timeval_
is either a number (of seconds) or number followed by one of characters
_s_
(seconds),
_m_
(minutes),
_h_
(hours), for example
_20m_
or
_1h_.

The port can either be a single port number
_portid_
or a port range
_portid_-_portid_. The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_. The destination address is a simple IP address.

The
**--timeout**
option is not combinable with the
**--permanent**
option.

For
_IPv6_
forward ports, please use the rich language.

_Note:_
IP forwarding will be implicitly enabled if
**toaddr**
is specified.

[**--permanent**] [**--zone**=_zone_] **--remove-forward-port**=port=_portid_[-_portid_]:proto=_protocol_[:toport=_portid_[-_portid_]][:toaddr=_address_[/_mask_]]
Remove the
_IPv4_
forward port from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

For
_IPv6_
forward ports, please use the rich language.

[**--permanent**] [**--zone**=_zone_] **--query-forward-port**=port=_portid_[-_portid_]:proto=_protocol_[:toport=_portid_[-_portid_]][:toaddr=_address_[/_mask_]]
Return whether the
_IPv4_
forward port has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

For
_IPv6_
forward ports, please use the rich language.

[**--permanent**] [**--zone**=_zone_] **--add-masquerade** [**--timeout**=_timeval_]
Enable
_IPv4_
masquerade for
_zone_. If zone is omitted, default zone will be used. If a timeout is supplied, masquerading will be active for the specified amount of time.
_timeval_
is either a number (of seconds) or number followed by one of characters
_s_
(seconds),
_m_
(minutes),
_h_
(hours), for example
_20m_
or
_1h_. Masquerading is useful if the machine is a router and machines connected over an interface in another zone should be able to use the first connection.

The
**--timeout**
option is not combinable with the
**--permanent**
option.

For
_IPv6_
masquerading, please use the rich language.

_Note:_
IP forwarding will be implicitly enabled.

[**--permanent**] [**--zone**=_zone_] **--remove-masquerade**
Disable
_IPv4_
masquerade for
_zone_. If zone is omitted, default zone will be used. If the masquerading was enabled with a timeout, it will be disabled also.

For
_IPv6_
masquerading, please use the rich language.

[**--permanent**] [**--zone**=_zone_] **--query-masquerade**
Return whether
_IPv4_
masquerading has been enabled for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

For
_IPv6_
masquerading, please use the rich language.

[**--permanent**] [**--zone**=_zone_] **--list-rich-rules**
List rich language rules added for
_zone_
as a newline separated list. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--add-rich-rule**=_rule_\*(Aq [**--timeout**=_timeval_]
Add rich language rule _rule_\*(Aq for
_zone_. This option can be specified multiple times. If zone is omitted, default zone will be used. If a timeout is supplied, the
_rule_
will be active for the specified amount of time and will be removed automatically afterwards.
_timeval_
is either a number (of seconds) or number followed by one of characters
_s_
(seconds),
_m_
(minutes),
_h_
(hours), for example
_20m_
or
_1h_.

For the rich language rule syntax, please have a look at
**firewalld.richlanguage**(5).

The
**--timeout**
option is not combinable with the
**--permanent**
option.

[**--permanent**] [**--zone**=_zone_] **--remove-rich-rule**=_rule_\*(Aq
Remove rich language rule _rule_\*(Aq from
_zone_. This option can be specified multiple times. If zone is omitted, default zone will be used.

For the rich language rule syntax, please have a look at
**firewalld.richlanguage**(5).

[**--permanent**] [**--zone**=_zone_] **--query-rich-rule**=_rule_\*(Aq
Return whether a rich language rule _rule_\*(Aq has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

For the rich language rule syntax, please have a look at
**firewalld.richlanguage**(5).

<a name="options-to-handle-bindings-of-interfaces"></a>

### Options to Handle Bindings of Interfaces


Binding an interface to a zone means that this zone settings are used to restrict traffic via the interface.

Options in this section affect only one particular zone. If used with
**--zone**=_zone_
option, they affect the zone
_zone_. If the option is omitted, they affect default zone (see
**--get-default-zone**).

For a list of predefined zones use
**firewall-cmd --get-zones**.

An interface name is a string up to 16 characters long, that may not contain
** \*(Aq**,
**/\*(Aq**,
**!\*(Aq**
and
***\*(Aq**.

[**--permanent**] [**--zone**=_zone_] **--list-interfaces**
List interfaces that are bound to zone
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--add-interface**=_interface_
Bind interface
_interface_
to zone
_zone_. If zone is omitted, default zone will be used.

If the interface is under control of NetworkManager, it is at first connected to change the zone for the connection that is using the interface. If this fails, the zone binding is created in firewalld and the limitations below apply. For interfaces that are not under control of NetworkManager, firewalld tries to change the ZONE setting in the ifcfg file, if the file exists.

As a end user you dont need this in most cases, because NetworkManager (or legacy network service) adds interfaces into zones automatically (according to
**ZONE=**
option from ifcfg-_interface_
file) if
_NM\_CONTROLLED=no_
is not set. You should do it only if theres no /etc/sysconfig/network-scripts/ifcfg-_interface_
file. If there is such file and you add interface to zone with this
**--add-interface**
option, make sure the zone is the same in both cases, otherwise the behaviour would be undefined. Please also have a look at the
**firewalld**(1)
man page in the
_Concepts_
section. For permanent association of interface with a zone, see also How to set or change a zone for a connection?\*(Aq in
**firewalld.zones**(5).

[**--permanent**] [**--zone**=_zone_] **--change-interface**=_interface_
If the interface is under control of NetworkManager, it is at first connected to change the zone for the connection that is using the interface. If this fails, the zone binding is created in firewalld and the limitations below apply. For interfaces that are not under control of NetworkManager, firewalld tries to change the ZONE setting in the ifcfg file, if the file exists.

Change zone the interface
_interface_
is bound to to zone
_zone_. Its basically
**--remove-interface**
followed by
**--add-interface**. If the interface has not been bound to a zone before, it behaves like
**--add-interface**. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--query-interface**=_interface_
Query whether interface
_interface_
is bound to zone
_zone_. Returns 0 if true, 1 otherwise.

[**--permanent**] **--remove-interface**=_interface_
If the interface is under control of NetworkManager, it is at first connected to change the zone for the connection that is using the interface. If this fails, the zone binding is created in firewalld and the limitations below apply.

For the addion or change of interfaces that are not under control of NetworkManager: firewalld tries to change the ZONE setting in the ifcfg file, if an ifcfg file exists that is using the interface.

Only for the removal of interfaces that are not under control of NetworkManager: firewalld is not trying to change the ZONE setting in the ifcfg file. This is needed to make sure that an ifdown of the interface will not result in a reset of the zone setting to the default zone. Only the zone binding is then removed in firewalld then.

Remove binding of interface
_interface_
from zone it was previously added to.

<a name="options-to-handle-bindings-of-sources"></a>

### Options to Handle Bindings of Sources


Binding a source to a zone means that this zone settings will be used to restrict traffic from this source.

A source address or address range is either an IP address or a network IP address with a mask for IPv4 or IPv6 or a MAC address or an ipset with the ipset: prefix. For IPv4, the mask can be a network mask or a plain number. For IPv6 the mask is a plain number. The use of host names is not supported.

Options in this section affect only one particular zone. If used with
**--zone**=_zone_
option, they affect the zone
_zone_. If the option is omitted, they affect default zone (see
**--get-default-zone**).

For a list of predefined zones use
**firewall-cmd ****[--permanent**]** --get-zones**.

[**--permanent**] [**--zone**=_zone_] **--list-sources**
List sources that are bound to zone
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--add-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Bind the source to zone
_zone_. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--change-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Change zone the source is bound to to zone
_zone_. Its basically
**--remove-source**
followed by
**--add-source**. If the source has not been bound to a zone before, it behaves like
**--add-source**. If zone is omitted, default zone will be used.

[**--permanent**] [**--zone**=_zone_] **--query-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Query whether the source is bound to the zone
_zone_. Returns 0 if true, 1 otherwise.

[**--permanent**] **--remove-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Remove binding of the source from zone it was previously added to.

<a name="ipset-options"></a>

### IPSet Options


**--get-ipset-types**
Print the supported ipset types.

**--permanent** **--new-ipset**=_ipset_ **--type**=_type_ [**--family**=_inet_|_inet6_] [**--option**=_key_[=_value_]]
Add a new permanent and empty ipset with specifying the type and optional the family and options like
_timeout_,
_hashsize_
and
_maxelem_. For more information please have a look at
**ipset**(8)
man page.

ipset names must be alphanumeric and may additionally include characters: _\*(Aq and \*(Aq-\*(Aq.

**--permanent** **--new-ipset-from-file**=_filename_ [**--name**=_ipset_]
Add a new permanent ipset from a prepared ipset file with an optional name override.

**--permanent** **--delete-ipset**=_ipset_
Delete an existing permanent ipset.

**--permanent** **--load-ipset-defaults**=_ipset_
Load ipset default settings or report NO_DEFAULTS error.

[**--permanent**] **--info-ipset=****ipset**
Print information about the ipset
_ipset_. The output format is:

.if n \{.RS 4
.\}
    ipset
      type: type
      options: option1[=value1] ..
      entries: entry1 ..
                  
.if n \{.RE
.\}


[**--permanent**] **--get-ipsets**
Print predefined ipsets as a space separated list.

**--permanent** **--ipset**=_ipset_ **--set-description**=_description_
Set new description to ipset

**--permanent** **--ipset**=_ipset_ **--get-description**
Print description for ipset

**--permanent** **--ipset**=_ipset_ **--set-short**=_description_
Set short description to ipset

**--permanent** **--ipset**=_ipset_ **--get-short**
Print short description for ipset

[**--permanent**] **--ipset**=_ipset_ **--add-entry**=_entry_
Add a new entry to the ipset.

Adding an entry to an ipset with option
_timeout_
is permitted, but these entries are not tracked by firewalld.

[**--permanent**] **--ipset**=_ipset_ **--remove-entry**=_entry_
Remove an entry from the ipset.

[**--permanent**] **--ipset**=_ipset_ **--query-entry**=_entry_
Return whether the entry has been added to an ipset. Returns 0 if true, 1 otherwise.

Querying an ipset with a timeout will yield an error. Entries are not tracked for ipsets with a timeout.

[**--permanent**] **--ipset**=_ipset_ **--get-entries**
List all entries of the ipset.

[**--permanent**] **--ipset**=_ipset_ **--add-entries-from-file**=_filename_
Add a new entries to the ipset from the file. For all entries that are listed in the file but already in the ipset, a warning will be printed.

The file should contain an entry per line. Lines starting with an hash or semicolon are ignored. Also empty lines.

[**--permanent**] **--ipset**=_ipset_ **--remove-entries-from-file**=_filename_
Remove existing entries from the ipset from the file. For all entries that are listed in the file but not in the ipset, a warning will be printed.

The file should contain an entry per line. Lines starting with an hash or semicolon are ignored. Also empty lines.

**--permanent** **--path-ipset=****ipset**
Print path of the ipset configuration file.

<a name="service-options"></a>

### Service Options


Options in this section affect only one particular service.

[**--permanent**] **--info-service=****service**
Print information about the service
_service_. The output format is:

.if n \{.RS 4
.\}
    service
      ports: port1 ..
      protocols: protocol1 ..
      source-ports: source-port1 ..
      helpers: helper1 ..
      destination: ipv1:address1 ..
                  
.if n \{.RE
.\}


The following options are only usable in the permanent configuration.

**--permanent** **--new-service**=_service_
Add a new permanent and empty service.

Service names must be alphanumeric and may additionally include characters: _\*(Aq and \*(Aq-\*(Aq.

**--permanent** **--new-service-from-file**=_filename_ [**--name**=_service_]
Add a new permanent service from a prepared service file with an optional name override.

**--permanent** **--delete-service**=_service_
Delete an existing permanent service.

**--permanent** **--load-service-defaults**=_service_
Load service default settings or report NO_DEFAULTS error.

**--permanent** **--path-service=****service**
Print path of the service configuration file.

**--permanent** **--service**=_service_ **--set-description**=_description_
Set new description to service

**--permanent** **--service**=_service_ **--get-description**
Print description for service

**--permanent** **--service**=_service_ **--set-short**=_description_
Set short description to service

**--permanent** **--service**=_service_ **--get-short**
Print short description for service

**--permanent** **--service**=_service_ **--add-port**=_portid_[-_portid_]/_protocol_
Add a new port to the permanent service.

**--permanent** **--service**=_service_ **--remove-port**=_portid_[-_portid_]/_protocol_
Remove a port from the permanent service.

**--permanent** **--service**=_service_ **--query-port**=_portid_[-_portid_]/_protocol_
Return wether the port has been added to the permanent service.

**--permanent** **--service**=_service_ **--get-ports**
List ports added to the permanent service.

**--permanent** **--service**=_service_ **--add-protocol**=_protocol_
Add a new protocol to the permanent service.

**--permanent** **--service**=_service_ **--remove-protocol**=_protocol_
Remove a protocol from the permanent service.

**--permanent** **--service**=_service_ **--query-protocol**=_protocol_
Return wether the protocol has been added to the permanent service.

**--permanent** **--service**=_service_ **--get-protocols**
List protocols added to the permanent service.

**--permanent** **--service**=_service_ **--add-source-port**=_portid_[-_portid_]/_protocol_
Add a new source port to the permanent service.

**--permanent** **--service**=_service_ **--remove-source-port**=_portid_[-_portid_]/_protocol_
Remove a source port from the permanent service.

**--permanent** **--service**=_service_ **--query-source-port**=_portid_[-_portid_]/_protocol_
Return wether the source port has been added to the permanent service.

**--permanent** **--service**=_service_ **--get-source-ports**
List source ports added to the permanent service.

**--permanent** **--service**=_service_ **--add-helper**=_helper_
Add a new helper to the permanent service.

**--permanent** **--service**=_service_ **--remove-helper**=_helper_
Remove a helper from the permanent service.

**--permanent** **--service**=_service_ **--query-helper**=_helper_
Return wether the helper has been added to the permanent service.

**--permanent** **--service**=_service_ **--get-service-helpers**
List helpers added to the permanent service.

**--permanent** **--service**=_service_ **--set-destination**=_ipv_:_address_[/_mask_]
Set destination for ipv to address[/mask] in the permanent service.

**--permanent** **--service**=_service_ **--remove-destination**=_ipv_
Remove the destination for ipv from the permanent service.

**--permanent** **--service**=_service_ **--query-destination**=_ipv_:_address_[/_mask_]
Return wether the destination ipv to address[/mask] has been set in the permanent service.

**--permanent** **--service**=_service_ **--get-destinations**
List destinations added to the permanent service.

**--permanent** **--service**=_service_ **--add-include**=_service_
Add a new include to the permanent service.

**--permanent** **--service**=_service_ **--remove-include**=_service_
Remove a include from the permanent service.

**--permanent** **--service**=_service_ **--query-include**=_service_
Return wether the include has been added to the permanent service.

**--permanent** **--service**=_service_ **--get-includes**
List includes added to the permanent service.

<a name="helper-options"></a>

### Helper Options


Options in this section affect only one particular helper.

[**--permanent**] **--info-helper=****helper**
Print information about the helper
_helper_. The output format is:

.if n \{.RS 4
.\}
    helper
      family: family
      module: module
      ports: port1 ..
                  
.if n \{.RE
.\}


The following options are only usable in the permanent configuration.

**--permanent** **--new-helper**=_helper_ **--module**=_nf\_conntrack\_module_ [**--family**=_ipv4_|_ipv6_]
Add a new permanent helper with module and optionally family defined.

Helper names must be alphanumeric and may additionally include characters: -\*(Aq.

**--permanent** **--new-helper-from-file**=_filename_ [**--name**=_helper_]
Add a new permanent helper from a prepared helper file with an optional name override.

**--permanent** **--delete-helper**=_helper_
Delete an existing permanent helper.

**--permanent** **--load-helper-defaults**=_helper_
Load helper default settings or report NO_DEFAULTS error.

**--permanent** **--path-helper=****helper**
Print path of the helper configuration file.

[**--permanent**] **--get-helpers**
Print predefined helpers as a space separated list.

**--permanent** **--helper**=_helper_ **--set-description**=_description_
Set new description to helper

**--permanent** **--helper**=_helper_ **--get-description**
Print description for helper

**--permanent** **--helper**=_helper_ **--set-short**=_description_
Set short description to helper

**--permanent** **--helper**=_helper_ **--get-short**
Print short description for helper

**--permanent** **--helper**=_helper_ **--add-port**=_portid_[-_portid_]/_protocol_
Add a new port to the permanent helper.

**--permanent** **--helper**=_helper_ **--remove-port**=_portid_[-_portid_]/_protocol_
Remove a port from the permanent helper.

**--permanent** **--helper**=_helper_ **--query-port**=_portid_[-_portid_]/_protocol_
Return wether the port has been added to the permanent helper.

**--permanent** **--helper**=_helper_ **--get-ports**
List ports added to the permanent helper.

**--permanent** **--helper**=_helper_ **--set-module**=_description_
Set module description for helper

**--permanent** **--helper**=_helper_ **--get-module**
Print module description for helper

**--permanent** **--helper**=_helper_ **--set-family**=_description_
Set family description for helper

**--permanent** **--helper**=_helper_ **--get-family**
Print family description of helper

<a name="internet-control-message-protocol-icmp-type-options"></a>

### Internet Control Message Protocol (ICMP) type Options


Options in this section affect only one particular icmptype.

[**--permanent**] **--info-icmptype=****icmptype**
Print information about the icmptype
_icmptype_. The output format is:

.if n \{.RS 4
.\}
    icmptype
      destination: ipv1 ..
                  
.if n \{.RE
.\}


The following options are only usable in the permanent configuration.

**--permanent** **--new-icmptype**=_icmptype_
Add a new permanent and empty icmptype.

ICMP type names must be alphanumeric and may additionally include characters: _\*(Aq and \*(Aq-\*(Aq.

**--permanent** **--new-icmptype-from-file**=_filename_ [**--name**=_icmptype_]
Add a new permanent icmptype from a prepared icmptype file with an optional name override.

**--permanent** **--delete-icmptype**=_icmptype_
Delete an existing permanent icmptype.

**--permanent** **--load-icmptype-defaults**=_icmptype_
Load icmptype default settings or report NO_DEFAULTS error.

**--permanent** **--icmptype**=_icmptype_ **--set-description**=_description_
Set new description to icmptype

**--permanent** **--icmptype**=_icmptype_ **--get-description**
Print description for icmptype

**--permanent** **--icmptype**=_icmptype_ **--set-short**=_description_
Set short description to icmptype

**--permanent** **--icmptype**=_icmptype_ **--get-short**
Print short description for icmptype

**--permanent** **--icmptype**=_icmptype_ **--add-destination**=_ipv_
Enable destination for ipv in permanent icmptype. ipv is one of
_ipv4_
or
_ipv6_.

**--permanent** **--icmptype**=_icmptype_ **--remove-destination**=_ipv_
Disable destination for ipv in permanent icmptype. ipv is one of
_ipv4_
or
_ipv6_.

**--permanent** **--icmptype**=_icmptype_ **--query-destination**=_ipv_
Return whether destination for ipv is enabled in permanent icmptype. ipv is one of
_ipv4_
or
_ipv6_.

**--permanent** **--icmptype**=_icmptype_ **--get-destinations**
List destinations in permanent icmptype.

**--permanent** **--path-icmptype=****icmptype**
Print path of the icmptype configuration file.

<a name="direct-options"></a>

### Direct Options


The direct options give a more direct access to the firewall. These options require user to know basic iptables concepts, i.e.
_table_
(filter/mangle/nat/...),
_chain_
(INPUT/OUTPUT/FORWARD/...),
_commands_
(-A/-D/-I/...),
_parameters_
(-p/-s/-d/-j/...) and
_targets_
(ACCEPT/DROP/REJECT/...).

Direct options should be used only as a last resort when its not possible to use for example
**--add-service**=_service_
or
**--add-rich-rule**=_rule_\*(Aq.

**Warning**: Direct rules behavior is different depending on the value of
_FirewallBackend_. See
_CAVEATS_
in
**firewalld.direct**(5).

The first argument of each option has to be
_ipv4_
or
_ipv6_
or
_eb_. With
_ipv4_
it will be for IPv4 (**iptables**(8)), with
_ipv6_
for IPv6 (**ip6tables**(8)) and with
_eb_
for ethernet bridges (**ebtables**(8)).

[**--permanent**] **--direct** **--get-all-chains**
Get all chains added to all tables. This option concerns only chains previously added with
**--direct --add-chain**.

[**--permanent**] **--direct** **--get-chains** { _ipv4_ | _ipv6_ | _eb_ } _table_
Get all chains added to table
_table_
as a space separated list. This option concerns only chains previously added with
**--direct --add-chain**.

[**--permanent**] **--direct** **--add-chain** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Add a new chain with name
_chain_
to table
_table_. Make sure theres no other chain with this name already.

There already exist basic chains to use with direct options, for example
_INPUT\_direct_
chain (see
_iptables-save | grep direct_
output for all of them). These chains are jumped into before chains for zones, i.e. every rule put into
_INPUT\_direct_
will be checked before rules in zones.

[**--permanent**] **--direct** **--remove-chain** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Remove chain with name
_chain_
from table
_table_. Only chains previously added with
**--direct --add-chain**
can be removed this way.

[**--permanent**] **--direct** **--query-chain** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Return whether a chain with name
_chain_
exists in table
_table_. Returns 0 if true, 1 otherwise. This option concerns only chains previously added with
**--direct --add-chain**.

[**--permanent**] **--direct** **--get-all-rules**
Get all rules added to all chains in all tables as a newline separated list of the priority and arguments. This option concerns only rules previously added with
**--direct --add-rule**.

[**--permanent**] **--direct** **--get-rules** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Get all rules added to chain
_chain_
in table
_table_
as a newline separated list of the priority and arguments. This option concerns only rules previously added with
**--direct --add-rule**.

[**--permanent**] **--direct** **--add-rule** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_ _priority_ _args_
Add a rule with the arguments
_args_
to chain
_chain_
in table
_table_
with priority
_priority_.

The
_priority_
is used to order rules. Priority 0 means add rule on top of the chain, with a higher priority the rule will be added further down. Rules with the same priority are on the same level and the order of these rules is not fixed and may change. If you want to make sure that a rule will be added after another one, use a low priority for the first and a higher for the following.

[**--permanent**] **--direct** **--remove-rule** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_ _priority_ _args_
Remove a rule with
_priority_
and the arguments
_args_
from chain
_chain_
in table
_table_. Only rules previously added with
**--direct --add-rule**
can be removed this way.

[**--permanent**] **--direct** **--remove-rules** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Remove all rules in the chain with name
_chain_
exists in table
_table_. This option concerns only rules previously added with
**--direct --add-rule**
in this chain.

[**--permanent**] **--direct** **--query-rule** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_ _priority_ _args_
Return whether a rule with
_priority_
and the arguments
_args_
exists in chain
_chain_
in table
_table_. Returns 0 if true, 1 otherwise. This option concerns only rules previously added with
**--direct --add-rule**.

**--direct** **--passthrough** { _ipv4_ | _ipv6_ | _eb_ } _args_
Pass a command through to the firewall.
_args_
can be all
**iptables**,
**ip6tables**
and
**ebtables**
command line arguments. This command is untracked, which means that firewalld is not able to provide information about this command later on, also not a listing of the untracked passthoughs.

[**--permanent**] **--direct** **--get-all-passthroughs**
Get all passthrough rules as a newline separated list of the ipv value and arguments.

[**--permanent**] **--direct** **--get-passthroughs** { _ipv4_ | _ipv6_ | _eb_ }
Get all passthrough rules for the ipv value as a newline separated list of the priority and arguments.

[**--permanent**] **--direct** **--add-passthrough** { _ipv4_ | _ipv6_ | _eb_ } _args_
Add a passthrough rule with the arguments
_args_
for the ipv value.

[**--permanent**] **--direct** **--remove-passthrough** { _ipv4_ | _ipv6_ | _eb_ } _args_
Remove a passthrough rule with the arguments
_args_
for the ipv value.

[**--permanent**] **--direct** **--query-passthrough** { _ipv4_ | _ipv6_ | _eb_ } _args_
Return whether a passthrough rule with the arguments
_args_
exists for the ipv value. Returns 0 if true, 1 otherwise.

<a name="lockdown-options"></a>

### Lockdown Options


Local applications or services are able to change the firewall configuration if they are running as root (example: libvirt) or are authenticated using PolicyKit. With this feature administrators can lock the firewall configuration so that only applications on lockdown whitelist are able to request firewall changes.

The lockdown access check limits D-Bus methods that are changing firewall rules. Query, list and get methods are not limited.

The lockdown feature is a very light version of user and application policies for firewalld and is turned off by default.

**--lockdown-on**
Enable lockdown. Be careful - if firewall-cmd is not on lockdown whitelist when you enable lockdown you wont be able to disable it again with firewall-cmd, you would need to edit firewalld.conf.

This is a runtime and permanent change.

**--lockdown-off**
Disable lockdown.

This is a runtime and permanent change.

**--query-lockdown**
Query whether lockdown is enabled. Returns 0 if lockdown is enabled, 1 otherwise.

<a name="lockdown-whitelist-options"></a>

### Lockdown Whitelist Options


The lockdown whitelist can contain
_commands_,
_contexts_,
_users_
and
_user ids_.

If a command entry on the whitelist ends with an asterisk *\*(Aq, then all command lines starting with the command will match. If the \*(Aq*\*(Aq is not there the absolute command inclusive arguments must match.

Command paths for users are not always the same and depends on the users PATH. Some distributions symlink
**/bin**
to
**/usr/bin**
in which case it depends on the order they appear in the PATH environment variable.

The context is the security (SELinux) context of a running application or service. To get the context of a running application use
**ps -e --context**.

**Warning:**
If the context is unconfined, then this will open access for more than the desired application.

The lockdown whitelist entries are checked in the following order:
1. _context_
2. _uid_
3. _user_
4. _command_

[**--permanent**] **--list-lockdown-whitelist-commands**
List all command lines that are on the whitelist.

[**--permanent**] **--add-lockdown-whitelist-command**=_command_
Add the
_command_
to the whitelist.

[**--permanent**] **--remove-lockdown-whitelist-command**=_command_
Remove the
_command_
from the whitelist.

[**--permanent**] **--query-lockdown-whitelist-command**=_command_
Query whether the
_command_
is on the whitelist. Returns 0 if true, 1 otherwise.

[**--permanent**] **--list-lockdown-whitelist-contexts**
List all contexts that are on the whitelist.

[**--permanent**] **--add-lockdown-whitelist-context**=_context_
Add the context
_context_
to the whitelist.

[**--permanent**] **--remove-lockdown-whitelist-context**=_context_
Remove the
_context_
from the whitelist.

[**--permanent**] **--query-lockdown-whitelist-context**=_context_
Query whether the
_context_
is on the whitelist. Returns 0 if true, 1 otherwise.

[**--permanent**] **--list-lockdown-whitelist-uids**
List all user ids that are on the whitelist.

[**--permanent**] **--add-lockdown-whitelist-uid**=_uid_
Add the user id
_uid_
to the whitelist.

[**--permanent**] **--remove-lockdown-whitelist-uid**=_uid_
Remove the user id
_uid_
from the whitelist.

[**--permanent**] **--query-lockdown-whitelist-uid**=_uid_
Query whether the user id
_uid_
is on the whitelist. Returns 0 if true, 1 otherwise.

[**--permanent**] **--list-lockdown-whitelist-users**
List all user names that are on the whitelist.

[**--permanent**] **--add-lockdown-whitelist-user**=_user_
Add the user name
_user_
to the whitelist.

[**--permanent**] **--remove-lockdown-whitelist-user**=_user_
Remove the user name
_user_
from the whitelist.

[**--permanent**] **--query-lockdown-whitelist-user**=_user_
Query whether the user name
_user_
is on the whitelist. Returns 0 if true, 1 otherwise.

<a name="panic-options"></a>

### Panic Options


**--panic-on**
Enable panic mode. All incoming and outgoing packets are dropped, active connections will expire. Enable this only if there are serious problems with your network environment. For example if the machine is getting hacked in.

This is a runtime only change.

**--panic-off**
Disable panic mode. After disabling panic mode established connections might work again, if panic mode was enabled for a short period of time.

This is a runtime only change.

**--query-panic**
Returns 0 if panic mode is enabled, 1 otherwise.

<a name="examples"></a>

# Examples


For more examples see
\m[blue]**http://fedoraproject.org/wiki/FirewallD**\m[]

<a name="example-1"></a>

### Example 1


Enable http service in default zone. This is runtime only change, i.e. effective until restart.

.if n \{.RS 4
.\}
    firewall-cmd --add-service=http
    	
.if n \{.RE
.\}


<a name="example-2"></a>

### Example 2


Enable port 443/tcp immediately and permanently in default zone. To make the change effective immediately and also after restart we need two commands. The first command makes the change in runtime configuration, i.e. makes it effective immediately, until restart. The second command makes the change in permanent configuration, i.e. makes it effective after restart.

.if n \{.RS 4
.\}
    firewall-cmd --add-port=443/tcp
    firewall-cmd --permanent --add-port=443/tcp
    	
.if n \{.RE
.\}


<a name="exit-codes"></a>

# Exit Codes


On success 0 is returned. On failure the output is red colored and exit code is either 2 in case of wrong command-line option usage or one of the following error codes in other cases:
.TS
allbox tab(:);
lB rB.
T{
String
T}:T{
Code
T}
.T&
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r
l r.
T{
ALREADY_ENABLED
T}:T{
11
T}
T{
NOT_ENABLED
T}:T{
12
T}
T{
COMMAND_FAILED
T}:T{
13
T}
T{
NO_IPV6_NAT
T}:T{
14
T}
T{
PANIC_MODE
T}:T{
15
T}
T{
ZONE_ALREADY_SET
T}:T{
16
T}
T{
UNKNOWN_INTERFACE
T}:T{
17
T}
T{
ZONE_CONFLICT
T}:T{
18
T}
T{
BUILTIN_CHAIN
T}:T{
19
T}
T{
EBTABLES_NO_REJECT
T}:T{
20
T}
T{
NOT_OVERLOADABLE
T}:T{
21
T}
T{
NO_DEFAULTS
T}:T{
22
T}
T{
BUILTIN_ZONE
T}:T{
23
T}
T{
BUILTIN_SERVICE
T}:T{
24
T}
T{
BUILTIN_ICMPTYPE
T}:T{
25
T}
T{
NAME_CONFLICT
T}:T{
26
T}
T{
NAME_MISMATCH
T}:T{
27
T}
T{
PARSE_ERROR
T}:T{
28
T}
T{
ACCESS_DENIED
T}:T{
29
T}
T{
UNKNOWN_SOURCE
T}:T{
30
T}
T{
RT_TO_PERM_FAILED
T}:T{
31
T}
T{
IPSET_WITH_TIMEOUT
T}:T{
32
T}
T{
BUILTIN_IPSET
T}:T{
33
T}
T{
ALREADY_SET
T}:T{
34
T}
T{
MISSING_IMPORT
T}:T{
35
T}
T{
DBUS_ERROR
T}:T{
36
T}
T{
BUILTIN_HELPER
T}:T{
37
T}
T{
NOT_APPLIED
T}:T{
38
T}
T{
INVALID_ACTION
T}:T{
100
T}
T{
INVALID_SERVICE
T}:T{
101
T}
T{
INVALID_PORT
T}:T{
102
T}
T{
INVALID_PROTOCOL
T}:T{
103
T}
T{
INVALID_INTERFACE
T}:T{
104
T}
T{
INVALID_ADDR
T}:T{
105
T}
T{
INVALID_FORWARD
T}:T{
106
T}
T{
INVALID_ICMPTYPE
T}:T{
107
T}
T{
INVALID_TABLE
T}:T{
108
T}
T{
INVALID_CHAIN
T}:T{
109
T}
T{
INVALID_TARGET
T}:T{
110
T}
T{
INVALID_IPV
T}:T{
111
T}
T{
INVALID_ZONE
T}:T{
112
T}
T{
INVALID_PROPERTY
T}:T{
113
T}
T{
INVALID_VALUE
T}:T{
114
T}
T{
INVALID_OBJECT
T}:T{
115
T}
T{
INVALID_NAME
T}:T{
116
T}
T{
INVALID_FILENAME
T}:T{
117
T}
T{
INVALID_DIRECTORY
T}:T{
118
T}
T{
INVALID_TYPE
T}:T{
119
T}
T{
INVALID_SETTING
T}:T{
120
T}
T{
INVALID_DESTINATION
T}:T{
121
T}
T{
INVALID_RULE
T}:T{
122
T}
T{
INVALID_LIMIT
T}:T{
123
T}
T{
INVALID_FAMILY
T}:T{
124
T}
T{
INVALID_LOG_LEVEL
T}:T{
125
T}
T{
INVALID_AUDIT_TYPE
T}:T{
126
T}
T{
INVALID_MARK
T}:T{
127
T}
T{
INVALID_CONTEXT
T}:T{
128
T}
T{
INVALID_COMMAND
T}:T{
129
T}
T{
INVALID_USER
T}:T{
130
T}
T{
INVALID_UID
T}:T{
131
T}
T{
INVALID_MODULE
T}:T{
132
T}
T{
INVALID_PASSTHROUGH
T}:T{
133
T}
T{
INVALID_MAC
T}:T{
134
T}
T{
INVALID_IPSET
T}:T{
135
T}
T{
INVALID_ENTRY
T}:T{
136
T}
T{
INVALID_OPTION
T}:T{
137
T}
T{
INVALID_HELPER
T}:T{
138
T}
T{
INVALID_PRIORITY
T}:T{
139
T}
T{
MISSING_TABLE
T}:T{
200
T}
T{
MISSING_CHAIN
T}:T{
201
T}
T{
MISSING_PORT
T}:T{
202
T}
T{
MISSING_PROTOCOL
T}:T{
203
T}
T{
MISSING_ADDR
T}:T{
204
T}
T{
MISSING_NAME
T}:T{
205
T}
T{
MISSING_SETTING
T}:T{
206
T}
T{
MISSING_FAMILY
T}:T{
207
T}
T{
RUNNING_BUT_FAILED
T}:T{
251
T}
T{
NOT_RUNNING
T}:T{
252
T}
T{
NOT_AUTHORIZED
T}:T{
253
T}
T{
UNKNOWN_ERROR
T}:T{
254
T}
.TE


Note that return codes of
**--query-***
options are special: Successful queries return 0, unsuccessful ones return 1 unless an error occurred in which case the table above applies.

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
