# keyctl(2) - manipulate the kernel's key management facility

Linux, 2017-09-15

    #include <sys/types.h>
    #include <keyutils.h>
    
    long keyctl(int operation, ...)
    
    "/* For direct call via syscall(2): */"
    #include <asm/unistd.h>
    #include <linux/keyctl.h>
    #include <unistd.h>
    
    long syscall(__NR_keyctl, int operation, __kernel_ulong_t arg2,
                 __kernel_ulong_t arg3, __kernel_ulong_t arg4,
                 __kernel_ulong_t arg5);
```

 No glibc wrapper is provided for this system call; see NOTES.
```

<a name="description"></a>

# Description

**keyctl**()
allows user-space programs to perform key manipulation.

The operation performed by
**keyctl**()
is determined by the value of the
_operation_
argument.
Each of these operations is wrapped by the
_libkeyutils_
library (provided by the
_keyutils_
package) into individual functions (noted below)
to permit the compiler to check types.

The permitted values for
_operation_
are:

* **KEYCTL_GET_KEYRING_ID** (since Linux 2.6.10)  
  Map a special key ID to a real key ID for this process.
* This operation looks up the special key whose ID is provided in
  _arg2_
  (cast to
  _key_serial_t_).
  If the special key is found,
  the ID of the corresponding real key is returned as the function result.
  The following values may be specified in
  _arg2_:
    * **KEY_SPEC_THREAD_KEYRING**  
      This specifies the calling thread's thread-specific keyring.
      See
      **thread-keyring**(7).
    * **KEY_SPEC_PROCESS_KEYRING**  
      This specifies the caller's process-specific keyring.
      See
      **process-keyring**(7).
    * **KEY_SPEC_SESSION_KEYRING**  
      This specifies the caller's session-specific keyring.
      See
      **session-keyring**(7).
    * **KEY_SPEC_USER_KEYRING**  
      This specifies the caller's UID-specific keyring.
      See
      **user-keyring**(7).
    * **KEY_SPEC_USER_SESSION_KEYRING**  
      This specifies the caller's UID-session keyring.
      See
      **user-session-keyring**(7).
    * **KEY_SPEC_REQKEY_AUTH_KEY** (since Linux 2.6.16)  
      
      This specifies the authorization key created by
      **request_key**(2)
      and passed to the process it spawns to generate a key.
      This key is available only in a
      **request-key**(8)-style
      program that was passed an authorization key by the kernel and
      ceases to be available once the requested key has been instantiated; see
      **request_key**(2).
    * **KEY_SPEC_REQUESTOR_KEYRING** (since Linux 2.6.29)  
      
      This specifies the key ID for the
      **request_key**(2)
      destination keyring.
      This keyring is available only in a
      **request-key**(8)-style
      program that was passed an authorization key by the kernel and
      ceases to be available once the requested key has been instantiated; see
      **request_key**(2).
* The behavior if the key specified in
  _arg2_
  does not exist depends on the value of
  _arg3_
  (cast to
  _int_).
  If
  _arg3_
  contains a nonzero value, then—if it is appropriate to do so
  (e.g., when looking up the user, user-session, or session key)—a new key
  is created and its real key ID returned as the function result.
  
  
  
  
  
  
  Otherwise, the operation fails with the error
  **ENOKEY**.
* If a valid key ID is specified in
  _arg2_,
  and the key exists, then this operation simply returns the key ID.
  If the key does not exist, the call fails with error
  **ENOKEY**.
* The caller must have
  _search_
  permission on a keyring in order for it to be found.
* The arguments
  _arg4_
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_get_keyring_ID**(3).
* **KEYCTL_JOIN_SESSION_KEYRING** (since Linux 2.6.10)  
  Replace the session keyring this process subscribes to with
  a new session keyring.
  
  
* If
  _arg2_
  is NULL,
  an anonymous keyring with the description "_ses" is created
  and the process is subscribed to that keyring as its session keyring,
  displacing the previous session keyring.
* Otherwise,
  _arg2_
  (cast to
  _char&nbsp;*_)
  is treated as the description (name) of a keyring,
  and the behavior is as follows:
    * *  
      If a keyring with a matching description exists,
      the process will attempt to subscribe to that keyring
      as its session keyring if possible;
      if that is not possible, an error is returned.
      In order to subscribe to the keyring,
      the caller must have
      _search_
      permission on the keyring.
    * *  
      If a keyring with a matching description does not exist,
      then a new keyring with the specified description is created,
      and the process is subscribed to that keyring as its session keyring.
* The arguments
  _arg3_,
  _arg4_,
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_join_session_keyring**(3).
* **KEYCTL_UPDATE** (since Linux 2.6.10)  
  Update a key's data payload.
* The
  _arg2_
  argument (cast to
  _key_serial_t_)
  specifies the ID of the key to be updated.
  The
  _arg3_
  argument (cast to
  _void&nbsp;*_)
  points to the new payload and
  _arg4_
  (cast to
  _size_t_)
  contains the new payload size in bytes.
* The caller must have
  _write_
  permission on the key specified and the key type must support updating.
* A negatively instantiated key (see the description of
  **KEYCTL_REJECT**)
  can be positively instantiated with this operation.
* The
  _arg5_
  argument is ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_update**(3).
* **KEYCTL_REVOKE** (since Linux 2.6.10)  
  Revoke the key with the ID provided in
  _arg2_
  (cast to
  _key_serial_t_).
  The key is scheduled for garbage collection;
  it will no longer be findable,
  and will be unavailable for further operations.
  Further attempts to use the key will fail with the error
  **EKEYREVOKED**.
* The caller must have
  _write_
  or
  _setattr_
  permission on the key.
  
  
  
* The arguments
  _arg3_,
  _arg4_,
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_revoke**(3).
* **KEYCTL_CHOWN** (since Linux 2.6.10)  
  Change the ownership (user and group ID) of a key.
