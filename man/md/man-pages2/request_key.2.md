# request_key(2) - request a key from the kernel's key management facility

Linux, 2017-09-15

    #include <sys/types.h>
    #include <keyutils.h>
    
    key_serial_t request_key(const char *type, const char *description,
                             const char *callout_info,
                             key_serial_t dest_keyring);
```

 No glibc wrapper is provided for this system call; see NOTES.
```

<a name="description"></a>

# Description

**request_key**()
attempts to find a key of the given
_type_
with a description (name) that matches the specified
_description_.
If such a key could not be found, then the key is optionally created.
If the key is found or created,
**request_key**()
attaches it to the keyring whose ID is specified in
_dest_keyring_
and returns the key's serial number.

**request_key**()
first recursively searches for a matching key in all of the keyrings
attached to the calling process.
The keyrings are searched in the order: thread-specific keyring,
process-specific keyring, and then session keyring.

If
**request_key**()
is called from a program invoked by
**request_key**()
on behalf of some other process to generate a key, then the keyrings of that
other process will be searched next,
using that other process's user ID, group ID,
supplementary group IDs, and security context to determine access.




The search of the keyring tree is breadth-first:
the keys in each keyring searched are checked for a match before any child
keyrings are recursed into.
Only keys for which the caller has
_search_
permission be found, and only keyrings for which the caller has
_search_
permission may be searched.

If the key is not found and
_callout_
is NULL, then the call fails with the error
**ENOKEY**.

If the key is not found and
_callout_
is not NULL, then the kernel attempts to invoke a user-space
program to instantiate the key.
The details are given below.

The
_dest_keyring_
serial number may be that of a valid keyring for which the caller has
_write_
permission, or it may be one of the following special keyring IDs:

* **KEY_SPEC_THREAD_KEYRING**  
  This specifies the caller's thread-specific keyring (see
  **thread-keyring**(7)).
* **KEY_SPEC_PROCESS_KEYRING**  
  This specifies the caller's process-specific keyring (see
  **process-keyring**(7)).
* **KEY_SPEC_SESSION_KEYRING**  
  This specifies the caller's session-specific keyring (see
  **session-keyring**(7)).
* **KEY_SPEC_USER_KEYRING**  
  This specifies the caller's UID-specific keyring (see
  **user-keyring**(7)).
* **KEY_SPEC_USER_SESSION_KEYRING**  
  This specifies the caller's UID-session keyring (see
  **user-session-keyring**(7)).

When the
_dest_keyring_
is specified as 0
and no key construction has been performed,
then no additional linking is done.

Otherwise, if
_dest_keyring_
is 0 and a new key is constructed, the new key will be linked
to the "default" keyring.
More precisely, when the kernel tries to determine to which keyring the
newly constructed key should be linked,
it tries the following keyrings,
beginning with the keyring set via the
**keyctl**(2)
**KEYCTL_SET_REQKEY_KEYRING**
operation and continuing in the order shown below
until it finds the first keyring that exists:

* ·  
  
  The requestor keyring
  (**KEY_REQKEY_DEFL_REQUESTOR_KEYRING**,
  since Linux 2.6.29).
  
  
  
  
  
* ·  
  The thread-specific keyring
  (**KEY_REQKEY_DEFL_THREAD_KEYRING**;
  see
  **thread-keyring**(7)).
* ·  
  The process-specific keyring
  (**KEY_REQKEY_DEFL_PROCESS_KEYRING**;
  see
  **process-keyring**(7)).
* ·  
  The session-specific keyring
  (**KEY_REQKEY_DEFL_SESSION_KEYRING**;
  see
  **session-keyring**(7)).
* ·  
  The session keyring for the process's user ID
  (**KEY_REQKEY_DEFL_USER_SESSION_KEYRING**;
  see
  **user-session-keyring**(7)).
  This keyring is expected to always exist.
* ·  
  The UID-specific keyring
  (**KEY_REQKEY_DEFL_USER_KEYRING**;
  see
  **user-keyring**(7)).
  This keyring is also expected to always exist.
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

