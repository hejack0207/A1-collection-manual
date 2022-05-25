# grub-render-label(3) - Render an Apple disk label.

Wed Feb 26 2014

```
grub-render-label [-b | --bgcolor=COLOR] [-c | --color=COLOR] .RS 19 [-f | --font=FILE] [-i | --input=FILE] .RE .RS 19 [-o | --output=FILE] [-t | --text=STRING] .RE .RS 19 [-v | --verbose]
```


<a name="description"></a>

# Description

**grub-render-label** renders an Apple disk label (.disk_label) file.



<a name="options"></a>

# Options


* **--color**=_COLOR_  
  Use COLOR as the color for generated labels.
  
* **--bgcolor**=_COLOR_  
  Use _COLOR_ as the background color for generated labels.
  
* **--font**=_FILE_  
  Use _FILE_ as the font file for generated labels.
  
* --input=_FILE_  
  Read input text from _FILE_.
  
* --output=_FILE_  
  Render output to _FILE_.
  
* --text=_STRING_  
  Use _STRING_ as input text.
  
* --verbose  
  Print verbose output.
  
  

<a name="see-also"></a>

# See Also

**info grub**
