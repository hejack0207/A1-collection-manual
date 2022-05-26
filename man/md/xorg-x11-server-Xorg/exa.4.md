# exa(4) - new 2D acceleration architecture for X.Org

X Version 11, xorg-server 1.20.11


<a name="description"></a>

# Description

**EXA**
provides a simple API for video drivers to implement for 2D acceleration.  It
is a module loaded by drivers, and is not intended to be loaded on its own.
See your driver's manual page for how to enable
**EXA**.

The
**EXA**
architecture is designed to make accelerating the Render extension simple and
efficient, and results in various performance tradeoffs compared to XAA.  Some
xorg.conf options are available for debugging performance issues or
driver rendering problems.  They are not intended for general use.

* **Option EXANoComposite\*q \*q**_boolean_**\*q**  
  Disables acceleration of the Composite operation, which is at the heart of
  the Render extension.  Not related to the Composite extension.  Default: No.
* **Option EXANoUploadToScreen\*q \*q**_boolean_**\*q**  
  Disables acceleration of uploading pixmap data to the framebuffer. Default: No.
* **Option EXANoDownloadFromScreen\*q \*q**_boolean_**\*q**  
  Disables acceleration of downloading of pixmap data from the framebuffer.
  **NOTE:**
  Not usable with drivers which rely on DownloadFromScreen succeeding.
  Default: No.
* **Option MigrationHeuristic\*q \*q**_anystr_**\*q**  
  Chooses an alternate pixmap migration heuristic, for debugging purposes.  The
  default is intended to be the best performing one for general use, though others
  may help with specific use cases.  Available options include always\*q,
  greedy\*q, and \*qsmart\*q.  Default: always.

<a name="see-also"></a>

# See Also

**Xorg**(1),
**xorg.conf(5).**

<a name="authors"></a>

# Authors

Authors include: Keith Packard, Eric Anholt, Zack Rusin, and Michel D\(:anzer
