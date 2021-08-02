# colcrt(1) - filter nroff output for CRT previewing

util-linux, September 2011

```
colcrt [options] [file...]
```

<a name="description"></a>

# Description

**colcrt**
provides virtual half-line and reverse line feed sequences for terminals
without such capability, and on which overstriking is destructive.
Half-line characters and underlining (changed to dashing \`-') are placed on
new lines in between the normal output lines.

<a name="options"></a>

# Options


* **-**, **--no-underlining**  
  Suppress all underlining.  This option is especially useful for previewing
  _allboxed_
  tables from
  **tbl**(1).
* **-2**, **--half-lines**  
  Causes all half-lines to be printed, effectively double spacing the output.
  Normally, a minimal space output format is used which will suppress empty
  lines.  The program never suppresses two consecutive empty lines, however.
  The
  **-2**
  option is useful for sending output to the line printer when the output
  contains superscripts and subscripts which would otherwise be invisible.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="examples"></a>

# Examples

A typical use of
**colcrt**
would be:

**tbl exum2.n | nroff -ms | colcrt - | more**

<a name="see-also"></a>

# See Also

**col**(1),
**more**(1),
**nroff**(1),
**troff**(1),
**ul**(1)

<a name="bugs"></a>

# Bugs

Should fold underlines onto blanks even with the
**'-'**
option so that a true underline character would show.

Can't back up more than 102 lines.

General overstriking is lost; as a special case '|' overstruck with '-' or
underline becomes '+'.

Lines are trimmed to 132 characters.

Some provision should be made for processing superscripts and subscripts in
documents which are already double-spaced.

<a name="history"></a>

# History

The
**colcrt**
command appeared in 3.0BSD.

<a name="availability"></a>

# Availability

The colcrt command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
