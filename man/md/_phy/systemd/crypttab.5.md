# crypttab(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

crypttab - Configuration for encrypted block devices

<a name="synopsis"></a>

# Synopsis

```

 /etc/crypttab
```

<a name="description"></a>

# Description


The
/etc/crypttab
file describes encrypted block devices that are set up during system boot.

Empty lines and lines starting with the
"#"
character are ignored. Each of the remaining lines describes one encrypted block device. Fields are delimited by white space.

Each line is in the form

.if n \{.RS 4
.\}
    name encrypted-device password options
.if n \{.RE
.\}

The first two fields are mandatory, the remaining two are optional.

Setting up encrypted block devices using this file supports three encryption modes: LUKS, TrueCrypt and plain. See
**cryptsetup**(8)
for more information about each mode. When no mode is specified in the options field and the block device contains a LUKS signature, it is opened as a LUKS device; otherwise, it is assumed to be in raw dm-crypt (plain mode) format.

The first field contains the name of the resulting encrypted block device; the device is set up within
/dev/mapper/.

The second field contains a path to the underlying block device or file, or a specification of a block device via
"UUID="
followed by the UUID.

The third field specifies the encryption password. If the field is not present or the password is set to
"none"
or
"-", the password has to be manually entered during system boot. Otherwise, the field is interpreted as an absolute path to a file containing the encryption password. For swap encryption,
/dev/urandom
or the hardware device
/dev/hw_random
can be used as the password file; using
/dev/random
may prevent boot completion if the system does not have enough entropy to generate a truly random encryption key.

The fourth field, if present, is a comma-delimited list of options. The following options are recognized:

**cipher=**
Specifies the cipher to use. See
**cryptsetup**(8)
for possible values and the default value of this option. A cipher with unpredictable IV values, such as
"aes-cbc-essiv:sha256", is recommended.

**discard**
Allow discard requests to be passed through the encrypted block device. This improves performance on SSD storage but has security implications.

**hash=**
Specifies the hash to use for password hashing. See
**cryptsetup**(8)
for possible values and the default value of this option.

**header=**
Use a detached (separated) metadata device or file where the LUKS header is stored. This option is only relevant for LUKS devices. See
**cryptsetup**(8)
for possible values and the default value of this option.

**keyfile-offset=**
Specifies the number of bytes to skip at the start of the key file. See
**cryptsetup**(8)
for possible values and the default value of this option.

**keyfile-size=**
Specifies the maximum number of bytes to read from the key file. See
**cryptsetup**(8)
for possible values and the default value of this option. This option is ignored in plain encryption mode, as the key file size is then given by the key size.

**key-slot=**
Specifies the key slot to compare the passphrase or key against. If the key slot does not match the given passphrase or key, but another would, the setup of the device will fail regardless. This option implies
**luks**. See
**cryptsetup**(8)
for possible values. The default is to try all key slots in sequential order.

**luks**
Force LUKS mode. When this mode is used, the following options are ignored since they are provided by the LUKS header on the device:
**cipher=**,
**hash=**,
**size=**.

**\_netdev**
Marks this cryptsetup device as requiring network. It will be started after the network is available, similarly to
**systemd.mount**(5)
units marked with
**\_netdev**. The service unit to set up this device will be ordered between
remote-fs-pre.target
and
remote-cryptsetup.target, instead of
cryptsetup-pre.target
and
cryptsetup.target.

Hint: if this device is used for a mount point that is specified in
**fstab**(5), the
**\_netdev**
option should also be used for the mount point. Otherwise, a dependency loop might be created where the mount point will be pulled in by
local-fs.target, while the service to configure the network is usually only started
_after_
the local file system has been mounted.

**noauto**
This device will not be added to
cryptsetup.target. This means that it will not be automatically unlocked on boot, unless something else pulls it in. In particular, if the device is used for a mount point, itll be unlocked automatically during boot, unless the mount point itself is also disabled with
**noauto**.

**nofail**
This device will not be a hard dependency of
cryptsetup.target. Itll be still pulled in and started, but the system will not wait for the device to show up and be unlocked, and boot will not fail if this is unsuccessful. Note that other units that depend on the unlocked device may still fail. In particular, if the device is used for a mount point, the mount point itself is also needs to have
**noauto**
option, or the boot will fail if the device is not unlocked successfully.

**offset=**
Start offset in the backend device, in 512-byte sectors. This option is only relevant for plain devices.

**plain**
Force plain encryption mode.

**read-only**, **readonly**
Set up the encrypted block device in read-only mode.

