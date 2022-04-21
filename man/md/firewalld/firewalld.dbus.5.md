# firewalld\&.dbus(5)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.dbus - firewalld D-Bus interface description

<a name="object-paths"></a>

# Object Paths


This is the basic firewalld object path structure. The used interfaces are explained below in
the section called “INTERFACES”.

.if n \{.RS 4
.\}
    /org/fedoraproject/FirewallD1
      Interfaces
        org.fedoraproject.FirewallD1
        org.fedoraproject.FirewallD1.direct
        org.fedoraproject.FirewallD1.ipset
        org.fedoraproject.FirewallD1.policies
        org.fedoraproject.FirewallD1.zone
        org.freedesktop.DBus.Introspectable
        org.freedesktop.DBus.Properties
    
    /org/fedoraproject/FirewallD1/config
      Interfaces
        org.fedoraproject.FirewallD1.config
        org.fedoraproject.FirewallD1.config.direct
        org.fedoraproject.FirewallD1.config.policies
        org.freedesktop.DBus.Introspectable
        org.freedesktop.DBus.Properties
    
    /org/fedoraproject/FirewallD1/config/zone/i
      Interfaces
        org.fedoraproject.FirewallD1.config.zone
        org.freedesktop.DBus.Introspectable
        org.freedesktop.DBus.Properties
    
    /org/fedoraproject/FirewallD1/config/service/i
      Interfaces:
        org.fedoraproject.FirewallD1.config.service
        org.freedesktop.DBus.Introspectable
        org.freedesktop.DBus.Properties
    
    /org/fedoraproject/FirewallD1/config/ipset/i
      Interfaces
        org.fedoraproject.FirewallD1.config.ipset
        org.freedesktop.DBus.Introspectable
        org.freedesktop.DBus.Properties
    
    /org/fedoraproject/FirewallD1/config/icmptype/i
      Interfaces
        org.fedoraproject.FirewallD1.config.icmptype
        org.freedesktop.DBus.Introspectable
        org.freedesktop.DBus.Properties
          
.if n \{.RE
.\}


<a name="interfaces"></a>

# Interfaces



<a name="orgfedoraprojectfirewalld1"></a>

### org\&.fedoraproject\&.FirewallD1


This interface contains general runtime operations, like: reloading, panic mode, default zone handling, getting services and icmp types and their settings.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

authorizeAll() → Nothing
Initiate authorization for the complete firewalld D-Bus interface. This method it mostly useful for configuration applications.

completeReload() → Nothing
Reload firewall completely, even netfilter kernel modules. This will most likely terminate active connections, because state information is lost. This option should only be used in case of severe firewall problems. For example if there are state information problems that no connection can be established with correct firewall rules.

disablePanicMode() → Nothing
Disable panic mode. After disabling panic mode established connections might work again, if panic mode was enabled for a short period of time.

Possible errors: NOT_ENABLED, COMMAND_FAILED

enablePanicMode() → Nothing
Enable panic mode. All incoming and outgoing packets are dropped, active connections will expire. Enable this only if there are serious problems with your network environment.

Possible errors: ALREADY_ENABLED, COMMAND_FAILED

getAutomaticHelpers() → s
Deprecated. This always returns "no".

getDefaultZone() → s
Return default zone.

getHelperSettings(s: _helper_) → (sssssa(ss))
Return runtime settings of given
_helper_. For getting permanent settings see
org.fedoraproject.FirewallD1.config.helper.Methods.getSettings. Settings are in format:
_version_,
_name_,
_description_,
_family_,
_module_
and array of
_ports_.

_version (s)_: see _version_ attribute of _helper_ tag in **firewalld.helper**(5).

_name (s)_: see _short_ tag in **firewalld.helper**(5).

_description (s)_: see _description_ tag in **firewalld.helper**(5).

_family (s)_: see _family_ tag in **firewalld.helper**(5).

_module (s)_: see _module_ tag in **firewalld.helper**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.helper**(5).

Possible errors: INVALID_HELPER

getHelpers() → as
Return array of helper names (s) in runtime configuration. For permanent configuration see
org.fedoraproject.FirewallD1.config.Methods.listHelpers.

getIcmpTypeSettings(s: _icmptype_) → (sssas)
Return runtime settings of given
_icmptype_. For getting permanent settings see
org.fedoraproject.FirewallD1.config.icmptype.Methods.getSettings. Settings are in format:
_version_,
_name_,
_description_, array of
_destinations_.

_version (s)_: see _version_ attribute of _icmptype_ tag in **firewalld.icmptype**(5).

_name (s)_: see _short_ tag in **firewalld.icmptype**(5).

_description (s)_: see _description_ tag in **firewalld.icmptype**(5).

_destinations (as)_: array, either empty or containing strings ipv4\*(Aq or \*(Aqipv6\*(Aq, see _destination_ tag in **firewalld.icmptype**(5).

Possible errors: INVALID_ICMPTYPE

getLogDenied() → s
Retruns the LogDenied value. If LogDenied is enabled, then logging rules are added right before reject and drop rules in the INPUT, FORWARD and OUTPUT chains for the default rules and also final reject and drop rules in zones. Possible values are:
_all_,
_unicast_,
_broadcast_,
_multicast_
and
_off_. The default value is
_off_

getServiceSettings(s: _service_) → (sssa(ss)asa{ss}asa(ss))
This function is deprecated, use
org.fedoraproject.FirewallD1.Methods.getServiceSettings2
instead.

getServiceSettings2(s: _service_) → s{sv}
Return runtime settings of given
_service_. For getting permanent settings see
org.fedoraproject.FirewallD1.config.service.Methods.getSettings2. Settings are a dictionary indexed by keywords. For the type of each value see below. If the value is empty it may be ommitted.

_version (s)_: see _version_ attribute of _service_ tag in **firewalld.service**(5).

_name (s)_: see _short_ tag in **firewalld.service**(5).

_description (s)_: see _description_ tag in **firewalld.service**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.service**(5).

_module names (as)_: array of kernel netfilter helpers, see _module_ tag in **firewalld.service**(5).

_destinations (a{ss})_: dictionary of {IP family : IP address} where IP family\*(Aq key can be either \*(Aqipv4\*(Aq or \*(Aqipv6\*(Aq. See _destination_ tag in **firewalld.service**(5).

_protocols (as)_: array of protocols, see _protocol_ tag in **firewalld.service**(5).

_source_ports (a(ss))_: array of port and protocol pairs. See _source-port_ tag in **firewalld.service**(5).

_includes (as)_: array of service includes, see _include_ tag in **firewalld.service**(5).

_helpers (as)_: array of service helpers, see _helper_ tag in **firewalld.service**(5).

Possible errors: INVALID_SERVICE

getZoneSettings(s: _zone_) → (sssbsasa(ss)asba(ssss)asasasasa(ss)b)
Return runtime settings of given
_zone_. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getSettings. Settings are in format:
_version_,
_name_,
_description_,
_UNUSED_,
_target_, array of
_services_, array of
_ports_
(port, protocol), array of
_icmp-blocks_,
_masquerade_, array of
_forward-ports_
(port, protocol, to-port, to-addr), array of
_interfaces_, array of
_sources_, array of
_rich rules_, array of
_protocols_
and array of
_source-ports_
(port, protocol).

_version (s)_: see _version_ attribute of _zone_ tag in **firewalld.zone**(5).

_name (s)_: see _short_ tag in **firewalld.zone**(5).

_description (s)_: see _description_ tag in **firewalld.zone**(5).

_UNUSED (b)_: this boolean value is no longer used for anything.

_target (s)_: see _target_ attribute of _zone_ tag in **firewalld.zone**(5).

_services (as)_: array of service names, see _service_ tag in **firewalld.zone**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.zone**(5).

_icmp-blocks (as)_: array of icmp-blocks. See _icmp-block_ tag in **firewalld.zone**(5).

_masquerade (b)_: see _masquerade_ tag in **firewalld.zone**(5).

_forward-ports (a(ssss))_: array of (port, protocol, to-port, to-addr). See _forward-port_ tag in **firewalld.zone**(5).

_interfaces (as)_: array of interfaces. See _interface_ tag in **firewalld.zone**(5).

_source addresses (as)_: array of source addresses. See _source_ tag in **firewalld.zone**(5).

_rich rules (as)_: array of rich-language rules. See _rule_ tag in **firewalld.zone**(5).

_protocols (as)_: array of protocols, see _protocol_ tag in **firewalld.zone**(5).

_source-ports (a(ss))_: array of port and protocol pairs. See _source-port_ tag in **firewalld.zone**(5).

Possible errors: INVALID_ZONE

listIcmpTypes() → as
Return array of names (s) of icmp types in runtime configuration. For permanent configuration see
org.fedoraproject.FirewallD1.config.Methods.listIcmpTypes.

listServices() → as
Return array of service names (s) in runtime configuration. For permanent configuration see
org.fedoraproject.FirewallD1.config.Methods.listServices.

queryPanicMode() → b
Return true if panic mode is enabled, false otherwise. In panic mode all incoming and outgoing packets are dropped.

reload() → Nothing
Reload firewall rules and keep state information. Current permanent configuration will become new runtime configuration, i.e. all runtime only changes done until reload are lost with reload if they have not been also in permanent configuration.

runtimeToPermanent() → Nothing
Make runtime settings permanent. Replaces permanent settings with runtime settings for zones, services, icmptypes, direct and policies (lockdown whitelist).

Possible errors: RT_TO_PERM_FAILED

checkPermanentConfig() → Nothing
Run checks on the permanent configuration. This is most useful if changes were made manually to configuration files.

Possible errors: any

setDefaultZone(s: _zone_) → Nothing
Set default zone for connections and interfaces where no zone has been selected to
_zone_. Setting the default zone changes the zone for the connections or interfaces, that are using the default zone. This is a runtime and permanent change.

Possible errors: ZONE_ALREADY_SET, COMMAND_FAILED

setLogDenied(s: _value_) → Nothing
Set LogDenied value to
_value_. If LogDenied is enabled, then logging rules are added right before reject and drop rules in the INPUT, FORWARD and OUTPUT chains for the default rules and also final reject and drop rules in zones. Possible values are:
_all_,
_unicast_,
_broadcast_,
_multicast_
and
_off_. The default value is
_off_
This is a runtime and permanent change.

Possible errors: ALREADY_SET, INVALID_VALUE

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

DefaultZoneChanged(s: _zone_)
Emitted when default zone has been changed to
_zone_.

LogDeniedChanged(s: _value_)
Emitted when LogDenied value has been changed.

PanicModeDisabled()
Emitted when panic mode has been deactivated.

PanicModeEnabled()
Emitted when panic mode has been activated.

Reloaded()
Emitted when firewalld has been reloaded. Also emitted for a complete reload.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Properties**

_BRIDGE_ - b - (ro)
Indicates whether the firewall has ethernet bridge support.

_IPSet_ - b - (ro)
Indicates whether the firewall has IPSet support.

_IPSetTypes_ - as - (ro)
The supported IPSet types by ipset and firewalld.

_IPv4_ - b - (ro)
Indicates whether the firewall has IPv4 support.

_IPv4ICMPTypes_ - as - (ro)
The list of supported IPv4 ICMP types.

_IPv6_ - b - (ro)
Indicates whether the firewall has IPv6 support.

_IPv6\_rpfilter_ - b - (ro)
Indicates whether the reverse path filter test on a packet for IPv6 is enabled. If a reply to the packet would be sent via the same interface that the packet arrived on, the packet will match and be accepted, otherwise dropped.

_IPv6ICMPTypes_ - as - (ro)
The list of supported IPv6 ICMP types.

_nf\_conntrach\_helper\_setting_ - b - (ro)
Deprecated. Always False.

_nf\_conntrack\_helpers_ - a{sas} - (ro)
Deprecated. Always returns an empty dictionary.

_nf\_nat\_helpers_ - a{sas} - (ro)
Deprecated. Always returns an empty dictionary.

_interface\_version_ - s - (ro)
firewalld D-Bus interface version string.

_state_ - s - (ro)
firewalld state. This can be either
_INIT_,
_FAILED_, or
_RUNNING_. In
_INIT_
state, firewalld is starting up and initializing. In
_FAILED_
state, firewalld completely started but experienced a failure.

_version_ - s - (ro)
firewalld version string.

<a name="orgfedoraprojectfirewalld1ipset"></a>

### org\&.fedoraproject\&.FirewallD1\&.ipset


Operations in this interface allows to get, add, remove and query runtime ipset settings. For permanent configuration see
org.fedoraproject.FirewallD1.config.ipset
interface.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addEntry(s: ipset, s: entry) → as
Add a new
_entry_
to
_ipset_. The entry must match the type of the ipset. If the ipset is using the timeout option, it is not possible to see the entries, as they are timing out automatically in the kernel. For permanent operation see
org.fedoraproject.FirewallD1.config.ipset.Methods.addEntry.

Possible errors: INVALID_IPSET, IPSET_WITH_TIMEOUT

getEntries(s: ipset) → Nothing
Get all entries added to the
_ipset_. If the ipset is using the timeout option, it is not possible to see the entries, as they are timing out automatically in the kernel. Return value is a array of
_entry_. For permanent operation see
org.fedoraproject.FirewallD1.config.ipset.Methods.getEntries.

Possible errors: INVALID_IPSET, IPSET_WITH_TIMEOUT

getSettings(s: ipset) → (ssssa{ss}as)
Return runtime settings of given
_ipset_. For getting permanent settings see
org.fedoraproject.FirewallD1.config.ipset.Methods.getSettings. Settings are in format:
_version_,
_name_,
_description_,
_type_, dictionary of
_options_
and array of
_entries_.

_version (s)_: see _version_ attribute of _ipset_ tag in **firewalld.ipset**(5).

_name (s)_: see _short_ tag in **firewalld.ipset**(5).

_description (s)_: see _description_ tag in **firewalld.ipset**(5).

_type (s)_: see _type_ attribute of _ipset_ tag in **firewalld.ipset**(5).

_options (a{ss})_: dictionary of {option : value} . See _options_ tag in **firewalld.ipset**(5).

_entries (as)_: array of entries, see _entry_ tag in **firewalld.ipset**(5).

Possible errors: INVALID_IPSET

getIPSets() → as
Return array of ipset names (s) in runtime configuration. For permanent configuration see
org.fedoraproject.FirewallD1.config.Methods.listIPSets.

queryService(s: ipset, s: entry) → b
Return whether
_entry_
has been added to
_ipset_. For permanent operation see
org.fedoraproject.FirewallD1.config.ipset.Methods.queryEntry.

Possible errors: INVALID_IPSET

queryService(s: ipset) → b
Return whether
_ipset_
is defined in runtime configuration.

removeEntry(s: ipset, s: entry) → as
Removes an
_entry_
from
_ipset_. For permanent operation see
org.fedoraproject.FirewallD1.config.ipset.Methods.removeEntry.

Possible errors: INVALID_IPSET, IPSET_WITH_TIMEOUT

setEntries(as: entries) → Nothing
Permanently set list of entries to
_entries_. For permanent operation see
org.fedoraproject.FirewallD1.config.ipset.Methods.setEntries. See
_entry_
tag in
**firewalld.ipset**(5).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

EntryAdded(s: ipset, s: entry)
Emitted when
_entry_
has been added to
_ipset_.

EntryRemoved(s: ipset, s: entry)
Emitted when
_entry_
has been removed from
_ipset_.

<a name="orgfedoraprojectfirewalld1direct"></a>

### org\&.fedoraproject\&.FirewallD1\&.direct


This interface enables more direct access to the firewall. It enables runtime manipulation with chains and rules. For permanent configuration see
org.fedoraproject.FirewallD1.config.direct
interface.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addChain(s: ipv, s: table, s: chain) → Nothing
Add a new
_chain_
to
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). Make sure theres no other chain with this name already. There already exist basic chains to use with direct methods, for example
_INPUT\_direct_
chain. These chains are jumped into before chains for zones, i.e. every rule put into
_INPUT\_direct_
will be checked before rules in zones. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.addChain.

Possible errors: INVALID_IPV, INVALID_TABLE, ALREADY_ENABLED, COMMAND_FAILED

addPassthrough(s: ipv, as: args) → Nothing
Add a tracked passthrough rule with the arguments
_args_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). Valid commands in args are only
_-A/--append_,
_-I/--insert_
and
_-N/--new-chain_. This method is (unlike passthrough method) tracked, i.e. firewalld remembers it. Its useful with
org.fedoraproject.FirewallD1.Methods.runtimeToPermanent
For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.addPassthrough.

Possible errors: INVALID_IPV, ALREADY_ENABLED, COMMAND_FAILED

addRule(s: ipv, s: table, s: chain, i: priority, as: args) → Nothing
Add a rule with the arguments
_args_
to
_chain_
in
_table_
with
_priority_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). The priority is used to order rules. Priority 0 means add rule on top of the chain, with a higher priority the rule will be added further down. Rules with the same priority are on the same level and the order of these rules is not fixed and may change. If you want to make sure that a rule will be added after another one, use a low priority for the first and a higher for the following. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.addRule.

Possible errors: INVALID_IPV, INVALID_TABLE, ALREADY_ENABLED, COMMAND_FAILED

getAllChains() → a(sss)
Get all chains added to all tables in format: ipv, table, chain. This concerns only chains previously added with
addChain. Return value is a array of (_ipv_,
_table_,
_chain_). For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.getAllChains.

_ipv (s)_: either _ipv4_ (iptables) or _ipv6_ (ip6tables) or _eb_ (ebtables).

_table (s)_: one of _filter_, _mangle_, _nat_, _raw_, _security_

_chain (s)_: name of a chain.


getAllPassthroughs() → a(sas)
Get all tracked passthrough rules added in all ipv types in format: ipv, rule. This concerns only rules previously added with
addPassthrough. Return value is a array of (_ipv_, array of
_arguments_). For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.getAllPassthroughs.

_ipv (s)_: either _ipv4_ (iptables) or _ipv6_ (ip6tables) or _eb_ (ebtables).

_arguments (as)_: array of commands, parameters and other iptables/ip6tables/ebtables command line options.


getAllRules() → a(sssias)
Get all rules added to all chains in all tables in format: ipv, table, chain, priority, rule. This concerns only rules previously added with
addRule. Return value is a array of (_ipv_,
_table_,
_chain_,
_priority_, array of
_arguments_). For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.getAllRules.

_ipv (s)_: either _ipv4_ (iptables) or _ipv6_ (ip6tables) or _eb_ (ebtables).

_table (s)_: one of _filter_, _mangle_, _nat_, _raw_, _security_

_chain (s)_: name of a chain.

_priority (i)_: used to order rules.

_arguments (as)_: array of commands, parameters and other iptables/ip6tables/ebtables command line options.


getChains(s: ipv, s: table) → as
Return an array of chains (s) added to
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only chains previously added with
addChain. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.getChains.

Possible errors: INVALID_IPV, INVALID_TABLE

getPassthroughs(s: ipv) → aas
Get tracked passthrough rules added in either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addPassthrough. Return value is a array of (array of
_arguments_). For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.getPassthroughs.

_arguments (as)_: array of commands, parameters and other iptables/ip6tables/ebtables command line options.


getRules(s: ipv, s: table, s: chain) → a(ias)
Get all rules added to
_chain_
in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addRule. Return value is a array of (_priority_, array of
_arguments_). For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.getRules.

_priority (i)_: used to order rules.

_arguments (as)_: array of commands, parameters and other iptables/ip6tables/ebtables command line options.

Possible errors: INVALID_IPV, INVALID_TABLE

passthrough(s: ipv, as: args) → s
Pass a command through to the firewall.
_ipv_
can be either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables).
_args_
can be all
**iptables**,
**ip6tables**
and
**ebtables**
command line arguments.
_args_
can be all iptables, ip6tables and ebtables command line arguments. This command is untracked, which means that firewalld is not able to provide information about this command later on.

Possible errors: COMMAND_FAILED

queryChain(s: ipv, s: table, s: chain) → b
Return whether a
_chain_
exists in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only chains previously added with
addChain. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.queryChain.

Possible errors: INVALID_IPV, INVALID_TABLE

queryPassthrough(s: ipv, as: args) → b
Return whether a tracked passthrough rule with the arguments
_args_
exists for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addPassthrough. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.queryPassthrough.

Possible errors: INVALID_IPV

queryRule(s: ipv, s: table, s: chain, i: priority, as: args) → b
Return whether a rule with
_priority_
and the arguments
_args_
exists in
_chain_
in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addRule. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.queryRule.

Possible errors: INVALID_IPV, INVALID_TABLE

removeAllPassthroughs() → Nothing
Remove all passthrough rules previously added with
addPassthrough.

removeChain(s: ipv, s: table, s: chain) → Nothing
Remove a
_chain_
from
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). Only chains previously added with
addChain
can be removed this way. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.removeChain.

Possible errors: INVALID_IPV, INVALID_TABLE, NOT_ENABLED, COMMAND_FAILED

removePassthrough(s: ipv, as: args) → Nothing
Remove a tracked passthrough rule with arguments
_args_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). Only rules previously added with
addPassthrough
can be removed this way. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.removePassthrough.

Possible errors: INVALID_IPV, NOT_ENABLED, COMMAND_FAILED

removeRule(s: ipv, s: table, s: chain, i: priority, as: args) → Nothing
Remove a rule with
_priority_
and arguments
_args_
from
_chain_
in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). Only rules previously added with
addRule
can be removed this way. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.removeRule.

Possible errors: INVALID_IPV, INVALID_TABLE, NOT_ENABLED, COMMAND_FAILED

removeRules(s: ipv, s: table, s: chain) → Nothing
Remove all rules from
_chain_
in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addRule. For permanent operation see
org.fedoraproject.FirewallD1.config.direct.Methods.removeRules.

Possible errors: INVALID_IPV, INVALID_TABLE

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

ChainAdded(s: ipv, s: table, s: chain)
Emitted when
_chain_
has been added into
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables).