If the
**keyctl**(2)
**KEYCTL_SET_REQKEY_KEYRING**
operation specifies
**KEY_REQKEY_DEFL_DEFAULT**
(or no
**KEYCTL_SET_REQKEY_KEYRING**
operation is performed),
then the kernel looks for a keyring
starting from the beginning of the list.


<a name="requesting-user-space-instantiation-of-a-key"></a>

### Requesting user-space instantiation of a key

If the kernel cannot find a key matching
_type_
and
_description_,
and
_callout_
is not NULL, then the kernel attempts to invoke a user-space
program to instantiate a key with the given
_type_
and
_description_.
In this case, the following steps are performed:

* a)  
  The kernel creates an uninstantiated key, U, with the requested
  _type_
  and
  _description_.
* b)  
  The kernel creates an authorization key, V,
  
  that refers to the key U and records the facts that the caller of
  **request_key**()
  is:
    * (1)  
      the context in which the key U should be instantiated and secured, and
    * (2)  
      the context from which associated key requests may be satisfied.
* The authorization key is constructed as follows:
    * *  
      The key type is
      _""_.request_key_auth_""_.
    * *  
      The key's UID and GID are the same as the corresponding filesystem IDs
      of the requesting process.
    * *  
      The key grants
      _view_,
      _read_,
      and
      _search_
      permissions to the key possessor as well as
      _view_
      permission for the key user.
    * *  
      The description (name) of the key is the hexadecimal
      string representing the ID of the key that is to be instantiated
      in the requesting program.
    * *  
      The payload of the key is taken from the data specified in
      _callout_info_.
    * *  
      Internally, the kernel also records the PID of the process that called
      **request_key**().
* c)  
  The kernel creates a process that executes a user-space service such as
  **request-key**(8)
  with a new session keyring that contains a link to the authorization key, V.
  
  
  
* This program is supplied with the following command-line arguments:
    * [0]  
      The string
      _""_/sbin/request-key_""_.
    * [1]  
      The string
      _"" create ""_
      (indicating that a key is to be created).
    * [2]  
      The ID of the key that is to be instantiated.
    * [3]  
      The filesystem UID of the caller of
      **request_key**().
    * [4]  
      The filesystem GID of the caller of
      **request_key**().
    * [5]  
      The ID of the thread keyring of the caller of
      **request_key**().
      This may be zero if that keyring hasn't been created.
    * [6]  
      The ID of the process keyring of the caller of
      **request_key**().
      This may be zero if that keyring hasn't been created.
    * [7]  
      The ID of the session keyring of the caller of
      **request_key**().
* _Note_:
  each of the command-line arguments that is a key ID is encoded in
  _decimal_
  (unlike the key IDs shown in
  _/proc/keys_,
  which are shown as hexadecimal values).
* d)  
  The program spawned in the previous step:
    * *  
      Assumes the authority to instantiate the key U using the
      **keyctl**(2)
      **KEYCTL_ASSUME_AUTHORITY**
      operation (typically via the
      **keyctl_assume_authority**(3)
      function).
    * *  
      Obtains the callout data from the payload of the authorization key V
      (using the
      **keyctl**(2)
      **KEYCTL_READ**
      operation (or, more commonly, the
      **keyctl_read**(3)
      function) with a key ID value of
      **KEY_SPEC_REQKEY_AUTH_KEY**).
    * *  
      Instantiates the key
      (or execs another program that performs that task),
      specifying the payload and destination keyring.
      (The destination keyring that the requestor specified when calling
      **request_key**()
      can be accessed using the special key ID
      **KEY_SPEC_REQUESTOR_KEYRING**.)
      
      
      
      
      
      Instantiation is performed using the
      **keyctl**(2)
      **KEYCTL_INSTANTIATE**
      operation (or, more commonly, the
      **keyctl_instantiate**(3)
      function).
      At this point, the
      **request_key**()
      call completes, and the requesting program can continue execution.

