# config(5)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

config - OpenSSL CONF library configuration files

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The OpenSSL \s-1CONF\s0 library can be used to read configuration files.
It is used for the OpenSSL master configuration file **openssl.cnf**
and in a few other places like **\s-1SPKAC\s0** files and certificate extension
files for the **x509** utility. OpenSSL applications can also use the
\s-1CONF\s0 library for their own purposes.

A configuration file is divided into a number of sections. Each section
starts with a line **[ section_name ]** and ends when a new section is
started or end of file is reached. A section name can consist of
alphanumeric characters and underscores.

The first section of a configuration file is special and is referred
to as the **default** section. This section is usually unnamed and spans from the
start of file until the first named section. When a name is being looked up
it is first looked up in a named section (if any) and then the
default section.

The environment is mapped onto a section called **\s-1ENV\s0**.

Comments can be included by preceding them with the **#** character

Other files can be included using the **.include** directive followed
by a path. If the path points to a directory all files with
names ending with **.cnf** or **.conf** are included from the directory.
Recursive inclusion of directories from files in such directory is not
supported. That means the files in the included directory can also contain
**.include** directives but only inclusion of regular files is supported
there. The inclusion of directories is not supported on systems without
\s-1POSIX IO\s0 support.

It is strongly recommended to use absolute paths with the **.include**
directive. Relative paths are evaluated based on the application current
working directory so unless the configuration file containing the
**.include** directive is application specific the inclusion will not
work as expected.

There can be optional **=** character and whitespace characters between
**.include** directive and the path which can be useful in cases the
configuration file needs to be loaded by old OpenSSL versions which do
not support the **.include** syntax. They would bail out with error
if the **=** character is not present but with it they just ignore
the include.

Each section in a configuration file consists of a number of name and
value pairs of the form **name=value**

The **name** string can contain any alphanumeric characters as well as
a few punctuation symbols such as **.** **,** **;** and **\_**.

The **value** string consists of the string following the **=** character
until end of line with any leading and trailing white space removed.

