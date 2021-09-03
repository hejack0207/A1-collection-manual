# pdfdetach(1) - Portable Document Format (PDF) document embedded file

15 August 2011

extractor (version 3.03)

<a name="synopsis"></a>

# Synopsis

```
pdfdetach [options] [PDF-file]
```

<a name="description"></a>

# Description

**Pdfdetach**
lists or extracts embedded files (attachments) from a Portable
Document Format (PDF) file.

<a name="options"></a>

# Options

Some of the following options can be set with configuration file
commands.  These are listed in square brackets with the description of
the corresponding command line option.

* **-list**  
  List all of the embedded files in the PDF file.  File names are
  converted to the text encoding specified by the "-enc" switch.
* **-save**_ number_  
  Save the specified embedded file.  By default, this uses the file name
  associated with the embedded file (as printed by the "-list" switch);
  the file name can be changed with the "-o" switch.
* **-saveall**  
  Save all of the embedded files.  This uses the file names associated
  with the embedded files (as printed by the "-list" switch).  By
  default, the files are saved in the current directory; this can be
  changed with the "-o" switch.
* **-o**_ path_  
  Set the file name used when saving an embedded file with the "-save"
  switch, or the directory used by "-saveall".
* **-enc**_ encoding-name_  
  Sets the encoding to use for text output (embedded file names).
  This defaults to "UTF-8".
* **-opw**_ password_  
  Specify the owner password for the PDF file.  Providing this will
  bypass all security restrictions.
* **-upw**_ password_  
  Specify the user password for the PDF file.
* **-v**  
  Print copyright and version information.
* **-h**  
  Print usage information.
  (**-help**
  and
  **--help**
  are equivalent.)

<a name="exit-codes"></a>

# Exit Codes

The Xpdf tools use the following exit codes:

* 0
  No error.
* 1
  Error opening a PDF file.
* 2
  Error opening an output file.
* 3
  Error related to PDF permissions.
* 99
  Other error.

<a name="author"></a>

# Author

The pdfinfo software and documentation are copyright 1996-2011 Glyph &
Cog, LLC.

<a name="see-also"></a>

# See Also

**pdffonts**(1),
**pdfimages**(1),
**pdfinfo**(1),
**pdftocairo**(1),
**pdftohtml**(1),
**pdftoppm**(1),
**pdftops**(1),
**pdftotext**(1)
**pdfseparate**(1),
**pdfsig**(1),
**pdfunite**(1)
