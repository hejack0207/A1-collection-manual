# glob(7) - globbing pathnames

Linux, 2016-10-08


<a name="description"></a>

# Description

Long ago, in UNIX&nbsp;V6, there was a program
_/etc/glob_
that would expand wildcard patterns.
Soon afterward this became a shell built-in.

These days there is also a library routine
**glob**(3)
that will perform this function for a user program.

The rules are as follows (POSIX.2, 3.13).

<a name="wildcard-matching"></a>

### Wildcard matching

A string is a wildcard pattern if it contains one of the
characters '?', '*' or '['.
Globbing is the operation
that expands a wildcard pattern into the list of pathnames
matching the pattern.
Matching is defined by:

A '?' (not between brackets) matches any single character.

A '*' (not between brackets) matches any string,
including the empty string.

**Character classes**

An expression "_[...]_" where the first character after the
leading '[' is not an '!' matches a single character,
namely any of the characters enclosed by the brackets.
The string enclosed by the brackets cannot be empty;
therefore ']' can be allowed between the brackets, provided
that it is the first character.
(Thus, "_[][!]_" matches the
three characters '[', ']' and '!'.)

**Ranges**

There is one special convention:
two characters separated by '-' denote a range.
(Thus, "_[A-Fa-f0-9]_"
is equivalent to "_[ABCDEFabcdef0123456789]_".)
One may include '-' in its literal meaning by making it the
first or last character between the brackets.
(Thus, "_[]-]_" matches just the two characters ']' and '-',
and "_[--0]_" matches the
three characters '-', '.', '0', since '/'
cannot be matched.)

**Complementation**

An expression "_[!...]_" matches a single character, namely
any character that is not matched by the expression obtained
by removing the first '!' from it.
(Thus, "_[!]a-]_" matches any
single character except ']', 'a' and '-'.)

One can remove the special meaning of '?', '*' and '[' by
preceding them by a backslash, or, in case this is part of
a shell command line, enclosing them in quotes.
Between brackets these characters stand for themselves.
Thus, "_[[?*\e]_" matches the
four characters '[', '?', '*' and '\e'.

<a name="pathnames"></a>

### Pathnames

Globbing is applied on each of the components of a pathname
separately.
A '/' in a pathname cannot be matched by a '?' or '*'
wildcard, or by a range like "_[.-0]_".
A range containing an explicit '/' character is syntactically incorrect.
(POSIX requires that syntactically incorrect patterns are left unchanged.)

If a filename starts with a '.',
this character must be matched explicitly.
(Thus, _rm&nbsp;*_ will not remove .profile, and _tar&nbsp;c&nbsp;*_ will not
archive all your files; _tar&nbsp;c&nbsp;._ is better.)

<a name="empty-lists"></a>

### Empty lists

The nice and simple rule given above: "expand a wildcard pattern
into the list of matching pathnames" was the original UNIX
definition.
It allowed one to have patterns that expand into
an empty list, as in

        xv -wait 0 *.gif *.jpg

where perhaps no *.gif files are present (and this is not
an error).
However, POSIX requires that a wildcard pattern is left
unchanged when it is syntactically incorrect, or the list of
matching pathnames is empty.
With
_bash_
one can force the classical behavior using this command:

    shopt -s nullglob


(Similar problems occur elsewhere.
For example, where old scripts have

        rm \`find . -name "*~"\`

new scripts require

        rm -f nosuchfile \`find . -name "*~"\`

to avoid error messages from
_rm_
called with an empty argument list.)

<a name="notes"></a>

# Notes


<a name="regular-expressions"></a>

### Regular expressions

Note that wildcard patterns are not regular expressions,
although they are a bit similar.
First of all, they match
filenames, rather than text, and secondly, the conventions
are not the same: for example, in a regular expression '*' means zero or
more copies of the preceding thing.

Now that regular expressions have bracket expressions where
the negation is indicated by a '^', POSIX has declared the
effect of a wildcard pattern "_[^...]_" to be undefined.

<a name="character-classes-and-internationalization"></a>

### Character classes and internationalization

Of course ranges were originally meant to be ASCII ranges,
so that "_[&nbsp;-%]_" stands for "_[&nbsp;!"#$%]_" and "_[a-z]_" stands
for "any lowercase letter".
Some UNIX implementations generalized this so that a range X-Y
stands for the set of characters with code between the codes for
X and for Y.
However, this requires the user to know the
character coding in use on the local system, and moreover, is
not convenient if the collating sequence for the local alphabet
differs from the ordering of the character codes.
Therefore, POSIX extended the bracket notation greatly,
both for wildcard patterns and for regular expressions.
In the above we saw three types of items that can occur in a bracket
expression: namely (i) the negation, (ii) explicit single characters,
and (iii) ranges.
POSIX specifies ranges in an internationally
more useful way and adds three more types:

(iii) Ranges X-Y comprise all characters that fall between X
and Y (inclusive) in the current collating sequence as defined
by the
**LC_COLLATE**
category in the current locale.

(iv) Named character classes, like

    [:alnum:]  [:alpha:]  [:blank:]  [:cntrl:]
    [:digit:]  [:graph:]  [:lower:]  [:print:]
    [:punct:]  [:space:]  [:upper:]  [:xdigit:]

so that one can say "_[[:lower:]]_" instead of "_[a-z]_", and have
things work in Denmark, too, where there are three letters past 'z'
in the alphabet.
These character classes are defined by the
**LC_CTYPE**
category
in the current locale.

(v) Collating symbols, like "_[.ch.]_" or "_[.a-acute.]_",
where the string between "_[._" and "_.]_" is a collating
element defined for the current locale.
Note that this may
be a multicharacter element.

(vi) Equivalence class expressions, like "_[=a=]_",
where the string between "_[=_" and "_=]_" is any collating
element from its equivalence class, as defined for the
current locale.
For example, "_[[=a=]]_" might be equivalent
to "_[a\('a\(\`a\(:a\(^a]_", that is,
to "_[a[.a-acute.][.a-grave.][.a-umlaut.][.a-circumflex.]]_".

<a name="see-also"></a>

# See Also

**sh**(1),
**fnmatch**(3),
**glob**(3),
**locale**(7),
**regex**(7)

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
