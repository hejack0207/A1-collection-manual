# localedef(1) - compile locale definition files

Linux, 2017-09-15

```
.nh localedef [options] outputpath
"localedef --list-archive" [options]
"localedef --delete-from-archive" [options] localename ...
"localedef --add-to-archive" [options] compiledpath
"localedef --version"
"localedef --help"
"localedef --usage"
```

<a name="description"></a>

# Description

The
**localedef**
program reads the indicated
_charmap_
and
_input_
files, compiles them to a binary form quickly usable by the
locale functions in the C library
(**setlocale**(3),
**localeconv**(3),
etc.), and places the output in
_outputpath_.

The
_outputpath_
argument is interpreted as follows:

* *  
  If
  _outputpath_
  contains a slash character ('/'), it is interpreted as the name of the
  directory where the output definitions are to be stored.
  In this case, there is a separate output file for each locale category
  (_LC_TIME_,
  _LC_NUMERIC_,
  and so on).
* *  
  If the
  **--no-archive**
  option is used,
  _outputpath_
  is the name of a subdirectory in
  _/usr/lib/locale_
  where per-category compiled files are placed.
* *  
  Otherwise,
  _outputpath_
  is the name of a locale and the compiled locale data is added to the
  archive file
  _/usr/lib/locale/locale-archive_.
  A locale archive is a memory-mapped file which contains all the
  system-provided locales;
  it is used by all localized programs when the environment variable
  **LOCPATH**
  is not set.

In any case,
**localedef**
aborts if the directory in which it tries to write locale files has
not already been created.

If no
_charmapfile_
is given, the value
_ANSI_X3.4-1968_
(for ASCII) is used by default.
If no
_inputfile_
is given, or if it is given as a dash
(-),
**localedef**
reads from standard input.

<a name="options"></a>

# Options


<a name="operation-selection-options"></a>

### Operation-selection options

A few options direct
**localedef**
to do something other than compile locale definitions.
Only one of these options should be used at a time.

* **--delete-from-archive**  
  Delete the named locales from the locale archive file.
* **--list-archive**  
  List the locales contained in the locale archive file.
* **--add-to-archive**  
  Add the
  _compiledpath_
  directories to the locale archive file.
  The directories should have been created by previous runs of
  **localedef**,
  using
  **--no-archive**.

<a name="other-options"></a>

### Other options

Some of the following options are sensible only for certain operations;
generally, it should be self-evident which ones.

* **-f**_ charmapfile_**, --charmap=**_charmapfile_  
  Specify the file that defines the character set
  that is used by the input file.
  If
  _charmapfile_
  contains a slash character ('/'),
  it is interpreted as the name of the character map.
  Otherwise, the file is sought in the current directory
  and the default directory for character maps.
  If the environment variable
  **I18NPATH**
  is set,
  _$I18NPATH/charmaps/_
  and
  _$I18NPATH/_
  are also searched after the current directory.
  The default directory for character maps is printed by
  **localedef --help**.
* **-i**_ inputfile_**, --inputfile=**_inputfile_  
  Specify the locale definition file to compile.
  The file is sought in the current directory
  and the default directory for locale definition files.
  If the environment variable
  **I18NPATH**
  is set,
  _$I18NPATH/locales/_
  and
  _$I18NPATH_
  are also searched after the current directory.
  The default directory for locale definition files is printed by
  **localedef --help**.
* **-u**_ repertoirefile_**, --repertoire-map=**_repertoirefile_  
  Read mappings from symbolic names to Unicode code points from
  _repertoirefile_.
  If
  _repertoirefile_
  contains a slash character ('/'),
  it is interpreted as the pathname of the repertoire map.
  Otherwise, the file is sought in the current directory
  and the default directory for repertoire maps.
  If the environment variable
  **I18NPATH**
  is set,
  _$I18NPATH/repertoiremaps/_
  and
  _$I18NPATH_
  are also searched after the current directory.
  The default directory for repertoire maps is printed by
  **localedef --help**.
* **-A**_ aliasfile_**, --alias-file=**_aliasfile_  
  Use
  _aliasfile_
  to look up aliases for locale names.
  There is no default aliases file.
