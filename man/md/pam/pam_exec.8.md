# pam_exec(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_exec - PAM module which calls an external command

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_exec.so&nbsp;'u pam_exec.so [debug] [expose_authtok] [seteuid] [quiet] [stdout] [log=file] [type=type] command [...]
```

<a name="description"></a>

# Description


pam_exec is a PAM module that can be used to run an external command.

The childs environment is set to the current PAM environment list, as returned by
**pam\_getenvlist**(3)
In addition, the following PAM items are exported as environment variables:
_PAM\_RHOST_,
_PAM\_RUSER_,
_PAM\_SERVICE_,
_PAM\_TTY_,
_PAM\_USER_
and
_PAM\_TYPE_, which contains one of the module types:
**account**,
**auth**,
**password**,
**open\_session**
and
**close\_session**.

Commands called by pam_exec need to be aware of that the user can have control over the environment.

<a name="options"></a>

# Options



**debug**
Print debug information.

**expose\_authtok**
During authentication the calling command can read the password from
**stdin**(3). Only first
_PAM\_MAX\_RESP\_SIZE_
bytes of a password are provided to the command.

**log=****file**
The output of the command is appended to
file

**type=****type**
Only run the command if the module type matches the given type.

**stdout**
Per default the output of the executed command is written to
/dev/null. With this option, the stdout output of the executed command is redirected to the calling application. Its in the responsibility of this application what happens with the output. The
**log**
option is ignored.

**quiet**
Per default pam_exec.so will echo the exit status of the external command if it fails. Specifying this option will suppress the message.

**seteuid**
Per default pam_exec.so will execute the external command with the real user ID of the calling process. Specifying this option means the command is run with the effective user ID.

<a name="module-types-provided"></a>

# Module Types Provided


All module types (**auth**,
**account**,
**password**
and
**session**) are provided.

<a name="return-values"></a>

# Return Values



PAM_SUCCESS
The external command was run successfully.

PAM_BUF_ERR
Memory buffer error.

PAM_CONV_ERR
The conversation method supplied by the application failed to obtain the username.

PAM_INCOMPLETE
The conversation method supplied by the application returned PAM_CONV_AGAIN.

PAM_SERVICE_ERR
No argument or a wrong number of arguments were given.

PAM_SYSTEM_ERR
A system error occurred or the command to execute failed.

PAM_IGNORE
**pam\_setcred**
was called, which does not execute the command. Or, the value given for the type= parameter did not match the module type.

<a name="examples"></a>

# Examples


Add the following line to
/etc/pam.d/passwd
to rebuild the NIS database after each local password change:

.if n \{.RS 4
.\}
            password optional pam_exec.so seteuid /usr/bin/make -C /var/yp
          
.if n \{.RE
.\}

This will execute the command

.if n \{.RS 4
.\}
    make -C /var/yp
.if n \{.RE
.\}

with effective user ID.

<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_exec was written by Thorsten Kukuk &lt;[kukuk@thkukuk.de](mailto:kukuk@thkukuk.de)&gt; and Josh Triplett &lt;josh@joshtriplett.org&gt;.
