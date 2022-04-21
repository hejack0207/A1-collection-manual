# firewall\-offline\-c(1)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewall-offline-cmd - firewalld offline command line client

<a name="synopsis"></a>

# Synopsis

```
.HP \w'firewall-offline-cmd&nbsp;'u firewall-offline-cmd [OPTIONS...]
```

<a name="description"></a>

# Description


firewall-offline-cmd is an offline command line client of the firewalld daemon. It should be used only if the firewalld service is not running. For example to migrate from system-config-firewall/lokkit or in the install environment to configure firewall settings with kickstart.

Some lokkit options can not be automatically converted for firewalld, they will result in an error or warning message. This tool tries to convert as much as possible, but there are limitations for example with custom rules, modules and masquerading.

Check the firewall configuration after using this tool.

<a name="options"></a>

# Options


If no options are given, configuration from
**/etc/sysconfig/system-config-firewall**
will be migrated.

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
Prints a short help text and exists.

**-V**, **--version**
Prints the version string of firewalld and exits.

**-q**, **--quiet**
Do not print status messages.

**--default-config**
Path to firewalld default configuration. This usually defaults to
_/usr/lib/firewalld_.

**--system-config**
Path to firewalld system (user) configuration. This usually defaults to
_/etc/firewalld_.

<a name="status-options"></a>

### Status Options


**--enabled**
Enable the firewall. This option is a default option and will activate the firewall if not already enabled as long as the option
**--disabled**
is not given.

**--disabled**
Disable the firewall by disabling the firewalld service.

**--check-config**
Run checks on the permanent (default and system) configuration. This includes XML validity and semantics.

This is may be used with
**--system-config**
to check the validity of handwritten configuration files before copying them to the standard location.

<a name="lokkit-compatibility-options"></a>

### Lokkit Compatibility Options


These options are nearly identical to the options of
**lokkit**.

**--migrate-system-config-firewall=****file**
Migrate system-config-firewall configuration from the given file. No further

**--addmodule**=_module_
This option will result in a warning message and will be ignored.

Handling of netfilter helpers has been merged into services completely. Adding or removing netfilter helpers outside of services is therefore not needed anymore. For more information on handling netfilter helpers in services, please have a look at
**firewalld.zone**(5).

**--removemodule**
This option will result in a warning message and will be ignored.

Handling of netfilter helpers has been merged into services completely. Adding or removing netfilter helpers outside of services is therefore not needed anymore. For more information on handling netfilter helpers in services, please have a look at
**firewalld.zone**(5).

**--remove-service**=_service_
Remove a service from the default zone. This option can be specified multiple times.

The service is one of the firewalld provided services. To get a list of the supported services, use
**firewall-cmd --get-services**.

**-s** _service_, **--service**=_service_
Add a service to the default zone. This option can be specified multiple times.

The service is one of the firewalld provided services. To get a list of the supported services, use
**firewall-cmd --get-services**.

**-p** _portid_[-_portid_]:_protocol_, **--port**=_portid_[-_portid_]:_protocol_
Add the port to the default zone. This option can be specified multiple times.

The port can either be a single port number or a port range
_portid_-_portid_. The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

**-t** _interface_, **--trust**=_interface_
This option will result in a warning message.

Mark an interface as trusted. This option can be specified multiple times. The interface will be bound to the trusted zone.

If the interface is used in a NetworkManager managed connection or if there is an ifcfg file for this interface, the zone will be changed to the zone defined in the configuration as soon as it gets activated. To change the zone of a connection use
**nm-connection-editor**
and set the zone to trusted, for an ifcfg file, use an editor and add "ZONE=trusted". If the zone is not defined in the ifcfg file, the firewalld default zone will be used.

**-m** _interface_, **--masq**=_interface_
This option will result in a warning message.

Masquerading will be enabled in the default zone. The interface argument will be ignored. This is for
_IPv4_
only.

**--custom-rules**=[_type_:][_table_:]_filename_
This option will result in a warning message and will be ignored.

Custom rule files are not supported by firewalld.