* **--prefix=**_pathname_  
  Set the prefix to be prepended to the full archive pathname.
  By default, the prefix is empty.
  Setting the prefix to
  _foo_,
  the archive would be placed in
  _foo/usr/lib/locale/locale-archive_.
* **-c**, **--force**  
  Write the output files even if warnings were generated about the input
  file.
* **-v**, **--verbose**  
  Generate extra warnings about errors that are normally ignored.
* **--quiet**  
  Suppress all notifications and warnings, and report only fatal errors.
* **--posix**  
  Conform strictly to POSIX.  Implies
  **--verbose**.
  This option currently has no other effect.
  POSIX conformance is assumed if the environment variable
  **POSIXLY_CORRECT**
  is set.
* **--replace**  
  Replace a locale in the locale archive file.
  Without this option, if the locale is in the archive file already,
  an error occurs.
* **--no-archive**  
  Do not use the locale archive file, instead create
  _outputpath_
  as a subdirectory in the same directory as the locale archive file,
  and create separate output files for locale categories in it.
  This is helpful to prevent system locale archive updates from overwriting
  custom locales created with
  **localedef**.
* **-?**, **--help**  
  Print a usage summary and exit.
  Also prints the default paths used by
  **localedef**.
* **--usage**  
  Print a short usage summary and exit.
* **-V**, **--version**  
  Print the version number, license, and disclaimer of warranty for
  **localedef**.

<a name="exit-status"></a>

# Exit Status

One of the following exit values can be returned by
**localedef**:

* **0**
  Command completed successfully.
* **1**
  Warnings or errors occurred, output files were written.
* **4**
  Errors encountered, no output created.

<a name="environment"></a>

# Environment


* **POSIXLY_CORRECT**  
  The
  **--posix**
  flag is assumed if this environment variable is set.
* **I18NPATH**  
  A colon-separated list of search directories for files.

<a name="files"></a>

# Files


* _/usr/share/i18n/charmaps_  
  Usual default character map path.
* _/usr/share/i18n/locales_  
  Usual default path for locale definition files.
* _/usr/share/i18n/repertoiremaps_  
  Usual default repertoire map path.
* _/usr/lib/locale/locale-archive_  
  Usual default locale archive location.
* _/usr/lib/locale_  
  Usual default path for compiled individual locale data files.
* _outputpath/LC_ADDRESS_  
  An output file that contains information about formatting of
  addresses and geography-related items.
* _outputpath/LC_COLLATE_  
  An output file that contains information about the rules for comparing
  strings.
* _outputpath/LC_CTYPE_  
  An output file that contains information about character classes.
* _outputpath/LC_IDENTIFICATION_  
  An output file that contains metadata about the locale.
* _outputpath/LC_MEASUREMENT_  
  An output file that contains information about locale measurements
  (metric versus US customary).
* _outputpath/LC_MESSAGES/SYS_LC_MESSAGES_  
  An output file that contains information about the language messages
  should be printed in, and what an affirmative or negative answer looks
  like.
* _outputpath/LC_MONETARY_  
  An output file that contains information about formatting of monetary
  values.
* _outputpath/LC_NAME_  
  An output file that contains information about salutations for persons.
* _outputpath/LC_NUMERIC_  
  An output file that contains information about formatting of nonmonetary
  numeric values.
* _outputpath/LC_PAPER_  
  An output file that contains information about settings related to
  standard paper size.
* _outputpath/LC_TELEPHONE_  
  An output file that contains information about formats to be used with
  telephone services.
* _outputpath/LC_TIME_  
  An output file that contains information about formatting of data and
  time values.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2008.

<a name="example"></a>

# Example

Compile the locale files for Finnish in the UTF-8 character set
and add it to the default locale archive with the name
**fi_FI.UTF-8**:

.in +4n
.EX
localedef -f UTF-8 -i fi_FI fi_FI.UTF-8
.EE
.in

The next example does the same thing, but generates files into the
_fi_FI.UTF-8_
directory which can then be used by programs when the environment
variable
**LOCPATH**
is set to the current directory (note that the last argument must
contain a slash):

.in +4n
.EX
localedef -f UTF-8 -i fi_FI ./fi_FI.UTF-8
.EE
.in

<a name="see-also"></a>

# See Also

**locale**(1),
**charmap**(5),
**locale**(5),
**repertoiremap**(5),
**locale**(7)

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
