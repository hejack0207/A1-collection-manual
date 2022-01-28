# locale(1) - get locale-specific information

Linux, 2017-09-15

    locale [option]
    locale [option] -a
    locale [option] -m
    locale [option] name...

<a name="description"></a>

# Description

The
**locale**
command displays information about the current locale, or all locales,
on standard output.

When invoked without arguments,
**locale**
displays the current locale settings for each locale category (see
**locale**(5)),
based on the settings of the environment variables that control the locale
(see
**locale**(7)).
Values for variables set in the environment are printed without double
quotes, implied values are printed with double quotes.

If either the
**-a**
or the
**-m**
option (or one of their long-format equivalents) is specified,
the behavior is as follows:

* **-a**, **--all-locales**  
  Display a list of all available locales.
  The
  **-v**
  option causes the
  **LC_IDENTIFICATION**
  metadata about each locale to be included in the output.
* **-m**, **--charmaps**  
  Display the available charmaps (character set description files).
  To display the current character set for the locale, use
  **locale -c charmap**.

The
**locale**
command can also be provided with one or more arguments,
which are the names of locale keywords (for example,
_date_fmt_,
_ctype-class-names_,
_yesexpr_,
or
_decimal_point_)
or locale categories (for example,
**LC_CTYPE**
or
**LC_TIME**).
For each argument, the following is displayed:

* *  
  For a locale keyword, the value of that keyword to be displayed.
* *  
  For a locale category,
  the values of all keywords in that category are displayed.

When arguments are supplied, the following options are meaningful:

* **-c**, **--category-name**  
  For a category name argument,
  write the name of the locale category
  on a separate line preceding the list of keyword values for that category.
* For a keyword name argument,
  write the name of the locale category for this keyword
  on a separate line preceding the keyword value.
* This option improves readability when multiple name arguments are specified.
  It can be combined with the
  **-k**
  option.
* **-k**, **--keyword-name**  
  For each keyword whose value is being displayed,
  include also the name of that keyword,
  so that the output has the format:
*     _keyword_="_value_"

The
**locale**
command also knows about the following options:

* **-v**, **--verbose**  
  Display additional information for some command-line option and argument
  combinations.
* **-?**, **--help**  
  Display a summary of command-line options and arguments and exit.
* **--usage**  
  Display a short usage message and exit.
* **-V**, **--version**  
  Display the program version and exit.

<a name="files"></a>

# Files


* _/usr/lib/locale/locale-archive_  
  Usual default locale archive location.
* _/usr/share/i18n/locales_  
  Usual default path for locale definition files.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="example"></a>

# Example

.EX
$ **locale**
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=

$ **locale date\_fmt**
%a %b %e %H:%M:%S %Z %Y

$ **locale -k date\_fmt**
date_fmt="%a %b %e %H:%M:%S %Z %Y"

$ **locale -ck date\_fmt**
LC_TIME
date_fmt="%a %b %e %H:%M:%S %Z %Y"

$ **locale LC\_TELEPHONE**
+%c (%a) %l
(%a) %l
11
1
UTF-8

$ **locale -k LC\_TELEPHONE**
tel_int_fmt="+%c (%a) %l"
tel_dom_fmt="(%a) %l"
int_select="11"
int_prefix="1"
telephone-codeset="UTF-8"
.EE

The following example compiles a custom locale from the
_./wrk_
directory with the
**localedef**(1)
utility under the
_$HOME/.locale_
directory, then tests the result with the
**date**(1)
command, and then sets the environment variables
**LOCPATH**
and
**LANG**
in the shell profile file so that the custom locale will be used in the
subsequent user sessions:

.EX
$ **mkdir -p $HOME/.locale**
$ **I18NPATH=./wrk/ localedef -f UTF-8 -i fi_SE $HOME/.locale/fi\_SE.UTF-8**
$ **LOCPATH=$HOME/.locale LC_ALL=fi_SE.UTF-8 date**
$ **echo "export LOCPATH=\\$HOME/.locale" &gt;&gt; $HOME/.bashrc**
$ **echo "export LANG=fi_SE.UTF-8" &gt;&gt; $HOME/.bashrc**
.EE

<a name="see-also"></a>

# See Also

**localedef**(1),
**charmap**(5),
**locale**(5),
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