**skip=**
How many 512-byte sectors of the encrypted data to skip at the beginning. This is different from the
**offset=**
option with respect to the sector numbers used in initialization vector (IV) calculation. Using
**offset=**
will shift the IV calculation by the same negative amount. Hence, if
**offset=****n**
is given, sector
_n_
will get a sector number of 0 for the IV calculation. Using
**skip=**
causes sector
_n_
to also be the first sector of the mapped device, but with its number for IV generation being
_n_.

This option is only relevant for plain devices.

**size=**
Specifies the key size in bits. See
**cryptsetup**(8)
for possible values and the default value of this option.

**sector-size=**
Specifies the sector size in bytes. See
**cryptsetup**(8)
for possible values and the default value of this option.

**swap**
The encrypted block device will be used as a swap device, and will be formatted accordingly after setting up the encrypted block device, with
**mkswap**(8). This option implies
**plain**.

WARNING: Using the
**swap**
option will destroy the contents of the named partition during every boot, so make sure the underlying block device is specified correctly.

**tcrypt**
Use TrueCrypt encryption mode. When this mode is used, the following options are ignored since they are provided by the TrueCrypt header on the device or do not apply:
**cipher=**,
**hash=**,
**keyfile-offset=**,
**keyfile-size=**,
**size=**.

When this mode is used, the passphrase is read from the key file given in the third field. Only the first line of this file is read, excluding the new line character.

Note that the TrueCrypt format uses both passphrase and key files to derive a password for the volume. Therefore, the passphrase and all key files need to be provided. Use
**tcrypt-keyfile=**
to provide the absolute path to all key files. When using an empty passphrase in combination with one or more key files, use
"/dev/null"
as the password file in the third field.

**tcrypt-hidden**
Use the hidden TrueCrypt volume. This option implies
**tcrypt**.

This will map the hidden volume that is inside of the volume provided in the second field. Please note that there is no protection for the hidden volume if the outer volume is mounted instead. See
**cryptsetup**(8)
for more information on this limitation.

**tcrypt-keyfile=**
Specifies the absolute path to a key file to use for a TrueCrypt volume. This implies
**tcrypt**
and can be used more than once to provide several key files.

See the entry for
**tcrypt**
on the behavior of the passphrase and key files when using TrueCrypt encryption mode.

**tcrypt-system**
Use TrueCrypt in system encryption mode. This option implies
**tcrypt**.

**tcrypt-veracrypt**
Check for a VeraCrypt volume. VeraCrypt is a fork of TrueCrypt that is mostly compatible, but uses different, stronger key derivation algorithms that cannot be detected without this flag. Enabling this option could substantially slow down unlocking, because VeraCrypts key derivation takes much longer than TrueCrypt\*(Aqs. This option implies
**tcrypt**.

**timeout=**
Specifies the timeout for querying for a password. If no unit is specified, seconds is used. Supported units are s, ms, us, min, h, d. A timeout of 0 waits indefinitely (which is the default).

**tmp**
The encrypted block device will be prepared for using it as
/tmp; it will be formatted using
**mke2fs**(8). This option implies
**plain**.

WARNING: Using the
**tmp**
option will destroy the contents of the named partition during every boot, so make sure the underlying block device is specified correctly.

**tries=**
Specifies the maximum number of times the user is queried for a password. The default is 3. If set to 0, the user is queried for a password indefinitely.

**verify**
If the encryption password is read from console, it has to be entered twice to prevent typos.

**x-systemd.device-timeout=**
Specifies how long systemd should wait for a device to show up before giving up on the entry. The argument is a time in seconds or explicitly specified units of
"s",
"min",
"h",
"ms".

At early boot and when the system manager configuration is reloaded, this file is translated into native systemd units by
**systemd-cryptsetup-generator**(8).

<a name="example"></a>

# Example


**Example&nbsp;1.&nbsp;/etc/crypttab example**

Set up four encrypted block devices. One using LUKS for normal storage, another one for usage as a swap device and two TrueCrypt volumes.

.if n \{.RS 4
.\}
    luks       UUID=2505567a-9e27-4efe-a4d5-15ad146c258b
    swap       /dev/sda7       /dev/urandom       swap
    truecrypt  /dev/sda2       /etc/container_password  tcrypt
    hidden     /mnt/tc_hidden  /dev/null    tcrypt-hidden,tcrypt-keyfile=/etc/keyfile
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-cryptsetup@.service**(8),
**systemd-cryptsetup-generator**(8),
**fstab**(5),
**cryptsetup**(8),
**mkswap**(8),
**mke2fs**(8)