* The
  _arg2_
  argument (cast to
  _key_serial_t_)
  contains the key ID.
  The
  _arg3_
  argument (cast to
  _uid_t_)
  contains the new user ID (or -1 in case the user ID shouldn't be changed).
  The
  _arg4_
  argument (cast to
  _gid_t_)
  contains the new group ID (or -1 in case the group ID shouldn't be changed).
* The key must grant the caller
  _setattr_
  permission.
* For the UID to be changed, or for the GID to be changed to a group
  the caller is not a member of, the caller must have the
  **CAP_SYS_ADMIN**
  capability (see
  **capabilities**(7)).
* If the UID is to be changed, the new user must have sufficient
  quota to accept the key.
  The quota deduction will be removed from the old user
  to the new user should the UID be changed.
* The
  _arg5_
  argument is ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_chown**(3).
* **KEYCTL_SETPERM** (since Linux 2.6.10)  
  Change the permissions of the key with the ID provided in the
  _arg2_
  argument (cast to
  _key_serial_t_)
  to the permissions provided in the
  _arg3_
  argument (cast to
  _key_perm_t_).
* If the caller doesn't have the
  **CAP_SYS_ADMIN**
  capability, it can change permissions only for the keys it owns.
  (More precisely: the caller's filesystem UID must match the UID of the key.)
* The key must grant
  _setattr_
  permission to the caller
  _regardless_
  of the caller's capabilities.
  
  
* The permissions in
  _arg3_
  specify masks of available operations
  for each of the following user categories:
    * _possessor_ (since Linux 2.6.14)  
      
      This is the permission granted to a process that possesses the key
      (has it attached searchably to one of the process's keyrings);
      see
      **keyrings**(7).
    * _user_  
      This is the permission granted to a process
      whose filesystem UID matches the UID of the key.
    * _group_  
      This is the permission granted to a process
      whose filesystem GID or any of its supplementary GIDs
      matches the GID of the key.
    * _other_  
      This is the permission granted to other processes
      that do not match the
      _user_
      and
      _group_
      categories.
* The
  _user_,
  _group_,
  and
  _other_
  categories are exclusive: if a process matches the
  _user_
  category, it will not receive permissions granted in the
  _group_
  category; if a process matches the
  _user_
  or
  _group_
  category, then it will not receive permissions granted in the
  _other_
  category.
* The
  _possessor_
  category grants permissions that are cumulative with the grants from the
  _user_,
  _group_,
  or
  _other_
  category.
* Each permission mask is eight bits in size,
  with only six bits currently used.
  The available permissions are:
    * _view_  
      This permission allows reading attributes of a key.
    * This permission is required for the
      **KEYCTL_DESCRIBE**
      operation.
    * The permission bits for each category are
      **KEY_POS_VIEW**,
      **KEY_USR_VIEW**,
      **KEY_GRP_VIEW**,
      and
      **KEY_OTH_VIEW**.
    * _read_  
      This permission allows reading a key's payload.
    * This permission is required for the
      **KEYCTL_READ**
      operation.
    * The permission bits for each category are
      **KEY_POS_READ**,
      **KEY_USR_READ**,
      **KEY_GRP_READ**,
      and
      **KEY_OTH_READ**.
    * _write_  
      This permission allows update or instantiation of a key's payload.
      For a keyring, it allows keys to be linked and unlinked from the keyring,
    * This permission is required for the
      **KEYCTL_UPDATE**,
      **KEYCTL_REVOKE**,
      **KEYCTL_CLEAR**,
      **KEYCTL_LINK**,
      and
      **KEYCTL_UNLINK**
      operations.
    * The permission bits for each category are
      **KEY_POS_WRITE**,
      **KEY_USR_WRITE**,
      **KEY_GRP_WRITE**,
      and
      **KEY_OTH_WRITE**.
    * _search_  
      This permission allows keyrings to be searched and keys to be found.
      Searches can recurse only into nested keyrings that have
      _search_
      permission set.
    * This permission is required for the
      **KEYCTL_GET_KEYRING_ID**,
      **KEYCTL_JOIN_SESSION_KEYRING**,
      **KEYCTL_SEARCH**,
      and
      **KEYCTL_INVALIDATE**
      operations.
    * The permission bits for each category are
      **KEY_POS_SEARCH**,
      **KEY_USR_SEARCH**,
      **KEY_GRP_SEARCH**,
      and
      **KEY_OTH_SEARCH**.
    * _link_  
      This permission allows a key or keyring to be linked to.
    * This permission is required for the
      **KEYCTL_LINK**
      and
      **KEYCTL_SESSION_TO_PARENT**
      operations.
    * The permission bits for each category are
      **KEY_POS_LINK**,
      **KEY_USR_LINK**,
      **KEY_GRP_LINK**,
      and
      **KEY_OTH_LINK**.
    * _setattr_ (since Linux 2.6.15).  
      This permission allows a key's UID, GID, and permissions mask to be changed.
    * This permission is required for the
      **KEYCTL_REVOKE**,
      **KEYCTL_CHOWN**,
      and
      **KEYCTL_SETPERM**
      operations.
    * The permission bits for each category are
      **KEY_POS_SETATTR**,
      **KEY_USR_SETATTR**,
      **KEY_GRP_SETATTR**,
      and
      **KEY_OTH_SETATTR**.
* As a convenience, the following macros are defined as masks for
  all of the permission bits in each of the user categories:
  **KEY_POS_ALL**,
  **KEY_USR_ALL,**
  **KEY_GRP_ALL**,
  and
  **KEY_OTH_ALL**.
* The
  _arg4_ and _arg5_
  arguments are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_setperm**(3).
* **KEYCTL_DESCRIBE** (since Linux 2.6.10)  
  Obtain a string describing the attributes of a specified key.
* The ID of the key to be described is specified in
  _arg2_
  (cast to
  _key_serial_t_).
  The descriptive string is returned in the buffer pointed to by
  _arg3_
  (cast to
  _char&nbsp;*_);
  _arg4_
  (cast to
  _size_t_)
  specifies the size of that buffer in bytes.
* The key must grant the caller
  _view_
  permission.
* The returned string is null-terminated and
  contains the following information about the key:
* .in +4n
  _type_;_uid_;_gid_;_perm_;_description_
  .in
* In the above,
  _type_
  and
  _description_
  are strings,
  _uid_
  and
  _gid_
  are decimal strings, and
  _perm_
  is a hexadecimal permissions mask.
  The descriptive string is written with the following format:
*     %s;%d;%d;%08x;%s
* **Note: the intention is that the descriptive string should**
  **be extensible in future kernel versions**.
  In particular, the
  _description_
  field will not contain semicolons;
  
  
  
  
  
  it should be parsed by working backwards from the end of the string
  to find the last semicolon.
  This allows future semicolon-delimited fields to be inserted
  in the descriptive string in the future.
* Writing to the buffer is attempted only when
  _arg3_
  is non-NULL and the specified buffer size
  is large enough to accept the descriptive string
  (including the terminating null byte).
  '
  '
  '
  In order to determine whether the buffer size was too small,
  check to see if the return value of the operation is greater than
  _arg4_.
* The
  _arg5_
  argument is ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_describe**(3).
* **KEYCTL_CLEAR**  
  Clear the contents of (i.e., unlink all keys from) a keyring.
* The ID of the key
  (which must be of keyring type)
  
  is provided in
  _arg2_
  (cast to
  _key_serial_t_).
  
  
  
  
* The caller must have
  _write_
  permission on the keyring.
* The arguments
  _arg3_,
  _arg4_,
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_clear**(3).
* **KEYCTL_LINK** (since Linux 2.6.10)  
  Create a link from a keyring to a key.
* The key to be linked is specified in
  _arg2_
  (cast to
  _key_serial_t_);
  the keyring is specified in
  _arg3_
  (cast to
  _key_serial_t_).
* If a key with the same type and description is already linked in the keyring,
  then that key is displaced from the keyring.
* Before creating the link,
  the kernel checks the nesting of the keyrings and returns appropriate errors
  if the link would produce a cycle
  or if the nesting of keyrings would be too deep
  (The limit on the nesting of keyrings is determined by the kernel constant
  **KEYRING_SEARCH_MAX_DEPTH**,
  defined with the value 6, and is necessary to prevent overflows
  on the kernel stack when recursively searching keyrings).
* The caller must have
  _link_
  permission on the key being added and
  _write_
  permission on the keyring.
* The arguments
  _arg4_
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_link**(3).
* **KEYCTL_UNLINK** (since Linux 2.6.10)  
  Unlink a key from a keyring.
* The ID of the key to be unlinked is specified in
  _arg2_
  (cast to
  _key_serial_t_);
  the ID of the keyring from which it is to be unlinked is specified in
  _arg3_
  (cast to
  _key_serial_t_).
* If the key is not currently linked into the keyring, an error results.
* The caller must have
  _write_
  permission on the keyring from which the key is being removed.
* If the last link to a key is removed,
  then that key will be scheduled for destruction.
* The arguments
  _arg4_
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_unlink**(3).
* **KEYCTL_SEARCH** (since Linux 2.6.10)  
  Search for a key in a keyring tree,
  returning its ID and optionally linking it to a specified keyring.
* The tree to be searched is specified by passing
  the ID of the head keyring in
  _arg2_
  (cast to
  _key_serial_t_).
  The search is performed breadth-first and recursively.
* The
  _arg3_
  and
  _arg4_
  arguments specify the key to be searched for:
  _arg3_
  (cast as
  _char&nbsp;*_)
  contains the key type
  (a null-terminated character string up to 32 bytes in size,
  including the terminating null byte), and
  _arg4_
  (cast as
  _char&nbsp;*_)
  contains the description of the key
  (a null-terminated character string up to 4096 bytes in size,
  including the terminating null byte).
* The source keyring must grant
  _search_
  permission to the caller.
  When performing the recursive search, only keyrings that grant the caller
  _search_
  permission will be searched.
  Only keys with for which the caller has
  _search_
  permission can be found.
* If the key is found, its ID is returned as the function result.
* If the key is found and
  _arg5_
  (cast to
  _key_serial_t_)
  is nonzero, then, subject to the same constraints and rules as
  **KEYCTL_LINK**,
  the key is linked into the keyring whose ID is specified in
  _arg5_.
  If the destination keyring specified in
  _arg5_
  already contains a link to a key that has the same type and description,
  then that link will be displaced by a link to
  the key found by this operation.
* Instead of valid existing keyring IDs, the source
  (_arg2_)
  and destination
  (_arg5_)
  keyrings can be one of the special keyring IDs listed under
  **KEYCTL_GET_KEYRING_ID**.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_search**(3).
* **KEYCTL_READ** (since Linux 2.6.10)  
  Read the payload data of a key.
* The ID of the key whose payload is to be read is specified in
  _arg2_
  (cast to
  _key_serial_t_).
  This can be the ID of an existing key,
  or any of the special key IDs listed for
  **KEYCTL_GET_KEYRING_ID**.
  
* The payload is placed in the buffer pointed by
  _arg3_
  (cast to
  _char&nbsp;*_);
  the size of that buffer must be specified in
  _arg4_
  (cast to
  _size_t_).
* The returned data will be processed for presentation
  according to the key type.
  For example, a keyring will return an array of
  _key_serial_t_
  entries representing the IDs of all the keys that are linked to it.
  The
  _user_
  key type will return its data as is.
  If a key type does not implement this function,
  the operation fails with the error
  **EOPNOTSUPP**.
* If
  _arg3_
  is not NULL,
  as much of the payload data as will fit is copied into the buffer.
  On a successful return,
  the return value is always the total size of the payload data.
  To determine whether the buffer was of sufficient size,
  check to see that the return value is less than or equal to
  the value supplied in
  _arg4_.
* The key must either grant the caller
  _read_
  permission, or grant the caller
  _search_
  permission when searched for from the process keyrings
  (i.e., the key is possessed).
* The
  _arg5_
  argument is ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_read**(3).
* **KEYCTL_INSTANTIATE** (since Linux 2.6.10)  
  (Positively) instantiate an uninstantiated key with a specified payload.
* The ID of the key to be instantiated is provided in
  _arg2_
  (cast to
  _key_serial_t_).
* The key payload is specified in the buffer pointed to by
  _arg3_
  (cast to
  _void&nbsp;*_);
  the size of that buffer is specified in
  _arg4_
  (cast to
  _size_t_).
* The payload may be a NULL pointer and the buffer size may be 0
  if this is supported by the key type (e.g., it is a keyring).
* The operation may be fail if the payload data is in the wrong format
  or is otherwise invalid.
* If
  _arg5_
  (cast to
  _key_serial_t_)
  is nonzero, then, subject to the same constraints and rules as
  **KEYCTL_LINK**,
  the instantiated key is linked into the keyring whose ID specified in
  _arg5_.
* The caller must have the appropriate authorization key,
  and once the uninstantiated key has been instantiated,
  the authorization key is revoked.
  In other words, this operation is available only from a
  **request-key**(8)-style
  program.
  See
  **request_key**(2)
  for an explanation of uninstantiated keys and key instantiation.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_instantiate**(3).
* **KEYCTL_NEGATE** (since Linux 2.6.10)  
  Negatively instantiate an uninstantiated key.
* This operation is equivalent to the call:
*     keyctl(KEYCTL_REJECT, arg2, arg3, ENOKEY, arg4);
* The
  _arg5_
  argument is ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_negate**(3).
* **KEYCTL_SET_REQKEY_KEYRING** (since Linux 2.6.13)  
  Set the default keyring to which implicitly requested keys
  will be linked for this thread, and return the previous setting.
  Implicit key requests are those made by internal kernel components,
  
  
  
  such as can occur when, for example, opening files
  on an AFS or NFS filesystem.
  Setting the default keyring also has an effect when requesting
  a key from user space; see
  **request_key**(2)
  for details.
* The
  _arg2_
  argument (cast to
  _int_)
  should contain one of the following values,
  to specify the new default keyring:
    * **KEY_REQKEY_DEFL_NO_CHANGE**  
      Don't change the default keyring.
      This can be used to discover the current default keyring
      (without changing it).
    * **KEY_REQKEY_DEFL_DEFAULT**  
      This selects the default behaviour,
      which is to use the thread-specific keyring if there is one,
      otherwise the process-specific keyring if there is one,
      otherwise the session keyring if there is one,
      otherwise the UID-specific session keyring,
      otherwise the user-specific keyring.
    * **KEY_REQKEY_DEFL_THREAD_KEYRING**  
      Use the thread-specific keyring
      (**thread-keyring**(7))
      as the new default keyring.
    * **KEY_REQKEY_DEFL_PROCESS_KEYRING**  
      Use the process-specific keyring
      (**process-keyring**(7))
      as the new default keyring.
    * **KEY_REQKEY_DEFL_SESSION_KEYRING**  
      Use the session-specific keyring
      (**session-keyring**(7))
      as the new default keyring.
    * **KEY_REQKEY_DEFL_USER_KEYRING**  
      Use the UID-specific keyring
      (**user-keyring**(7))
      as the new default keyring.
    * **KEY_REQKEY_DEFL_USER_SESSION_KEYRING**  
      Use the UID-specific session keyring
      (**user-session-keyring**(7))
      as the new default keyring.
    * **KEY_REQKEY_DEFL_REQUESTOR_KEYRING** (since Linux 2.6.29)  
      '
      Use the requestor keyring.
      
      
      
      
      
      
      
* All other values are invalid.
  
* The arguments
  _arg3_,
  _arg4_,
  and
  _arg5_
  are ignored.
* The setting controlled by this operation is inherited by the child of
  **fork**(2)
  and preserved across
  **execve**(2).
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_set_reqkey_keyring**(3).
* **KEYCTL_SET_TIMEOUT** (since Linux 2.6.16)  
  Set a timeout on a key.
* The ID of the key is specified in
  _arg2_
  (cast to
  _key_serial_t_).
  The timeout value, in seconds from the current time,
  is specified in
  _arg3_
  (cast to
  _unsigned int_).
  The timeout is measured against the realtime clock.
* Specifying the timeout value as 0 clears any existing timeout on the key.
* The
  _/proc/keys_
  file displays the remaining time until each key will expire.
  (This is the only method of discovering the timeout on a key.)
* The caller must either have the
  _setattr_
  permission on the key
  or hold an instantiation authorization token for the key (see
  **request_key**(2)).
* The key and any links to the key will be
  automatically garbage collected after the timeout expires.
  Subsequent attempts to access the key will then fail with the error
  **EKEYEXPIRED**.
* This operation cannot be used to set timeouts on revoked, expired,
  or negatively instantiated keys.
* The arguments
  _arg4_
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_set_timeout**(3).
* **KEYCTL_ASSUME_AUTHORITY** (since Linux 2.6.16)  
  Assume (or divest) the authority for the calling thread
  to instantiate a key.
* The
  _arg2_
  argument (cast to
  _key_serial_t_)
  specifies either a nonzero key ID to assume authority,
  or the value 0 to divest authority.
* If
  _arg2_
  is nonzero, then it specifies the ID of an uninstantiated key for which
  authority is to be assumed.
  That key can then be instantiated using one of
  **KEYCTL_INSTANTIATE**,
  **KEYCTL_INSTANTIATE_IOV**,
  **KEYCTL_REJECT**,
  or
  **KEYCTL_NEGATE**.
  Once the key has been instantiated,
  the thread is automatically divested of authority to instantiate the key.
* Authority over a key can be assumed only if the calling thread has present
  in its keyrings the authorization key that is
  associated with the specified key.
  (In other words, the
  **KEYCTL_ASSUME_AUTHORITY**
  operation is available only from a
  **request-key**(8)-style
  program; see
  **request_key**(2)
  for an explanation of how this operation is used.)
  The caller must have
  _search_
  permission on the authorization key.
* If the specified key has a matching authorization key,
  then the ID of that key is returned.
  The authorization key can be read
  (**KEYCTL_READ**)
  to obtain the callout information passed to
  **request_key**(2).
* If the ID given in
  _arg2_
  is 0, then the currently assumed authority is cleared (divested),
  and the value 0 is returned.
* The
  **KEYCTL_ASSUME_AUTHORITY**
  mechanism allows a program such as
  **request-key**(8)
  to assume the necessary authority to instantiate a new uninstantiated key
  that was created as a consequence of a call to
  **request_key**(2).
  For further information, see
  **request_key**(2)
  and the kernel source file
  _Documentation/security/keys-request-key.txt_.
* The arguments
  _arg3_,
  _arg4_,
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_assume_authority**(3).
* **KEYCTL_GET_SECURITY** (since Linux 2.6.26)  
  
  Get the LSM (Linux Security Module) security label of the specified key.
* The ID of the key whose security label is to be fetched is specified in
  _arg2_
  (cast to
  _key_serial_t_).
  The security label (terminated by a null byte)
  will be placed in the buffer pointed to by
  _arg3_
  argument (cast to
  _char&nbsp;*_);
  the size of the buffer must be provided in
  _arg4_
  (cast to
  _size_t_).
* If
  _arg3_
  is specified as NULL or the buffer size specified in
  _arg4_
  is too small, the full size of the security label string
  (including the terminating null byte)
  is returned as the function result,
  and nothing is copied to the buffer.
* The caller must have
  _view_
  permission on the specified key.
* The returned security label string will be rendered in a form appropriate
  to the LSM in force.
  For example, with SELinux, it may look like:
*     unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
* If no LSM is currently in force,
  then an empty string is placed in the buffer.
* The
  _arg5_
  argument is ignored.
* This operation is exposed by
  _libkeyutils_
  via the functions
  **keyctl_get_security**(3)
  and
  **keyctl_get_security_alloc**(3).
* **KEYCTL_SESSION_TO_PARENT** (since Linux 2.6.32)  
  
  Replace the session keyring to which the
  _parent_
  of the calling process
  subscribes with the session keyring of the calling process.
  
  
  
* The keyring will be replaced in the parent process at the point
  where the parent next transitions from kernel space to user space.
* The keyring must exist and must grant the caller
  _link_
  permission.
  The parent process must be single-threaded and have
  the same effective ownership as this process
  and must not be set-user-ID or set-group-ID.
  The UID of the parent process's existing session keyring (f it has one),
  as well as the UID of the caller's session keyring
  much match the caller's effective UID.
* The fact that it is the parent process that is affected by this operation
  allows a program such as the shell to start a child process that
  uses this operation to change the shell's session keyring.
  (This is what the
  **keyctl**(1)
  **new_session**
  command does.)
* The arguments
  _arg2_,
  _arg3_,
  _arg4_,
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_session_to_parent**(3).
* **KEYCTL_REJECT** (since Linux 2.6.39)  
  
  Mark a key as negatively instantiated and set an expiration timer
  on the key.
  This operation provides a superset of the functionality of the earlier
  **KEYCTL_NEGATE**
  operation.
* The ID of the key that is to be negatively instantiated is specified in
  _arg2_
  (cast to
  _key_serial_t_).
  The
  _arg3_
  (cast to
  _unsigned int_)
  argument specifies the lifetime of the key, in seconds.
  The
  _arg4_
  argument (cast to
  _unsigned int_)
  specifies the error to be returned when a search hits this key;
  typically, this is one of
  **EKEYREJECTED**,
  **EKEYREVOKED**,
  or
  **EKEYEXPIRED**.
* If
  _arg5_
  (cast to
  _key_serial_t_)
  is nonzero, then, subject to the same constraints and rules as
  **KEYCTL_LINK**,
  the negatively instantiated key is linked into the keyring
  whose ID is specified in
  _arg5_.
* The caller must have the appropriate authorization key.
  In other words, this operation is available only from a
  **request-key**(8)-style
  program.
  See
  **request_key**(2).
* The caller must have the appropriate authorization key,
  and once the uninstantiated key has been instantiated,
  the authorization key is revoked.
  In other words, this operation is available only from a
  **request-key**(8)-style
  program.
  See
  **request_key**(2)
  for an explanation of uninstantiated keys and key instantiation.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_reject**(3).
* **KEYCTL_INSTANTIATE_IOV** (since Linux 2.6.39)  
  
  Instantiate an uninstantiated key with a payload specified
  via a vector of buffers.
* This operation is the same as
  **KEYCTL_INSTANTIATE**,
  but the payload data is specified as an array of
  _iovec_
  structures:
* .in +4n
  .EX
  struct iovec {
      void  *iov_base;    /* Starting address of buffer */
      size_t iov_len;     /* Size of buffer (in bytes) */
  };
  .EE
  .in
* The pointer to the payload vector is specified in
  _arg3_
  (cast as
  _const struct iovec&nbsp;*_).
  The number of items in the vector is specified in
  _arg4_
  (cast as
  _unsigned int_).
* The
  _arg2_
  (key ID)
  and
  _arg5_
  (keyring ID)
  are interpreted as for
  **KEYCTL_INSTANTIATE**.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_instantiate_iov**(3).
* **KEYCTL_INVALIDATE** (since Linux 3.5)  
  
  Mark a key as invalid.
* The ID of the key to be invalidated is specified in
  _arg2_
  (cast to
  _key_serial_t_).
* To invalidate a key,
  the caller must have
  _search_
  permission on the key.
  
* This operation marks the key as invalid
  and schedules immediate garbage collection.
  The garbage collector removes the invalidated key from all keyrings and
  deletes the key when its reference count reaches zero.
  After this operation,
  the key will be ignored by all searches,
  even if it is not yet deleted.
* Keys that are marked invalid become invisible to normal key operations
  immediately, though they are still visible in
  _/proc/keys_
  (marked with an 'i' flag)
  until they are actually removed.
* The arguments
  _arg3_,
  _arg4_,
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_invalidate**(3).
* **KEYCTL_GET_PERSISTENT** (since Linux 3.13)  
  
  Get the persistent keyring
  (**persistent-keyring**(7))
  for a specified user and link it to a specified keyring.
* The user ID is specified in
  _arg2_
  (cast to
  _uid_t_).
  If the value -1 is specified, the caller's real user ID is used.
  The ID of the destination keyring is specified in
  _arg3_
  (cast to
  _key_serial_t_).
* The caller must have the
  **CAP_SETUID**
  capability in its user namespace in order to fetch the persistent keyring
  for a user ID that does not match either the real or effective user ID
  of the caller.
* If the call is successful,
  a link to the persistent keyring is added to the keyring
  whose ID was specified in
  _arg3_.
* The caller must have
  _write_
  permission on the keyring.
* The persistent keyring will be created by the kernel
  if it does not yet exist.
* Each time the
  **KEYCTL_GET_PERSISTENT**
  operation is performed, the persistent keyring will
  have its expiration timeout reset to the value in:
* .in +4n
  .EX
  /proc/sys/kernel/keys/persistent_keyring_expiry
  .EE
  .in
* Should the timeout be reached,
  the persistent keyring will be removed and
  everything it pins can then be garbage collected.
* Persistent keyrings were added to Linux in kernel version 3.13.
* The arguments
  _arg4_
  and
  _arg5_
  are ignored.
* This operation is exposed by
  _libkeyutils_
  via the function
  **keyctl_get_persistent**(3).
* **KEYCTL_DH_COMPUTE** (since Linux 4.7)  
  
  Compute a Diffie-Hellman shared secret or public key,
  optionally applying key derivation function (KDF) to the result.
* The
  _arg2_
  argument is a pointer to a set of parameters containing
  serial numbers for three
  _""_user_""_
  keys used in the Diffie-Hellman calculation,
  packaged in a structure of the following form:
* .in +4n
  .EX
  struct keyctl_dh_params {
      int32_t private; /* The local private key */
      int32_t prime; /* The prime, known to both parties */
      int32_t base;  /* The base integer: either a shared
                        generator or the remote public key */
  };
  .EE
  .in
* Each of the three keys specified in this structure must grant the caller
  _read_
  permission.
  The payloads of these keys are used to calculate the Diffie-Hellman
  result as:
*     base ^ private mod prime
* If the base is the shared generator, the result is the local public key.
  If the base is the remote public key, the result is the shared secret.
* The
  _arg3_
  argument (cast to
  _char&nbsp;*_)
  points to a buffer where the result of the calculation is placed.
  The size of that buffer is specified in
  _arg4_
  (cast to
  _size_t_).
* The buffer must be large enough to accommodate the output data,
  otherwise an error is returned.
  If
  _arg4_
  is specified zero,
  in which case the buffer is not used and
  the operation returns the minimum required buffer size
  (i.e., the length of the prime).
* Diffie-Hellman computations can be performed in user space,
  but require a multiple-precision integer (MPI) library.
  Moving the implementation into the kernel gives access to
  the kernel MPI implementation,
  and allows access to secure or acceleration hardware.
* Adding support for DH computation to the
  **keyctl()**
  system call was considered a good fit due to the DH algorithm's use
  for deriving shared keys;
  it also allows the type of the key to determine
  which DH implementation (software or hardware) is appropriate.
  
* If the
  _arg5_
  argument is
  **NULL**,
  then the DH result itself is returned.
  Otherwise (since Linux 4.12), it is a pointer to a structure which specifies
  parameters of the KDF operation to be applied:
* .in +4n
  .EX
  struct keyctl_kdf_params {
      char *hashname;     /* Hash algorithm name */
      char *otherinfo;    /* SP800-56A OtherInfo */
      __u32 otherinfolen; /* Length of otherinfo data */
      __u32 __spare[8];   /* Reserved */
  };
  .EE
  .in
* The
  _hashname_
  field is a null-terminated string which specifies a hash name
  (available in the kernel's crypto API; the list of the hashes available
  is rather tricky to observe; please refer to the
  .UR https://www.kernel.org​/doc​/html​/latest​/crypto​/architecture.html
  "Kernel Crypto API Architecture"
  .UE
  documentation for the information regarding how hash names are constructed and
  your kernel's source and configuration regarding what ciphers
  and templates with type
  **CRYPTO_ALG_TYPE_SHASH**
  are available)
  to be applied to DH result in KDF operation.
* The
  _otherinfo_
  field is an
  _OtherInfo_
  data as described in SP800-56A section 5.8.1.2 and is algorithm-specific.
  This data is concatenated with the result of DH operation and is provided as
  an input to the KDF operation.
  Its size is provided in the
  _otherinfolen_
  field and is limited by
  **KEYCTL_KDF_MAX_OI_LEN**
  constant that defined in
  _security/keys/internal.h_
  to a value of 64.
* The
  **__spare**
  field is currently unused.
  
  It was ignored until Linux 4.13 (but still should be
  user-addressable since it is copied to the kernel),
  and should contain zeros since Linux 4.13.
* The KDF implementation complies with SP800-56A as well
  as with SP800-108 (the counter KDF).
* 
  
  This operation is exposed by
  _libkeyutils_
  (from version 1.5.10 onwards) via the functions
  **keyctl_dh_compute**(3)
  and
  **keyctl_dh_compute_alloc**(3).
* **KEYCTL_RESTRICT_KEYRING** (since Linux 4.12)  
  
  
  Apply a key-linking restriction to the keyring with the ID provided in
  _arg2_
  (cast to
  _key_serial_t_).
  The caller must have
  _setattr_
  permission on the key.
  If
  _arg3_
  is NULL, any attempt to add a key to the keyring is blocked;
  otherwise it contains a pointer to a string with a key type name and
  _arg4_
  contains a pointer to string that describes the type-specific restriction.
  As of Linux 4.12, only the type "asymmetric" has restrictions defined:
    * **builtin_trusted**  
      Allows only keys that are signed by a key linked to the built-in keyring
      (".builtin_trusted_keys").
    * **builtin_and_secondary_trusted**  
      Allows only keys that are signed by a key linked to the secondary keyring
      (".secondary_trusted_keys") or, by extension, a key in a built-in keyring,
      as the latter is linked to the former.
    * **key_or_keyring:**_key_  
      .TQ
      **key_or_keyring:**_key_**:chain**
      If
      _key_
      specifies the ID of a key of type "asymmetric",
      then only keys that are signed by this key are allowed.
    * If
      _key_
      specifies the ID of a keyring,
      then only keys that are signed by a key linked
      to this keyring are allowed.
    * If ":chain" is specified, keys that are signed by a keys linked to the
      destination keyring (that is, the keyring with the ID specified in the
      _arg2_
      argument) are also allowed.
* Note that a restriction can be configured only once for the specified keyring;
  once a restriction is set, it can't be overridden.
* The argument
  _arg5_
  is ignored.

<a name="return-value"></a>

# Return Value

For a successful call, the return value depends on the operation:

* **KEYCTL_GET_KEYRING_ID**  
  The ID of the requested keyring.
* **KEYCTL_JOIN_SESSION_KEYRING**  
  The ID of the joined session keyring.
* **KEYCTL_DESCRIBE**  
  The size of the description (including the terminating null byte),
  irrespective of the provided buffer size.
* **KEYCTL_SEARCH**  
  The ID of the key that was found.
* **KEYCTL_READ**  
  The amount of data that is available in the key,
  irrespective of the provided buffer size.
* **KEYCTL_SET_REQKEY_KEYRING**  
  The ID of the previous default keyring
  to which implicitly requested keys were linked
  (one of
  **KEY_REQKEY_DEFL_USER_***).
* **KEYCTL_ASSUME_AUTHORITY**  
  Either 0, if the ID given was 0,
  or the ID of the authorization key matching the specified key,
  if a nonzero key ID was provided.
* **KEYCTL_GET_SECURITY**  
  The size of the LSM security label string
  (including the terminating null byte),
  irrespective of the provided buffer size.
* **KEYCTL_GET_PERSISTENT**  
  The ID of the persistent keyring.
* **KEYCTL_DH_COMPUTE**  
  The number of bytes copied to the buffer, or, if
  _arg4_
  is 0, the required buffer size.
* All other operations  
  Zero.

On error, -1 is returned, and
_errno_
is set appropriately to indicate the error.

<a name="errors"></a>

# Errors


* **EACCES**  
  The requested operation wasn't permitted.
* **EAGAIN**  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**
  and there was an error during crypto module initialization.
* **EDEADLK**  
  _operation_
  was
  **KEYCTL_LINK**
  and the requested link would result in a cycle.
* **EDEADLK**  
  _operation_
  was
  **KEYCTL_RESTRICT_KEYRING**
  and the requested keyring restriction would result in a cycle.
* **EDQUOT**  
  The key quota for the caller's user would be exceeded by creating a key or
  linking it to the keyring.
* **EEXIST**  
  _operation_
  was
  **KEYCTL_RESTRICT_KEYRING**
  and keyring provided in
  _arg2_
  argument already has a restriction set.
* **EFAULT**  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**
  and one of the following has failed:
    * ·  
      copying of the
      _struct keyctl_dh_params_,
      provided in the
      _arg2_
      argument, from user space;
    * ·  
      copying of the
      _struct keyctl_kdf_params_,
      provided in the non-NULL
      _arg5_
      argument, from user space
      (in case kernel supports performing KDF operation on DH operation result);
    * ·  
      copying of data pointed by the
      _hashname_
      field of the
      _struct keyctl_kdf_params_
      from user space;
    * ·  
      copying of data pointed by the
      _otherinfo_
      field of the
      _struct keyctl_kdf_params_
      from user space if the
      _otherinfolen_
      field was nonzero;
    * ·  
      copying of the result to user space.
* **EINVAL**  
  _operation_
  was
  **KEYCTL_SETPERM**
  and an invalid permission bit was specified in
  _arg3_.
* **EINVAL**  
  _operation_
  was
  **KEYCTL_SEARCH**
  and the size of the description in
  _arg4_
  (including the terminating null byte) exceeded 4096 bytes.
  size of the string (including the terminating null byte) specified in
  _arg3_
  (the key type)
  or
  _arg4_
  (the key description)
  exceeded the limit (32 bytes and 4096 bytes respectively).
* **EINVAL** (Linux kernels before 4.12)  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**,
  argument
  _arg5_
  was non-NULL.
* **EINVAL**  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**
  And the digest size of the hashing algorithm supplied is zero.
* **EINVAL**  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**
  and the buffer size provided is not enough to hold the result.
  Provide 0 as a buffer size in order to obtain the minimum buffer size.
* **EINVAL**  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**
  and the hash name provided in the
  _hashname_
  field of the
  _struct keyctl_kdf_params_
  pointed by
  _arg5_
  argument is too big (the limit is implementation-specific and varies between
  kernel versions, but it is deemed big enough for all valid algorithm names).
* **EINVAL**  
  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**
  and the
  ___spare_
  field of the
  _struct keyctl_kdf_params_
  provided in the
  _arg5_
  argument contains nonzero values.
* **EKEYEXPIRED**  
  An expired key was found or specified.
* **EKEYREJECTED**  
  A rejected key was found or specified.
* **EKEYREVOKED**  
  A revoked key was found or specified.
* **ELOOP**  
  _operation_
  was
  **KEYCTL_LINK**
  and the requested link would cause the maximum nesting depth
  for keyrings to be exceeded.
* **EMSGSIZE**  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**
  and the buffer length exceeds
  **KEYCTL_KDF_MAX_OUTPUT_LEN**
  (which is 1024 currently)
  or the
  _otherinfolen_
  field of the
  _struct keyctl_kdf_parms_
  passed in
  _arg5_
  exceeds
  **KEYCTL_KDF_MAX_OI_LEN**
  (which is 64 currently).
* **ENFILE** (Linux kernels before 3.13)  
  _operation_
  was
  **KEYCTL_LINK**
  and the keyring is full.
  (Before Linux 3.13,
  
  the available space for storing keyring links was limited to
  a single page of memory; since Linux 3.13, there is no fixed limit.)
* **ENOENT**  
  _operation_
  was
  **KEYCTL_UNLINK**
  and the key to be unlinked isn't linked to the keyring.
* **ENOENT**  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**
  and the hashing algorithm specified in the
  _hashname_
  field of the
  _struct keyctl_kdf_params_
  pointed by
  _arg5_
  argument hasn't been found.
* **ENOENT**  
  _operation_
  was
  **KEYCTL_RESTRICT_KEYRING**
  and the type provided in
  _arg3_
  argument doesn't support setting key linking restrictions.
* **ENOKEY**  
  No matching key was found or an invalid key was specified.
* **ENOKEY**  
  The value
  **KEYCTL_GET_KEYRING_ID**
  was specified in
  _operation_,
  the key specified in
  _arg2_
  did not exist, and
  _arg3_
  was zero (meaning don't create the key if it didn't exist).
* **ENOMEM**  
  One of kernel memory allocation routines failed during the execution of the
  syscall.
* **ENOTDIR**  
  A key of keyring type was expected but the ID of a key with
  a different type was provided.
* **EOPNOTSUPP**  
  _operation_
  was
  **KEYCTL_READ**
  and the key type does not support reading
  (e.g., the type is
  _""_login_""_).
* **EOPNOTSUPP**  
  _operation_
  was
  **KEYCTL_UPDATE**
  and the key type does not support updating.
* **EOPNOTSUPP**  
  _operation_
  was
  **KEYCTL_RESTRICT_KEYRING**,
  the type provided in
  _arg3_
  argument was "asymmetric", and the key specified in the restriction specification
  provided in
  _arg4_
  has type other than "asymmetric" or "keyring".
* **EPERM**  
  _operation_
  was
  **KEYCTL_GET_PERSISTENT**,
  _arg2_
  specified a UID other than the calling thread's real or effective UID,
  and the caller did not have the
  **CAP_SETUID**
  capability.
* **EPERM**  
  _operation_
  was
  **KEYCTL_SESSION_TO_PARENT**
  and either:
  all of the UIDs (GIDs) of the parent process do not match
  the effective UID (GID) of the calling process;
  the UID of the parent's existing session keyring or
  the UID of the caller's session keyring did not match
  the effective UID of the caller;
  the parent process is not single-thread;
  or the parent process is
  **init**(1)
  or a kernel thread.
* **ETIMEDOUT**  
  _operation_
  was
  **KEYCTL_DH_COMPUTE**
  and the initialisation of crypto modules has timed out.

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
library.
When employing the wrapper in that library, link with
_-lkeyutils_.
However, rather than using this system call directly,
you probably want to use the various library functions
mentioned in the descriptions of individual operations above.

<a name="example"></a>

# Example

The program below provide subset of the functionality of the
**request-key**(8)
program provided by the
_keyutils_
package.
For informational purposes,
the program records various information in a log file.

As described in
**request_key**(2),
the
**request-key**(8)
program is invoked with command-line arguments that
describe a key that is to be instantiated.
The example program fetches and logs these arguments.
The program assumes authority to instantiate the requested key,
and then instantiates that key.

The following shell session demonstrates the use of this program.
In the session,
we compile the program and then use it to temporarily replace the standard
**request-key**(8)
program.
(Note that temporarily disabling the standard
**request-key**(8)
program may not be safe on some systems.)
While our example program is installed,
we use the example program shown in
**request_key**(2)
to request a key.

.in +4n
.EX
$ **cc -o key_instantiate key_instantiate.c -lkeyutils**
$ **sudo mv /sbin/request-key /sbin/request-key.backup**
$ **sudo cp key_instantiate /sbin/request-key**
$ **./t_request_key user mykey somepayloaddata**
Key ID is 20d035bf
$ **sudo mv /sbin/request-key.backup /sbin/request-key**
.EE
.in

Looking at the log file created by this program,
we can see the command-line arguments supplied to our example program:

.in +4n
.EX
$ **cat /tmp/key_instantiate.log **
Time: Mon Nov  7 13:06:47 2016

Command line arguments:
  argv[0]:            /sbin/request-key
  operation:          create
  key_to_instantiate: 20d035bf
  UID:                1000
  GID:                1000
  thread_keyring:     0
  process_keyring:    0
  session_keyring:    256e6a6

Key description:      user;1000;1000;3f010000;mykey
Auth key payload:     somepayloaddata
Destination keyring:  256e6a6
Auth key description: .request_key_auth;1000;1000;0b010000;20d035bf
.EE
.in

The last few lines of the above output show that the example program
was able to fetch:

* *  
  the description of the key to be instantiated,
  which included the name of the key
  (_mykey_);
* *  
  the payload of the authorization key, which consisted of the data
  (_somepayloaddata_)
  passed to
  **request_key**(2);
* *  
  the destination keyring that was specified in the call to
  **request_key**(2);
  and
* *  
  the description of the authorization key,
  where we can see that the name of the authorization key matches
  the ID of the key that is to be instantiated
  (_20d035bf_).

The example program in
**request_key**(2)
specified the destination keyring as
**KEY_SPEC_SESSION_KEYRING**.
By examining the contents of
_/proc/keys_,
we can see that this was translated to the ID of the destination keyring
(_0256e6a6_)
shown in the log output above;
we can also see the newly created key with the name
_mykey_
and ID
_20d035bf_.

.in +4n
.EX
$ **cat /proc/keys | egrep 'mykey|256e6a6'**
0256e6a6 I--Q---  194 perm 3f030000  1000  1000 keyring  _ses: 3
20d035bf I--Q---    1 perm 3f010000  1000  1000 user     mykey: 16
.EE
.in

<a name="program-source"></a>

### Program source


.EX
/* key_instantiate.c */

#include &lt;sys/types.h&gt;
#include &lt;keyutils.h&gt;
#include &lt;time.h&gt;
#include &lt;fcntl.h&gt;
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;unistd.h&gt;
#include &lt;string.h&gt;
#include &lt;errno.h&gt;

#ifndef KEY_SPEC_REQUESTOR_KEYRING
#define KEY_SPEC_REQUESTOR_KEYRING      -8
#endif

int
main(int argc, char *argv[])
{
    FILE *fp;
    time_t t;
    char *operation;
    key_serial_t key_to_instantiate, dest_keyring;
    key_serial_t thread_keyring, process_keyring, session_keyring;
    uid_t uid;
    gid_t gid;
    char dbuf[256];
    char auth_key_payload[256];
    int akp_size;       /* Size of auth_key_payload */

    fp = fopen("/tmp/key_instantiate.log", "w");
    if (fp == NULL)
        exit(EXIT_FAILURE);

    setbuf(fp, NULL);

    t = time(NULL);
    fprintf(fp, "Time: %s\\n", ctime(&t));

    /*
     * The kernel passes a fixed set of arguments to the program
     * that it execs; fetch them.
     */
    operation = argv[1];
    key_to_instantiate = atoi(argv[2]);
    uid = atoi(argv[3]);
    gid = atoi(argv[4]);
    thread_keyring = atoi(argv[5]);
    process_keyring = atoi(argv[6]);
    session_keyring = atoi(argv[7]);

    fprintf(fp, "Command line arguments:\\n");
    fprintf(fp, "  argv[0]:            %s\\n", argv[0]);
    fprintf(fp, "  operation:          %s\\n", operation);
    fprintf(fp, "  key_to_instantiate: %lx\\n",
            (long) key_to_instantiate);
    fprintf(fp, "  UID:                %ld\\n", (long) uid);
    fprintf(fp, "  GID:                %ld\\n", (long) gid);
    fprintf(fp, "  thread_keyring:     %lx\\n", (long) thread_keyring);
    fprintf(fp, "  process_keyring:    %lx\\n", (long) process_keyring);
    fprintf(fp, "  session_keyring:    %lx\\n", (long) session_keyring);
    fprintf(fp, "\\n");

    /*
     * Assume the authority to instantiate the key named in argv[2]
     */
    if (keyctl(KEYCTL_ASSUME_AUTHORITY, key_to_instantiate) == -1) {
        fprintf(fp, "KEYCTL_ASSUME_AUTHORITY failed: %s\\n",
                strerror(errno));
        exit(EXIT_FAILURE);
    }

    /*
     * Fetch the description of the key that is to be instantiated
     */
    if (keyctl(KEYCTL_DESCRIBE, key_to_instantiate,
                dbuf, sizeof(dbuf)) == -1) {
        fprintf(fp, "KEYCTL_DESCRIBE failed: %s\\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    fprintf(fp, "Key description:      %s\\n", dbuf);

    /*
     * Fetch the payload of the authorization key, which is
     * actually the callout data given to request_key()
     */
    akp_size = keyctl(KEYCTL_READ, KEY_SPEC_REQKEY_AUTH_KEY,
                      auth_key_payload, sizeof(auth_key_payload));
    if (akp_size == -1) {
        fprintf(fp, "KEYCTL_READ failed: %s\\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    auth_key_payload[akp_size] = '\\0';
    fprintf(fp, "Auth key payload:     %s\\n", auth_key_payload);

    /*
     * For interest, get the ID of the authorization key and
     * display it.
     */
    auth_key = keyctl(KEYCTL_GET_KEYRING_ID,
            KEY_SPEC_REQKEY_AUTH_KEY);
    if (auth_key == -1) {
        fprintf(fp, "KEYCTL_GET_KEYRING_ID failed: %s\\n",
                strerror(errno));
        exit(EXIT_FAILURE);
    }

    fprintf(fp, "Auth key ID:          %lx\\n", (long) auth_key);

    /*
     * Fetch key ID for the request_key(2) destination keyring.
     */
    dest_keyring = keyctl(KEYCTL_GET_KEYRING_ID,
                          KEY_SPEC_REQUESTOR_KEYRING);
    if (dest_keyring == -1) {
        fprintf(fp, "KEYCTL_GET_KEYRING_ID failed: %s\\n",
                strerror(errno));
        exit(EXIT_FAILURE);
    }

    fprintf(fp, "Destination keyring:  %lx\\n", (long) dest_keyring);

    /*
     * Fetch the description of the authorization key. This
     * allows us to see the key type, UID, GID, permissions,
     * and description (name) of the key. Among other things,
     * we will see that the name of the key is a hexadecimal
     * string representing the ID of the key to be instantiated.
     */
    if (keyctl(KEYCTL_DESCRIBE, KEY_SPEC_REQKEY_AUTH_KEY,
                dbuf, sizeof(dbuf)) == -1) {
        fprintf(fp, "KEYCTL_DESCRIBE failed: %s\\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    fprintf(fp, "Auth key description: %s\\n", dbuf);

    /*
     * Instantiate the key using the callout data that was supplied
     * in the payload of the authorization key.
     */
    if (keyctl(KEYCTL_INSTANTIATE, key_to_instantiate,
               auth_key_payload, akp_size + 1, dest_keyring) == -1) {
        fprintf(fp, "KEYCTL_INSTANTIATE failed: %s\\n",
                strerror(errno));
        exit(EXIT_FAILURE);
    }

    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

.nh
**keyctl**(1),
**add_key**(2),
**request_key**(2),


**keyctl**(3),
**keyctl_assume_authority**(3),
**keyctl_chown**(3),
**keyctl_clear**(3),
**keyctl_describe**(3),
**keyctl_describe_alloc**(3),
**keyctl_dh_compute**(3),
**keyctl_dh_compute_alloc**(3),
**keyctl_get_keyring_ID**(3),
**keyctl_get_persistent**(3),
**keyctl_get_security**(3),
**keyctl_get_security_alloc**(3),
**keyctl_instantiate**(3),
**keyctl_instantiate_iov**(3),
**keyctl_invalidate**(3),
**keyctl_join_session_keyring**(3),
**keyctl_link**(3),
**keyctl_negate**(3),
**keyctl_read**(3),
**keyctl_read_alloc**(3),
**keyctl_reject**(3),
**keyctl_revoke**(3),
**keyctl_search**(3),
**keyctl_session_to_parent**(3),
**keyctl_set_reqkey_keyring**(3),
**keyctl_set_timeout**(3),
**keyctl_setperm**(3),
**keyctl_unlink**(3),
**keyctl_update**(3),
**recursive_key_scan**(3),
**recursive_session_key_scan**(3),
**capabilities**(7),
**credentials**(7),
**keyrings**(7),
**keyutils**(7),
**persistent-keyring**(7),
**process-keyring**(7),
**session-keyring**(7),
**thread-keyring**(7),
**user-keyring**(7),
**user_namespaces**(7),
**user-session-keyring**(7),
**request-key**(8)

The kernel source files under
_Documentation/security/keys/_
(or, before Linux 4.13, in the file
_Documentation/security/keys.txt_).

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
