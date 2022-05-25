# grub-mkfont(3) - Convert common font file formats into the PF2 format.

Wed Feb 26 2014

```
grub-mkfont [--ascii-bitmaps] [-a | --force-autohint] .RS 13 [-b | --bold] [-c | --asce=NUM] [-d | --desc=NUM] .RE .RS 13 [-i | --index=NUM] [-n | --name=NAME] [--no-bitmap] .RE .RS 13 [--no-hinting] <-o | --output=FILE> .RE .RS 13 [-r | --range=FROM-TO[,FROM-TO]] [-s | --size=SIZE] .RE .RS 13 [-v | --verbose] [--width-spec] FONT_FILES
```


<a name="description"></a>

# Description

**grub-mkfont** converts font files from common formats into the PF2 format used by GRUB.


<a name="options"></a>

# Options


* --ascii-bitmaps  
  Save only bitmaps for ASCII characters.
  
* --force-autohint  
  Force generation of automatic hinting.
  
* --bold  
  Convert font to bold.
  
* --asce=_NUM_  
  Set font ascent to _NUM_.
  
* --desc=_NUM_  
  Set font descent to _NUM_.
  
* --index=_NUM_  
  Select face index _NUM_.
  
* --name=_NAME_  
  Set font family to _NAME_.
  
* --no-bitmap  
  Ignore bitmap strikes when loading.
  
* --no-hinting  
  Disable hinting.
  
* --output=_FILE_  
  Save ouptut to _FILE_.  This argument is required.
  
* --range=_FROM-TO__,FROM-TO_  
  Set the font ranges to each pair of _FROM_,_TO_.
  
* --size=_SIZE_  
  Set font size to _SIZE_.
  
* --verbose  
  Print verbose messages.
  
* --width-spec  
  Create a width summary file.
  
* _FONT\_FILES_  
  The input files to be converted.
  

<a name="see-also"></a>

# See Also

**info grub**
