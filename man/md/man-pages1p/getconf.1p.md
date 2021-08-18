# getconf(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

getconf
— get configuration values

<a name="synopsis"></a>

# Synopsis

```


```
    getconf [(miv specification] system_var
    
    getconf [(miv specification] path_var pathname

<a name="description"></a>

# Description

In the first synopsis form, the
_getconf_
utility shall write to the standard output the value of the variable
specified by the
_system_var_
operand.

In the second synopsis form, the
_getconf_
utility shall write to the standard output the value of the variable
specified by the
_path_var_
operand for the path specified by the
_pathname_
operand.

The value of each configuration variable shall be determined as if it
were obtained by calling the function from which it is defined to be
available by this volume of POSIX.1-2008 or by the System Interfaces volume of POSIX.1-2008 (see the OPERANDS section). The
value shall reflect conditions in the current operating environment.

<a name="options"></a>

# Options

The
_getconf_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(miv&nbsp;specification**    
  Indicate a specific specification and version for which configuration
  variables shall be determined. If this option is not specified, the
  values returned correspond to an implementation default conforming
  compilation environment.

If the command:

    
    getconf _POSIX_V7_ILP32_OFF32


does not write
**"\(mi1\en"**
or
**"undefined\en"**
to standard output, then commands of the form:

    
    getconf (miv POSIX_V7_ILP32_OFF32 ...


determine values for configuration variables corresponding to the
POSIX_V7_ILP32_OFF32 compilation environment specified in
__c99_\^_,
the EXTENDED DESCRIPTION.

If the command:

    
    getconf _POSIX_V7_ILP32_OFFBIG


does not write
**"\(mi1\en"**
or
**"undefined\en"**
to standard output, then commands of the form:

    
    getconf (miv POSIX_V7_ILP32_OFFBIG ...


determine values for configuration variables corresponding to the
POSIX_V7_ILP32_OFFBIG compilation environment specified in
__c99_\^_,
the EXTENDED DESCRIPTION.

If the command:

    
    getconf _POSIX_V7_LP64_OFF64


does not write
**"\(mi1\en"**
or
**"undefined\en"**
to standard output, then commands of the form:

    
    getconf (miv POSIX_V7_LP64_OFF64 ...


determine values for configuration variables corresponding to the
POSIX_V7_LP64_OFF64 compilation environment specified in
__c99_\^_,
the EXTENDED DESCRIPTION.

If the command:

    
    getconf _POSIX_V7_LPBIG_OFFBIG


does not write
**"\(mi1\en"**
or
**"undefined\en"**
to standard output, then commands of the form:

    
    getconf (miv POSIX_V7_LPBIG_OFFBIG ...


determine values for configuration variables corresponding to the
POSIX_V7_LPBIG_OFFBIG compilation environment specified in
__c99_\^_,
the EXTENDED DESCRIPTION.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _path\_var_  
  A name of a configuration variable. All of the variables in the
  Variable column of the table in the DESCRIPTION of the
  _fpathconf_()
  function defined in the System Interfaces volume of POSIX.1-2008, without the enclosing braces, shall be
  supported. The implementation may add other local variables.
* _pathname_  
  A pathname for which the variable specified by
  _path_var_
  is to be determined.
* _system\_var_  
  A name of a configuration variable. All of the following variables
  shall be supported:
    *  *  
      The names in the Variable column of the table in the DESCRIPTION of the
      _sysconf_()
      function in the System Interfaces volume of POSIX.1-2008, except for the entries corresponding to
      _SC_CLK_TCK, _SC_GETGR_R_SIZE_MAX, and _SC_GETPW_R_SIZE_MAX, without
      the enclosing braces.

For compatibility with earlier versions, the following variable names
shall also be supported:
POSIX2_C_BIND
POSIX2_C_DEV
POSIX2_CHAR_TERM
POSIX2_FORT_DEV
POSIX2_FORT_RUN
POSIX2_LOCALEDEF
POSIX2_SW_DEV
POSIX2_UPE
POSIX2_VERSION

and shall be equivalent to the same name prefixed with an
&lt;underscore&gt;.
This requirement may be removed in a future version.

*  *  
  The names of the symbolic constants used as the
  _name_
  argument of the
  _confstr_()
  function in the System Interfaces volume of POSIX.1-2008, without the _CS_ prefix.
*  *  
  The names of the symbolic constants listed under the headings \`\`Maximum
  Values'' and \`\`Minimum Values'' in the description of the
  _&lt;limits.h&gt;_
  header in the Base Definitions volume of POSIX.1-2008, without the enclosing braces.

For compatibility with earlier versions, the following variable names
shall also be supported:
POSIX2_BC_BASE_MAX
POSIX2_BC_DIM_MAX
POSIX2_BC_SCALE_MAX
POSIX2_BC_STRING_MAX
POSIX2_COLL_WEIGHTS_MAX
POSIX2_EXPR_NEST_MAX
POSIX2_LINE_MAX
POSIX2_RE_DUP_MAX

and shall be equivalent to the same name prefixed with an
&lt;underscore&gt;.
This requirement may be removed in a future version.

The implementation may add other local values.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_getconf_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If the specified variable is defined on the system and its value is
described to be available from the
_confstr_()
function defined in the System Interfaces volume of POSIX.1-2008, its value shall be written in the
following format:

    
    "%sen", <value>


Otherwise, if the specified variable is defined on the system, its
value shall be written in the following format:

    
    "%den", <value>


If the specified variable is valid, but is undefined on the system,
_getconf_
shall write using the following format:

    
    "undefineden"


If the variable name is invalid or an error occurs, nothing shall be
written to standard output.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  The specified variable is valid and information about its current state
  was written successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

The following example illustrates the value of
{NGROUPS_MAX}:

    
    getconf NGROUPS_MAX


The following example illustrates the value of
{NAME_MAX}
for a specific directory:

    
    getconf NAME_MAX /usr


The following example shows how to deal more carefully with results
that might be unspecified:

    
    if value=$(getconf PATH_MAX /usr); then
        if [ "$value" = "undefined" ]; then
            echo PATH_MAX in /usr is indeterminate.
        else
            echo PATH_MAX in /usr is $value.
        fi
    else
        echo Error in getconf.
    fi


<a name="rationale"></a>

# Rationale

The original need for this utility, and for the
_confstr_()
function, was to provide a way of finding the configuration-defined
default value for the
_PATH_
environment variable. Since
_PATH_
can be modified by the user to include directories that could contain
utilities replacing the standard utilities, shell scripts need
a way to determine the system-supplied
_PATH_
environment variable value that contains the correct search path for
the standard utilities. It was later suggested that access to the other
variables described in this volume of POSIX.1-2008 could also be useful to applications.

This functionality of
_getconf_
would not be adequately subsumed by another command such as:

    
    grep var /etc/conf


because such a strategy would provide correct values for neither those
variables that can vary at runtime, nor those that can vary depending
on the path.

Early proposal versions of
_getconf_
specified exit status 1 when the specified variable was valid, but not
defined on the system. The output string
**"undefined"**
is now used to specify this case with exit code 0 because so many
things depend on an exit code of zero when an invoked utility is
successful.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__c99_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_,
_**&lt;limits.h&gt;**_

The System Interfaces volume of POSIX.1-2008,
__confstr_\^(\|)_,
__fpathconf_\^(\|)_,
__sysconf_\^(\|)_,
__system_\^(\|)_

<a name="copyright"></a>

# Copyright

Portions of this text are reprinted and reproduced in electronic form
from IEEE Std 1003.1, 2013 Edition, Standard for Information Technology
-- Portable Operating System Interface (POSIX), The Open Group Base
Specifications Issue 7, Copyright (C) 2013 by the Institute of
Electrical and Electronics Engineers, Inc and The Open Group.
(This is POSIX.1-2008 with the 2013 Technical Corrigendum 1 applied.) In the
event of any discrepancy between this version and the original IEEE and
The Open Group Standard, the original IEEE and The Open Group Standard
is the referee document. The original Standard can be obtained online at
http://www.unix.org/online.html .

Any typographical or formatting errors that appear
in this page are most likely
to have been introduced during the conversion of the source files to
man page format. To report such errors, see
https://www.kernel.org/doc/man-pages/reporting_bugs.html .
