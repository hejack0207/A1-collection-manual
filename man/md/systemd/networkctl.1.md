# networkctl(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

networkctl - Query the status of network links

<a name="synopsis"></a>

# Synopsis

```
.HP \w'networkctl&nbsp;'u networkctl [OPTIONS...] COMMAND [LINK...]
```

<a name="description"></a>

# Description


**networkctl**
may be used to introspect the state of the network links as seen by
**systemd-networkd**. Please refer to
**systemd-networkd.service**(8)
for an introduction to the basic concepts, functionality, and configuration syntax.

<a name="options"></a>

# Options


The following options are understood:

**-a** **--all**
Show all links with
**status**.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

**--no-legend**
Do not print the legend, i.e. column headers and the footer with hints.

**--no-pager**
Do not pipe output into a pager.

<a name="commands"></a>

# Commands


The following commands are understood:

**list** [_LINK..._]
Show a list of existing links and their status. If no further arguments are specified shows all links, otherwise just the specified links. Produces output similar to:

.if n \{.RS 4
.\}
    IDX LINK         TYPE     OPERATIONAL SETUP
      1 lo           loopback carrier     unmanaged
      2 eth0         ether    routable    configured
      3 virbr0       ether    no-carrier  unmanaged
      4 virbr0-nic   ether    off         unmanaged
    
    4 links listed.
.if n \{.RE
.\}

The operational status is one of the following:

off
the device is powered down

no-carrier
the device is powered up, but it does not yet have a carrier

dormant
the device has a carrier, but is not yet ready for normal traffic

carrier
the link has a carrier

degraded
the link has carrier and addresses valid on the local link configured

routable
the link has carrier and routable address configured

The setup status is one of the following:

pending
udev is still processing the link, we dont yet know if we will manage it

failed
networkd failed to manage the link

configuring
in the process of retrieving configuration or configuring the link

configured
link configured successfully

unmanaged
networkd is not handling the link

linger
the link is gone, but has not yet been dropped by networkd


**status** [_LINK..._]
Show information about the specified links: type, state, kernel module driver, hardware and IP address, configured DNS servers, etc.

When no links are specified, an overall network status is shown. Also see the option
**--all**.

Produces output similar to:

.if n \{.RS 4
.\}
    ●      State: routable
         Address: 10.193.76.5 on eth0
                  192.168.122.1 on virbr0
                  169.254.190.105 on eth0
                  fe80::5054:aa:bbbb:cccc on eth0
         Gateway: 10.193.11.1 (CISCO SYSTEMS, INC.) on eth0
             DNS: 8.8.8.8
                  8.8.4.4
.if n \{.RE
.\}

**lldp** [_LINK..._]
Show discovered LLDP (Link Layer Discovery Protocol) neighbors. If one or more link names are specified only neighbors on those interfaces are shown. Otherwise shows discovered neighbors on all interfaces. Note that for this feature to work,
_LLDP=_
must be turned on for the specific interface, see
**systemd.network**(5)
for details.

Produces output similar to:

.if n \{.RS 4
.\}
    LINK             CHASSIS ID        SYSTEM NAME      CAPS        PORT ID           PORT DESCRIPTION
    enp0s25          00:e0:4c:00:00:00 GS1900           ..b........ 2                 Port #2
    
    Capability Flags:
    o - Other; p - Repeater;  b - Bridge; w - WLAN Access Point; r - Router;
    t - Telephone; d - DOCSIS cable device; a - Station; c - Customer VLAN;
    s - Service VLAN, m - Two-port MAC Relay (TPMR)
    
    1 neighbors listed.
.if n \{.RE
.\}

**label**
Show numerical address labels that can be used for address selection. This is the same information that
**ip-addrlabel**(8)
shows. See
\m[blue]**RFC 3484**\m[]\s-2\u[1]\d\s+2
for a discussion of address labels.

Produces output similar to:

.if n \{.RS 4
.\}
    Prefix/Prefixlen                          Label
            ::/0                                  1
        fc00::/7                                  5
        fec0::/10                                11
        2002::/16                                 2
        3ffe::/16                                12
     2001:10::/28                                 7
        2001::/32                                 6
    ::ffff:0.0.0.0/96                             4
            ::/96                                 3
           ::1/128                                0
.if n \{.RE
.\}

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="see-also"></a>

# See Also


**systemd-networkd.service**(8),
**systemd.network**(5),
**systemd.netdev**(5),
**ip**(8)

<a name="notes"></a>

# Notes


*  1.  
  RFC 3484
      https://tools.ietf.org/html/rfc3484
