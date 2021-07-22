# kbd_mode(1) - report or set the keyboard mode

6 Apr 1994

```
kbd_mode [ -a | -u | -k | -s  ] [ -C CONSOLE ]
```

<a name="description"></a>

# Description

.IX "kbd_mode command" "" "\fLkbd\_mode command"  

Without argument,
**kbd_mode**
prints the current keyboard mode (RAW, MEDIUMRAW or XLATE).
With argument, it sets the keyboard mode as indicated:

-s: scancode mode (RAW),

-k: keycode mode (MEDIUMRAW),

-a: ASCII mode (XLATE),

-u: UTF-8 mode (UNICODE).

Of course the "-a" is only traditional, and the code used can be any
8-bit character set.  With "-u" a 16-bit character set is expected,
and these chars are transmitted to the kernel as 1, 2, or 3 bytes
(following the UTF-8 coding).
In these latter two modes the key mapping defined by loadkeys(1)
is used.

kbd_mode operates on the console specified by the "-C" option; if there
is none, the console associated with stdin is used.

Warning: changing the keyboard mode, other than between ASCII and
Unicode, will probably make your keyboard unusable.
This command is only meant for use (say via remote login)
when some program left your keyboard in the wrong state.
Note that in some obsolete versions of this program the "-u"
option was a synonym for "-s".

<a name="see-also"></a>

# See Also

**loadkeys**(1)

