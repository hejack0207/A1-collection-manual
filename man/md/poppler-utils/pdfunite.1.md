# pdfunite(1) - Portable Document Format (PDF) page merger

15 September 2011

```
pdfunite [options] PDF-sourcefile1..PDF-sourcefilen PDF-destfile
```

<a name="description"></a>

# Description

**pdfunite**
merges several PDF (Portable Document Format) files in order of their occurrence on command line to one PDF result file.

* Neither of the PDF-sourcefile1 to PDF-sourcefilen should be encrypted.  

<a name="options"></a>

# Options


* **-v**  
  Print copyright and version information.
* **-h**  
  Print usage information.
  (**-help**
  and
  **--help**
  are equivalent.)

<a name="example"></a>

# Example

pdfunite sample1.pdf sample2.pdf sample.pdf

* merges all pages from sample1.pdf and sample2.pdf (in that order) and creates sample.pdf  

<a name="author"></a>

# Author

The pdfunite software and documentation are copyright 1996-2004 Glyph & Cog, LLC
and copyright 2005-2011 The Poppler Developers - http://poppler.freedesktop.org

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
**pdftotext**(1)
**pdfseparate**(1),
**pdfsig**(1)
