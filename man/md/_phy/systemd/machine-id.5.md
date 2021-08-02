# machine\-id(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

machine-id - Local machine ID configuration file

<a name="synopsis"></a>

# Synopsis

```

 /etc/machine-id
```

<a name="description"></a>

# Description


The
/etc/machine-id
file contains the unique machine ID of the local system that is set during installation or boot. The machine ID is a single newline-terminated, hexadecimal, 32-character, lowercase ID. When decoded from hexadecimal, this corresponds to a 16-byte/128-bit value. This ID may not be all zeros.

The machine ID is usually generated from a random source during system installation or first boot and stays constant for all subsequent boots. Optionally, for stateless systems, it is generated during runtime during early boot if necessary.

The machine ID may be set, for example when network booting, with the
_systemd.machine\_id=_
kernel command line parameter or by passing the option
**--machine-id=**
to systemd. An ID is specified in this manner has higher priority and will be used instead of the ID stored in
/etc/machine-id.

The machine ID does not change based on local or network configuration or when hardware is replaced. Due to this and its greater length, it is a more useful replacement for the
**gethostid**(3)
call that POSIX specifies.

This machine ID adheres to the same format and logic as the D-Bus machine ID.

This ID uniquely identifies the host. It should be considered "confidential", and must not be exposed in untrusted environments, in particular on the network. If a stable unique identifier that is tied to the machine is needed for some application, the machine ID or any part of it must not be used directly. Instead the machine ID should be hashed with a cryptographic, keyed hash function, using a fixed, application-specific key. That way the ID will be properly unique, and derived in a constant way from the machine ID but there will be no way to retrieve the original machine ID from the application-specific one. The
**sd\_id128\_get\_machine\_app\_specific**(3)
API provides an implementation of such an algorithm.

<a name="initialization"></a>

# Initialization


Each machine should have a non-empty ID in normal operation. The ID of each machine should be unique. To achieve those objectives,
/etc/machine-id
can be initialized in a few different ways.

For normal operating system installations, where a custom image is created for a specific machine,
/etc/machine-id
should be populated during installation.

**systemd-machine-id-setup**(1)
may be used by installer tools to initialize the machine ID at install time, but
/etc/machine-id
may also be written using any other means.

For operating system images which are created once and used on multiple machines, for example for containers or in the cloud,
/etc/machine-id
should be an empty file in the generic file system image. An ID will be generated during boot and saved to this file if possible. Having an empty file in place is useful because it allows a temporary file to be bind-mounted over the real file, in case the image is used read-only.

**systemd-firstboot**(1)
may be used to initialize
/etc/machine-id
on mounted (but not booted) system images.

When a machine is booted with
**systemd**(1)
the ID of the machine will be established. If
_systemd.machine\_id=_
or
**--machine-id=**
options (see first section) are specified, this value will be used. Otherwise, the value in
/etc/machine-id
will be used. If this file is empty or missing,
systemd
will attempt to use the D-Bus machine ID from
/var/lib/dbus/machine-id, the value of the kernel command line option
_container\_uuid_, the KVM DMI
product_uuid
(on KVM systems), and finally a randomly generated UUID.

After the machine ID is established,
**systemd**(1)
will attempt to save it to
/etc/machine-id. If this fails, it will attempt to bind-mount a temporary file over
/etc/machine-id. It is an error if the file system is read-only and does not contain a (possibly empty)
/etc/machine-id
file.

**systemd-machine-id-commit.service**(8)
will attempt to write the machine ID to the file system if
/etc/machine-id
or
/etc
are read-only during early boot but become writable later on.

<a name="relation-to-osf-uuids"></a>

# Relation to Osf Uuids


Note that the machine ID historically is not an OSF UUID as defined by
\m[blue]**RFC 4122**\m[]\s-2\u[1]\d\s+2, nor a Microsoft GUID; however, starting with systemd v30, newly generated machine IDs do qualify as v4 UUIDs.

In order to maintain compatibility with existing installations, an application requiring a UUID should decode the machine ID, and then apply the following operations to turn it into a valid OSF v4 UUID. With
"id"
being an unsigned character array:

.if n \{.RS 4
.\}
    /* Set UUID version to 4 --- truly random generation */
    id[6] = (id[6] & 0x0F) | 0x40;
    /* Set the UUID variant to DCE */
    id[8] = (id[8] & 0x3F) | 0x80;
.if n \{.RE
.\}

(This code is inspired by
"generate_random_uuid()"
of
drivers/char/random.c
from the Linux kernel sources.)

<a name="history"></a>

# History


The simple configuration file format of
/etc/machine-id
originates in the
/var/lib/dbus/machine-id
file introduced by D-Bus. In fact, this latter file might be a symlink to
/etc/machine-id.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-machine-id-setup**(1),
**gethostid**(3),
**hostname**(5),
**machine-info**(5),
**os-release**(5),
**sd-id128**(3),
**sd\_id128\_get\_machine**(3),
**systemd-firstboot**(1)

<a name="notes"></a>

# Notes


*  1.  
  RFC 4122
      https://tools.ietf.org/html/rfc4122