ChainRemoved(s: ipv, s: table, s: chain)
Emitted when
_chain_
has been removed from
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables).

PassthroughAdded(s: ipv, as: args)
Emitted when a tracked passthruogh rule with
_args_
has been added for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables).

PassthroughRemoved(s: ipv, as: args)
Emitted when a tracked passthrough rule with
_args_
has been removed for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables).

RuleAdded(s: ipv, s: table, s: chain, i: priority, as: args)
Emitted when a rule with
_args_
has been added to
_chain_
in
_table_
with
_priority_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables).

RuleRemoved(s: ipv, s: table, s: chain, i: priority, as: args)
Emitted when a rule with
_args_
has been removed from
_chain_
in
_table_
with
_priority_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables).

<a name="orgfedoraprojectfirewalld1policies"></a>

### org\&.fedoraproject\&.FirewallD1\&.policies


Enables firewalld to be able to lock down configuration changes from local applications. Local applications or services are able to change the firewall configuration if they are running as root (example: libvirt). With these operations administrator can lock the firewall configuration so that either none or only applications that are in the whitelist are able to request firewall changes. For permanent configuration see
org.fedoraproject.FirewallD1.config.policies
interface.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addLockdownWhitelistCommand(s: command) → Nothing
Add
_command_
to whitelist. See
_command_
option in
**firewalld.lockdown-whitelist**(5). For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.addLockdownWhitelistCommand.

Possible errors: ALREADY_ENABLED, INVALID_COMMAND

addLockdownWhitelistContext(s: context) → Nothing
Add
_context_
to whitelist. See
_selinux_
option in
**firewalld.lockdown-whitelist**(5). For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.addLockdownWhitelistContext.

Possible errors: ALREADY_ENABLED, INVALID_COMMAND

addLockdownWhitelistUid(i: uid) → Nothing
Add user id
_uid_
to whitelist. See
_user_
option in
**firewalld.lockdown-whitelist**(5). For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.addLockdownWhitelistUid.

Possible errors: ALREADY_ENABLED, INVALID_COMMAND

addLockdownWhitelistUser(s: user) → Nothing
Add
_user_
name to whitelist. See
_user_
option in
**firewalld.lockdown-whitelist**(5). For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.addLockdownWhitelistUser.

Possible errors: ALREADY_ENABLED, INVALID_COMMAND

disableLockdown() → Nothing
Disable lockdown. This is a runtime and permanent change.

Possible errors: NOT_ENABLED

enableLockdown() → Nothing
Enable lockdown. Be careful - if the calling application/user is not on lockdown whitelist when you enable lockdown you wont be able to disable it again with the application, you would need to edit firewalld.conf. This is a runtime and permanent change.

Possible errors: ALREADY_ENABLED

getLockdownWhitelistCommands() → as
List all command lines (s) that are on whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.getLockdownWhitelistCommands.

getLockdownWhitelistContexts() → as
List all contexts (s) that are on whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.getLockdownWhitelistContexts.

getLockdownWhitelistUids() → ai
List all user ids (i) that are on whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.getLockdownWhitelistUids.

getLockdownWhitelistUsers() → as
List all users (s) that are on whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.getLockdownWhitelistUsers.

queryLockdown() → b
Query whether lockdown is enabled.

queryLockdownWhitelistCommand(s: command) → b
Query whether
_command_
is on whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.queryLockdownWhitelistCommand.

queryLockdownWhitelistContext(s: context) → b
Query whether
_context_
is on whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.queryLockdownWhitelistContext.

queryLockdownWhitelistUid(i: uid) → b
Query whether user id
_uid_
is on whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.queryLockdownWhitelistUid.

queryLockdownWhitelistUser(s: user) → b
Query whether
_user_
is on whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.queryLockdownWhitelistUser.

removeLockdownWhitelistCommand(s: command) → Nothing
Remove
_command_
from whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.removeLockdownWhitelistCommand.

Possible errors: NOT_ENABLED

removeLockdownWhitelistContext(s: context) → Nothing
Remove
_context_
from whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.removeLockdownWhitelistContext.

Possible errors: NOT_ENABLED

removeLockdownWhitelistUid(i: uid) → Nothing
Remove user id
_uid_
from whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.removeLockdownWhitelistUid.

Possible errors: NOT_ENABLED

removeLockdownWhitelistUser(s: user) → Nothing
Remove
_user_
from whitelist. For permanent operation see
org.fedoraproject.FirewallD1.config.policies.Methods.removeLockdownWhitelistUser.

Possible errors: NOT_ENABLED

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

LockdownDisabled()
Emitted when lockdown has been disabled.

LockdownEnabled()
Emitted when lockdown has been enabled.

LockdownWhitelistCommandAdded(s: command)
Emitted when
_command_
has been added to whitelist.

LockdownWhitelistCommandRemoved(s: command)
Emitted when
_command_
has been removed from whitelist.

LockdownWhitelistContextAdded(s: context)
Emitted when
_context_
has been added to whitelist.

