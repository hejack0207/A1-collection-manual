# pdftohtml(1) - program to convert PDF files into HTML, XML and PNG images

```
pdftohtml "[options] <PDF-file> [<HTML-file> <XML-file>]"
```

<a name="description"></a>

# Description

This manual page documents briefly the
**pdftohtml**
command.
This manual page was written for the Debian GNU/Linux distribution
because the original program does not have a manual page.

**pdftohtml**
is a program that converts PDF documents into HTML. It generates its output in
the current working directory.

<a name="options"></a>

# Options

A summary of options are included below.

* **-h, -help**  
  Show summary of options.
* **-f &lt;int&gt;**  
  first page to print
* **-l &lt;int&gt;**  
  last page to print
* **-q**  
  do not print any messages or errors
* **-v**  
  print copyright and version info
* **-p**  
  exchange .pdf links with .html
* **-c**  
  generate complex output
* **-s**  
  generate single HTML that includes all pages
* **-i**  
  ignore images
* **-noframes**  
  generate no frames. Not supported in complex output mode.
* **-stdout**  
  use standard output
* **-zoom &lt;fp&gt;**  
  zoom the PDF document (default 1.5)
* **-xml**  
  output for XML post-processing
* **-noRoundedCoordinates**  
  do not round coordinates (with XML output only)
* **-enc &lt;string&gt;**  
  output text encoding name
* **-opw &lt;string&gt;**  
  owner password (for encrypted files)
* **-upw &lt;string&gt;**  
  user password (for encrypted files)
* **-hidden**  
  force hidden text extraction
* **-fmt**  
  image file format for Splash output (png or jpg).
  If complex is selected, but -fmt is not specified,
  -fmt png will be assumed
* **-nomerge**  
  do not merge paragraphs
* **-nodrm**  
  override document DRM settings
* **-wbt &lt;fp&gt;**  
  adjust the word break threshold percent. Default is 10.
  Word break occurs when distance between two adjacent characters is
  greater than this percent of character height.
* **-fontfullname**  
  outputs the font name without any substitutions.
  

<a name="author"></a>

# Author


Pdftohtml was developed by Gueorgui Ovtcharov and Rainer Dorsch. It is
based and benefits a lot from Derek Noonburg's xpdf package.

This manual page was written by Søren Boll Overgaard &lt;[boll@debian.org](mailto:boll@debian.org)&gt;,
for the Debian GNU/Linux system (but may be used by others).

<a name="see-also"></a>

# See Also

**pdfdetach**(1),
**pdffonts**(1),
**pdfimages**(1),
**pdfinfo**(1),
**pdftocairo**(1),
**pdftoppm**(1),
**pdftops**(1),
**pdftotext**(1)
**pdfseparate**(1),
**pdfsig**(1),
**pdfunite**(1)
