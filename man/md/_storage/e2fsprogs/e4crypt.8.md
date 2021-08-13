# e4crypt(8) - ext4 filesystem encryption utility

E2fsprogs version 1.45.6, March 2020

```
e4crypt add_key -S [ -k keyring ] [-v] [-q] [ -p pad ] [ path ... ]
e4crypt new_session
e4crypt get_policy path ...
e4crypt set_policy [ -p pad ] policy path ...
```

<a name="description"></a>

# Description

**e4crypt**
performs encryption management for ext4 file systems.

<a name="commands"></a>

# Commands


* **e4crypt add_key [**-vq**] [**-S_ salt** ] [**-k keyring** ] [** -p pad** ] [ path_ ... ]**  
  Prompts the user for a passphrase and inserts it into the specified
  keyring.  If no keyring is specified, e4crypt will use the session
  keyring if it exists or the user session keyring if it does not.
* The
  _salt_
  argument is interpreted in a number of different ways, depending on how
  its prefix value.  If the first two characters are "s:", then the rest
  of the argument will be used as an text string and used as the salt
  value.  If the first two characters are "0x", then the rest of the
  argument will be parsed as a hex string as used as the salt.  If the
  first characters are "f:" then the rest of the argument will be
  interpreted as a filename from which the salt value will be read.  If
  the string begins with a '/' character, it will similarly be treated as
  filename.  Finally, if the
  _salt_
  argument can be parsed as a valid UUID, then the UUID value will be used
  as a salt value.
* The
  _keyring_
  argument specifies the keyring to which the key should be added.
* The
  _pad_
  value specifies the number of bytes of padding will be added to
  directory names for obfuscation purposes.  Valid
  _pad_
  values are 4, 8, 16, and 32.
* If one or more directory paths are specified, e4crypt will try to
  set the policy of those directories to use the key just added by the
  **add_key**
  command.
* **e4crypt get_policy _path_ ...**  
  Print the policy for the directories specified on the command line.
* **e4crypt new_session**  
  Give the invoking process (typically a shell) a new session keyring,
  discarding its old session keyring.
* **e4crypt set_policy [** -p _pad** ] policy path_ ...**  
  Sets the policy for the directories specified on the command line.
  All directories must be empty to set the policy; if the directory
  already has a policy established, e4crypt will validate that the
  policy matches what was specified.  A policy is an encryption key
  identifier consisting of 16 hexadecimal characters.

<a name="author"></a>

# Author

Written by Michael Halcrow &lt;[mhalcrow@google.com](mailto:mhalcrow@google.com)&gt;, Ildar Muslukhov
&lt;[muslukhovi@gmail.com](mailto:muslukhovi@gmail.com)&gt;, and Theodore Ts'o &lt;tytso@mit.edu&gt;

<a name="see-also"></a>

# See Also

**keyctl**(1),
**mke2fs**(8),
**mount**(8).