LockdownWhitelistContextRemoved(s: context)
Emitted when
_context_
has been removed from whitelist.

LockdownWhitelistUidAdded(i: uid)
Emitted when user id
_uid_
has been added to whitelist.

LockdownWhitelistUidRemoved(i: uid)
Emitted when user id
_uid_
has been removed from whitelist.

LockdownWhitelistUserAdded(s: user)
Emitted when
_user_
has been added to whitelist.

LockdownWhitelistUserRemoved(s: user)
Emitted when
_user_
has been removed from whitelist.

<a name="orgfedoraprojectfirewalld1zone"></a>

### org\&.fedoraproject\&.FirewallD1\&.zone


Operations in this interface allows to get, add, remove and query runtime zones settings. For permanent settings see
org.fedoraproject.FirewallD1.config.zone
interface.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addForwardPort(s: zone, s: port, s: protocol, s: toport, s: toaddr, i: timeout) → s
Add the IPv4 forward port into
_zone_. If
_zone_
is empty, use default zone. The port can either be a single port number
_portid_
or a port range
_portid_-_portid_. The protocol can either be
_tcp_
or
_udp_. The destination address is a simple IP address. If
_timeout_
is non-zero, the operation will be active only for the amount of seconds. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addForwardPort.

Returns name of zone to which the forward port was added.

Possible errors: INVALID_ZONE, INVALID_PORT, MISSING_PROTOCOL, INVALID_PROTOCOL, INVALID_ADDR, INVALID_FORWARD, ALREADY_ENABLED, INVALID_COMMAND

addIcmpBlock(s: zone, s: icmp, i: timeout) → s
Add an ICMP block
_icmp_
into
_zone_. The
_icmp_
is the one of the icmp types firewalld supports. To get a listing of supported icmp types use
org.fedoraproject.FirewallD1.Methods.listIcmpTypes
If
_zone_
is empty, use default zone. If
_timeout_
is non-zero, the operation will be active only for the amount of seconds. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addIcmpBlock.

Returns name of zone to which the ICMP block was added.

Possible errors: INVALID_ZONE, INVALID_ICMPTYPE, ALREADY_ENABLED, INVALID_COMMAND

addIcmpBlockInversion(s: zone) → s
Add ICMP block inversion to
_zone_. If
_zone_
is empty, use default zone. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addIcmpBlockInversion.

Returns name of zone to which the ICMP block inversion was added.

Possible errors: INVALID_ZONE, ALREADY_ENABLED, INVALID_COMMAND

addInterface(s: zone, s: interface) → s
Bind
_interface_
with
_zone_. From now on all traffic going through the
_interface_
will respect the
_zone_s settings. If
_zone_
is empty, use default zone. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addInterface.

Returns name of zone to which the interface was bound.

Possible errors: INVALID_ZONE, INVALID_INTERFACE, ALREADY_ENABLED, INVALID_COMMAND

addMasquerade(s: zone, i: timeout) → s
Enable masquerade in
_zone_. If
_zone_
is empty, use default zone. If
_timeout_
is non-zero, masquerading will be active for the amount of seconds. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addMasquerade.

Returns name of zone in which the masquerade was enabled.

Possible errors: INVALID_ZONE, ALREADY_ENABLED, INVALID_COMMAND

addPort(s: zone, s: port, s: protocol, i: timeout) → s
Add port into
_zone_. If
_zone_
is empty, use default zone. The port can either be a single port number or a port range
_portid_-_portid_. The protocol can either be
_tcp_
or
_udp_. If
_timeout_
is non-zero, the operation will be active only for the amount of seconds. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addPort.

Returns name of zone to which the port was added.

Possible errors: INVALID_ZONE, INVALID_PORT, MISSING_PROTOCOL, INVALID_PROTOCOL, ALREADY_ENABLED, INVALID_COMMAND

addProtocol(s: zone, s: protocol, i: timeout) → s
Add protocol into
_zone_. If
_zone_
is empty, use default zone. The protocol can be any protocol supported by the system. Please have a look at
_/etc/protocols_
for supported protocols. If
_timeout_
is non-zero, the operation will be active only for the amount of seconds. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addProtocol.

Returns name of zone to which the protocol was added.

Possible errors: INVALID_ZONE, INVALID_PROTOCOL, ALREADY_ENABLED, INVALID_COMMAND

addRichRule(s: zone, s: rule, i: timeout) → s
Add rich language
_rule_
into
_zone_. For the rich language rule syntax, please have a look at
**firewalld.direct**(5). If
_zone_
is empty, use default zone. If
_timeout_
is non-zero, the operation will be active only for the amount of seconds. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addRichRule.

Returns name of zone to which the rich language rule was added.

Possible errors: INVALID_ZONE, INVALID_RULE, ALREADY_ENABLED, INVALID_COMMAND

addService(s: zone, s: service, i: timeout) → s
Add
_service_
into
_zone_. If
_zone_
is empty, use default zone. If
_timeout_
is non-zero, the operation will be active only for the amount of seconds. To get a list of supported services, use
org.fedoraproject.FirewallD1.Methods.listServices. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addService.

Returns name of zone to which the service was added.

Possible errors: INVALID_ZONE, INVALID_SERVICE, ALREADY_ENABLED, INVALID_COMMAND

addSource(s: zone, s: source) → s
Bind
_source_
with
_zone_. From now on all traffic going from this
_source_
will respect the
_zone_s settings. A source address or address range is either an IP address or a network IP address with a mask for IPv4 or IPv6. For IPv4, the mask can be a network mask or a plain number. For IPv6 the mask is a plain number. Use of host names is not supported. If
_zone_
is empty, use default zone. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addSource.

Returns name of zone to which the source was bound.

Possible errors: INVALID_ZONE, INVALID_ADDR, ALREADY_ENABLED, INVALID_COMMAND

addSourcePort(s: zone, s: port, s: protocol, i: timeout) → s
Add source port into
_zone_. If
_zone_
is empty, use default zone. The port can either be a single port number or a port range
_portid_-_portid_. The protocol can either be
_tcp_
or
_udp_. If
_timeout_
is non-zero, the operation will be active only for the amount of seconds. For permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.addSourcePort.

Returns name of zone to which the port was added.

Possible errors: INVALID_ZONE, INVALID_PORT, MISSING_PROTOCOL, INVALID_PROTOCOL, ALREADY_ENABLED, INVALID_COMMAND

changeZone(s: zone, s: interface) → s
This function is deprecated, use
org.fedoraproject.FirewallD1.zone.Methods.changeZoneOfInterface
instead.

changeZoneOfInterface(s: zone, s: interface) → s
Change a zone an
_interface_
is bound to to
_zone_. Its basically removeInterface(_interface_) followed by addInterface(_zone_,
_interface_). If
_interface_
has not been bound to a zone before, it behaves like
addInterface. If
_zone_
is empty, use default zone.

Returns name of zone to which the interface was bound.

Possible errors: INVALID_ZONE, ZONE_ALREADY_SET, ZONE_CONFLICT

changeZoneOfSource(s: zone, s: source) → s
Change a zone an
_source_
is bound to to
_zone_. Its basically removeSource(_source_) followed by addSource(_zone_,
_source_). If
_source_
has not been bound to a zone before, it behaves like
addSource. If
_zone_
is empty, use default zone.

Returns name of zone to which the source was bound.

Possible errors: INVALID_ZONE, ZONE_ALREADY_SET, ZONE_CONFLICT

getActiveZones() → a{sa{sas}}
Return dictionary of currently active zones altogether with interfaces and sources used in these zones. Active zones are zones, that have a binding to an interface or source.