If these steps are unsuccessful, then an
**ENOKEY**
error will be returned to the caller of
**request_key**()
and a temporary, negatively instantiated key will be installed
in the keyring specified by
_dest_keyring_.
This will expire after a few seconds, but will cause subsequent calls to
**request_key**()
to fail until it does.
The purpose of this negatively instantiated key is to prevent
(possibly different) processes making repeated requests
(that require expensive
**request-key**(8)
upcalls) for a key that can't (at the moment) be positively instantiated.

Once the key has been instantiated, the authorization key
(**KEY_SPEC_REQKEY_AUTH_KEY**)
is revoked, and the destination keyring
(**KEY_SPEC_REQUESTOR_KEYRING**)
is no longer accessible from the
**request-key**(8)
program.

If a key is created, then—regardless of whether it is a valid key or
a negatively instantiated key—it will displace any other key with
the same type and description from the keyring specified in
_dest_keyring_.

<a name="return-value"></a>

# Return Value

On success,
**request_key**()
returns the serial number of the key it found or caused to be created.
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
  One of
  _type_,
  _description_,
  or
  _callout_info_
  points outside the process's accessible address space.
* **EINTR**  
  The request was interrupted by a signal; see
  **signal**(7).
* **EINVAL**  
  The size of the string (including the terminating null byte) specified in
  _type_
  or
  _description_
  exceeded the limit (32 bytes and 4096 bytes respectively).
* **EINVAL**  
  The size of the string (including the terminating null byte) specified in
  _callout_info_
  exceeded the system page size.
* **EKEYEXPIRED**  
  An expired key was found, but no replacement could be obtained.
* **EKEYREJECTED**  
  The attempt to generate a new key was rejected.
* **EKEYREVOKED**  
  A revoked key was found, but no replacement could be obtained.
* **ENOKEY**  
  No matching key was found.
* **ENOMEM**  
  Insufficient memory to create a key.
* **EPERM**  
  The
  _type_
  argument started with a period ('.').

<a name="versions"></a>

# Versions

This system call first appeared in Linux 2.6.10.
The ability to instantiate keys upon request was added

in Linux 2.6.13.

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

The program below demonstrates the use of
**request_key**().
The
_type_,
_description_,
and
_callout_info_
arguments for the system call are taken from the values
supplied in the command-line arguments.
The call specifies the session keyring as the target keyring.

In order to demonstrate this program,
we first create a suitable entry in the file
_/etc/request-key.conf_.

.in +4n
.EX
$ sudo sh
# **echo 'create user mtk:* *   /bin/keyctl instantiate %k %c %S' \\**
          **&gt; /etc/request-key.conf**
# **exit**
.EE
.in

This entry specifies that when a new "user" key with the prefix
"mtk:" must be instantiated, that task should be performed via the
**keyctl**(1)
command's
**instantiate**
operation.
The arguments supplied to the
**instantiate**
operation are:
the ID of the uninstantiated key
(_%k_);
the callout data supplied to the
**request_key**()
call
(_%c_);
and the session keyring
(_%S_)
of the requestor (i.e., the caller of
**request_key**()).
See
**request-key.conf**(5)
for details of these
_%_
specifiers.

Then we run the program and check the contents of
_/proc/keys_
to verify that the requested key has been instantiated:

.in +4n
.EX
$ **./t_request_key user mtk:key1 "Payload data"**
$ **grep '2dddaf50' /proc/keys**
2dddaf50 I--Q---  1 perm 3f010000  1000  1000 user  mtk:key1: 12
.EE
.in

For another example of the use of this program, see
**keyctl**(2).

<a name="program-source"></a>

### Program source


.EX
/* t_request_key.c */

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
        fprintf(stderr, "Usage: %s type description callout-data\\n",
                argv[0]);
        exit(EXIT_FAILURE);
    }

    key = request_key(argv[1], argv[2], argv[3],
                      KEY_SPEC_SESSION_KEYRING);
    if (key == -1) {
        perror("request_key");
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
**add_key**(2),
**keyctl**(2),
**keyctl**(3),
**capabilities**(7),
**keyrings**(7),
**keyutils**(7),
**persistent-keyring**(7),
**process-keyring**(7),
**session-keyring**(7),
**thread-keyring**(7),
**user-keyring**(7),
**user-session-keyring**(7),
**request-key**(8)

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
