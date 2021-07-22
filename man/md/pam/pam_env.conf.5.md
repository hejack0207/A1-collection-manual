# pam_env\&.conf(5)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_env.conf, environment - the environment variables config files

<a name="description"></a>

# Description


The
/etc/security/pam_env.conf
file specifies the environment variables to be set, unset or modified by
**pam\_env**(8). When someone logs in, this file is read and the environment variables are set according.

Each line starts with the variable name, there are then two possible options for each variable DEFAULT and OVERRIDE. DEFAULT allows and administrator to set the value of the variable to some default value, if none is supplied then the empty string is assumed. The OVERRIDE option tells pam_env that it should enter in its value (overriding the default value) if there is one to use. OVERRIDE is not used, "" is assumed and no override will be done.

_VARIABLE_
[_DEFAULT=[value]_] [_OVERRIDE=[value]_]

(Possibly non-existent) environment variables may be used in values using the ${string} syntax and (possibly non-existent) PAM_ITEMs as well as HOME and SHELL may be used in values using the @{string} syntax. Both the $ and @ characters can be backslash escaped to be used as literal values values can be delimited with "", escaped " not supported. Note that many environment variables that you would like to use may not be set by the time the module is called. For example, ${HOME} is used below several times, but many PAM applications dont make it available by the time you need it. The special variables @{HOME} and @{SHELL} are expanded to the values for the user from his
_passwd_
entry.

The "_#_" character at start of line (no space at front) can be used to mark this line as a comment line.

The
/etc/environment
file specifies the environment variables to be set. The file must consist of simple
_NAME=VALUE_
pairs on separate lines. The
**pam\_env**(8)
module will read the file after the
pam_env.conf
file.

<a name="examples"></a>

# Examples


These are some example lines which might be specified in
/etc/security/pam_env.conf.

Set the REMOTEHOST variable for any hosts that are remote, default to "localhost" rather than not being set at all

.if n \{.RS 4
.\}
          REMOTEHOST     DEFAULT=localhost OVERRIDE=@{PAM_RHOST}
        
.if n \{.RE
.\}

Set the DISPLAY variable if it seems reasonable

.if n \{.RS 4
.\}
          DISPLAY        DEFAULT=${REMOTEHOST}:0.0 OVERRIDE=${DISPLAY}
        
.if n \{.RE
.\}

Now some simple variables

.if n \{.RS 4
.\}
          PAGER          DEFAULT=less
          MANPAGER       DEFAULT=less
          LESS           DEFAULT="M q e h15 z23 b80"
          NNTPSERVER     DEFAULT=localhost
          PATH           DEFAULT=${HOME}/bin:/usr/local/bin:/bine
          :/usr/bin:/usr/local/bin/X11:/usr/bin/X11
          XDG_DATA_HOME  @{HOME}/share/
        
.if n \{.RE
.\}

Silly examples of escaped variables, just to show how they work.

.if n \{.RS 4
.\}
          DOLLAR         DEFAULT=e$
          DOLLARDOLLAR   DEFAULT=        OVERRIDE=e$${DOLLAR}
          DOLLARPLUS     DEFAULT=e${REMOTEHOST}${REMOTEHOST}
          ATSIGN         DEFAULT=""      OVERRIDE=e@
        
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**pam\_env**(8),
**pam.d**(5),
**pam**(8),
**environ**(7)

<a name="author"></a>

# Author


pam_env was written by Dave Kinchlea &lt;[kinch@kinch.ark](mailto:kinch@kinch.ark).com&gt;.