Return value is a dictionary where keys are zone names (s) and values are again dictionaries where keys are either interfaces\*(Aq or \*(Aqsources\*(Aq and values are arrays of interface names (s) or sources (s).

getForwardPorts(s: zone) → aas
Return array of IPv4 forward ports previously added into
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getForwardPorts.

Return value is array of 4-tuples, where each 4-tuple consists of (port, protocol, to-port, to-addr). to-addr might be empty in case of local forwarding.

Possible errors: INVALID_ZONE

getIcmpBlocks(s: zone) → as
Return array of ICMP type (s) blocks previously added into
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getIcmpBlocks.

Possible errors: INVALID_ZONE

getIcmpBlockInversion(s: zone) → b
Return whether ICMP block inversion was previously added to
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getIcmpBlockInversion.

Possible errors: INVALID_ZONE

getInterfaces(s: zone) → as
Return array of interfaces (s) previously bound with
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getInterfaces.

Possible errors: INVALID_ZONE

getPorts(s: zone) → aas
Return array of ports (2-tuple of port and protocol) previously enabled in
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getPorts.

Possible errors: INVALID_ZONE

getProtocols(s: zone) → as
Return array of protocols (s) previously enabled in
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getProtocols.

Possible errors: INVALID_ZONE

getRichRules(s: zone) → as
Return array of rich language rules (s) previously added into
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getRichRules.

Possible errors: INVALID_ZONE

getServices(s: zone) → as
Return array of services (s) previously enabled in
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getServices.

Possible errors: INVALID_ZONE

getSourcePorts(s: zone) → aas
Return array of source ports (2-tuple of port and protocol) previously enabled in
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getSourcePorts.

Possible errors: INVALID_ZONE

getSources(s: zone) → as
Return array of sources (s) previously bound with
_zone_. If
_zone_
is empty, use default zone. For getting permanent settings see
org.fedoraproject.FirewallD1.config.zone.Methods.getSources.

Possible errors: INVALID_ZONE

getZoneOfInterface(s: interface) → s
Return name (s) of zone the
_interface_
is bound to or empty string.

getZoneOfSource(s: source) → s
Return name (s) of zone the
_source_
is bound to or empty string.

getZones() → as
Return array of names (s) of predefined zones known to current runtime environment. For list of zones known to permanent environment see
org.fedoraproject.FirewallD1.config.Methods.listZones. The lists (of zones known to runtime and permanent environment) will contain same zones in most cases, but might differ for example if
org.fedoraproject.FirewallD1.config.Methods.addZone
has been called recently, but firewalld has not been reloaded since then.

isImmutable(s: zone) → b
Deprecated.

queryForwardPort(s: zone, s: port, s: protocol, s: toport, s: toaddr) → b
Return whether the IPv4 forward port (_port_,
_protocol_,
_toport_,
_toaddr_) has been added into
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.queryForwardPort.

Possible errors: INVALID_ZONE, INVALID_PORT, MISSING_PROTOCOL, INVALID_PROTOCOL, INVALID_ADDR, INVALID_FORWARD

queryIcmpBlock(s: zone, s: icmp) → b
Return whether an ICMP block for
_icmp_
has been added into
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.queryIcmpBlock.

Possible errors: INVALID_ZONE, INVALID_ICMPTYPE

queryIcmpBlockInversion(s: zone) → b
Return whether ICMP block inversion has been added to
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.queryIcmpBlockInversion.

Possible errors: INVALID_ZONE, INVALID_ICMPTYPE

queryInterface(s: zone, s: interface) → b
Query whether
_interface_
has been bound to
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.queryInterface.

Possible errors: INVALID_ZONE, INVALID_INTERFACE

queryMasquerade(s: zone) → b
Return whether masquerading has been enabled in
_zone_
If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.queryMasquerade.

Possible errors: INVALID_ZONE

queryPort(s: zone, s: port, s: protocol) → b
Return whether
_port_/_protocol_
has been added in
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.queryPort.

Possible errors: INVALID_ZONE, INVALID_PORT, MISSING_PROTOCOL, INVALID_PROTOCOL

queryProtocol(s: zone, s: protocol) → b
Return whether
_protocol_
has been added in
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.queryProtocol.

Possible errors: INVALID_ZONE, INVALID_PROTOCOL

queryRichRule(s: zone, s: rule) → b
Return whether rich rule
_rule_
has been added in
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.queryRichRule.

Possible errors: INVALID_ZONE, INVALID_RULE

queryService(s: zone, s: service) → b
Return whether
_service_
has been added for
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.queryService.

Possible errors: INVALID_ZONE, INVALID_SERVICE

querySource(s: zone, s: source) → b
Query whether
_source_has been bound to
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.querySource.

Possible errors: INVALID_ZONE, INVALID_ADDR

querySourcePort(s: zone, s: port, s: protocol) → b
Return whether
_port_/_protocol_
has been added in
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.querySourcePort.

Possible errors: INVALID_ZONE, INVALID_PORT, MISSING_PROTOCOL, INVALID_PROTOCOL

removeForwardPort(s: zone, s: port, s: protocol, s: toport, s: toaddr) → s
Remove IPv4 forward port ((_port_,
_protocol_,
_toport_,
_toaddr_)) from
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeForwardPort.

Returns name of zone from which the forward port was removed.

Possible errors: INVALID_ZONE, INVALID_PORT, MISSING_PROTOCOL, INVALID_PROTOCOL, INVALID_ADDR, INVALID_FORWARD, NOT_ENABLED, INVALID_COMMAND

removeIcmpBlock(s: zone, s: icmp) → s
Remove ICMP block
_icmp_
from
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeIcmpBlock.

Returns name of zone from which the ICMP block was removed.

Possible errors: INVALID_ZONE, INVALID_ICMPTYPE, NOT_ENABLED, INVALID_COMMAND

removeIcmpBlockInversion(s: zone) → s
Remove ICMP block inversion from
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeIcmpBlockInversion.

Returns name of zone from which the ICMP block inversion was removed.

Possible errors: INVALID_ZONE, NOT_ENABLED, INVALID_COMMAND

removeInterface(s: zone, s: interface) → s
Remove binding of
_interface_
from
_zone_. If
_zone_
is empty, the interface will be removed from zone it belongs to. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeInterface.

Returns name of zone from which the
_interface_
was removed.

Possible errors: INVALID_ZONE, INVALID_INTERFACE, NOT_ENABLED, INVALID_COMMAND

removeMasquerade(s: zone) → s
Disable masquerade for
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeMasquerade.

Returns name of zone for which the masquerade was disabled.

Possible errors: INVALID_ZONE, NOT_ENABLED, INVALID_COMMAND

removePort(s: zone, s: port, s: protocol) → s
Remove
_port_/_protocol_
from
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removePort.

Returns name of zone from which the port was removed.

Possible errors: INVALID_ZONE, INVALID_PORT, MISSING_PROTOCOL, INVALID_PROTOCOL, NOT_ENABLED, INVALID_COMMAND

removeProtocol(s: zone, s: protocol) → s
Remove protocol from
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeProtocol.

Returns name of zone from which the protocol was removed.

Possible errors: INVALID_ZONE, INVALID_PROTOCOL, NOT_ENABLED, INVALID_COMMAND

removeRichRule(s: zone, s: rule) → s
Remove rich language
_rule_
from
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeRichRule.

Returns name of zone from which the rich language rule was removed.

Possible errors: INVALID_ZONE, INVALID_RULE, NOT_ENABLED, INVALID_COMMAND

removeService(s: zone, s: service) → s
Remove
_service_
from
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeService.

Returns name of zone from which the service was removed.

Possible errors: INVALID_ZONE, INVALID_SERVICE, NOT_ENABLED, INVALID_COMMAND

removeSource(s: zone, s: source) → s
Remove binding of
_source_
from
_zone_. If
_zone_
is empty, the source will be removed from zone it belongs to. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeSource.

Returns name of zone from which the
_source_
was removed.

Possible errors: INVALID_ZONE, INVALID_ADDR, NOT_ENABLED, INVALID_COMMAND

removeSourcePort(s: zone, s: port, s: protocol) → s
Remove
_port_/_protocol_
from
_zone_. If
_zone_
is empty, use default zone. For permanent operation see
org.fedoraproject.FirewallD1.config.zone.Methods.removeSourcePort.

Returns name of zone from which the source port was removed.

Possible errors: INVALID_ZONE, INVALID_PORT, MISSING_PROTOCOL, INVALID_PROTOCOL, NOT_ENABLED, INVALID_COMMAND

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

ForwardPortAdded(s: zone, s: port, s: protocol, s: toport, s: toaddr, i: timeout)
Emitted when forward port has been added to
_zone_
with
_timeout_.

ForwardPortRemoved(s: zone, s: port, s: protocol, s: toport, s: toaddr)
Emitted when forward port has been removed from
_zone_.

IcmpBlockAdded(s: zone, s: icmp, i: timeout)
Emitted when ICMP block for
_icmp_
has been added to
_zone_
with
_timeout_.

IcmpBlockInversionAdded(s: zone)
Emitted when ICMP block inversion has been added to
_zone_.

IcmpBlockInversionRemoved(s: zone)
Emitted when ICMP block inversion has been removed from
_zone_.

IcmpBlockRemoved(s: zone, s: icmp)
Emitted when ICMP block for
_icmp_
has been removed from
_zone_.

InterfaceAdded(s: zone, s: interface)
Emitted when
_interface_
has been added to
_zone_.

InterfaceRemoved(s: zone, s: interface)
Emitted when
_interface_
has been removed from
_zone_.

MasqueradeAdded(s: zone, i: timeout)
Emitted when masquerade has been enabled for
_zone_.

MasqueradeRemoved(s: zone)
Emitted when masquerade has been disabled for
_zone_.

PortAdded(s: zone, s: port, s: protocol, i: timeout)
Emitted when
_port_/_protocol_
has been added to
_zone_
with
_timeout_.

PortRemoved(s: zone, s: port, s: protocol)
Emitted when
_port_/_protocol_
has been removed from
_zone_.

ProtocolAdded(s: zone, s: protocol, i: timeout)
Emitted when
_protocol_
has been added to
_zone_
with
_timeout_.

ProtocolRemoved(s: zone, s: protocol)
Emitted when
_protocol_
has been removed from
_zone_.

RichRuleAdded(s: zone, s: rule, i: timeout)
Emitted when rich language
_rule_
has been added to
_zone_
with
_timeout_.

RichRuleRemoved(s: zone, s: rule)
Emitted when rich language
_rule_
has been removed from
_zone_.

ServiceAdded(s: zone, s: service, i: timeout)
Emitted when
_service_
has been added to
_zone_
with
_timeout_.

ServiceRemoved(s: zone, s: service)
Emitted when
_service_
has been removed from
_zone_.

SourceAdded(s: zone, s: source)
Emitted when
_source_
has been added to
_zone_.

SourcePortAdded(s: zone, s: port, s: protocol, i: timeout)
Emitted when
_source-port_/_protocol_
has been added to
_zone_
with
_timeout_.

SourcePortRemoved(s: zone, s: port, s: protocol)
Emitted when
_source-port_/_protocol_
has been removed from
_zone_.

SourceRemoved(s: zone, s: source)
Emitted when
_source_
has been removed from
_zone_.

ZoneChanged(s: zone, s: interface)
Deprecated

ZoneOfInterfaceChanged(s: zone, s: interface)
Emitted when a zone an
_interface_
is part of has been changed to
_zone_.

ZoneOfSourceChanged(s: zone, s: source)
Emitted when a zone an
_source_
is part of has been changed to
_zone_.

<a name="orgfedoraprojectfirewalld1config"></a>

### org\&.fedoraproject\&.FirewallD1\&.config


Allows to permanently add, remove and query zones, services and icmp types.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addIPSet(s: ipset, (ssssa{ss}as): settings) → o
Add
_ipset_
with given
_settings_
into permanent configuration. Settings are in format:
_version_,
_name_,
_description_,
_type_, dictionary of
_options_
and array of
_entries_.

_version (s)_: see _version_ attribute of _ipset_ tag in **firewalld.ipset**(5).

_name (s)_: see _short_ tag in **firewalld.ipset**(5).

_description (s)_: see _description_ tag in **firewalld.ipset**(5).

_type (s)_: see _type_ attribute of _ipset_ tag in **firewalld.ipset**(5).

_options (a{ss})_: dictionary of {option : value} . See _options_ tag in **firewalld.ipset**(5).

_entries (as)_: array of entries, see _entry_ tag in **firewalld.ipset**(5).

Possible errors: NAME_CONFLICT, INVALID_NAME, INVALID_TYPE

addIcmpType(s: icmptype, (sssas): settings) → o
Add
_icmptype_
with given
_settings_
into permanent configuration. Settings are in format:
_version_,
_name_,
_description_, array of
_destinations_. Returns object path of the new icmp type.

_version (s)_: see _version_ attribute of _icmptype_ tag in **firewalld.icmptype**(5).

_name (s)_: see _short_ tag in **firewalld.icmptype**(5).

_description (s)_: see _description_ tag in **firewalld.icmptype**(5).

_destinations (as)_: array, either empty or containing strings ipv4\*(Aq or \*(Aqipv6\*(Aq, see _destination_ tag in **firewalld.icmptype**(5).

Possible errors: NAME_CONFLICT, INVALID_NAME, INVALID_TYPE

addService(s: service, (sssa(ss)asa{ss}asa(ss)): settings) → o
This function is deprecated, use
org.fedoraproject.FirewallD1.config.Methods.addService2
instead.

addService2s: service, a{sv}: settings) → o
Add
_service_
with given
_settings_
into permanent configuration. Settings are a dictionary indexed by keywords. For the type of each value see below. To zero a value pass an empty string or list.

_version (s)_: see _version_ attribute of _service_ tag in **firewalld.service**(5).

_name (s)_: see _short_ tag in **firewalld.service**(5).

_description (s)_: see _description_ tag in **firewalld.service**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.service**(5).

_module names (as)_: array of kernel netfilter helpers, see _module_ tag in **firewalld.service**(5).

_destinations (a{ss})_: dictionary of {IP family : IP address} where IP family\*(Aq key can be either \*(Aqipv4\*(Aq or \*(Aqipv6\*(Aq. See _destination_ tag in **firewalld.service**(5).

_protocols (as)_: array of protocols, see _protocol_ tag in **firewalld.service**(5).

_source_ports (a(ss))_: array of port and protocol pairs. See _source-port_ tag in **firewalld.service**(5).

_includes (as)_: array of service includes, see _include_ tag in **firewalld.service**(5).

_helpers (as)_: array of service helpers, see _helper_ tag in **firewalld.service**(5).

Possible errors: NAME_CONFLICT, INVALID_NAME, INVALID_TYPE

addZone(s: zone, (sssbsasa(ss)asba(ssss)asasasasa(ss)b): settings) → o
Add
_zone_
with given
_settings_
into permanent configuration. Settings are in format:
_version_,
_name_,
_description_,
_UNUSED_,
_target_, array of
_services_, array of
_ports_
(port, protocol), array of
_icmp-blocks_,
_masquerade_, array of
_forward-ports_
(port, protocol, to-port, to-addr), array of
_interfaces_, array of
_sources_, array of
_rich rules_, array of
_protocols_
and array of
_source-ports_
(port, protocol).

_version (s)_: see _version_ attribute of _zone_ tag in **firewalld.zone**(5).

_name (s)_: see _short_ tag in **firewalld.zone**(5).

_description (s)_: see _description_ tag in **firewalld.zone**(5).

_UNUSED (b)_: this boolean value is no longer used for anything.

_target (s)_: see _target_ attribute of _zone_ tag in **firewalld.zone**(5).

_services (as)_: array of service names, see _service_ tag in **firewalld.zone**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.zone**(5).

_icmp-blocks (as)_: array of icmp-blocks. See _icmp-block_ tag in **firewalld.zone**(5).

_masquerade (b)_: see _masquerade_ tag in **firewalld.zone**(5).

_forward-ports (a(ssss))_: array of (port, protocol, to-port, to-addr). See _forward-port_ tag in **firewalld.zone**(5).

_interfaces (as)_: array of interfaces. See _interface_ tag in **firewalld.zone**(5).

_source addresses (as)_: array of source addresses. See _source_ tag in **firewalld.zone**(5).

_rich rules (as)_: array of rich-language rules. See _rule_ tag in **firewalld.zone**(5).

_protocols (as)_: array of protocols. See _protocol_ tag in **firewalld.zone**(5).

_source-ports (a(ss))_: array of port and protocol pairs. See _source-port_ tag in **firewalld.zone**(5).

Possible errors: NAME_CONFLICT, INVALID_NAME, INVALID_TYPE

getHelperByName(s: helper) → o
Return object path (permanent configuration) of
_helper_
with given name.

Possible errors: INVALID_HELPER

getHelperNames() → as
Return list of
_helper_
names (permanent configuration).

getIPSetByName(s: ipset) → o
Return object path (permanent configuration) of
_ipset_
with given name.

Possible errors: INVALID_IPSET

getIPSetNames() → as
Return list of
_ipset_
names (permanent configuration).

getIcmpTypeByName(s: icmptype) → o
Return object path (permanent configuration) of
_icmptype_
with given name.

Possible errors: INVALID_ICMPTYPE

getIcmpTypeNames() → as
Return list of
_icmptype_
names (permanent configuration).

getServiceByName(s: service) → o
Return object path (permanent configuration) of
_service_
with given name.

Possible errors: INVALID_SERVICE

getServiceNames() → as
Return list of
_service_
names (permanent configuration).

getZoneByName(s: zone) → o
Return object path (permanent configuration) of
_zone_
with given name.

Possible errors: INVALID_ZONE

getZoneNames() → as
Return list of
_zone_
names (permanent configuration) of.

getZoneOfInterface(s: iface) → s
Return name of zone the
_iface_
is bound to or empty string.

getZoneOfSource(s: source) → s
Return name of zone the
_source_
is bound to or empty string.

listHelpers() → ao
Return array of object paths (o) of
helper
in permanent configuration. For runtime configuration see
org.fedoraproject.FirewallD1.Methods.getHelpers.

listIPSets() → ao
Return array of object paths (o) of
ipset
in permanent configuration. For runtime configuration see
org.fedoraproject.FirewallD1.ipset.Methods.getIPSets.

listIcmpTypes() → ao
Return array of object paths (o) of
icmp types
in permanent configuration. For runtime configuration see
org.fedoraproject.FirewallD1.Methods.listIcmpTypes.

listServices() → ao
Return array of objects paths (o) of
services
in permanent configuration. For runtime configuration see
org.fedoraproject.FirewallD1.Methods.listServices.

listZones() → ao
List object paths of zones known to permanent environment. For list of zones known to runtime environment see
org.fedoraproject.FirewallD1.zone.Methods.getZones. The lists (of zones known to runtime and permanent environment) will contain same zones in most cases, but might differ for example if
org.fedoraproject.FirewallD1.config.Methods.addZone
has been called recently, but firewalld has not been reloaded since then.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

HelperAdded(s: helper)
Emitted when
_helper_
has been added.

IPSetAdded(s: ipset)
Emitted when
_ipset_
has been added.

IcmpTypeAdded(s: icmptype)
Emitted when
_icmptype_
has been added.

ServiceAdded(s: service)
Emitted when
_service_
has been added.

ZoneAdded(s: zone)
Emitted when
_zone_
has been added.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Properties**

_AllowZoneDrifting_ - s - (rw)
Older versions of firewalld had undocumented behavior known as "zone drifting". This allowed packets to ingress multiple zones - this is a violation of zone based firewalls. However, some users rely on this behavior to have a "catch-all" zone, e.g. the default zone. You can enable this if you desire such behavior. Its disabled by default for security reasons. Note: If "yes" packets will only drift from source based zones to interface based zones (including the default zone). Packets never drift from interface based zones to other interfaces based zones (including the default zone). Valid values; "yes", "no". Defaults to "no".

AutomaticHelpers - s - (rw)
Deprecated. Getting this value always returns "no". Setting this value is ignored.

CleanupOnExit - s - (rw)
If firewalld stops, it cleans up all firewall rules. Setting this option to no or false leaves the current firewall rules untouched.

DefaultZone - s - (ro)
Default zone for connections or interfaces if the zone is not selected or specified by NetworkManager, initscripts or command line tool.

FirewallBackend - s - (rw)
Selects the firewalld backend for all rules except the direct interface. Valid options are; nftables, iptables. Default in nftables.

FirewallBackend - s - (rw)
Flush all runtime rules on a reload. Valid options are; yes, no.

_IPv6\_rpfilter_ - s - (rw)
Indicates whether the reverse path filter test on a packet for IPv6 is enabled. If a reply to the packet would be sent via the same interface that the packet arrived on, the packet will match and be accepted, otherwise dropped.

_IndividualCalls_ - s - (ro)
Indicates whether individual calls combined -restore calls are used. If enabled, this increases the time that is needed to apply changes and to start the daemon, but is good for debugging.

Lockdown - s - (rw)
If this property is enabled, firewall changes with the D-Bus interface will be limited to applications that are listed in the lockdown whitelist.

LogDenied - s - (rw)
If LogDenied is enabled, then logging rules are added right before reject and drop rules in the INPUT, FORWARD and OUTPUT chains for the default rules and also final reject and drop rules in zones. Possible values are:
_all_,
_unicast_,
_broadcast_,
_multicast_
and
_off_.

MinimalMark - i - (rw)
Deprecated. This option is ignored and no longer used. Marks are no longer used internally.

FirewallBackend - s - (rw)
As per RFC 3964, filter IPv6 traffic with 6to4 destination addresses that correspond to IPv4 addresses that should not be routed over the public internet. Valid options are; yes, no.

<a name="orgfedoraprojectfirewalld1configdirect"></a>

### org\&.fedoraproject\&.FirewallD1\&.config\&.direct


Interface for permanent direct configuration, see also
**firewalld.direct**(5). For runtime direct configuration see
org.fedoraproject.FirewallD1.direct
interface.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addChain(s: ipv, s: table, s: chain) → Nothing
Add a new
_chain_
to
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). Make sure theres no other chain with this name already. There already exist basic chains to use with direct methods, for example
_INPUT\_direct_
chain. These chains are jumped into before chains for zones, i.e. every rule put into
_INPUT\_direct_
will be checked before rules in zones. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.addChain.

Possible errors: INVALID_IPV, INVALID_TABLE, ALREADY_ENABLED

addPassthrough(s: ipv, as: args) → Nothing
Add a passthrough rule with the arguments
_args_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.addPassthrough.

Possible errors: INVALID_IPV, ALREADY_ENABLED

addRule(s: ipv, s: table, s: chain, i: priority, as: args) → Nothing
Add a rule with the arguments
_args_
to
_chain_
in
_table_
with
_priority_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). The priority is used to order rules. Priority 0 means add rule on top of the chain, with a higher priority the rule will be added further down. Rules with the same priority are on the same level and the order of these rules is not fixed and may change. If you want to make sure that a rule will be added after another one, use a low priority for the first and a higher for the following. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.addRule.

Possible errors: INVALID_IPV, INVALID_TABLE, ALREADY_ENABLED

getAllChains() → a(sss)
Get all chains added to all tables in format: ipv, table, chain. This concerns only chains previously added with
addChain. Return value is a array of (_ipv_,
_table_,
_chain_). For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.getAllChains.

_ipv (s)_: either _ipv4_ (iptables) or _ipv6_ (ip6tables) or _eb_ (ebtables).

_table (s)_: one of _filter_, _mangle_, _nat_, _raw_, _security_

_chain (s)_: name of a chain.


getAllPassthroughs() → a(sas)
Get all passthrough rules added in all ipv types in format: ipv, rule. This concerns only rules previously added with
addPassthrough. Return value is a array of (_ipv_, array of
_arguments_). For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.getAllPassthroughs.

_ipv (s)_: either _ipv4_ (iptables) or _ipv6_ (ip6tables) or _eb_ (ebtables).

_arguments (as)_: array of commands, parameters and other iptables/ip6tables/ebtables command line options.


getAllRules() → a(sssias)
Get all rules added to all chains in all tables in format: ipv, table, chain, priority, rule. This concerns only rules previously added with
addRule. Return value is a array of (_ipv_,
_table_,
_chain_,
_priority_, array of
_arguments_). For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.getAllRules.

_ipv (s)_: either _ipv4_ (iptables) or _ipv6_ (ip6tables) or _eb_ (ebtables).

_table (s)_: one of _filter_, _mangle_, _nat_, _raw_, _security_

_chain (s)_: name of a chain.

_priority (i)_: used to order rules.

_arguments (as)_: array of commands, parameters and other iptables/ip6tables/ebtables command line options.


getChains(s: ipv, s: table) → as
Return an array of chains (s) added to
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only chains previously added with
addChain. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.getChains.

Possible errors: INVALID_IPV, INVALID_TABLE

getPassthroughs(s: ipv) → aas
Get tracked passthrough rules added in either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addPassthrough. Return value is a array of (array of
_arguments_). For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.getPassthroughs.

_arguments (as)_: array of commands, parameters and other iptables/ip6tables/ebtables command line options.


getRules(s: ipv, s: table, s: chain) → a(ias)
Get all rules added to
_chain_
in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addRule. Return value is a array of (_priority_, array of
_arguments_). For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.getRules.

_priority (i)_: used to order rules.

_arguments (as)_: array of commands, parameters and other iptables/ip6tables/ebtables command line options.

Possible errors: INVALID_IPV, INVALID_TABLE

getSettings() → (a(sss)a(sssias)a(sas))
Get settings of permanent direct configuration in format: array of
_chains_, array of
_rules_, array of
_passthroughs_.

_chains (a(sss))_: array of (_ipv_, _table_, _chain_), see chain\*(Aq in **firewalld.direct**(5).
.
                  .PP
_rules (a(sssias))_: array of (_ipv_, _table_, _chain_, _priority_, array of _arguments_), see rule\*(Aq in **firewalld.direct**(5).
.
                  .PP
_passthroughs (a(sas))_: array of (_ipv_, array of _arguments_), see passthrough in **firewalld.direct**(5).
.
                .sp

queryChain(s: ipv, s: table, s: chain) → b
Return whether a
_chain_
exists in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only chains previously added with
addChain. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.queryChain.

Possible errors: INVALID_IPV, INVALID_TABLE

queryPassthrough(s: ipv, as: args) → b
Return whether a tracked passthrough rule with the arguments
_args_
exists for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addPassthrough. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.queryPassthrough.

Possible errors: INVALID_IPV

queryRule(s: ipv, s: table, s: chain, i: priority, as: args) → b
Return whether a rule with
_priority_
and the arguments
_args_
exists in
_chain_
in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addRule. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.queryRule.

Possible errors: INVALID_IPV, INVALID_TABLE

removeChain(s: ipv, s: table, s: chain) → Nothing
Remove a
_chain_
from
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). Only chains previously added with
addChain
can be removed this way. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.removeChain.

Possible errors: INVALID_IPV, INVALID_TABLE, NOT_ENABLED

removePassthrough(s: ipv, as: args) → Nothing
Remove a passthrough rule with arguments
_args_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). Only rules previously added with
addPassthrough
can be removed this way. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.removePassthrough.

Possible errors: INVALID_IPV, NOT_ENABLED

removeRule(s: ipv, s: table, s: chain, i: priority, as: args) → Nothing
Remove a rule with
_priority_
and arguments
_args_
from
_chain_
in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). Only rules previously added with
addRule
can be removed this way. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.removeRule.

Possible errors: INVALID_IPV, INVALID_TABLE, NOT_ENABLED

removeRules(s: ipv, s: table, s: chain) → Nothing
Remove all rules from
_chain_
in
_table_
for
_ipv_
being either
_ipv4_
(iptables) or
_ipv6_
(ip6tables) or
_eb_
(ebtables). This concerns only rules previously added with
addRule. For runtime operation see
org.fedoraproject.FirewallD1.direct.Methods.removeRules.

Possible errors: INVALID_IPV, INVALID_TABLE

update((a(sss)a(sssias)a(sas)): settings) → Nothing
Update permanent direct configuration with given
_settings_. Settings are in format: array of
_chains_, array of
_rules_, array of
_passthroughs_.

_chains (a(sss))_: array of (_ipv_, _table_, _chain_), see chain\*(Aq in **firewalld.direct**(5).
.
                  .PP
_rules (a(sssias))_: array of (_ipv_, _table_, _chain_, _priority_, array of _arguments_), see rule\*(Aq in **firewalld.direct**(5).
.
                  .PP
_passthroughs (a(sas))_: array of (_ipv_, array of _arguments_), see passthrough in **firewalld.direct**(5).
.
                .sp
Possible errors: INVALID_TYPE

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

Updated()
Emitted when configuration has been updated.

<a name="orgfedoraprojectfirewalld1configpolicies"></a>

### org\&.fedoraproject\&.FirewallD1\&.config\&.policies


Interface for permanent lockdown-whitelist configuration, see also
**firewalld.lockdown-whitelist**(5). For runtime configuration see
org.fedoraproject.FirewallD1.policies
interface.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addLockdownWhitelistCommand(s: command) → Nothing
Add
_command_
to whitelist. See
_command_
option in
**firewalld.lockdown-whitelist**(5). For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.addLockdownWhitelistCommand.

Possible errors: ALREADY_ENABLED, INVALID_TYPE

addLockdownWhitelistContext(s: context) → Nothing
Add
_context_
to whitelist. See
_selinux_
option in
**firewalld.lockdown-whitelist**(5). For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.addLockdownWhitelistContext.

Possible errors: ALREADY_ENABLED, INVALID_TYPE

addLockdownWhitelistUid(i: uid) → Nothing
Add user id
_uid_
to whitelist. See
_user_
option in
**firewalld.lockdown-whitelist**(5). For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.addLockdownWhitelistUid.

Possible errors: ALREADY_ENABLED, INVALID_TYPE

addLockdownWhitelistUser(s: user) → Nothing
Add
_user_
name to whitelist. See
_user_
option in
**firewalld.lockdown-whitelist**(5). For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.addLockdownWhitelistUser.

Possible errors: ALREADY_ENABLED, INVALID_TYPE

getLockdownWhitelist() → (asasasai)
Get settings of permanent lockdown-whitelist configuration in format:
_commands_,
_selinux contexts_,
_users_,
_uids_

_commands (as)_: see _command_ option in **firewalld.lockdown-whitelist**(5).

_selinux contexts (as)_: see _selinux_ option in **firewalld.lockdown-whitelist**(5).

_users (as)_: see _name_ attribute of _user_ option in **firewalld.lockdown-whitelist**(5).

_uids (ai)_: see _id_ attribute of _user_ option in **firewalld.lockdown-whitelist**(5).


getLockdownWhitelistCommands() → as
List all command lines (s) that are on whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.getLockdownWhitelistCommands.

getLockdownWhitelistContexts() → as
List all contexts (s) that are on whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.getLockdownWhitelistContexts.

getLockdownWhitelistUids() → ai
List all user ids (i) that are on whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.getLockdownWhitelistUids.

getLockdownWhitelistUsers() → as
List all users (s) that are on whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.getLockdownWhitelistUsers.

queryLockdownWhitelistCommand(s: command) → b
Query whether
_command_
is on whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.queryLockdownWhitelistCommand.

queryLockdownWhitelistContext(s: context) → b
Query whether
_context_
is on whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.queryLockdownWhitelistContext.

queryLockdownWhitelistUid(i: uid) → b
Query whether user id
_uid_
is on whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.queryLockdownWhitelistUid.

queryLockdownWhitelistUser(s: user) → b
Query whether
_user_
is on whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.queryLockdownWhitelistUser.

removeLockdownWhitelistCommand(s: command) → Nothing
Remove
_command_
from whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.removeLockdownWhitelistCommand.

Possible errors: NOT_ENABLED

removeLockdownWhitelistContext(s: context) → Nothing
Remove
_context_
from whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.removeLockdownWhitelistContext.

Possible errors: NOT_ENABLED

removeLockdownWhitelistUid(i: uid) → Nothing
Remove user id
_uid_
from whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.removeLockdownWhitelistUid.

Possible errors: NOT_ENABLED

removeLockdownWhitelistUser(s: user) → Nothing
Remove
_user_
from whitelist. For runtime operation see
org.fedoraproject.FirewallD1.policies.Methods.removeLockdownWhitelistUser.

Possible errors: NOT_ENABLED

setLockdownWhitelist((asasasai): settings) → Nothing
Set permanent lockdown-whitelist configuration to
_settings_. Settings are in format:
_commands_,
_selinux contexts_,
_users_,
_uids_

_commands (as)_: see _command_ option in **firewalld.lockdown-whitelist**(5).

_selinux contexts (as)_: see _selinux_ option in **firewalld.lockdown-whitelist**(5).

_users (as)_: see _name_ attribute of _user_ option in **firewalld.lockdown-whitelist**(5).

_uids (ai)_: see _id_ attribute of _user_ option in **firewalld.lockdown-whitelist**(5).

Possible errors: INVALID_TYPE

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

LockdownWhitelistUpdated()
Emitted when permanent lockdown-whitelist configuration has been updated.

<a name="orgfedoraprojectfirewalld1configipset"></a>

### org\&.fedoraproject\&.FirewallD1\&.config\&.ipset


Interface for permanent ipset configuration, see also
**firewalld.ipset**(5).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addEntry(s: entry) → Nothing
Permanently add
_entry_
to list of entries of ipset. See
_entry_
tag in
**firewalld.ipset**(5). For runtime operation see
org.fedoraproject.FirewallD1.ipset.Methods.addEntry.

Possible errors: ALREADY_ENABLED

addOption(s: key, s: value) → Nothing
Permanently add (_key_,
_value_) to the ipset. See
_option_
tag in
**firewalld.ipset**(5).

Possible errors: ALREADY_ENABLED

getDescription() → s
Get description of ipset. See
_description_
tag in
**firewalld.ipset**(5).

getEntries() → as
Get list of entries added to ipset. See
_entry_
tag in
**firewalld.ipset**(5). For runtime operation see
org.fedoraproject.FirewallD1.ipset.Methods.getEntries.

Possible errors: IPSET_WITH_TIMEOUT

getOptions() → a{ss}
Get dictionary of
_options_
set for ipset. See
_option_
tag in
**firewalld.ipset**(5).

getSettings() → (ssssa{ss}as)
Return permament settings of the ipset. For getting runtime settings see
org.fedoraproject.FirewallD1.ipset.Methods.getIPSetSettings. Settings are in format:
_version_,
_name_,
_description_,
_type_, dictionary of
_options_
and array of
_entries_.

_version (s)_: see _version_ attribute of _ipset_ tag in **firewalld.ipset**(5).

_name (s)_: see _short_ tag in **firewalld.ipset**(5).

_description (s)_: see _description_ tag in **firewalld.ipset**(5).

_type (s)_: see _type_ attribute of _ipset_ tag in **firewalld.ipset**(5).

_options (a{ss})_: dictionary of {option : value} . See _options_ tag in **firewalld.ipset**(5).

_entries (as)_: array of entries, see _entry_ tag in **firewalld.ipset**(5).


getShort() → s
Get name of ipset. See
_short_
tag in
**firewalld.ipset**(5).

getType() → s
Get type of ipset. See
_type_
attribute of
_ipset_
tag in
**firewalld.ipset**(5).

getVersion() → s
Get version of ipset. See
_version_
attribute of
_ipset_
tag in
**firewalld.ipset**(5).

loadDefaults() → Nothing
Load default settings for built-in ipset.

Possible errors: NO_DEFAULTS

queryEntry(s: entry) → b
Return whether
_entry_
has been added to
_ipset_. For runtime operation see
org.fedoraproject.FirewallD1.ipset.Methods.queryEntry.

queryOption(s: key, s: value) → b
Return whether (_key_,
_value_) has been added to options of the
_ipset_.

remove() → Nothing
Remove not built-in ipset.

Possible errors: BUILTIN_IPSET

removeEntry(s: entry) → Nothing
Permanently remove
_entry_
from ipset. See
_entry_
tag in
**firewalld.ipset**(5). For runtime operation see
org.fedoraproject.FirewallD1.ipset.Methods.removeEntry.

Possible errors: NOT_ENABLED

removeOption(s: key) → Nothing
Permanently remove
_key_
from the ipset. See
_option_
tag in
**firewalld.ipset**(5).

Possible errors: NOT_ENABLED

rename(s: name) → Nothing
Rename not built-in ipset to
_name_.

Possible errors: BUILTIN_IPSET

setDescription(s: description) → Nothing
Permanently set description of ipset to
_description_. See
_description_
tag in
**firewalld.ipset**(5).

setEntries(as: entries) → Nothing
Permanently set list of entries to
_entries_. See
_entry_
tag in
**firewalld.ipset**(5).

setOptions(a{ss}: options) → Nothing
Permanently set dict of options to
_options_. See
_option_
tag in
**firewalld.ipset**(5).

setShort(s: short) → Nothing
Permanently set name of ipset to
_short_. See
_short_
tag in
**firewalld.ipset**(5).

setType(s: ipset_type) → Nothing
Permanently set type of ipset to
_ipset\_type_. See
_type_
attribute of
_ipset_
tag in
**firewalld.ipset**(5).

setVersion(s: version) → Nothing
Permanently set version of ipset to
_version_. See
_version_
attribute of
_ipset_
tag in
**firewalld.ipset**(5).

update((ssssa{ss}as): settings) → Nothing
Update settings of ipset to
_settings_. Settings are in format:
_version_,
_name_,
_description_,
_type_, dictionary of
_options_
and array of
_entries_.

_version (s)_: see _version_ attribute of _ipset_ tag in **firewalld.ipset**(5).

_name (s)_: see _short_ tag in **firewalld.ipset**(5).

_description (s)_: see _description_ tag in **firewalld.ipset**(5).

_type (s)_: see _type_ attribute of _ipset_ tag in **firewalld.ipset**(5).

_options (a{ss})_: dictionary of {option : value} . See _options_ tag in **firewalld.ipset**(5).

_entries (as)_: array of entries, see _entry_ tag in **firewalld.ipset**(5).

Possible errors: INVALID_TYPE

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

Removed(s: name)
Emitted when ipset with
_name_
has been removed.

Renamed(s: name)
Emitted when ipset has been renamed to
_name_.

Updated(s: name)
Emitted when ipset with
_name_
has been updated.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Properties**

builtin - b - (ro)
True if ipset is build-in, false else.

default - b - (ro)
True if build-in ipset has default settings. False if it has been modified. Always False for not build-in ipsets.

filename - s - (ro)
Name (including .xml extension) of file where the configuration is stored.

name - s - (ro)
Name of ipset.

path - s - (ro)
Path to directory where the ipset configuration is stored. Should be either /usr/lib/firewalld/ipsets or /etc/firewalld/ipsets.

<a name="orgfedoraprojectfirewalld1configzone"></a>

### org\&.fedoraproject\&.FirewallD1\&.config\&.zone


Interface for permanent zone configuration, see also
**firewalld.zone**(5).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addForwardPort(s: port, s: protocol, s: toport, s: toaddr) → Nothing
Permanently add (_port_,
_protocol_,
_toport_,
_toaddr_) to list of forward ports of zone. See
_forward-port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addForwardPort.

Possible errors: ALREADY_ENABLED

addIcmpBlock(s: icmptype) → Nothing
Permanently add
_icmptype_
to list of icmp types blocked in zone. See
_icmp-block_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addIcmpBlock.

Possible errors: ALREADY_ENABLED

addIcmpBlock(s: icmptype) → Nothing
Permanently add icmp block inversion to zone. See
_icmp-block-inversion_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addIcmpBlockInversion.

Possible errors: ALREADY_ENABLED

addInterface(s: interface) → Nothing
Permanently add
_interface_
to list of interfaces bound to zone. See
_interface_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addInterface.

Possible errors: ALREADY_ENABLED

addMasquerade() → Nothing
Permanently enable masquerading in zone. See
_masquerade_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addMasquerade.

Possible errors: ALREADY_ENABLED

addPort(s: port, s: protocol) → Nothing
Permanently add (_port_,
_protocol_) to list of ports of zone. See
_port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addPort.

Possible errors: ALREADY_ENABLED

addProtocol(s: protocol) → Nothing
Permanently add protocol into
_zone_. The protocol can be any protocol supported by the system. Please have a look at
_/etc/protocols_
for supported protocols. For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addProtocol.

Possible errors: INVALID_PROTOCOL, ALREADY_ENABLED

addRichRule(s: rule) → Nothing
Permanently add
_rule_
to list of rich-language rules in zone. See
_rule_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addRichRule.

Possible errors: ALREADY_ENABLED

addService(s: service) → Nothing
Permanently add
_service_
to list of services used in zone. See
_service_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addService.

Possible errors: ALREADY_ENABLED

addSource(s: source) → Nothing
Permanently add
_source_
to list of source addresses bound to zone. See
_source_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addSource.

Possible errors: ALREADY_ENABLED

addSourcePort(s: port, s: protocol) → Nothing
Permanently add (_port_,
_protocol_) to list of source ports of zone. See
_source-port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.addSourcePort.

Possible errors: ALREADY_ENABLED

getDescription() → s
Get description of zone. See
_description_
tag in
**firewalld.zone**(5).

getForwardPorts() → a(ssss)
Get list of (_port_,
_protocol_,
_toport_,
_toaddr_) defined in zone. See
_forward-port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.getForwardPorts.

getIcmpBlockInversion() → b
Get icmp block inversion flag of zone. See
_icmp-block-inversion_
tag in
**firewalld.zone**(5).

getIcmpBlocks() → as
Get list of icmp type names blocked in zone. See
_icmp-block_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.getIcmpBlocks.

getInterfaces() → as
Get list of interfaces bound to zone. See
_interface_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.getInterfaces.

getMasquerade() → b
Return whether
_masquerade_
is enabled in zone. This is the same as queryMasquerade() method. See
_masquerade_
tag in
**firewalld.zone**(5).

getPorts() → a(ss)
Get list of (_port_,
_protocol_) defined in zone. See
_port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.getPorts.

getProtocols() → as
Return array of protocols (s) previously enabled in
_zone_. For getting runtime settings see
org.fedoraproject.FirewallD1.zone.Methods.getProtocols.

getRichRules() → as
Get list of rich-language rules in zone. See
_rule_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.getRichRules.

getServices() → as
Get list of service names used in zone. See
_service_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.getServices.

getSettings() → (sssbsasa(ss)asba(ssss)asasasasa(ss)b)
Return permanent settings of given
_zone_. For getting runtime settings see
org.fedoraproject.FirewallD1.Methods.getZoneSettings. Settings are in format:
_version_,
_name_,
_description_,
_UNUSED_,
_target_, array of
_services_, array of
_ports_
(port, protocol), array of
_icmp-blocks_,
_masquerade_, array of
_forward-ports_
(port, protocol, to-port, to-addr), array of
_interfaces_, array of
_sources_, array of
_rich rules_, array of
_protocols_
and array of
_source-ports_
(port, protocol).

_version (s)_: see _version_ attribute of _zone_ tag in **firewalld.zone**(5).

_name (s)_: see _short_ tag in **firewalld.zone**(5).

_description (s)_: see _description_ tag in **firewalld.zone**(5).

_UNUSED (b)_: this boolean value is no longer used for anything.

_target (s)_: see _target_ attribute of _zone_ tag in **firewalld.zone**(5).

_services (as)_: array of service names, see _service_ tag in **firewalld.zone**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.zone**(5).

_icmp-blocks (as)_: array of icmp-blocks. See _icmp-block_ tag in **firewalld.zone**(5).

_masquerade (b)_: see _masquerade_ tag in **firewalld.zone**(5).

_forward-ports (a(ssss))_: array of (port, protocol, to-port, to-addr). See _forward-port_ tag in **firewalld.zone**(5).

_interfaces (as)_: array of interfaces. See _interface_ tag in **firewalld.zone**(5).

_source addresses (as)_: array of source addresses. See _source_ tag in **firewalld.zone**(5).

_rich rules (as)_: array of rich-language rules. See _rule_ tag in **firewalld.zone**(5).

_protocols (as)_: array of protocols. See _protocol_ tag in **firewalld.zone**(5).

_source-ports (a(ss))_: array of port and protocol pairs. See _source-port_ tag in **firewalld.zone**(5).


getShort() → s
Get name of zone. See
_short_
tag in
**firewalld.zone**(5).

getSourcePorts() → a(ss)
Get list of (_port_,
_protocol_) defined in zone. See
_source-port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.getSourcePorts.

getSources() → as
Get list of source addresses bound to zone. See
_source_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.getSources.

getTarget() → s
Get target of zone. See
_target_
attribute of
_zone_
tag in
**firewalld.zone**(5).

getVersion() → s
Get version of zone. See
_version_
attribute of
_zone_
tag in
**firewalld.zone**(5).

loadDefaults() → Nothing
Load default settings for built-in zone.

Possible errors: NO_DEFAULTS

queryForwardPort(s: port, s: protocol, s: toport, s: toaddr) → b
Return whether (_port_,
_protocol_,
_toport_,
_toaddr_) is in list of forward ports of zone. See
_forward-port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.queryForwardPort.

queryIcmpBlock(s: icmptype) → b
Return whether
_icmptype_
is in list of icmp types blocked in zone. See
_icmp-block_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.queryIcmpBlock.

queryIcmpBlockInversion() → b
Return whether
_icmp block inversion_
is in enabled in zone. See
_icmp-block-inversion_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.queryIcmpBlockInversion.

queryInterface(s: interface) → b
Return whether
_interface_
is in list of interfaces bound to zone. See
_interface_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.queryInterface.

queryMasquerade() → b
Return whether
_masquerade_
is enabled in zone. This is the same as getMasquerade() method. See
_masquerade_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.queryMasquerade.

queryPort(s: port, s: protocol) → b
Return whether (_port_,
_protocol_) is in list of ports of zone. See
_port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.queryPort.

queryProtocol(s: protocol) → b
Return whether
_protocol_
has been added in
_zone_. For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.queryProtocol.

Possible errors: INVALID_PROTOCOL

queryRichRule(s: rule) → b
Return whether
_rule_
is in list of rich-language rules in zone. See
_rule_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.queryRichRule.

queryService(s: service) → b
Return whether
_service_
is in list of services used in zone. See
_service_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.queryService.

querySource(s: source) → b
Return whether
_source_
is in list of source addresses bound to zone. See
_source_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.querySource.

querySourcePort(s: port, s: protocol) → b
Return whether (_port_,
_protocol_) is in list of source ports of zone. See
_source-port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.querySourcePort.

remove() → Nothing
Remove not built-in zone.

Possible errors: BUILTIN_ZONE

removeForwardPort(s: port, s: protocol, s: toport, s: toaddr) → Nothing
Permanently remove (_port_,
_protocol_,
_toport_,
_toaddr_) from list of forward ports of zone. See
_forward-port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeForwardPort.

Possible errors: NOT_ENABLED

removeIcmpBlock(s: icmptype) → Nothing
Permanently remove
_icmptype_
from list of icmp types blocked in zone. See
_icmp-block_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeIcmpBlock.

Possible errors: NOT_ENABLED

removeIcmpBlockInversion() → Nothing
Permanently remove
_icmp block inversion_
from the zone. See
_icmp-block-inversion_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeIcmpBlockInversion.

Possible errors: NOT_ENABLED

removeInterface(s: interface) → Nothing
Permanently remove
_interface_
from list of interfaces bound to zone. See
_interface_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeInterface.

Possible errors: NOT_ENABLED

removeMasquerade() → Nothing
Permanently disable masquerading in zone. See
_masquerade_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeMasquerade.

Possible errors: NOT_ENABLED

removePort(s: port, s: protocol) → Nothing
Permanently remove (_port_,
_protocol_) from list of ports of zone. See
_port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removePort.

Possible errors: NOT_ENABLED

removeProtocol(s: protocol) → Nothing
Permanently remove protocol from
_zone_. For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeProtocol.

Possible errors: INVALID_PROTOCOL, NOT_ENABLED

removeRichRule(s: rule) → Nothing
Permanently remove
_rule_
from list of rich-language rules in zone. See
_rule_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeRichRule.

Possible errors: NOT_ENABLED

removeService(s: service) → Nothing
Permanently remove
_service_
from list of services used in zone. See
_service_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeService.

Possible errors: NOT_ENABLED

removeSource(s: source) → Nothing
Permanently remove
_source_
from list of source addresses bound to zone. See
_source_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeSource.

Possible errors: NOT_ENABLED

removeSourcePort(s: port, s: protocol) → Nothing
Permanently remove (_port_,
_protocol_) from list of source ports of zone. See
_source-port_
tag in
**firewalld.zone**(5). For runtime operation see
org.fedoraproject.FirewallD1.zone.Methods.removeSourcePort.

Possible errors: NOT_ENABLED

rename(s: name) → Nothing
Rename not built-in zone to
_name_.

Possible errors: BUILTIN_ZONE

setDescription(s: description) → Nothing
Permanently set description of zone to
_description_. See
_description_
tag in
**firewalld.zone**(5).

setForwardPorts(a(ssss): ports) → Nothing
Permanently set forward ports of zone to list of (_port_,
_protocol_,
_toport_,
_toaddr_). See
_forward-port_
tag in
**firewalld.zone**(5).

setIcmpBlockInversion(b: flag) → Nothing
Permanently set icmp block inversion flag of zone to
_flag_. See
_icmp-block-inversion_
tag in
**firewalld.zone**(5).

setIcmpBlocks(as: icmptypes) → Nothing
Permanently set list of icmp types blocked in zone to
_icmptypes_. See
_icmp-block_
tag in
**firewalld.zone**(5).

setInterfaces(as: interfaces) → Nothing
Permanently set list of interfaces bound to zone to
_interfaces_. See
_interface_
tag in
**firewalld.zone**(5).

setMasquerade(b: masquerade) → Nothing
Permanently set masquerading in zone to
_masquerade_. See
_masquerade_
tag in
**firewalld.zone**(5).

setPorts(a(ss): ports) → Nothing
Permanently set ports of zone to list of (_port_,
_protocol_). See
_port_
tag in
**firewalld.zone**(5).

setProtocols(as: protocols) → Nothing
Permanently set list of protocols used in zone to
_protocols_. See
_protocol_
tag in
**firewalld.zone**(5).

setRichRules(as: rules) → Nothing
Permanently set list of rich-language rules to
_rules_. See
_rule_
tag in
**firewalld.zone**(5).

setServices(as: services) → Nothing
Permanently set list of services used in zone to
_services_. See
_service_
tag in
**firewalld.zone**(5).

setShort(s: short) → Nothing
Permanently set name of zone to
_short_. See
_short_
tag in
**firewalld.zone**(5).

setSourcePorts(a(ss): ports) → Nothing
Permanently set source-ports of zone to list of (_port_,
_protocol_). See
_source-port_
tag in
**firewalld.zone**(5).

setSources(as: sources) → Nothing
Permanently set list of source addresses bound to zone to
_sources_. See
_source_
tag in
**firewalld.zone**(5).

setTarget(s: target) → Nothing
Permanently set target of zone to
_target_. See
_target_
attribute of
_zone_
tag in
**firewalld.zone**(5).

setVersion(s: version) → Nothing
Permanently set version of zone to
_version_. See
_version_
attribute of
_zone_
tag in
**firewalld.zone**(5).

update((sssbsasa(ss)asba(ssss)asasasasa(ss)b): settings) → Nothing
Update settings of zone to
_settings_. Settings are in format:
_version_,
_name_,
_description_,
_UNUSED_,
_target_, array of
_services_, array of
_ports_
(port, protocol), array of
_icmp-blocks_,
_masquerade_, array of
_forward-ports_
(port, protocol, to-port, to-addr), array of
_interfaces_, array of
_sources_, array of
_rich rules_, array of
_protocols_
and array of
_source-ports_
(port, protocol).

_version (s)_: see _version_ attribute of _zone_ tag in **firewalld.zone**(5).

_name (s)_: see _short_ tag in **firewalld.zone**(5).

_description (s)_: see _description_ tag in **firewalld.zone**(5).

_UNUSED (b)_: this boolean value is no longer used for anything.

_target (s)_: see _target_ attribute of _zone_ tag in **firewalld.zone**(5).

_services (as)_: array of service names, see _service_ tag in **firewalld.zone**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.zone**(5).

_icmp-blocks (as)_: array of icmp-blocks. See _icmp-block_ tag in **firewalld.zone**(5).

_masquerade (b)_: see _masquerade_ tag in **firewalld.zone**(5).

_forward-ports (a(ssss))_: array of (port, protocol, to-port, to-addr). See _forward-port_ tag in **firewalld.zone**(5).

_interfaces (as)_: array of interfaces. See _interface_ tag in **firewalld.zone**(5).

_source addresses (as)_: array of source addresses. See _source_ tag in **firewalld.zone**(5).

_rich rules (as)_: array of rich-language rules. See _rule_ tag in **firewalld.zone**(5).

_protocols (as)_: array of protocols. See _protocol_ tag in **firewalld.zone**(5).

_source-ports (a(ss))_: array of port and protocol pairs. See _source-port_ tag in **firewalld.zone**(5).

Possible errors: INVALID_TYPE

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

Removed(s: name)
Emitted when zone with
_name_
has been removed.

Renamed(s: name)
Emitted when zone has been renamed to
_name_.

Updated(s: name)
Emitted when zone with
_name_
has been updated.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Properties**

builtin - b - (ro)
True if zone is build-in, false else.

default - b - (ro)
True if build-in zone has default settings. False if it has been modified. Always False for not build-in zones.

filename - s - (ro)
Name (including .xml extension) of file where the configuration is stored.

name - s - (ro)
Name of zone.

path - s - (ro)
Path to directory where the zone configuration is stored. Should be either /usr/lib/firewalld/zones or /etc/firewalld/zones.

<a name="orgfedoraprojectfirewalld1configservice"></a>

### org\&.fedoraproject\&.FirewallD1\&.config\&.service


Interface for permanent service configuration, see also
**firewalld.service**(5).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addModule(s: module) → Nothing
This method is deprecated. Please use "helpers" in the update2() method.

addPort(s: port, s: protocol) → Nothing
Permanently add (_port_,
_protocol_) to list of ports in service. See
_port_
tag in
**firewalld.service**(5).

Possible errors: ALREADY_ENABLED

addProtocol(s: protocol) → Nothing
Permanently add protocol into
_zone_. The protocol can be any protocol supported by the system. Please have a look at
_/etc/protocols_
for supported protocols. See
_protocol_
tag in
**firewalld.service**(5).

Possible errors: INVALID_PROTOCOL, ALREADY_ENABLED

addSourcePort(s: port, s: protocol) → Nothing
Permanently add (_port_,
_protocol_) to list of source ports in service. See
_source-port_
tag in
**firewalld.service**(5).

Possible errors: ALREADY_ENABLED

getDescription() → s
Get description of service. See
_description_
tag in
**firewalld.service**(5).

getDestination(s: family) → s
Get destination for IP family being either ipv4\*(Aq or \*(Aqipv6\*(Aq. See
_destination_
tag in
**firewalld.service**(5).

Possible errors: ALREADY_ENABLED

getDestinations() → a{ss}
Get list of destinations. Return value is a dictionary of {IP family : IP address} where IP family\*(Aq key can be either \*(Aqipv4\*(Aq or \*(Aqipv6\*(Aq. See
_destination_
tag in
**firewalld.service**(5).

getModules() → as
This method is deprecated. Please use "helpers" in the getSettings2() method.

getPorts() → a(ss)
Get list of (_port_,
_protocol_) defined in service. See
_port_
tag in
**firewalld.service**(5).

getProtocols() → as
Return array of protocols (s) defined in
_service_. See
_protocol_
tag in
**firewalld.service**(5).

getSettings() → (sssa(ss)asa{ss}asa(ss))
This function is deprecated, use
org.fedoraproject.FirewallD1.config.service.Methods.getSettings2
instead.

getSettings2(s: _service_) → s{sv}
Return runtime settings of given
_service_. For getting runtime settings see
org.fedoraproject.FirewallD1.Methods.getServiceSettings2. Settings are a dictionary indexed by keywords. For the type of each value see below. If the value is empty it may be ommitted.

_version (s)_: see _version_ attribute of _service_ tag in **firewalld.service**(5).

_name (s)_: see _short_ tag in **firewalld.service**(5).

_description (s)_: see _description_ tag in **firewalld.service**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.service**(5).

_module names (as)_: array of kernel netfilter helpers, see _module_ tag in **firewalld.service**(5).

_destinations (a{ss})_: dictionary of {IP family : IP address} where IP family\*(Aq key can be either \*(Aqipv4\*(Aq or \*(Aqipv6\*(Aq. See _destination_ tag in **firewalld.service**(5).

_protocols (as)_: array of protocols, see _protocol_ tag in **firewalld.service**(5).

_source_ports (a(ss))_: array of port and protocol pairs. See _source-port_ tag in **firewalld.service**(5).

_includes (as)_: array of service includes, see _include_ tag in **firewalld.service**(5).

_helpers (as)_: array of service helpers, see _helper_ tag in **firewalld.service**(5).


getShort() → s
Get name of service. See
_short_
tag in
**firewalld.service**(5).

getSourcePorts() → a(ss)
Get list of (_port_,
_protocol_) defined in service. See
_source-port_
tag in
**firewalld.service**(5).

getVersion() → s
Get version of service. See
_version_
attribute of
_service_
tag in
**firewalld.service**(5).

loadDefaults() → Nothing
Load default settings for built-in service.

Possible errors: NO_DEFAULTS

queryDestination(s: family, s: address) → b
Return whether a
_destination_
is in dictionary of destinations of this service. destination is in format: (_IP family_,
_IP address_) where
_IP family_
can be either ipv4\*(Aq or \*(Aqipv6\*(Aq. See
_destination_
tag in
**firewalld.service**(5).

queryModule(s: module) → b
This method is deprecated. Please use "helpers" in the getSettings2() method.

queryPort(s: port, s: protocol) → b
Return whether (_port_,
_protocol_) is in list of ports in service. See
_port_
tag in
**firewalld.service**(5).

queryProtocol(s: protocol) → b
Return whether
_protocol_
is in list of protocols in service. See
_protocol_
tag in
**firewalld.service**(5).

querySourcePort(s: port, s: protocol) → b
Return whether (_port_,
_protocol_) is in list of source ports in service. See
_source-port_
tag in
**firewalld.service**(5).

remove() → Nothing
Remove not built-in service.

Possible errors: BUILTIN_SERVICE

removeDestination(s: family) → Nothing
Permanently remove a destination with
_family_
(ipv4\*(Aq or \*(Aqipv6\*(Aq) from service. See
_destination_
tag in
**firewalld.service**(5).

Possible errors: NOT_ENABLED

removeModule(s: module) → Nothing
This method is deprecated. Please use "helpers" in the update2() method.

removePort(s: port, s: protocol) → Nothing
Permanently remove (_port_,
_protocol_) from list of ports in service. See
_port_
tag in
**firewalld.service**(5).

Possible errors: NOT_ENABLED

removeProtocol(s: protocol) → Nothing
Permanently remove
_protocol_
from list of protocols in service. See
_protocol_
tag in
**firewalld.service**(5).

Possible errors: NOT_ENABLED

removeSourcePort(s: port, s: protocol) → Nothing
Permanently remove (_port_,
_protocol_) from list of source ports in service. See
_source-port_
tag in
**firewalld.service**(5).

Possible errors: NOT_ENABLED

rename(s: name) → Nothing
Rename not built-in service to
_name_.

Possible errors: BUILTIN_SERVICE

setDescription(s: description) → Nothing
Permanently set description of service to
_description_. See
_description_
tag in
**firewalld.service**(5).

setDestination(s: family, s: address) → Nothing
Permanently set a destination address. destination is in format: (_IP family_,
_IP address_) where
_IP family_
can be either ipv4\*(Aq or \*(Aqipv6\*(Aq. See
_destination_
tag in
**firewalld.service**(5).

Possible errors: ALREADY_ENABLED

setDestinations(a{ss}: destinations) → Nothing
Permanently set destinations of service to
_destinations_, which is a dictionary of {IP family : IP address} where IP family\*(Aq key can be either \*(Aqipv4\*(Aq or \*(Aqipv6\*(Aq. See
_destination_
tag in
**firewalld.service**(5).

setModules(as: modules) → Nothing
This method is deprecated. Please use "helpers" in the update2() method.

setPorts(a(ss): ports) → Nothing
Permanently set ports of service to list of (_port_,
_protocol_). See
_port_
tag in
**firewalld.service**(5).

setProtocols(as: protocols) → Nothing
Permanently set protocols of service to list of
_protocols_. See
_protocol_
tag in
**firewalld.service**(5).

setShort(s: short) → Nothing
Permanently set name of service to
_short_. See
_short_
tag in
**firewalld.service**(5).

setSourcePorts(a(ss): ports) → Nothing
Permanently set source-ports of service to list of (_port_,
_protocol_). See
_source-port_
tag in
**firewalld.service**(5).

setVersion(s: version) → Nothing
Permanently set version of service to
_version_. See
_version_
attribute of
_service_
tag in
**firewalld.service**(5).

update((sssa(ss)asa{ss}asa(ss)): settings) → Nothing
This function is deprecated, use
org.fedoraproject.FirewallD1.config.service.Methods.update2
instead.

update2a{sv}: settings) → Nothing
Update settings of service to
_settings_. Settings are a dictionary indexed by keywords. For the type of each value see below. To zero a value pass an empty string or list.

_version (s)_: see _version_ attribute of _service_ tag in **firewalld.service**(5).

_name (s)_: see _short_ tag in **firewalld.service**(5).

_description (s)_: see _description_ tag in **firewalld.service**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.service**(5).

_module names (as)_: array of kernel netfilter helpers, see _module_ tag in **firewalld.service**(5).

_destinations (a{ss})_: dictionary of {IP family : IP address} where IP family\*(Aq key can be either \*(Aqipv4\*(Aq or \*(Aqipv6\*(Aq. See _destination_ tag in **firewalld.service**(5).

_protocols (as)_: array of protocols, see _protocol_ tag in **firewalld.service**(5).

_source_ports (a(ss))_: array of port and protocol pairs. See _source-port_ tag in **firewalld.service**(5).

_includes (as)_: array of service includes, see _include_ tag in **firewalld.service**(5).

_helpers (as)_: array of service helpers, see _helper_ tag in **firewalld.service**(5).

Possible errors: INVALID_TYPE

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

Removed(s: name)
Emitted when service with
_name_
has been removed.

Renamed(s: name)
Emitted when service has been renamed to
_name_.

Updated(s: name)
Emitted when service with
_name_
has been updated.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Properties**

builtin - b - (ro)
True if service is build-in, false else.

default - b - (ro)
True if build-in service has default settings. False if it has been modified. Always False for not build-in services.

filename - s - (ro)
Name (including .xml extension) of file where the configuration is stored.

name - s - (ro)
Name of service.

path - s - (ro)
Path to directory where the configuration is stored. Should be either /usr/lib/firewalld/services or /etc/firewalld/services.

<a name="orgfedoraprojectfirewalld1confighelper"></a>

### org\&.fedoraproject\&.FirewallD1\&.config\&.helper


Interface for permanent helper configuration, see also
**firewalld.helper**(5).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addPort(s: port, s: protocol) → Nothing
Permanently add (_port_,
_protocol_) to list of ports in helper. See
_port_
tag in
**firewalld.helper**(5).

Possible errors: ALREADY_ENABLED

getDescription() → s
Get description of helper. See
_description_
tag in
**firewalld.helper**(5).

getFamily() → s
Get family being ipv4\*(Aq, \*(Aqipv6\*(Aq or empty for both. See
_family_
tag in
**firewalld.helper**(5).

getModule() → s
Get modules (netfilter kernel helpers) used in helper. See
_module_
tag in
**firewalld.helper**(5).

getPorts() → a(ss)
Get list of (_port_,
_protocol_) defined in helper. See
_port_
tag in
**firewalld.helper**(5).

getSettings() → (sssssa(ss))
Return permanent settings of a
_helper_. For getting runtime settings see
org.fedoraproject.FirewallD1.Methods.getHelperSettings. Settings are in format:
_version_,
_name_,
_description_,
_family_,
_module_, array of
_ports_
(port, protocol).

_version (s)_: see _version_ attribute of _helper_ tag in **firewalld.helper**(5).

_name (s)_: see _short_ tag in **firewalld.helper**(5).

_description (s)_: see _description_ tag in **firewalld.helper**(5).

_family (s)_: see _family_ tag in **firewalld.helper**(5).

_module (s)_: see _module_ tag in **firewalld.helper**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.helper**(5).


getShort() → s
Get name of helper. See
_short_
tag in
**firewalld.helper**(5).

getVersion() → s
Get version of helper. See
_version_
attribute of
_helper_
tag in
**firewalld.helper**(5).

loadDefaults() → Nothing
Load default settings for built-in helper.

Possible errors: NO_DEFAULTS

queryFamily(s: module) → b
Return whether
_family_
is set for helper. See
_family_
tag in
**firewalld.helper**(5).

queryModule(s: module) → b
Return whether
_module_
(netfilter kernel helpers) is used in helper. See
_module_
tag in
**firewalld.helper**(5).

queryPort(s: port, s: protocol) → b
Return whether (_port_,
_protocol_) is in list of ports in helper. See
_port_
tag in
**firewalld.helper**(5).

remove() → Nothing
Remove not built-in helper.

Possible errors: BUILTIN_HELPER

removePort(s: port, s: protocol) → Nothing
Permanently remove (_port_,
_protocol_) from list of ports in helper. See
_port_
tag in
**firewalld.helper**(5).

Possible errors: NOT_ENABLED

rename(s: name) → Nothing
Rename not built-in helper to
_name_.

Possible errors: BUILTIN_HELPER

setDescription(s: description) → Nothing
Permanently set description of helper to
_description_. See
_description_
tag in
**firewalld.helper**(5).

setFamily(s: family) → Nothing
Permanently set family of helper to
_family_. See
_family_
tag in
**firewalld.helper**(5).

setModule(s: module) → Nothing
Permanently set module of helper to
_description_. See
_module_
tag in
**firewalld.helper**(5).

setPorts(a(ss): ports) → Nothing
Permanently set ports of helper to list of (_port_,
_protocol_). See
_port_
tag in
**firewalld.helper**(5).

setShort(s: short) → Nothing
Permanently set name of helper to
_short_. See
_short_
tag in
**firewalld.helper**(5).

setVersion(s: version) → Nothing
Permanently set version of helper to
_version_. See
_version_
attribute of
_helper_
tag in
**firewalld.helper**(5).

update((sssssa(ss)): settings) → Nothing
Update settings of helper to
_settings_. Settings are in format:
_version_,
_name_,
_description_,
_family_,
_module_
and array of
_ports_.

_version (s)_: see _version_ attribute of _helper_ tag in **firewalld.helper**(5).

_name (s)_: see _short_ tag in **firewalld.helper**(5).

_description (s)_: see _description_ tag in **firewalld.helper**(5).

_family (s)_: see _family_ tag in **firewalld.helper**(5).

_module (s)_: see _module_ tag in **firewalld.helper**(5).

_ports (a(ss))_: array of port and protocol pairs. See _port_ tag in **firewalld.helper**(5).

Possible errors: INVALID_HELPER

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

Removed(s: name)
Emitted when helper with
_name_
has been removed.

Renamed(s: name)
Emitted when helper has been renamed to
_name_.

Updated(s: name)
Emitted when helper with
_name_
has been updated.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Properties**

builtin - b - (ro)
True if helper is build-in, false else.

default - b - (ro)
True if build-in helper has default settings. False if it has been modified. Always False for not build-in helpers.

filename - s - (ro)
Name (including .xml extension) of file where the configuration is stored.

name - s - (ro)
Name of helper.

path - s - (ro)
Path to directory where the configuration is stored. Should be either /usr/lib/firewalld/helpers or /etc/firewalld/helpers.

<a name="orgfedoraprojectfirewalld1configicmptype"></a>

### org\&.fedoraproject\&.FirewallD1\&.config\&.icmptype


Interface for permanent icmp type configuration, see also
**firewalld.icmptype**(5).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Methods**

addDestination(s: destination) → Nothing
Permanently add a
_destination_
(ipv4\*(Aq or \*(Aqipv6\*(Aq) to list of destinations of this icmp type. See
_destination_
tag in
**firewalld.icmptype**(5).

Possible errors: ALREADY_ENABLED

getDescription() → s
Get description of icmp type. See
_description_
tag in
**firewalld.icmptype**(5).

getDestinations() → as
Get list of destinations. See
_destination_
tag in
**firewalld.icmptype**(5).

getSettings() → (sssas)
Return permanent settings of
_icmp type_. For getting runtime settings see
org.fedoraproject.FirewallD1.Methods.getIcmpTypeSettings. Settings are in format:
_version_,
_name_,
_description_, array of
_destinations_.

_version (s)_: see _version_ attribute of _icmptype_ tag in **firewalld.icmptype**(5).

_name (s)_: see _short_ tag in **firewalld.icmptype**(5).

_description (s)_: see _description_ tag in **firewalld.icmptype**(5).

_destinations (as)_: array, either empty or containing strings ipv4\*(Aq and/or \*(Aqipv6\*(Aq, see destination tag in **firewalld.icmptype**(5).


getShort() → s
Get name of icmp type. See
_short_
tag in
**firewalld.icmptype**(5).

getVersion() → s
Get version of icmp type. See
_version_
attribute of
_icmptype_
tag in
**firewalld.icmptype**(5).

loadDefaults() → Nothing
Load default settings for built-in icmp type.

Possible errors: NO_DEFAULTS

queryDestination(s: destination) → b
Return whether a
_destination_
(ipv4\*(Aq or \*(Aqipv6\*(Aq) is in list of destinations of this icmp type. See
_destination_
tag in
**firewalld.icmptype**(5).

remove() → Nothing
Remove not built-in icmp type.

Possible errors: BUILTIN_ICMPTYPE

removeDestination(s: destination) → Nothing
Permanently remove a
_destination_
(ipv4\*(Aq or \*(Aqipv6\*(Aq) from list of destinations of this icmp type. See
_destination_
tag in
**firewalld.icmptype**(5).

Possible errors: NOT_ENABLED

rename(s: name) → Nothing
Rename not built-in icmp type to
_name_.

Possible errors: BUILTIN_ICMPTYPE

setDescription(s: description) → Nothing
Permanently set description of icmp type to
_description_. See
_description_
tag in
**firewalld.icmptype**(5).

setDestinations(as: destinations) → Nothing
Permanently set destinations of icmp type to
_destinations_, which is array, either empty or containing strings ipv4\*(Aq and/or \*(Aqipv6\*(Aq. See
_destination_
tag in
**firewalld.icmptype**(5).

setShort(s: short) → Nothing
Permanently set name of icmp type to
_short_. See
_short_
tag in
**firewalld.icmptype**(5).

setVersion(s: version) → Nothing
Permanently set version of icmp type to
_version_. See
_version_
attribute of
_icmptype_
tag in
**firewalld.icmptype**(5).

update((sssas): settings) → Nothing
Update permanent settings of icmp type to
_settings_. Settings are in format:
_version_,
_name_,
_description_, array of
_destinations_.

_version (s)_: see _version_ attribute of _icmptype_ tag in **firewalld.icmptype**(5).

_name (s)_: see _short_ tag in **firewalld.icmptype**(5).

_description (s)_: see _description_ tag in **firewalld.icmptype**(5).

_destinations (as)_: array, either empty or containing strings ipv4\*(Aq and/or \*(Aqipv6\*(Aq, see destination tag in **firewalld.icmptype**(5).


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Signals**

Removed(s: name)
Emitted when icmp type with
_name_
has been removed.

Renamed(s: name)
Emitted when icmp type has been renamed to
_name_.

Updated(s: name)
Emitted when icmp type with
_name_
has been updated.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Properties**

builtin - b - (ro)
True if icmptype is build-in, false else.

default - b - (ro)
True if build-in icmp type has default settings. False if it has been modified. Always False for not build-in zones.

filename - s - (ro)
Name (including .xml extension) of file where the configuration is stored.

name - s - (ro)
Name of icmp type.

path - s - (ro)
Path to directory where the icmp type configuration is stored. Should be either /usr/lib/firewalld/icmptypes or /etc/firewalld/icmptypes.

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