The value string undergoes variable expansion. This can be done by
including the form **\f(CB$var** or **${var}**: this will substitute the value
of the named variable in the current section. It is also possible to
substitute a value from another section using the syntax **\f(CB$section::name**
or **${section::name}**. By using the form **\f(CB$ENV::name** environment
variables can be substituted. It is also possible to assign values to
environment variables by using the name **ENV::name**, this will work
if the program looks up environment variables using the **\s-1CONF\s0** library
instead of calling **getenv()** directly. The value string must not exceed 64k in
length after variable expansion. Otherwise an error will occur.

It is possible to escape certain characters by using any kind of quote
or the **\e** character. By making the last character of a line a **\e**
a **value** string can be spread across multiple lines. In addition
the sequences **\en**, **\er**, **\eb** and **\et** are recognized.

All expansion and escape rules as described above that apply to **value**
also apply to the path of the **.include** directive.

<a name="openssl-library-configuration"></a>

# Openssl Library Configuration

.IX Header "OPENSSL LIBRARY CONFIGURATION"
Applications can automatically configure certain
aspects of OpenSSL using the master OpenSSL configuration file, or optionally
an alternative configuration file. The **openssl** utility includes this
functionality: any sub command uses the master OpenSSL configuration file
unless an option is used in the sub command to use an alternative configuration
file.

To enable library configuration the default section needs to contain an
appropriate line which points to the main configuration section. The default
name is **openssl\_conf** which is used by the **openssl** utility. Other
applications may use an alternative name such as **myapplication\_conf**.
All library configuration lines appear in the default section at the start
of the configuration file.

The configuration section should consist of a set of name value pairs which
contain specific module configuration information. The **name** represents
the name of the _configuration module_. The meaning of the **value** is
module specific: it may, for example, represent a further configuration
section containing configuration module specific information. E.g.:

.Vb 2
 # This must be in the default section
 openssl_conf = openssl_init

 [openssl_init]

 oid_section = new_oids
 engines = engine_section

 [new_oids]

 ... new oids here ...

 [engine_section]

 ... engine stuff here ...
.Ve

The features of each configuration module are described below.

<a name="s-1asn1s0-object-configuration-module"></a>

### \s-1ASN1\s0 Object Configuration Module

.IX Subsection "ASN1 Object Configuration Module"
This module has the name **oid\_section**. The value of this variable points
to a section containing name value pairs of OIDs: the name is the \s-1OID\s0 short
and long name, the value is the numerical form of the \s-1OID.\s0 Although some of
the **openssl** utility sub commands already have their own \s-1ASN1 OBJECT\s0 section
functionality not all do. By using the \s-1ASN1 OBJECT\s0 configuration module
**all** the **openssl** utility sub commands can see the new objects as well
as any compliant applications. For example:

.Vb 1
 [new_oids]

 some_new_oid = 1.2.3.4
 some_other_oid = 1.2.3.5
.Ve

It is also possible to set the value to the long name followed
by a comma and the numerical \s-1OID\s0 form. For example:

.Vb 1
 shortName = some object long name, 1.2.3.4
.Ve

<a name="engine-configuration-module"></a>

### Engine Configuration Module

.IX Subsection "Engine Configuration Module"
This \s-1ENGINE\s0 configuration module has the name **engines**. The value of this
variable points to a section containing further \s-1ENGINE\s0 configuration
information.

The section pointed to by **engines** is a table of engine names (though see
**engine\_id** below) and further sections containing configuration information
specific to each \s-1ENGINE.\s0

Each \s-1ENGINE\s0 specific section is used to set default algorithms, load
dynamic, perform initialization and send ctrls. The actual operation performed
depends on the _command_ name which is the name of the name value pair. The
currently supported commands are listed below.

For example:

.Vb 1
 [engine_section]

 # Configure ENGINE named "foo"
 foo = foo_section
 # Configure ENGINE named "bar"
 bar = bar_section

 [foo_section]
 ... foo ENGINE specific commands ...

 [bar_section]
 ... "bar" ENGINE specific commands ...
.Ve

The command **engine\_id** is used to give the \s-1ENGINE\s0 name. If used this
command must be first. For example:

.Vb 3
 [engine_section]
 # This would normally handle an ENGINE named "foo"
 foo = foo_section

 [foo_section]
 # Override default name and use "myfoo" instead.
 engine_id = myfoo
.Ve

The command **dynamic\_path** loads and adds an \s-1ENGINE\s0 from the given path. It
is equivalent to sending the ctrls **\s-1SO\_PATH\s0** with the path argument followed
by **\s-1LIST\_ADD\s0** with value 2 and **\s-1LOAD\s0** to the dynamic \s-1ENGINE.\s0 If this is
not the required behaviour then alternative ctrls can be sent directly
to the dynamic \s-1ENGINE\s0 using ctrl commands.

The command **init** determines whether to initialize the \s-1ENGINE.\s0 If the value
is **0** the \s-1ENGINE\s0 will not be initialized, if **1** and attempt it made to
initialized the \s-1ENGINE\s0 immediately. If the **init** command is not present
then an attempt will be made to initialize the \s-1ENGINE\s0 after all commands in
its section have been processed.

The command **default\_algorithms** sets the default algorithms an \s-1ENGINE\s0 will
supply using the functions **ENGINE\_set\_default\_string()**.

If the name matches none of the above command names it is assumed to be a
ctrl command which is sent to the \s-1ENGINE.\s0 The value of the command is the
argument to the ctrl command. If the value is the string **\s-1EMPTY\s0** then no
value is sent to the command.

For example:

.Vb 1
 [engine_section]

 # Configure ENGINE named "foo"
 foo = foo_section

 [foo_section]
 # Load engine from DSO
 dynamic_path = /some/path/fooengine.so
 # A foo specific ctrl.
 some_ctrl = some_value
 # Another ctrl that doesnt take a value.
 other_ctrl = EMPTY
 # Supply all default algorithms
 default_algorithms = ALL
.Ve

<a name="s-1evps0-configuration-module"></a>

### \s-1EVP\s0 Configuration Module

.IX Subsection "EVP Configuration Module"
This modules has the name **alg\_section** which points to a section containing
algorithm commands.

Currently the only algorithm command supported is **fips\_mode** whose
value can only be the boolean string **off**. If **fips\_mode** is set to **on**,
an error occurs as this library version is not \s-1FIPS\s0 capable.

<a name="s-1ssls0-configuration-module"></a>

### \s-1SSL\s0 Configuration Module

.IX Subsection "SSL Configuration Module"
This module has the name **ssl\_conf** which points to a section containing
\s-1SSL\s0 configurations.

Each line in the \s-1SSL\s0 configuration section contains the name of the
configuration and the section containing it.

Each configuration section consists of command value pairs for **\s-1SSL\_CONF\s0**.
Each pair will be passed to a **\s-1SSL\_CTX\s0** or **\s-1SSL\s0** structure if it calls
**SSL\_CTX\_config()** or **SSL\_config()** with the appropriate configuration name.

Note: any characters before an initial dot in the configuration section are
ignored so the same command can be used multiple times.

For example:

.Vb 1
 ssl_conf = ssl_sect

 [ssl_sect]

 server = server_section

 [server_section]

 RSA.Certificate = server-rsa.pem
 ECDSA.Certificate = server-ecdsa.pem
 Ciphers = ALL:!RC4
.Ve

The system default configuration with name **system\_default** if present will
be applied during any creation of the **\s-1SSL\_CTX\s0** structure.

Example of a configuration with the system default:

.Vb 1
 ssl_conf = ssl_sect

 [ssl_sect]
 system_default = system_default_sect

 [system_default_sect]
 MinProtocol = TLSv1.2
 MinProtocol = DTLSv1.2
.Ve

<a name="notes"></a>

# Notes

.IX Header "NOTES"
If a configuration file attempts to expand a variable that doesn't exist
then an error is flagged and the file will not load. This can happen
if an attempt is made to expand an environment variable that doesn't
exist. For example in a previous version of OpenSSL the default OpenSSL
master configuration file used the value of **\s-1HOME\s0** which may not be
defined on non Unix systems and would cause an error.

This can be worked around by including a **default** section to provide
a default value: then if the environment lookup fails the default value
will be used instead. For this to work properly the default value must
be defined earlier in the configuration file than the expansion. See
the **\s-1EXAMPLES\s0** section for an example of how to do this.

If the same variable exists in the same section then all but the last
value will be silently ignored. In certain circumstances such as with
DNs the same field may occur multiple times. This is usually worked
around by ignoring any characters before an initial **.** e.g.

.Vb 2
 1.OU="My first OU"
 2.OU="My Second OU"
.Ve

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Here is a sample configuration file using some of the features
mentioned above.

.Vb 1
 # This is the default section.

 HOME=/temp
 RANDFILE= ${ENV::HOME}/.rnd
 configdir=$ENV::HOME/config

 [ section_one ]

 # We are now in section one.

 # Quotes permit leading and trailing whitespace
 any = " any variable name "

 other = A string that can \e
 cover several lines \e
 by including \e\e characters

 message = Hello World\en

 [ section_two ]

 greeting = $section_one::message
.Ve

This next example shows how to expand environment variables safely.

Suppose you want a variable called **tmpfile** to refer to a
temporary filename. The directory it is placed in can determined by
the **\s-1TEMP\s0** or **\s-1TMP\s0** environment variables but they may not be
set to any value at all. If you just include the environment variable
names and the variable doesn't exist then this will cause an error when
an attempt is made to load the configuration file. By making use of the
default section both values can be looked up with **\s-1TEMP\s0** taking
priority and **/tmp** used if neither is defined:

.Vb 5
 TMP=/tmp
 # The above value is used if TMP isnt in the environment
 TEMP=$ENV::TMP
 # The above value is used if TEMP isnt in the environment
 tmpfile=${ENV::TEMP}/tmp.filename
.Ve

Simple OpenSSL library configuration example to enter \s-1FIPS\s0 mode:

.Vb 3
 # Default appname: should match "appname" parameter (if any)
 # supplied to CONF_modules_load_file et al.
 openssl_conf = openssl_conf_section

 [openssl_conf_section]
 # Configuration module list
 alg_section = evp_sect

 [evp_sect]
 # Set to "yes" to enter FIPS mode if supported
 fips_mode = yes
.Ve

Note: in the above example you will get an error in non \s-1FIPS\s0 capable versions
of OpenSSL.

Simple OpenSSL library configuration to make \s-1TLS 1.2\s0 and \s-1DTLS 1.2\s0 the
system-default minimum \s-1TLS\s0 and \s-1DTLS\s0 versions, respectively:

.Vb 2
 # Toplevel section for openssl (including libssl)
 openssl_conf = default_conf_section

 [default_conf_section]
 # We only specify configuration for the "ssl module"
 ssl_conf = ssl_section

 [ssl_section]
 system_default = system_default_section

 [system_default_section]
 MinProtocol = TLSv1.2
 MinProtocol = DTLSv1.2
.Ve

The minimum \s-1TLS\s0 protocol is applied to **\s-1SSL\_CTX\s0** objects that are TLS-based,
and the minimum \s-1DTLS\s0 protocol to those are DTLS-based.
The same applies also to maximum versions set with **MaxProtocol**.

More complex OpenSSL library configuration. Add \s-1OID\s0 and don't enter \s-1FIPS\s0 mode:

.Vb 3
 # Default appname: should match "appname" parameter (if any)
 # supplied to CONF_modules_load_file et al.
 openssl_conf = openssl_conf_section

 [openssl_conf_section]
 # Configuration module list
 alg_section = evp_sect
 oid_section = new_oids

 [evp_sect]
 # This will have no effect as FIPS mode is off by default.
 # Set to "yes" to enter FIPS mode, if supported
 fips_mode = no

 [new_oids]
 # New OID, just short name
 newoid1 = 1.2.3.4.1
 # New OID shortname and long name
 newoid2 = New OID 2 long name, 1.2.3.4.2
.Ve

The above examples can be used with any application supporting library
configuration if openssl_conf\*(R" is modified to match the appropriate \*(L"appname\*(R".

For example if the second sample file above is saved to example.cnf\*(R" then
the command line:

.Vb 1
 OPENSSL_CONF=example.cnf openssl asn1parse -genstr OID:1.2.3.4.1
.Ve

will output:

.Vb 1
    0:d=0  hl=2 l=   4 prim: OBJECT            :newoid1
.Ve

showing that the \s-1OID\s0 newoid1\*(R" has been added as \*(L"1.2.3.4.1\*(R".

<a name="environment"></a>

# Environment

.IX Header "ENVIRONMENT"

* **\s-1OPENSSL\_CONF\s0**  
  .IX Item "OPENSSL_CONF"
  The path to the config file.
  Ignored in set-user-ID and set-group-ID programs.
* **\s-1OPENSSL\_ENGINES\s0**  
  .IX Item "OPENSSL_ENGINES"
  The path to the engines directory.
  Ignored in set-user-ID and set-group-ID programs.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
Currently there is no way to include characters using the octal **\ennn**
form. Strings are all null terminated so nulls cannot form part of
the value.

The escaping isn't quite right: if you want to use sequences like **\en**
you can't use any quote escaping on the same line.

Files are loaded in a single pass. This means that a variable expansion
will only work if the variables referenced are defined earlier in the
file.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**x509**\|(1), **req**\|(1), **ca**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