**--forward-port**=if=_interface_:port=_port_:proto=_protocol_[:toport=_destination port_:][:toaddr=_destination address_]
This option will result in a warning message.

Add the
_IPv4_
forward port in the default zone. This option can be specified multiple times.

The port can either be a single port number
_portid_
or a port range
_portid_-_portid_. The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_. The destination address is an IP address.

**--block-icmp**=_icmptype_
This option will result in a warning message.

Add an ICMP block for
_icmptype_
in the default zone. This option can be specified multiple times.

The
_icmptype_
is the one of the icmp types firewalld supports. To get a listing of supported icmp types:
**firewall-cmd --get-icmptypes**

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

<a name="zone-options"></a>

### Zone Options


**--get-default-zone**
Print default zone for connections and interfaces.

**--set-default-zone**=_zone_
Set default zone for connections and interfaces where no zone has been selected. Setting the default zone changes the zone for the connections or interfaces, that are using the default zone.

**--get-zones**
Print predefined zones as a space separated list.

**--get-services**
Print predefined services as a space separated list.

**--get-icmptypes**
Print predefined icmptypes as a space separated list.

**--get-zone-of-interface**=_interface_
Print the name of the zone the
_interface_
is bound to or
_no zone_.

**--get-zone-of-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Print the name of the zone the source is bound to or
_no zone_.

**--info-zone=****zone**
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


**--list-all-zones**
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
      source-ports: source-port1 ..
      icmp-blocks: icmp-type1 ..
      rich rules:
            rich-rule1
            ..
    ..
                  
.if n \{.RE
.\}


**--new-zone**=_zone_
Add a new permanent zone.

Zone names must be alphanumeric and may additionally include characters: _\*(Aq and \*(Aq-\*(Aq.

**--new-zone-from-file**=_filename_ [**--name**=_zone_]
Add a new permanent zone from a prepared zone file with an optional name override.

**--path-zone=****zone**
Print path of the zone configuration file.

**--delete-zone**=_zone_
Delete an existing permanent zone.

**--zone**=_zone_ **--set-description**=_description_
Set new description to zone

**--zone**=_zone_ **--get-description**
Print description for zone

**--zone**=_zone_ **--set-short**=_description_
Set short description to zone

**--zone**=_zone_ **--get-short**
Print short description for zone

**--zone**=_zone_ **--get-target**
Get the target of a permanent zone.

**--zone**=_zone_ **--set-target**=_zone_
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

[**--zone**=_zone_] **--list-all**
List everything added for or enabled in
_zone_. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--list-services**
List services added for
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--add-service**=_service_
Add a service for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

The service is one of the firewalld provided services. To get a list of the supported services, use
**firewall-cmd --get-services**.

[**--zone**=_zone_] **--remove-service-from-zone**=_service_
Remove a service from
_zone_. This option can be specified multiple times. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--query-service**=_service_
Return whether
_service_
has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--zone**=_zone_] **--list-ports**
List ports added for
_zone_
as a space separated list. A port is of the form
_portid_[-_portid_]/_protocol_, it can be either a port and protocol pair or a port range with a protocol. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--add-port**=_portid_[-_portid_]/_protocol_
Add the port for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

The port can either be a single port number or a port range
_portid_-_portid_. The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

[**--zone**=_zone_] **--remove-port**=_portid_[-_portid_]/_protocol_
Remove the port from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

[**--zone**=_zone_] **--query-port**=_portid_[-_portid_]/_protocol_
Return whether the port has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--zone**=_zone_] **--list-protocols**
List protocols added for
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--add-protocol**=_protocol_
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

[**--zone**=_zone_] **--remove-protocol**=_protocol_
Remove the protocol from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

[**--zone**=_zone_] **--query-protocol**=_protocol_
Return whether the protocol has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--zone**=_zone_] **--list-icmp-blocks**
List Internet Control Message Protocol (ICMP) type blocks added for
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--add-icmp-block**=_icmptype_
Add an ICMP block for
_icmptype_
for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

The
_icmptype_
is the one of the icmp types firewalld supports. To get a listing of supported icmp types:
**firewall-cmd --get-icmptypes**

