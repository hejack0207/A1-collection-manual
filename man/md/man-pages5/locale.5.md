# locale(5) - describes a locale definition file

Linux, 2017-09-15


<a name="description"></a>

# Description

The
**locale**
definition file contains all the information that the
**localedef**(1)
command needs to convert it into the binary locale database.

The definition files consist of sections which each describe a
locale category in detail.
See
**locale**(7)
for additional details for these categories.

<a name="syntax"></a>

### Syntax

The locale definition file starts with a header that may consist
of the following keywords:

* _escape_char_  
  is followed by a character that should be used as the
  escape-character for the rest of the file to mark characters that
  should be interpreted in a special way.
  It defaults to the backslash (\.
* _comment_char_  
  is followed by a character that will be used as the
  comment-character for the rest of the file.
  It defaults to the number sign (#).

The locale definition has one part for each locale category.
Each part can be copied from another existing locale or
can be defined from scratch.
If the category should be copied,
the only valid keyword in the definition is
_copy_
followed by the name of the locale in double quotes which should be
copied.
The exceptions for this rule are
**LC_COLLATE**
and
**LC_CTYPE**
where a
_copy_
statement can be followed by locale-specific rules and selected overrides.

When defining a locale or a category from scratch, an existing system-
provided locale definition file should be used as a reference to follow
common glibc conventions.

<a name="locale-category-sections"></a>

### Locale category sections

The following category sections are defined by POSIX:

* *  
  **LC_CTYPE**
* *  
  **LC_COLLATE**
* *  
  **LC_MESSAGES**
* *  
  **LC_MONETARY**
* *  
  **LC_NUMERIC**
* *  
  **LC_TIME**

In addition, since version 2.2,
the GNU C library supports the following nonstandard categories:

* *  
  **LC_ADDRESS**
* *  
  **LC_IDENTIFICATION**
* *  
  **LC_MEASUREMENT**
* *  
  **LC_NAME**
* *  
  **LC_PAPER**
* *  
  **LC_TELEPHONE**

See
**locale**(7)
for a more detailed description of each category.


<a name="lc_address"></a>

### LC_ADDRESS

The definition starts with the string
_LC_ADDRESS_
in the first column.

The following keywords are allowed:

* _postal_fmt_  
  followed by a string containing field descriptors that define
  the format used for postal addresses in the locale.
  The following field descriptors are recognized:
    * %n  
      Person's name, possibly constructed with the
      **LC_NAME**
      _name_fmt_
      keyword (since glibc 2.24).
    * %a  
      Care of person, or organization.
    * %f  
      Firm name.
    * %d  
      Department name.
    * %b  
      Building name.
    * %s  
      Street or block (e.g., Japanese) name.
    * %h  
      House number or designation.
    * %N  
      Insert an end-of-line if the previous descriptor's value was not an empty
      string; otherwise ignore.
    * %t  
      Insert a space if the previous descriptor's value was not an empty string;
      otherwise ignore.
    * %r  
      Room number, door designation.
    * %e  
      Floor number.
    * %C  
      Country designation, from the
      _country_post_
      keyword.
    * %l  
      Local township within town or city (since glibc 2.24).
    * %z  
      Zip number, postal code.
    * %T  
      Town, city.
    * %S  
      State, province, or prefecture.
    * %c  
      Country, as taken from data record.

Each field descriptor may have an 'R' after
the '%' to specify that the
information is taken from a Romanized version string of the
entity.

* _country_name_  
  followed by the country name in the language of the current document
  (e.g., "Deutschland" for the
  **de_DE**
  locale).
* _country_post_  
  followed by the abbreviation of the country (see CERT_MAILCODES).
* _country_ab2_  
  followed by the two-letter abbreviation of the country (ISO 3166).
* _country_ab3_  
  followed by the three-letter abbreviation of the country (ISO 3166).
* _country_num_  
  followed by the numeric country code (ISO 3166).
* _country_car_  
  followed by the international licence plate country code.
* _country_isbn_  
  followed by the ISBN code (for books).
* _lang_name_  
  followed by the language name in the language of the current document.
* _lang_ab_  
  followed by the two-letter abbreviation of the language (ISO 639).
* _lang_term_  
  followed by the three-letter abbreviation of the language (ISO 639-2/T).
* _lang_lib_  
  followed by the three-letter abbreviation of the language for library
  use (ISO 639-2/B).
  Applications should in general prefer
  _lang_term_
  over
  _lang_lib_.

The
**LC_ADDRESS**
definition ends with the string
_END LC_ADDRESS_.

<a name="lc_ctype"></a>

### LC_CTYPE

The definition starts with the string
_LC_CTYPE_
in the first column.

The following keywords are allowed:

* _upper_  
  followed by a list of uppercase letters.
  The letters
  **A**
  through
  **Z**
  are included automatically.
  Characters also specified as
  **cntrl**,
  **digit**,
  **punct**,
  or
  **space**
  are not allowed.
* _lower_  
  followed by a list of lowercase letters.
  The letters
  **a**
  through
  **z**
  are included automatically.
  Characters also specified as
  **cntrl**,
  **digit**,
  **punct**,
  or
  **space**
  are not allowed.
* _alpha_  
  followed by a list of letters.
  All character specified as either
  **upper**
  or
  **lower**
  are automatically included.
  Characters also specified as
  **cntrl**,
  **digit**,
  **punct**,
  or
  **space**
  are not allowed.
* _digit_  
  followed by the characters classified as numeric digits.
  Only the
  digits
  **0**
  through
  **9**
  are allowed.
  They are included by default in this class.
* _space_  
  followed by a list of characters defined as white-space
  characters.
  Characters also specified as
  **upper**,
  **lower**,
  **alpha**,
  **digit**,
  **graph**,
  or
  **xdigit**
  are not allowed.
  The characters
  **&lt;space&gt;**,
  **&lt;form-feed&gt;**,
  **&lt;newline&gt;**,
  **&lt;carriage-return&gt;**,
  **&lt;tab&gt;**,
  and
  **&lt;vertical-tab&gt;**
  are automatically included.
* _cntrl_  
  followed by a list of control characters.
  Characters also specified as
  **upper**,
  **lower**,
  **alpha**,
  **digit**,
  **punct**,
  **graph**,
  **print**,
  or
  **xdigit**
  are not allowed.
* _punct_  
  followed by a list of punctuation characters.
  Characters also
  specified as
  **upper**,
  **lower**,
  **alpha**,
  **digit**,
  **cntrl**,
  **xdigit**,
  or the
  **&lt;space&gt;**
  character are not allowed.
* _graph_  
  followed by a list of printable characters, not including the
  **&lt;space&gt;**
  character.
  The characters defined as
  **upper**,
  **lower**,
  **alpha**,
  **digit**,
  **xdigit**,
  and
  **punct**
  are automatically included.
  Characters also specified as
  **cntrl**
  are not allowed.
* _print_  
  followed by a list of printable characters, including the
  **&lt;space&gt;**
  character.
  The characters defined as
  **upper**,
  **lower**,
  **alpha**,
  **digit**,
  **xdigit**,
  **punct**,
  and the
  **&lt;space&gt;**
  character are automatically included.
  Characters also specified as
  **cntrl**
  are not allowed.
* _xdigit_  
  followed by a list of characters classified as hexadecimal
  digits.
  The decimal digits must be included followed by one or
  more set of six characters in ascending order.
  The following
  characters are included by default:
  **0**
  through
  **9**,
  **a**
  through
  **f**,
  **A**
  through
  **F**.
* _blank_  
  followed by a list of characters classified as
  **blank**.
  The characters
  **&lt;space&gt;**
  and
  **&lt;tab&gt;**
  are automatically included.
* _charclass_  
  followed by a list of locale-specific character class names
  which are then to be defined in the locale.
* _toupper_  
  followed by a list of mappings from lowercase to uppercase
  letters.
  Each mapping is a pair of a lowercase and an uppercase letter
  separated with a
  **,**
  and enclosed in parentheses.
* _tolower_  
  followed by a list of mappings from uppercase to lowercase
  letters.
  If the keyword tolower is not present, the reverse of the
  toupper list is used.
* _map totitle_  
  followed by a list of mapping pairs of
  characters and letters
  to be used in titles (headings).
* _class_  
  followed by a locale-specific character class definition,
  starting with the class name followed by the characters
  belonging to the class.
* _charconv_  
  followed by a list of locale-specific character mapping names
  which are then to be defined in the locale.
* _outdigit_  
  followed by a list of alternate output digits for the locale.
* _map to_inpunct_  
  followed by a list of mapping pairs of
  alternate digits and separators
  for input digits for the locale.
* _map to_outpunct_  
  followed by a list of mapping pairs of
  alternate separators
  for output for the locale.
* _translit_start_  
  marks the start of the transliteration rules section.
  The section can contain the
  _include_
  keyword in the beginning followed by
  locale-specific rules and overrides.
  Any rule specified in the locale file
  will override any rule
  copied or included from other files.
  In case of duplicate rule definitions in the locale file,
  only the first rule is used.
* A transliteration rule consist of a character to be transliterated
  followed by a list of transliteration targets separated by semicolons.
  The first target which can be presented in the target character set
  is used, if none of them can be used the
  _default_missing_
  character will be used instead.
* _include_  
  in the transliteration rules section includes
  a transliteration rule file
  (and optionally a repertoire map file).
* _default_missing_  
  in the transliteration rules section
  defines the default character to be used for
  transliteration where none of the targets cannot be presented
  in the target character set.
* _translit_end_  
  marks the end of the transliteration rules.

The
**LC_CTYPE**
definition ends with the string
_END LC_CTYPE_.

<a name="lc_collate"></a>

### LC_COLLATE

Note that glibc does not support all POSIX-defined options,
only the options described below are supported (as of glibc 2.23).

The definition starts with the string
_LC_COLLATE_
in the first column.

The following keywords are allowed:

* _coll_weight_max_  
  followed by the number representing used collation levels.
  This keyword is recognized but ignored by glibc.
* _collating-element_  
  followed by the definition of a collating-element symbol
  representing a multicharacter collating element.
* _collating-symbol_  
  followed by the definition of a collating symbol
  that can be used in collation order statements.
* _define_  
  followed by
  **string**
  to be evaluated in an
  _ifdef_
  **string**
  /
  _else_
  /
  _endif_
  construct.
* _reorder-after_  
  followed by a redefinition of a collation rule.
* _reorder-end_  
  marks the end of the redefinition of a collation rule.
* _reorder-sections-after_  
  followed by a script name to reorder listed scripts after.
* _reorder-sections-end_  
  marks the end of the reordering of sections.
* _script_  
  followed by a declaration of a script.
* _symbol-equivalence_  
  followed by a collating-symbol to be equivalent to another defined
  collating-symbol.

The collation rule definition starts with a line:

* _order_start_  
  followed by a list of keywords chosen from
  **forward**,
  **backward**,
  or
  **position**.
  The order definition consists of lines that describe the collation
  order and is terminated with the keyword
  _order_end_.

The
**LC_COLLATE**
definition ends with the string
_END LC_COLLATE_.

<a name="lc_identification"></a>

### LC_IDENTIFICATION

The definition starts with the string
_LC_IDENTIFICATION_
in the first column.

The following keywords are allowed:

* _title_  
  followed by the title of the locale document
  (e.g., "Maori language locale for New Zealand").
* _source_  
  followed by the name of the organization that maintains this document.
* _address_  
  followed by the address of the organization that maintains this document.
* _contact_  
  followed by the name of the contact person at
  the organization that maintains this document.
* _email_  
  followed by the email address of the person or
  organization that maintains this document.
* _tel_  
  followed by the telephone number (in international format)
  of the organization that maintains this document.
  As of glibc 2.24, this keyword is deprecated in favor of
  other contact methods.
* _fax_  
  followed by the fax number (in international format)
  of the organization that maintains this document.
  As of glibc 2.24, this keyword is deprecated in favor of
  other contact methods.
* _language_  
  followed by the name of the language to which this document applies.
* _territory_  
  followed by the name of the country/geographic extent
  to which this document applies.
* _audience_  
  followed by a description of the audience for which this document is
  intended.
* _application_  
  followed by a description of any special application
  for which this document is intended.
* _abbreviation_  
  followed by the short name for provider of the source of this document.
* _revision_  
  followed by the revision number of this document.
* _date_  
  followed by the revision date of this document.

In addition, for each of the categories defined by the document,
there should be a line starting with the keyword
_category_,
followed by:

* *  
  a string that identifies this locale category definition,
* *  
  a semicolon, and
* *  
  one of the
  **LC_**_*_
  identifiers.

The
**LC_IDENTIFICATION**
definition ends with the string
_END LC_IDENTIFICATION_.

<a name="lc_messages"></a>

### LC_MESSAGES

The definition starts with the string
_LC_MESSAGES_
in the first column.

The following keywords are allowed:

* _yesexpr_  
  followed by a regular expression that describes possible
  yes-responses.
* _noexpr_  
  followed by a regular expression that describes possible
  no-responses.
* _yesstr_  
  followed by the output string corresponding to "yes".
* _nostr_  
  followed by the output string corresponding to "no".

The
**LC_MESSAGES**
definition ends with the string
_END LC_MESSAGES_.

<a name="lc_measurement"></a>

### LC_MEASUREMENT

The definition starts with the string
_LC_MEASUREMENT_
in the first column.

The following keywords are allowed:

* _measurement_  
  followed by number identifying the standard used for measurement.
  The following values are recognized:
    * **1**  
      Metric.
    * **2**  
      US customary measurements.

The
**LC_MEASUREMENT**
definition ends with the string
_END LC_MEASUREMENT_.

<a name="lc_monetary"></a>

### LC_MONETARY

The definition starts with the string
_LC_MONETARY_
in the first column.

The following keywords are allowed:

* _int_curr_symbol_  
  followed by the international currency symbol.
  This must be a
  4-character string containing the international currency symbol as
  defined by the ISO 4217 standard (three characters) followed by a
  separator.
* _currency_symbol_  
  followed by the local currency symbol.
* _mon_decimal_point_  
  followed by the string that will be used as the decimal delimiter
  when formatting monetary quantities.
* _mon_thousands_sep_  
  followed by the string that will be used as a group separator
  when formatting monetary quantities.
* _mon_grouping_  
  followed by a sequence of integers separated by semicolons that
  describe the formatting of monetary quantities.
  See
  _grouping_
  below for details.
* _positive_sign_  
  followed by a string that is used to indicate a positive sign for
  monetary quantities.
* _negative_sign_  
  followed by a string that is used to indicate a negative sign for
  monetary quantities.
* _int_frac_digits_  
  followed by the number of fractional digits that should be used when
  formatting with the
  _int_curr_symbol_.
* _frac_digits_  
  followed by the number of fractional digits that should be used when
  formatting with the
  _currency_symbol_.
* _p_cs_precedes_  
  followed by an integer that indicates the placement of
  _currency_symbol_
  for a nonnegative formatted monetary quantity:
    * **0**  
      the symbol succeeds the value.
    * **1**  
      the symbol precedes the value.
* _p_sep_by_space_  
  followed by an integer that indicates the separation of
  _currency_symbol_,
  the sign string, and the value for a nonnegative formatted monetary quantity.
  The following values are recognized:
    * **0**  
      No space separates the currency symbol and the value.
    * **1**  
      If the currency symbol and the sign string are adjacent,
      a space separates them from the value;
      otherwise a space separates the currency symbol and the value.
    * **2**  
      If the currency symbol and the sign string are adjacent,
      a space separates them from the value;
      otherwise a space separates the sign string and the value.
* _n_cs_precedes_  
  followed by an integer that indicates the placement of
  _currency_symbol_
  for a negative formatted monetary quantity.
  The same values are recognized as for
  _p_cs_precedes_.
* _n_sep_by_space_  
  followed by an integer that indicates the separation of
  _currency_symbol_,
  the sign string, and the value for a negative formatted monetary quantity.
  The same values are recognized as for
  _p_sep_by_space_.
* _p_sign_posn_  
  followed by an integer that indicates where the
  _positive_sign_
  should be placed for a nonnegative monetary quantity:
    * **0**  
      Parentheses enclose the quantity and the
      _currency_symbol_
      or
      _int_curr_symbol_.
    * **1**  
      The sign string precedes the quantity and the
      _currency_symbol_
      or the
      _int_curr_symbol_.
    * **2**  
      The sign string succeeds the quantity and the
      _currency_symbol_
      or the
      _int_curr_symbol_.
    * **3**  
      The sign string precedes the
      _currency_symbol_
      or the
      _int_curr_symbol_.
    * **4**  
      The sign string succeeds the
      _currency_symbol_
      or the
      _int_curr_symbol_.
* _n_sign_posn_  
  followed by an integer that indicates where the
  _negative_sign_
  should be placed for a negative monetary quantity.
  The same values are recognized as for
  _p_sign_posn_.
* _int_p_cs_precedes_  
  followed by an integer that indicates the placement of
  _int_curr_symbol_
  for a nonnegative internationally formatted monetary quantity.
  The same values are recognized as for
  _p_cs_precedes_.
* _int_n_cs_precedes_  
  followed by an integer that indicates the placement of
  _int_curr_symbol_
  for a negative internationally formatted monetary quantity.
  The same values are recognized as for
  _p_cs_precedes_.
* _int_p_sep_by_space_  
  followed by an integer that indicates the separation of
  _int_curr_symbol_,
  the sign string,
  and the value for a nonnegative internationally formatted monetary quantity.
  The same values are recognized as for
  _p_sep_by_space_.
* _int_n_sep_by_space_  
  followed by an integer that indicates the separation of
  _int_curr_symbol_,
  the sign string,
  and the value for a negative internationally formatted monetary quantity.
  The same values are recognized as for
  _p_sep_by_space_.
* _int_p_sign_posn_  
  followed by an integer that indicates where the
  _positive_sign_
  should be placed for a nonnegative
  internationally formatted monetary quantity.
  The same values are recognized as for
  _p_sign_posn_.
* _int_n_sign_posn_  
  followed by an integer that indicates where the
  _negative_sign_
  should be placed for a negative
  internationally formatted monetary quantity.
  The same values are recognized as for
  _p_sign_posn_.

The
**LC_MONETARY**
definition ends with the string
_END LC_MONETARY_.

<a name="lc_name"></a>

### LC_NAME

The definition starts with the string
_LC_NAME_
in the first column.

Various keywords are allowed, but only
_name_fmt_
is mandatory.
Other keywords are needed only if there is common convention to
use the corresponding salutation in this locale.
The allowed keywords are as follows:

* _name_fmt_  
  followed by a string containing field descriptors that define
  the format used for names in the locale.
  The following field descriptors are recognized:
    * %f  
      Family name(s).
    * %F  
      Family names in uppercase.
    * %g  
      First given name.
    * %G  
      First given initial.
    * %l  
      First given name with Latin letters.
    * %o  
      Other shorter name.
    * %m  
      Additional given name(s).
    * %M  
      Initials for additional given name(s).
    * %p  
      Profession.
    * %s  
      Salutation, such as "Doctor".
    * %S  
      Abbreviated salutation, such as "Mr." or "Dr.".
    * %d  
      Salutation, using the FDCC-sets conventions.
      
      
      
      
      
      
      
      
      
    * %t  
      If the preceding field descriptor resulted in an empty string,
      then the empty string, otherwise a space character.
* _name_gen_  
  followed by the general salutation for any gender.
* _name_mr_  
  followed by the salutation for men.
* _name_mrs_  
  followed by the salutation for married women.
* _name_miss_  
  followed by the salutation for unmarried women.
* _name_ms_  
  followed by the salutation valid for all women.

The
**LC_NAME**
definition ends with the string
_END LC_NAME_.

<a name="lc_numeric"></a>

### LC_NUMERIC

The definition starts with the string
_LC_NUMERIC_
in the first column.

The following keywords are allowed:

* _decimal_point_  
  followed by the string that will be used as the decimal delimiter
  when formatting numeric quantities.
* _thousands_sep_  
  followed by the string that will be used as a group separator
  when formatting numeric quantities.
* _grouping_  
  followed by a sequence of integers separated by semicolons
  that describe the formatting of numeric quantities.
* Each integer specifies the number of digits in a group.
  The first integer defines the size of the group immediately
  to the left of the decimal delimiter.
  Subsequent integers define succeeding groups to the
  left of the previous group.
  If the last integer is not -1, then the size of the previous group
  (if any) is repeatedly used for the remainder of the digits.
  If the last integer is -1, then no further grouping is performed.

The
**LC_NUMERIC**
definition ends with the string
_END LC_NUMERIC_.

<a name="lc_paper"></a>

### LC_PAPER

The definition starts with the string
_LC_PAPER_
in the first column.

The following keywords are allowed:

* _height_  
  followed by the height, in millimeters, of the standard paper format.
* _width_  
  followed by the width, in millimeters, of the standard paper format.

The
**LC_PAPER**
definition ends with the string
_END LC_PAPER_.

<a name="lc_telephone"></a>

### LC_TELEPHONE

The definition starts with the string
_LC_TELEPHONE_
in the first column.

The following keywords are allowed:

* _tel_int_fmt_  
  followed by a string that contains field descriptors that identify
  the format used to dial international numbers.
  The following field descriptors are recognized:
    * %a  
      Area code without nationwide prefix (the prefix is often "00").
    * %A  
      Area code including nationwide prefix.
    * %l  
      Local number (within area code).
    * %e  
      Extension (to local number).
    * %c  
      Country code.
    * %C  
      Alternate carrier service code used for dialing abroad.
    * %t  
      If the preceding field descriptor resulted in an empty string,
      then the empty string, otherwise a space character.
* _tel_dom_fmt_  
  followed by a string that contains field descriptors that identify
  the format used to dial domestic numbers.
  The recognized field descriptors are the same as for
  _tel_int_fmt_.
* _int_select_  
  followed by the prefix used to call international phone numbers.
* _int_prefix_  
  followed by the prefix used from other countries to dial this country.

The
**LC_TELEPHONE**
definition ends with the string
_END LC_TELEPHONE_.

<a name="lc_time"></a>

### LC_TIME

The definition starts with the string
_LC_TIME_
in the first column.

The following keywords are allowed:

* _abday_  
  followed by a list of abbreviated names of the days of the week.
  The list starts with the first day of the week
  as specified by
  _week_
  (Sunday by default).
  See NOTES.
* _day_  
  followed by a list of names of the days of the week.
  The list starts with the first day of the week
  as specified by
  _week_
  (Sunday by default).
  See NOTES.
* _abmon_  
  followed by a list of abbreviated month names.
* _mon_  
  followed by a list of month names.
* _d_t_fmt_  
  followed by the appropriate date and time format
  (for syntax, see
  **strftime**(3)).
* _d_fmt_  
  followed by the appropriate date format
  (for syntax, see
  **strftime**(3)).
* _t_fmt_  
  followed by the appropriate time format
  (for syntax, see
  **strftime**(3)).
* _am_pm_  
  followed by the appropriate representation of the
  **am**
  and
  **pm**
  strings.
  This should be left empty for locales not using AM/PM convention.
* _t_fmt_ampm_  
  followed by the appropriate time format
  (for syntax, see
  **strftime**(3))
  when using 12h clock format.
  This should be left empty for locales not using AM/PM convention.
* _era_  
  followed by semicolon-separated strings that define how years are
  counted and displayed for each era in the locale.
  Each string has the following format:

_direction_:_offset_:_start_date_:_end_date_:_era_name_:_era_format_

The fields are to be defined as follows:


* _direction_  
  Either
  **+**
  or
  **-.**
  **+**
  means the years closer to
  _start_date_
  have lower numbers than years closer to
  _end_date_.
  **-**
  means the opposite.
* _offset_  
  The number of the year closest to
  _start_date_
  in the era, corresponding to the
  _%Ey_
  descriptor (see
  **strptime**(3)).
* _start_date_  
  The start of the era in the form of
  _yyyy/mm/dd_.
  Years prior AD 1 are represented as negative numbers.
* _end_date_  
  The end of the era in the form of
  _yyyy/mm/dd_,
  or one of the two special values of
  **-***
  or
  **+***.
  **-***
  means the ending date is the beginning of time.
  **+***
  means the ending date is the end of time.
* _era_name_  
  The name of the era corresponding to the
  _%EC_
  descriptor (see
  **strptime**(3)).
* _era_format_  
  The format of the year in the era corresponding to the
  _%EY_
  descriptor (see
  **strptime**(3)).

* _era_d_fmt_  
  followed by the format of the date in alternative era notation,
  corresponding to the
  _%Ex_
  descriptor (see
  **strptime**(3)).
* _era_t_fmt_  
  followed by the format of the time in alternative era notation,
  corresponding to the
  _%EX_
  descriptor (see
  **strptime**(3)).
* _era_d_t_fmt_  
  followed by the format of the date and time in alternative era notation,
  corresponding to the
  _%Ec_
  descriptor (see
  **strptime**(3)).
* _alt_digits_  
  followed by the alternative digits used for date and time in the locale.
* _week_  
  followed by a list of three values separated by semicolons:
  The number of days in a week (by default 7),
  a date of beginning of the week (by default corresponds to Sunday),
  and the minimal length of the first week in year (by default 4).
  Regarding the start of the week,
  **19971130**
  shall be used for Sunday and
  **19971201**
  shall be used for Monday.
  See NOTES.
* _first_weekday_ (since glibc 2.2)  
  followed by the number of the first day from the
  _day_
  list to be shown in calendar applications.
  The default value of
  **1**
  corresponds to either Sunday or Monday depending
  on the value of the second
  _week_
  list item.
  See NOTES.
* _first_workday_ (since glibc 2.2)  
  followed by the number of the first working day from the
  _day_
  list.
  The default value is
  **2**.
  See NOTES.
* _cal_direction_  
  followed by a number value that indicates the direction for the
  display of calendar dates, as follows:
    * **1**  
      Left-right from top.
    * **2**  
      Top-down from left.
    * **3**  
      Right-left from top.
* _date_fmt_  
  followed by the appropriate date representation for
  **date**(1)
  (for syntax, see
  **strftime**(3)).

The
**LC_TIME**
definition ends with the string
_END LC_TIME_.

<a name="files"></a>

# Files


* _/usr/lib/locale/locale-archive_  
  Usual default locale archive location.
* _/usr/share/i18n/locales_  
  Usual default path for locale definition files.

<a name="conforming-to"></a>

# Conforming to

POSIX.2.

<a name="notes"></a>

# Notes

The collective GNU C library community wisdom regarding
_abday_,
_day_,
_week_,
_first_weekday_,
and
_first_workday_
states at
https://sourceware.org/glibc/wiki/Locales
the following:

* *  
  The value of the second
  _week_
  list item specifies the base of the
  _abday_
  and
  _day_
  lists.
* *  
  _first_weekday_
  specifies the offset of the first day-of-week in the
  _abday_
  and
  _day_
  lists.
* *  
  For compatibility reasons, all glibc locales should set the value of the
  second
  _week_
  list item to
  **19971130**
  (Sunday) and base the
  _abday_
  and
  _day_
  lists appropriately, and set
  _first_weekday_
  and
  _first_workday_
  to
  **1**
  or
  **2**,
  depending on whether the week and work week actually starts on Sunday or
  Monday for the locale.
  
  

<a name="see-also"></a>

# See Also

**iconv**(1),
**locale**(1),
**localedef**(1),
**localeconv**(3),
**newlocale**(3),
**setlocale**(3),
**strftime**(3),
**strptime**(3),
**uselocale**(3),
**charmap**(5),
**charsets**(7),
**locale**(7),
**unicode**(7),
**utf-8**(7)

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
