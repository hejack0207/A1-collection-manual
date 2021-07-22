# pam_env(8)

Linux-PAM Manual, 08/04/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_env - PAM module to set/unset environment variables

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_env.so&nbsp;'u pam_env.so [debug] [conffile=conf-file] [envfile=env-file] [readenv=0|1] [user_envfile=env-file] [user_readenv=0|1]
```

<a name="description"></a>

# Description


The pam_env PAM module allows the (un)setting of environment variables. Supported is the use of previously set environment variables as well as
_PAM\_ITEM_s such as
_PAM\_RHOST_.

By default rules for (un)setting of variables are taken from the config file
/etc/security/pam_env.conf. An alternate file can be specified with the
_conffile_
option.

Second a file (/etc/environment
by default) with simple
_KEY=VAL_
pairs on separate lines will be read. With the
_envfile_
option an alternate file can be specified. And with the
_readenv_
option this can be completely disabled.

Third it will read a user configuration file ($HOME/.pam_environment
by default). The default file can be changed with the
_user\_envfile_
option and it can be turned on and off with the
_user\_readenv_
option.

Since setting of PAM environment variables can have side effects to other modules, this module should be the last one on the stack.

<a name="options"></a>

# Options


**conffile=****/path/to/pam\_env.conf**
Indicate an alternative
pam_env.conf
style configuration file to override the default. This can be useful when different services need different environments.

**debug**
A lot of debug information is printed with
**syslog**(3).

**envfile=****/path/to/environment**
Indicate an alternative
environment
file to override the default. The syntax are simple
_KEY=VAL_
pairs on separate lines. The
_export_
instruction can be specified for bash compatibility, but will be ignored. This can be useful when different services need different environments.

**readenv=****0|1**
Turns on or off the reading of the file specified by envfile (0 is off, 1 is on). By default this option is on.

**user\_envfile=****filename**
Indicate an alternative
.pam_environment
file to override the default.The syntax is the same as for
_/etc/security/pam\_env.conf_. The filename is relative to the user home directory. This can be useful when different services need different environments.

**user\_readenv=****0|1**
Turns on or off the reading of the user specific environment file. 0 is off, 1 is on. By default this option is off as user supplied environment variables in the PAM environment could affect behavior of subsequent modules in the stack without the consent of the system administrator.

<a name="module-types-provided"></a>

# Module Types Provided


The
**auth**
and
**session**
module types are provided.

<a name="return-values"></a>

# Return Values


PAM_ABORT
Not all relevant data or options could be gotten.

PAM_BUF_ERR
Memory buffer error.

PAM_IGNORE
No pam_env.conf and environment file was found.

PAM_SUCCESS
Environment variables were set.

<a name="files"></a>

# Files


/etc/security/pam_env.conf
Default configuration file

/etc/environment
Default environment file

$HOME/.pam_environment
User specific environment file

<a name="see-also"></a>

# See Also


**pam\_env.conf**(5),
**pam.d**(5),
**pam**(8),
**environ**(7).

<a name="author"></a>

# Author


pam_env was written by Dave Kinchlea &lt;[kinch@kinch.ark](mailto:kinch@kinch.ark).com&gt;.
