# pdfinfo(1) - Portable Document Format (PDF) document information

15 August 2011

extractor (version 3.03)

<a name="synopsis"></a>

# Synopsis

```
pdfinfo [options] [PDF-file]
```

<a name="description"></a>

# Description

**Pdfinfo**
prints the contents of the \'Info' dictionary (plus some other useful
information) from a Portable Document Format (PDF) file.

The \'Info' dictionary contains the following values:

title
subject
keywords
author
creator
producer
creation date
modification date

In addition, the following information is printed:

tagged (yes/no)
form (AcroForm / XFA / none)
javascript (yes/no)
page count
encrypted flag (yes/no)
print and copy permissions (if encrypted)
page size
file size
linearized (yes/no)
PDF version
metadata (only if requested)

The options -listenc, -meta, -js, -struct, and -struct-text only print the requested information. The 'Info' dictionary and related data listed above is not printed. At most one of these five options may be used.

<a name="options"></a>

# Options


* **-f**_ number_  
  Specifies the first page to examine.  If multiple pages are requested
  using the "-f" and "-l" options, the size of each requested page (and,
  optionally, the bounding boxes for each requested page) are printed.
  Otherwise, only page one is examined.
* **-l**_ number_  
  Specifies the last page to examine.
* **-box**  
  Prints the page box bounding boxes: MediaBox, CropBox, BleedBox,
  TrimBox, and ArtBox.
* **-meta**  
  Prints document-level metadata.  (This is the "Metadata" stream from
  the PDF file's Catalog object.)
* **-js**  
  Prints all JavaScript in the PDF.
* **-struct**  
  Prints the logical document structure of a Tagged-PDF file.
* **-struct-text**  
  Print the textual content along with the document structure of a Tagged-PDF
  file.  Note that extracting text this way might be slow for big PDF files.
  (Implies
  **-struct**.)
* **-isodates**  
  Prints dates in ISO-8601 format (including the time zone).
* **-rawdates**  
  Prints the raw (undecoded) date strings, directly from the PDF file.
* **-dests**  
  Print a list of all named destinations. If a page range is specified using "-f" and "-l", only
  destinations in the page range are listed.
* **-enc**_ encoding-name_  
  Sets the encoding to use for text output. This defaults to "UTF-8".
* **-listenc**  
  Lits the available encodings
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

**pdfdetach**(1),
**pdffonts**(1),
**pdfimages**(1),
**pdftocairo**(1),
**pdftohtml**(1),
**pdftoppm**(1),
**pdftops**(1),
**pdftotext**(1)
**pdfseparate**(1),
**pdfsig**(1),
**pdfunite**(1)
