# iceauth(1) - ICE authority file utility

X Version 11, iceauth 1.0.8

```
iceauth [ -f authfile ] [ -vqibuV ] [ command arg ... ]
```

<a name="description"></a>

# Description


The _iceauth_ program is used to edit and display the authorization
information used in connecting with ICE.  This program is usually
used to extract authorization records from one machine and merge them in on
another (as is the case when using remote logins or granting access to
other users).  Commands (described below) may be entered interactively,
on the _iceauth_ command line, or in scripts.

<a name="options"></a>

# Options


**-f** _authfile_  Name of the authority file to use. Will default to
             the file currently in use by the session.

**-v**           Turns on extra messages (verbose mode)

**-q**           Turns off extra messages (quiet mode)

**-i**           Ignore the locks on the authority file

**-b**           Break the locks on the authority file

**-u**           Print basic usage instructions

**-V**           Print version and exit


<a name="usage"></a>

# Usage


When _iceauth_ is run it will allow the following set of commands
to be entered interactively or in scripts.

**?**

List available commands.

**help**

Print help information. You may supply a command name to _help_ to
get specific information about it.

**info**

Print information about the entries in the authority file.

**list**

List (print) entries in the authority file. You may specify optional
modifiers as below to specify which entries are listed.

_list_ [ _protocol\_name_ ] [ _protocol\_data_ ] [
_netid_ ] [ _authname_ ]

**add**

Add an entry to the authority file. This must be in the format

_add_ _protocol\_name_ _protocol\_data_ _netid_ _authname_ _authdata_

**remove**

Remove entries from the authority file.

_remove_ [ _protocol\_name_ ] [ _protocol\_data_ ] [
_netid_ ] [ _authname_ ]

**extract**

Extract entries from the authority file in to a destination file. You
must supply the path to the destination to this command as in the
following format. Optional specifiers allow you to narrow which
entries are extracted.

_extract_ _filename_ [ _protocol\_name_ ] [ _protocol\_data_ ]
[ _netid_ ] [ _authname_ ]

**merge**

Merge entries from other files in to the authority file selected by the program. You may supply any number of file paths to this command as follows:

_merge_ _filename1_ [ _filename2_ ] [ _filename3_ ] ...

**exit**

Save changes and exit the program.

**quit**

Abort changes and exit the program without saving.

**source**

Read and execute commands from a file.

_source_ _filename_


<a name="author"></a>

# Author

Ralph Mor, X Consortium
