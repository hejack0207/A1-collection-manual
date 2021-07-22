# add_key(2) - add a key to the kernel's key management facility

Linux, 2017-09-15

    #include <sys/types.h>
    #include <keyutils.h>
    
    key_serial_t add_key(const char *type, const char *description,
                         const void *payload, size_t plen,
                         key_serial_t keyring);
```

 No glibc wrapper is provided for this system call; see NOTES.
```

<a name="description"></a>

# Description

**add_key**()
creates or updates a key of the given
_type_
and
_description_,
instantiates it with the
_payload_
of length
_plen_,
attaches it to the nominated
_keyring_,
and returns the key's serial number.

The key may be rejected if the provided data is in the wrong format or
it is invalid in some other way.

If the destination
_keyring_
already contains a key that matches the specified
_type_
and
_description_,
then, if the key type supports it,


that key will be updated rather than a new key being created;
if not, a new key (with a different ID) will be created
and it will displace the link to the extant key from the keyring.






The destination
_keyring_
serial number may be that of a valid keyring for which the caller has
_write_
permission.
Alternatively, it may be one of the following special keyring IDs:


* **KEY_SPEC_THREAD_KEYRING**  
  This specifies the caller's thread-specific keyring
  (**thread-keyring**(7)).
* **KEY_SPEC_PROCESS_KEYRING**  
  This specifies the caller's process-specific keyring
  (**process-keyring**(7)).
* **KEY_SPEC_SESSION_KEYRING**  
  This specifies the caller's session-specific keyring
  (**session-keyring**(7)).
* **KEY_SPEC_USER_KEYRING**  
  This specifies the caller's UID-specific keyring
  (**user-keyring**(7)).
* **KEY_SPEC_USER_SESSION_KEYRING**  
  This specifies the caller's UID-session keyring
  (**user-session-keyring**(7)).

<a name="key-types"></a>

### Key types

The key
_type_
is a string that specifies the key's type.
Internally, the kernel defines a number of key types that are
available in the core key management code.
Among the types that are available for user-space use
and can be specified as the
_type_
argument to
**add_key**()
are the following:

* _"" keyring ""_  
  Keyrings are special key types that may contain links to sequences of other
  keys of any type.
  If this interface is used to create a keyring, then
  _payload_
  should be NULL and
  _plen_
  should be zero.
* _""_user_""_  
  This is a general purpose key type whose payload may be read and updated
  by user-space applications.
  The key is kept entirely within kernel memory.
  The payload for keys of this type is a blob of arbitrary data
  of up to 32,767 bytes.
* _""_logon_""_ (since Linux 3.3)  
  
  This key type is essentially the same as
  _""_user_""_,
  but it does not permit the key to read.
  This is suitable for storing payloads
  that you do not want to be readable from user space.

This key type vets the
_description_
to ensure that it is qualified by a "service" prefix,
by checking to ensure that the
_description_
contains a ':' that is preceded by other characters.

* _""_big_key_""_ (since Linux 3.13)  
  
  This key type is similar to
  _""_user_""_,
  but may hold a payload of up to 1&nbsp;MiB.
  If the key payload is large enough,
  then it may be stored encrypted in tmpfs
  (which can be swapped out) rather than kernel memory.

For further details on these key types, see
**keyrings**(7).

<a name="return-value"></a>

# Return Value

On success,
**add_key**()
returns the serial number of the key it created or updated.
On error, -1 is returned and
_errno_
is set to indicate the cause of the error.

<a name="errors"></a>

# Errors


* **EACCES**  
  The keyring wasn't available for modification by the user.
* **EDQUOT**  
  The key quota for this user would be exceeded by creating this key or linking
  it to the keyring.
* **EFAULT**  
  One or more of
  _type_,
  _description_,
  and
  _payload_
  points outside process's accessible address space.
* **EINVAL**  
  The size of the string (including the terminating null byte) specified in
  _type_
  or
  _description_
  exceeded the limit (32 bytes and 4096 bytes respectively).
* **EINVAL**  
  The payload data was invalid.
* **EINVAL**  
  _type_
  was
  _""_logon_""_
  and the
  _description_
  was not qualified with a prefix string of the form
  _""_service:_""_.
* **EKEYEXPIRED**  
  The keyring has expired.
* **EKEYREVOKED**  
  The keyring has been revoked.
* **ENOKEY**  
  The keyring doesn't exist.
* **ENOMEM**  
  Insufficient memory to create a key.
* **EPERM**  
  The
  _type_
  started with a period ('.').
  Key types that begin with a period are reserved to the implementation.
* **EPERM**  
  _type_
  was
  _"" keyring ""_
  and the
  _description_
  started with a period ('.').
  Keyrings with descriptions (names)
  that begin with a period are reserved to the implementation.

<a name="versions"></a>

# Versions

This system call first appeared in Linux 2.6.10.

<a name="conforming-to"></a>

# Conforming to

This system call is a nonstandard Linux extension.

<a name="notes"></a>

# Notes

No wrapper for this system call is provided in glibc.
A wrapper is provided in the
_libkeyutils_
package.
When employing the wrapper in that library, link with
_-lkeyutils_.

<a name="example"></a>

# Example

The program below creates a key with the type, description, and payload
specified in its command-line arguments,
and links that key into the session keyring.
The following shell session demonstrates the use of the program:

.in +4n
.EX
$ **./a.out user mykey "Some payload"**
Key ID is 64a4dca
$ **grep '64a4dca' /proc/keys**
064a4dca I--Q---    1 perm 3f010000  1000  1000 user    mykey: 12
.EE
.in

<a name="program-source"></a>

### Program source


.EX
#include &lt;sys/types.h&gt;
#include &lt;keyutils.h&gt;
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;string.h&gt;

int
main(int argc, char *argv[])
{
    key_serial_t key;

    if (argc != 4) {
        fprintf(stderr, "Usage: %s type description payload\\n",
                argv[0]);
        exit(EXIT_FAILURE);
    }

    key = add_key(argv[1], argv[2], argv[3], strlen(argv[3]),
                KEY_SPEC_SESSION_KEYRING);
    if (key == -1) {
        perror("add_key");
        exit(EXIT_FAILURE);
    }

    printf("Key ID is %lx\\n", (long) key);

    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

.nh
**keyctl**(1),
**keyctl**(2),
**request_key**(2),
**keyctl**(3),
**keyrings**(7),
**keyutils**(7),
**persistent-keyring**(7),
**process-keyring**(7),
**session-keyring**(7),
**thread-keyring**(7),
**user-keyring**(7),
**user-session-keyring**(7)

The kernel source files
_Documentation/security/keys/core.rst_
and
_Documentation/keys/request-key.rst_
(or, before Linux 4.13, in the files

_Documentation/security/keys.txt_
and

_Documentation/security/keys-request-key.txt_).

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