[**--zone**=_zone_] **--remove-icmp-block**=_icmptype_
Remove the ICMP block for
_icmptype_
from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

[**--zone**=_zone_] **--query-icmp-block**=_icmptype_
Return whether an ICMP block for
_icmptype_
has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--zone**=_zone_] **--list-forward-ports**
List
_IPv4_
forward ports added for
_zone_
as a space separated list. If zone is omitted, default zone will be used.

For
_IPv6_
forward ports, please use the rich language.

[**--zone**=_zone_] **--add-forward-port**=port=_portid_[-_portid_]:proto=_protocol_[:toport=_portid_[-_portid_]][:toaddr=_address_[/_mask_]]
Add the
_IPv4_
forward port for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

The port can either be a single port number
_portid_
or a port range
_portid_-_portid_. The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_. The destination address is a simple IP address.

For
_IPv6_
forward ports, please use the rich language.

_Note:_
IP forwarding will be implicitly enabled if
**toaddr**
is specified.

[**--zone**=_zone_] **--remove-forward-port**=port=_portid_[-_portid_]:proto=_protocol_[:toport=_portid_[-_portid_]][:toaddr=_address_[/_mask_]]
Remove the
_IPv4_
forward port from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

For
_IPv6_
forward ports, please use the rich language.

[**--zone**=_zone_] **--query-forward-port**=port=_portid_[-_portid_]:proto=_protocol_[:toport=_portid_[-_portid_]][:toaddr=_address_[/_mask_]]
Return whether the
_IPv4_
forward port has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

For
_IPv6_
forward ports, please use the rich language.

[**--zone**=_zone_] **--list-source-ports**
List source ports added for
_zone_
as a space separated list. A port is of the form
_portid_[-_portid_]/_protocol_. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--add-source-port**=_portid_[-_portid_]/_protocol_
Add the source port for
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times. If a timeout is supplied, the rule will be active for the specified amount of time and will be removed automatically afterwards.

The port can either be a single port number or a port range
_portid_-_portid_. The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

[**--zone**=_zone_] **--remove-source-port**=_portid_[-_portid_]/_protocol_
Remove the source port from
_zone_. If zone is omitted, default zone will be used. This option can be specified multiple times.

[**--zone**=_zone_] **--query-source-port**=_portid_[-_portid_]/_protocol_
Return whether the source port has been added for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

[**--zone**=_zone_] **--add-masquerade**
Enable
_IPv4_
masquerade for
_zone_. If zone is omitted, default zone will be used. Masquerading is useful if the machine is a router and machines connected over an interface in another zone should be able to use the first connection.

For
_IPv6_
masquerading, please use the rich language.

_Note:_
IP forwarding will be implicitly enabled.

[**--zone**=_zone_] **--remove-masquerade**
Disable
_IPv4_
masquerade for
_zone_. If zone is omitted, default zone will be used.

For
_IPv6_
masquerading, please use the rich language.

[**--zone**=_zone_] **--query-masquerade**
Return whether
_IPv4_
masquerading has been enabled for
_zone_. If zone is omitted, default zone will be used. Returns 0 if true, 1 otherwise.

For
_IPv6_
masquerading, please use the rich language.

