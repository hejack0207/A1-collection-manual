# create extension(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_EXTENSION - install an extension

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE EXTENSION [ IF NOT EXISTS ] extension_name
        [ WITH ] [ SCHEMA schema_name ]
                 [ VERSION version ]
                 [ FROM old_version ]
                 [ CASCADE ]

<a name="description"></a>

# Description


**CREATE EXTENSION**
loads a new extension into the current database. There must not be an extension of the same name already loaded.

Loading an extension essentially amounts to running the extensions script file. The script will typically create new
SQL
objects such as functions, data types, operators and index support methods.
**CREATE EXTENSION**
additionally records the identities of all the created objects, so that they can be dropped again if
**DROP EXTENSION**
is issued.

Loading an extension requires the same privileges that would be required to create its component objects. For most extensions this means superuser or database owner privileges are needed. The user who runs
**CREATE EXTENSION**
becomes the owner of the extension for purposes of later privilege checks, as well as the owner of any objects created by the extensions script.

<a name="parameters"></a>

# Parameters


IF NOT EXISTS
Do not throw an error if an extension with the same name already exists. A notice is issued in this case. Note that there is no guarantee that the existing extension is anything like the one that would have been created from the currently-available script file.

_extension\_name_
The name of the extension to be installed.
PostgreSQL
will create the extension using details from the file
SHAREDIR/extension/_extension\_name_.control.

_schema\_name_
The name of the schema in which to install the extensions objects, given that the extension allows its contents to be relocated. The named schema must already exist. If not specified, and the extension\*(Aqs control file does not specify a schema either, the current default object creation schema is used.

If the extension specifies a
schema
parameter in its control file, then that schema cannot be overridden with a
SCHEMA
clause. Normally, an error will be raised if a
SCHEMA
clause is given and it conflicts with the extensions
schema
parameter. However, if the
CASCADE
clause is also given, then
_schema\_name_
is ignored when it conflicts. The given
_schema\_name_
will be used for installation of any needed extensions that do not specify
schema
in their control files.

Remember that the extension itself is not considered to be within any schema: extensions have unqualified names that must be unique database-wide. But objects belonging to the extension can be within schemas.

_version_
The version of the extension to install. This can be written as either an identifier or a string literal. The default version is whatever is specified in the extensions control file.

_old\_version_
FROM
_old\_version_
must be specified when, and only when, you are attempting to install an extension that replaces an
“old style”
module that is just a collection of objects not packaged into an extension. This option causes
**CREATE EXTENSION**
to run an alternative installation script that absorbs the existing objects into the extension, instead of creating new objects. Be careful that
SCHEMA
specifies the schema containing these pre-existing objects.

The value to use for
_old\_version_
is determined by the extensions author, and might vary if there is more than one version of the old-style module that can be upgraded into an extension. For the standard additional modules supplied with pre-9.1
PostgreSQL, use
unpackaged
for
_old\_version_
when updating a module to extension style.

CASCADE
Automatically install any extensions that this extension depends on that are not already installed. Their dependencies are likewise automatically installed, recursively. The
SCHEMA
clause, if given, applies to all extensions that get installed this way. Other options of the statement are not applied to automatically-installed extensions; in particular, their default versions are always selected.

<a name="notes"></a>

# Notes


Before you can use
**CREATE EXTENSION**
to load an extension into a database, the extensions supporting files must be installed. Information about installing the extensions supplied with
PostgreSQL
can be found in
Additional Supplied Modules.

The extensions currently available for loading can be identified from the
pg_available_extensions
or
pg_available_extension_versions
system views.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Caution**
.ps -1  

Installing an extension as superuser requires trusting that the extensions author wrote the extension installation script in a secure fashion. It is not terribly difficult for a malicious user to create trojan-horse objects that will compromise later execution of a carelessly-written extension script, allowing that user to acquire superuser privileges. However, trojan-horse objects are only hazardous if they are in the
_search\_path_
during script execution, meaning that they are in the extensions installation target schema or in the schema of some extension it depends on. Therefore, a good rule of thumb when dealing with extensions whose scripts have not been carefully vetted is to install them only into schemas for which CREATE privilege has not been and will not be granted to any untrusted users. Likewise for any extensions they depend on.

The extensions supplied with
PostgreSQL
are believed to be secure against installation-time attacks of this sort, except for a few that depend on other extensions. As stated in the documentation for those extensions, they should be installed into secure schemas, or installed into the same schemas as the extensions they depend on, or both.


For information about writing new extensions, see
Section&nbsp;37.17.

<a name="examples"></a>

# Examples


Install the
hstore
extension into the current database, placing its objects in schema
addons:

.if n \{.RS 4
.\}
    CREATE EXTENSION hstore SCHEMA addons;
.if n \{.RE
.\}

Another way to accomplish the same thing:

.if n \{.RS 4
.\}
    SET search_path = addons;
    CREATE EXTENSION hstore;
.if n \{.RE
.\}

Update a pre-9.1 installation of
hstore
into extension style:

.if n \{.RS 4
.\}
    CREATE EXTENSION hstore SCHEMA public FROM unpackaged;
.if n \{.RE
.\}

Be careful to specify the schema in which you installed the existing
hstore
objects.

<a name="compatibility"></a>

# Compatibility


**CREATE EXTENSION**
is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

ALTER EXTENSION (**ALTER\_EXTENSION**(7)), DROP EXTENSION (**DROP\_EXTENSION**(7))
