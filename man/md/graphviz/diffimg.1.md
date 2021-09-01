# diffimg(1) - Calculates intersection between two images

Jan 31, 2010

```
diffimg image1 image2 [outimage]
```

<a name="description"></a>

# Description


**diffimg** generates an image where each pixel is the difference between the corresponding pixel
in each of the two source images.  Thus, if the source images are the same the resulting image will
be black, otherwise it will have regions of non-black where the images differ.

Currently supports: .png, .gif, .jpg, and .ps by using ghostscript

<a name="author"></a>

# Author

diffimg was written by John Ellson &lt;[ellson@research.att](mailto:ellson@research.att).com&gt;

This manual page was written by David Claughton &lt;[dave@eclecticdave.com](mailto:dave@eclecticdave.com)&gt;,
for the Debian project (but may be used by others).