[**--zone**=_zone_] **--list-rich-rules**
List rich language rules added for
_zone_
as a newline separated list. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--add-rich-rule**=_rule_\*(Aq
Add rich language rule _rule_\*(Aq for
_zone_. This option can be specified multiple times. If zone is omitted, default zone will be used.

For the rich language rule syntax, please have a look at
**firewalld.richlanguage**(5).

[**--zone**=_zone_] **--remove-rich-rule**=_rule_\*(Aq
Remove rich language rule _rule_\*(Aq from
_zone_. This option can be specified multiple times. If zone is omitted, default zone will be used.

For the rich language rule syntax, please have a look at
**firewalld.richlanguage**(5).

[**--zone**=_zone_] **--query-rich-rule**=_rule_\*(Aq
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

[**--zone**=_zone_] **--list-interfaces**
List interfaces that are bound to zone
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--add-interface**=_interface_
Bind interface
_interface_
to zone
_zone_. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--change-interface**=_interface_
Change zone the interface
_interface_
is bound to to zone
_zone_. If zone is omitted, default zone will be used. If old and new zone are the same, the call will be ignored without an error. If the interface has not been bound to a zone before, it will behave like
**--add-interface**.

[**--zone**=_zone_] **--query-interface**=_interface_
Query whether interface
_interface_
is bound to zone
_zone_. Returns 0 if true, 1 otherwise.

[**--zone**=_zone_] **--remove-interface**=_interface_
Remove binding of interface
_interface_
from zone
_zone_. If zone is omitted, default zone will be used.

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
**firewall-cmd --get-zones**.

[**--zone**=_zone_] **--list-sources**
List sources that are bound to zone
_zone_
as a space separated list. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--add-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Bind the source to zone
_zone_. If zone is omitted, default zone will be used.

[**--zone**=_zone_] **--change-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Change zone the source is bound to to zone
_zone_. If zone is omitted, default zone will be used. If old and new zone are the same, the call will be ignored without an error. If the source has not been bound to a zone before, it will behave like
**--add-source**.

[**--zone**=_zone_] **--query-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Query whether the source is bound to the zone
_zone_. Returns 0 if true, 1 otherwise.

[**--zone**=_zone_] **--remove-source**=_source_[/_mask_]|_MAC_|ipset:_ipset_
Remove binding of the source from zone
_zone_. If zone is omitted, default zone will be used.

<a name="ipset-options"></a>

### IPSet Options


**--new-ipset**=_ipset_ **--type**=_ipset type_ [**--option**=_ipset option_[=_value_]]
Add a new permanent ipset with specifying the type and optional options.

ipset names must be alphanumeric and may additionally include characters: _\*(Aq and \*(Aq-\*(Aq.

**--new-ipset-from-file**=_filename_ [**--name**=_ipset_]
Add a new permanent ipset from a prepared ipset file with an optional name override.

**--delete-ipset**=_ipset_
Delete an existing permanent ipset.

**--info-ipset=****ipset**
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


**--get-ipsets**
Print predefined ipsets as a space separated list.

**--ipset**=_ipset_ **--add-entry**=_entry_
Add a new entry to the ipset.

**--ipset**=_ipset_ **--remove-entry**=_entry_
Remove an entry from the ipset.

**--ipset**=_ipset_ **--query-entry**=_entry_
Return whether the entry has been added to an ipset. Returns 0 if true, 1 otherwise.

**--ipset**=_ipset_ **--get-entries**
List all entries of the ipset.

**--ipset**=_ipset_ **--add-entries-from-file**=_filename_
Add a new entries to the ipset from the file. For all entries that are listed in the file but already in the ipset, a warning will be printed.

The file should contain an entry per line. Lines starting with an hash or semicolon are ignored. Also empty lines.

**--ipset**=_ipset_ **--remove-entries-from-file**=_filename_
Remove existing entries from the ipset from the file. For all entries that are listed in the file but not in the ipset, a warning will be printed.

The file should contain an entry per line. Lines starting with an hash or semicolon are ignored. Also empty lines.

**--ipset**=_ipset_ **--set-description**=_description_
Set new description to ipset

**--ipset**=_ipset_ **--get-description**
Print description for ipset

**--ipset**=_ipset_ **--set-short**=_description_
Set new short description to ipset

**--ipset**=_ipset_ **--get-short**
Print short description for ipset

**--path-ipset=****ipset**
Print path of the ipset configuration file.

<a name="service-options"></a>

### Service Options


**--info-service=****service**
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


**--new-service**=_service_
Add a new permanent service.

Service names must be alphanumeric and may additionally include characters: _\*(Aq and \*(Aq-\*(Aq.

**--new-service-from-file**=_filename_ [**--name**=_service_]
Add a new permanent service from a prepared service file with an optional name override.

**--delete-service**=_service_
Delete an existing permanent service.

**--path-service=****service**
Print path of the service configuration file.

**--service**=_service_ **--set-description**=_description_
Set new description to service

**--service**=_service_ **--get-description**
Print description for service

**--service**=_service_ **--set-short**=_description_
Set short description to service

**--service**=_service_ **--get-short**
Print short description for service

**--service**=_service_ **--add-port**=_portid_[-_portid_]/_protocol_
Add a new port to the permanent service.

**--service**=_service_ **--remove-port**=_portid_[-_portid_]/_protocol_
Remove a port from the permanent service.

**--service**=_service_ **--query-port**=_portid_[-_portid_]/_protocol_
Return wether the port has been added to the permanent service.

**--service**=_service_ **--get-ports**
List ports added to the permanent service.

**--service**=_service_ **--add-protocol**=_protocol_
Add a new protocol to the permanent service.

**--service**=_service_ **--remove-protocol**=_protocol_
Remove a protocol from the permanent service.

**--service**=_service_ **--query-protocol**=_protocol_
Return wether the protocol has been added to the permanent service.

**--service**=_service_ **--get-protocols**
List protocols added to the permanent service.

**--service**=_service_ **--add-source-port**=_portid_[-_portid_]/_protocol_
Add a new source port to the permanent service.

**--service**=_service_ **--remove-source-port**=_portid_[-_portid_]/_protocol_
Remove a source port from the permanent service.

**--service**=_service_ **--query-source-port**=_portid_[-_portid_]/_protocol_
Return wether the source port has been added to the permanent service.

**--service**=_service_ **--get-source-ports**
List source ports added to the permanent service.

**--service**=_service_ **--add-helper**=_helper_
Add a new helper to the permanent service.

**--service**=_service_ **--remove-helper**=_helper_
Remove a helper from the permanent service.

**--service**=_service_ **--query-helper**=_helper_
Return wether the helper has been added to the permanent service.

**--service**=_service_ **--get-service-helpers**
List helpers added to the permanent service.

**--service**=_service_ **--set-destination**=_ipv_:_address_[/_mask_]
Set destination for ipv to address[/mask] in the permanent service.

**--service**=_service_ **--remove-destination**=_ipv_
Remove the destination for ipv from the permanent service.

**--service**=_service_ **--query-destination**=_ipv_:_address_[/_mask_]
Return wether the destination ipv to address[/mask] has been set in the permanent service.

**--service**=_service_ **--get-destinations**
List destinations added to the permanent service.

**--service**=_service_ **--add-include**=_service_
Add a new include to the permanent service.

**--service**=_service_ **--remove-include**=_service_
Remove a include from the permanent service.

**--service**=_service_ **--query-include**=_service_
Return wether the include has been added to the permanent service.

**--service**=_service_ **--get-includes**
List includes added to the permanent service.

<a name="helper-options"></a>

### Helper Options


Options in this section affect only one particular helper.

**--info-helper=****helper**
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

**--new-helper**=_helper_ **--module**=_nf\_conntrack\_module_ [**--family**=_ipv4_|_ipv6_]
Add a new permanent helper with module and optionally family defined.

Helper names must be alphanumeric and may additionally include characters: -\*(Aq.

**--new-helper-from-file**=_filename_ [**--name**=_helper_]
Add a new permanent helper from a prepared helper file with an optional name override.

**--delete-helper**=_helper_
Delete an existing permanent helper.

**--load-helper-defaults**=_helper_
Load helper default settings or report NO_DEFAULTS error.

**--path-helper=****helper**
Print path of the helper configuration file.

**--get-helpers**
Print predefined helpers as a space separated list.

**--helper**=_helper_ **--set-description**=_description_
Set new description to helper

**--helper**=_helper_ **--get-description**
Print description for helper

**--helper**=_helper_ **--set-short**=_description_
Set short description to helper

**--helper**=_helper_ **--get-short**
Print short description for helper

**--helper**=_helper_ **--add-port**=_portid_[-_portid_]/_protocol_
Add a new port to the permanent helper.

**--helper**=_helper_ **--remove-port**=_portid_[-_portid_]/_protocol_
Remove a port from the permanent helper.

**--helper**=_helper_ **--query-port**=_portid_[-_portid_]/_protocol_
Return wether the port has been added to the permanent helper.

**--helper**=_helper_ **--get-ports**
List ports added to the permanent helper.

**--helper**=_helper_ **--set-module**=_description_
Set module description for helper

**--helper**=_helper_ **--get-module**
Print module description for helper

**--helper**=_helper_ **--set-family**=_description_
Set family description for helper

**--helper**=_helper_ **--get-family**
Print family description of helper

<a name="internet-control-message-protocol-icmp-type-options"></a>

### Internet Control Message Protocol (ICMP) type Options


**--info-icmptype=****icmptype**
Print information about the icmptype
_icmptype_. The output format is:

.if n \{.RS 4
.\}
    icmptype
      destination: ipv1 ..
                  
.if n \{.RE
.\}


**--new-icmptype**=_icmptype_
Add a new permanent icmptype.

ICMP type names must be alphanumeric and may additionally include characters: _\*(Aq and \*(Aq-\*(Aq.

**--new-icmptype-from-file**=_filename_ [**--name**=_icmptype_]
Add a new permanent icmptype from a prepared icmptype file with an optional name override.

**--delete-icmptype**=_icmptype_
Delete an existing permanent icmptype.

**--icmptype**=_icmptype_ **--set-description**=_description_
Set new description to icmptype

**--icmptype**=_icmptype_ **--get-description**
Print description for icmptype

**--icmptype**=_icmptype_ **--set-short**=_description_
Set short description to icmptype

**--icmptype**=_icmptype_ **--get-short**
Print short description for icmptype

**--icmptype**=_icmptype_ **--add-destination**=_ipv_
Enable destination for ipv in permanent icmptype. ipv is one of
_ipv4_
or
_ipv6_.

**--icmptype**=_icmptype_ **--remove-destination**=_ipv_
Disable destination for ipv in permanent icmptype. ipv is one of
_ipv4_
or
_ipv6_.

**--icmptype**=_icmptype_ **--query-destination**=_ipv_
Return whether destination for ipv is enabled in permanent icmptype. ipv is one of
_ipv4_
or
_ipv6_.

**--icmptype**=_icmptype_ **--get-destinations**
List destinations in permanent icmptype.

**--path-icmptype=****icmptype**
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

**--direct** **--get-all-chains**
Get all chains added to all tables.

This option concerns only chains previously added with
**--direct --add-chain**.

**--direct** **--get-chains** { _ipv4_ | _ipv6_ | _eb_ } _table_
Get all chains added to table
_table_
as a space separated list.

This option concerns only chains previously added with
**--direct --add-chain**.

**--direct** **--add-chain** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Add a new chain with name
_chain_
to table
_table_.

There already exist basic chains to use with direct options, for example
_INPUT\_direct_
chain (see
_iptables-save | grep direct_
output for all of them). These chains are jumped into before chains for zones, i.e. every rule put into
_INPUT\_direct_
will be checked before rules in zones.

**--direct** **--remove-chain** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Remove the chain with name
_chain_
from table
_table_.

**--direct** **--query-chain** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Return whether a chain with name
_chain_
exists in table
_table_. Returns 0 if true, 1 otherwise.

This option concerns only chains previously added with
**--direct --add-chain**.

**--direct** **--get-all-rules**
Get all rules added to all chains in all tables as a newline separated list of the priority and arguments.

**--direct** **--get-rules** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Get all rules added to chain
_chain_
in table
_table_
as a newline separated list of the priority and arguments.

**--direct** **--add-rule** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_ _priority_ _args_
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

**--direct** **--remove-rule** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_ _priority_ _args_
Remove a rule with
_priority_
and the arguments
_args_
from chain
_chain_
in table
_table_.

**--direct** **--remove-rules** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_
Remove all rules in the chain with name
_chain_
exists in table
_table_.

This option concerns only rules previously added with
**--direct --add-rule**
in this chain.

**--direct** **--query-rule** { _ipv4_ | _ipv6_ | _eb_ } _table_ _chain_ _priority_ _args_
Return whether a rule with
_priority_
and the arguments
_args_
exists in chain
_chain_
in table
_table_. Returns 0 if true, 1 otherwise.

**--direct** **--get-all-passthroughs**
Get all permanent passthrough as a newline separated list of the ipv value and arguments.

**--direct** **--get-passthroughs** { _ipv4_ | _ipv6_ | _eb_ }
Get all permanent passthrough rules for the ipv value as a newline separated list of the priority and arguments.

**--direct** **--add-passthrough** { _ipv4_ | _ipv6_ | _eb_ } _args_
Add a permanent passthrough rule with the arguments
_args_
for the ipv value.

**--direct** **--remove-passthrough** { _ipv4_ | _ipv6_ | _eb_ } _args_
Remove a permanent passthrough rule with the arguments
_args_
for the ipv value.

**--direct** **--query-passthrough** { _ipv4_ | _ipv6_ | _eb_ } _args_
Return whether a permanent passthrough rule with the arguments
_args_
exists for the ipv value. Returns 0 if true, 1 otherwise.

<a name="lockdown-options"></a>

### Lockdown Options


Local applications or services are able to change the firewall configuration if they are running as root (example: libvirt) or are authenticated using PolicyKit. With this feature administrators can lock the firewall configuration so that only applications on lockdown whitelist are able to request firewall changes.

The lockdown access check limits D-Bus methods that are changing firewall rules. Query, list and get methods are not limited.

The lockdown feature is a very light version of user and application policies for firewalld and is turned off by default.

**--lockdown-on**
Enable lockdown. Be careful - if firewall-cmd is not on lockdown whitelist when you enable lockdown you wont be able to disable it again with firewall-cmd, you would need to edit firewalld.conf.

**--lockdown-off**
Disable lockdown.

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

Commands for user root and others is not always the same. Example: As root
**/bin/firewall-cmd**
is used, as a normal user
**/usr/bin/firewall-cmd**
is be used on Fedora.

The context is the security (SELinux) context of a running application or service. To get the context of a running application use
**ps -e --context**.

**Warning:**
If the context is unconfined, then this will open access for more than the desired application.

The lockdown whitelist entries are checked in the following order:
1. _context_
2. _uid_
3. _user_
4. _command_

**--list-lockdown-whitelist-commands**
List all command lines that are on the whitelist.

**--add-lockdown-whitelist-command**=_command_
Add the
_command_
to the whitelist.

**--remove-lockdown-whitelist-command**=_command_
Remove the
_command_
from the whitelist.

**--query-lockdown-whitelist-command**=_command_
Query whether the
_command_
is on the whitelist. Returns 0 if true, 1 otherwise.

**--list-lockdown-whitelist-contexts**
List all contexts that are on the whitelist.

**--add-lockdown-whitelist-context**=_context_
Add the context
_context_
to the whitelist.

**--remove-lockdown-whitelist-context**=_context_
Remove the
_context_
from the whitelist.

**--query-lockdown-whitelist-context**=_context_
Query whether the
_context_
is on the whitelist. Returns 0 if true, 1 otherwise.

**--list-lockdown-whitelist-uids**
List all user ids that are on the whitelist.

**--add-lockdown-whitelist-uid**=_uid_
Add the user id
_uid_
to the whitelist.

**--remove-lockdown-whitelist-uid**=_uid_
Remove the user id
_uid_
from the whitelist.

**--query-lockdown-whitelist-uid**=_uid_
Query whether the user id
_uid_
is on the whitelist. Returns 0 if true, 1 otherwise.

**--list-lockdown-whitelist-users**
List all user names that are on the whitelist.

**--add-lockdown-whitelist-user**=_user_
Add the user name
_user_
to the whitelist.

**--remove-lockdown-whitelist-user**=_user_
Remove the user name
_user_
from the whitelist.

**--query-lockdown-whitelist-user**=_user_
Query whether the user name
_user_
is on the whitelist. Returns 0 if true, 1 otherwise.

<a name="policy-options"></a>

### Policy Options


**--policy-server**
Change Polkit actions to server\*(Aq (more restricted)

**--policy-desktop**
Change Polkit actions to desktop\*(Aq (less restricted)

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
