# pdftoppm(1) - Portable Document Format (PDF) to Portable Pixmap (PPM)

15 August 2011

converter (version 3.03)

<a name="synopsis"></a>

# Synopsis

```
pdftoppm [options] PDF-file PPM-root
```

<a name="description"></a>

# Description

**Pdftoppm**
converts Portable Document Format (PDF) files to color image files in
Portable Pixmap (PPM) format, grayscale image files in Portable
Graymap (PGM) format, or monochrome image files in Portable Bitmap
(PBM) format.

Pdftoppm reads the PDF file,
_PDF-file_,
and writes one PPM file for each page,
_PPM-root_-_number_.ppm,
where
_number_
is the page number.

<a name="options"></a>

# Options


* **-f**_ number_  
  Specifies the first page to convert.
* **-l**_ number_  
  Specifies the last page to convert.
* **-o**  
  Generates only the odd numbered pages.
* **-e**  
  Generates only the even numbered pages.
* **-singlefile**  
  Writes only the first page and does not add digits.
* **-r**_ number_  
  Specifies the X and Y resolution, in DPI.  The default is 150 DPI.
* **-rx**_ number_  
  Specifies the X resolution, in DPI.  The default is 150 DPI.
* **-ry**_ number_  
  Specifies the Y resolution, in DPI.  The default is 150 DPI.
* **-scale-to**_ number_  
  Scales the long side of each page (width for landscape pages, height
  for portrait pages) to fit in scale-to pixels. The size of the short
  side will be determined by the aspect ratio of the page.
* **-scale-to-x**_ number_  
  Scales each page horizontally to fit in scale-to-x pixels. If
  scale-to-y is set to -1, the vertical size will determined by the
  aspect ratio of the page.
* **-scale-to-y**_ number_  
  Scales each page vertically to fit in scale-to-y pixels. If scale-to-x
  is set to -1, the horizontal size will determined by the aspect ratio
  of the page.
* **-x**_ number_  
  Specifies the x-coordinate of the crop area top left corner
* **-y**_ number_  
  Specifies the y-coordinate of the crop area top left corner
* **-W**_ number_  
  Specifies the width of crop area in pixels (default is 0)
* **-H**_ number_  
  Specifies the height of crop area in pixels (default is 0)
* **-sz**_ number_  
  Specifies the size of crop square in pixels (sets W and H)
* **-cropbox**  
  Uses the crop box rather than media box when generating the files
* **-mono**  
  Generate a monochrome PBM file (instead of a color PPM file).
* **-gray**  
  Generate a grayscale PGM file (instead of a color PPM file).
* **-png**  
  Generates a PNG file instead a PPM file.
* **-jpeg**  
  Generates a JPEG file instead a PPM file.
* **-jpegopt**_ jpeg-options_  
  When used with -jpeg, takes a list of options to control the jpeg compression. See
  **JPEG OPTIONS**
  for the available options.
* **-tiff**  
  Generates a TIFF file instead a PPM file.
* **-tiffcompression**_ none | packbits | jpeg | lzw | deflate_  
  Specifies the TIFF compression type.  This defaults to "none".
* **-freetype**_ yes | no_  
  Enable or disable FreeType (a TrueType / Type 1 font rasterizer).
  This defaults to "yes".
* **-thinlinemode**_ none | solid | shape_  
  Specifies the thin line mode. This defaults to "none".
* "solid":   
  adjust lines with a width less than one pixel to pixel boundary 
  and paint it with a width of one pixel.
* "shape":   
  adjust lines with a width less than one pixel to pixel boundary 
  and paint it with a width of one pixel but with a shape in proportion
  to its width.
* **-aa**_ yes | no_  
  Enable or disable font anti-aliasing.  This defaults to "yes".
* **-aaVector**_ yes | no_  
  Enable or disable vector anti-aliasing.  This defaults to "yes".
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

<a name="jpeg-options"></a>

# Jpeg Options

When JPEG output is specified, the -jpegopt option can be used to control the JPEG compression parameters.
It takes a string of the form "&lt;opt&gt;=&lt;val&gt;[,&lt;opt&gt;=&lt;val&gt;]". Currently the available options are:

* **quality**  
  Selects the JPEG quality value. The value must be an integer between 0 and 100.
* **progressive**  
  Select progressive JPEG output. The possible values are "y", "n",
  indicating progressive (yes) or non-progressive (no), respectively.
* **optimize**  
  Sets whether to compute optimal Huffman coding tables for the JPEG output, which
  will create smaller files but make an extra pass over the data. The value must
  be "y" or "n", with "y" performing optimization, otherwise the default Huffman
  tables are used.

<a name="author"></a>

# Author

The pdftoppm software and documentation are copyright 1996-2011 Glyph
& Cog, LLC.

<a name="see-also"></a>

# See Also

**pdfdetach**(1),
**pdffonts**(1),
**pdfimages**(1),
**pdfinfo**(1),
**pdftocairo**(1),
**pdftohtml**(1),
**pdftops**(1),
**pdftotext**(1)
**pdfseparate**(1),
**pdfsig**(1),
**pdfunite**(1)
