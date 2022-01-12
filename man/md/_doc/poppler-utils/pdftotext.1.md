# pdftotext(1) - Portable Document Format (PDF) to text converter

15 August 2011

(version 3.03)

<a name="synopsis"></a>

# Synopsis

```
pdftotext [options] [PDF-file [text-file]]
```

<a name="description"></a>

# Description

**Pdftotext**
converts Portable Document Format (PDF) files to plain text.

Pdftotext reads the PDF file,
_PDF-file_,
and writes a text file,
_text-file_.
If
_text-file_
is not specified, pdftotext converts
_file.pdf_
to
_file.txt_.
If 
_text-file_
is \'-', the text is sent to stdout.

<a name="options"></a>

# Options


* **-f**_ number_  
  Specifies the first page to convert.
* **-l**_ number_  
  Specifies the last page to convert.
* **-r**_ number_  
  Specifies the resolution, in DPI.  The default is 72 DPI.
* **-x**_ number_  
  Specifies the x-coordinate of the crop area top left corner
* **-y**_ number_  
  Specifies the y-coordinate of the crop area top left corner
* **-W**_ number_  
  Specifies the width of crop area in pixels (default is 0)
* **-H**_ number_  
  Specifies the height of crop area in pixels (default is 0)
* **-layout**  
  Maintain (as best as possible) the original physical layout of the
  text.  The default is to \'undo' physical layout (columns,
  hyphenation, etc.) and output the text in reading order.
* **-fixed**_ number_  
  Assume fixed-pitch (or tabular) text, with the specified character
  width (in points).  This forces physical layout mode.
* **-raw**  
  Keep the text in content stream order.  This is a hack which often
  "undoes" column formatting, etc.  Use of raw mode is no longer
  recommended.
* **-htmlmeta**  
  Generate a simple HTML file, including the meta information.  This
  simply wraps the text in &lt;pre&gt; and &lt;/pre&gt; and prepends the meta
  headers.
* **-bbox**  
  Generate an XHTML file containing bounding box information for each
  word in the file.
* **-bbox-layout**  
  Generate an XHTML file containing bounding box information for each
  block, line, and word in the file.
* **-enc**_ encoding-name_  
  Sets the encoding to use for text output. This defaults to "UTF-8".
* **-listenc**  
  Lits the available encodings
* **-eol**_ unix | dos | mac_  
  Sets the end-of-line convention to use for text output.
* **-nopgbrk**  
  Don't insert page breaks (form feed characters) between pages.
* **-opw**_ password_  
  Specify the owner password for the PDF file.  Providing this will
  bypass all security restrictions.
* **-upw**_ password_  
  Specify the user password for the PDF file.
* **-q**  
  Don't print any messages or errors.
* **-v**  
  Print copyright and version information.
* **-h**  
  Print usage information.
  (**-help**
  and
  **--help**
  are equivalent.)

<a name="bugs"></a>

# Bugs

Some PDF files contain fonts whose encodings have been mangled beyond
recognition.  There is no way (short of OCR) to extract text from
these files.

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

The pdftotext software and documentation are copyright 1996-2011 Glyph
& Cog, LLC.

<a name="see-also"></a>

# See Also

**pdfdetach**(1),
**pdffonts**(1),
**pdfimages**(1),
**pdfinfo**(1),
**pdftocairo**(1),
**pdftohtml**(1),
**pdftoppm**(1),
**pdftops**(1),
**pdfseparate**(1),
**pdfsig**(1),
**pdfunite**(1)
