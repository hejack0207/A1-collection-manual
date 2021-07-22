# pam_echo(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_echo - PAM module for printing text messages

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_echo.so&nbsp;'u pam_echo.so [file=/path/message]
```

<a name="description"></a>

# Description


The
_pam\_echo_
PAM module is for printing text messages to inform user about special things. Sequences starting with the
_%_
character are interpreted in the following way:

_%H_
The name of the remote host (PAM_RHOST).

_%h_
The name of the local host.

_%s_
The service name (PAM_SERVICE).

_%t_
The name of the controlling terminal (PAM_TTY).

_%U_
The remote user name (PAM_RUSER).

_%u_
The local user name (PAM_USER).

All other sequences beginning with
_%_
expands to the characters following the
_%_
character.

<a name="options"></a>

# Options


**file=****/path/message**
The content of the file
/path/message
will be printed with the PAM conversion function as PAM_TEXT_INFO.

<a name="module-types-provided"></a>

# Module Types Provided


All module types (**auth**,
**account**,
**password**
and
**session**) are provided.

<a name="return-values"></a>

# Return Values


PAM_BUF_ERR
Memory buffer error.

PAM_SUCCESS
Message was successful printed.

PAM_IGNORE
PAM_SILENT flag was given or message file does not exist, no message printed.

<a name="examples"></a>

# Examples


For an example of the use of this module, we show how it may be used to print information about good passwords:

.if n \{.RS 4
.\}
    password optional pam_echo.so file=/usr/share/doc/good-password.txt
    password required pam_unix.so
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam.conf**(8),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


Thorsten Kukuk &lt;[kukuk@thkukuk.de](mailto:kukuk@thkukuk.de)&gt;
