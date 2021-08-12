# haddock(1) - documentation tool for annotated Haskell source code

Haddock, version 2.6.1, July 2010

```
haddock [options] file...
```



<a name="description"></a>

# Description

This manual page documents briefly the
**haddock**
command.
Extensive documentation is available in various other formats including DVI,
PostScript and HTML; see below.


_file_
is a filename containing a Haskell source module.
All the modules specified on the command line will be processed together.
When one module refers to an entity in another module being processed, the
documentation will link directly to that entity.

Entities that cannot be found, for example because they are in a module that
is not being processed as part of the current batch, simply will not be
hyperlinked in the generated documentation.
**haddock**
will emit warnings listing all the identifiers it could not resolve.

The modules should not be mutually recursive, as
**haddock**
does not like swimming in circles.



<a name="options"></a>

# Options

The programs follow the usual GNU command line syntax, with long
options starting with two dashes (\`--').
A summary of options is included below.
For a complete description, see the other documentation.


* **-o _DIR**, --odir=DIR_  
  directory in which to put the output files
  
* **-i _FILE**, --read-interface=FILE_  
  read an interface from 
  _FILE_.
  
* **-D _FILE**, --dump-interface=FILE_  
  dump an interface for these modules in  
  _FILE_.
  
* **-l _DIR**, --lib=DIR_  
  location of Haddock's auxiliary files
  
* **-h**, **--html**  
  Generate documentation in HTML format.
  Several files will be generated into the current directory (or the specified
  directory if the 
  **-o**
  option is given), including the following:
    * _index.html_  
      The top level page of the documentation:
      lists the modules available, using indentation to represent the hierarchy if
      the modules are hierarchical.
    * _haddock.css_  
      The stylesheet used by the generated HTML.
      Feel free to modify this to change the colors or layout, or even specify
      your own stylesheet using the
      **--css**
      option.
    * _module.html_  
      An HTML page for each module.
    * _doc-index.html_, _doc-index-XX.html_  
      The index, split into two (functions/constructors and types/classes, as per
      Haskell namespaces) and further split alphabetically.
  
* **--hoogle**  
  output for Hoogle
  
* --html-help=format  
  produce index and table of contents in mshelp, mshelp2 or devhelp format 
  (with _-h_)
  
* **--source-base=**URL  
  Include links to the source files in the generated documentation, where URL
  is the base URL where the source files can be found.
  
* **-s **URL, **--source-module=**URL  
  Include links to the source files in the generated documentation, where URL
  is a source code link for each module (using the %{FILE} or %{MODULE} vars).
  
* **--source-entity=**URL  
  Include links to the source files in the generated documentation, where URL
  is a source code link for each entity (using the %{FILE}, %{MODULE} or %{NAME} vars).
  
* **--comments-base=**URL  
  URL for a comments link on the contents and index pages.
* **--comments-module=**URL  
  URL for a comments link for each module (using the %{MODULE} var).
* **--comments-entity=**URL  
  URL for a comments link for each entity (using the %{FILE}, %{MODULE} or %{NAME} vars).
* **--css=**_FILE_  
  Use the CSS
  _FILE_
  instead of the default stylesheet that comes with
  **haddock**
  for HTML output. It should specify certain classes: see the default stylesheet for details.
  
* **-p _FILE**, --prologue=FILE_  
  Specify a file containing prologue text.
  
* **-t _TITLE**, --title=TITLE_  
  Use _TITLE_ as the page heading for each page in the documentation.
  This will normally be the name of the library being documented.
  
  The title should be a plain string (no markup please!).
  
* **-k _NAME**, --package=NAME_  
  Specify the package name (optional).
  
* **-n**, **--no-implicit-prelude**  
  do not assume Prelude is imported
  
* **-d**, **--debug**  
  Enable extra debugging output.
  
* **-?**, **--help**  
  Display help.
  
* **-V**, **--version**  
  Display version.
  
* **-v**, **--verbose**  
  Verbose status reporting.
  
* **--use-contents=**URL  
  Use a separately-generated HTML contents page.
  
* **--gen-contents**  
  Generate an HTML contents from specified  interfaces.
  
* **--use-index=**URL  
  Use a separately-generated HTML index.
  
* **--gen-index**  
  Generate an HTML index from specified interfaces.
  
* **--ignore-all-exports**  
  Behave as if all modules have the ignore-exports atribute
  
* --hide=MODULE  
  Behave as if _MODULE_ has the hide attribute.
  
* --use-package=PACKAGE   
  The modules being processed depend on _PACKAGE_.
  

<a name="files"></a>

# Files

_/usr/bin/haddock_  
_/usr/share/haddock-2.6.1/html/plus.gif_  
_/usr/share/haddock-2.6.1/html/minus.gif_  
_/usr/share/haddock-2.6.1/html/haskell_icon.gif_  
_/usr/share/haddock-2.6.1/html/haddock.js_  
_/usr/share/haddock-2.6.1/html/haddock.css_  
_/usr/share/haddock-2.6.1/html/haddock-DEBUG.css_


<a name="see-also"></a>

# See Also

_/usr/share/doc/haddock/_,  
the Haddock homepage
[(http://haskell.org/haddock/)](http://haskell.org/haddock/)


<a name="copyright"></a>

# Copyright

Haddock version 2.6.1

Copyright 2006-2010  Simon Marlow &lt;simonmar@microsoft.com&gt;, Dawid Waern &lt;david.waern@gmail.com&gt;.
All rights reserved.



<a name="author"></a>

# Author

This manual page was written by Michael Weber &lt;[michaelw@debian.org](mailto:michaelw@debian.org)&gt;
for the Debian GNU/Linux system (but may be used by others).




