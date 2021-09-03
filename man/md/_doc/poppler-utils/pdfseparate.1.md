# pdfseparate(1) - Portable Document Format (PDF) page extractor

15 September 2011

```
pdfseparate [options] PDF-file PDF-page-pattern
```

<a name="description"></a>

# Description

**pdfseparate**
extract single pages from a Portable Document Format (PDF).

pdfseparate reads the PDF file
_PDF-file_,
extracts one or more pages, and writes one PDF file for each page to
_PDF-page-pattern._

PDF-page-pattern should contain
**%d**
(or any variant respecting printf format), since %d is replaced by the page number.

* The PDF-file should not be encrypted.  

<a name="options"></a>

# Options


* **-f**_ number_  
  Specifies the first page to extract. If -f is omitted, extraction starts with page 1.
* **-l**_ number_  
  Specifies the last page to extract. If -l is omitted, extraction ends with the last page.
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

pdfseparate sample.pdf sample-%d.pdf

* extracts all pages from sample.pdf, if i.e. sample.pdf has 3 pages, it produces  
* sample-1.pdf, sample-2.pdf, sample-3.pdf  

<a name="author"></a>

# Author

The pdfseparate software and documentation are copyright 1996-2004 Glyph
& Cog, LLC and copyright 2005-2011 The Poppler Developers - http://poppler.freedesktop.org

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
**pdfsig**(1),
**pdfunite**(1)
