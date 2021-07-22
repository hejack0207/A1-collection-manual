# unicode_stop(1) - revert keyboard and console from unicode mode

3 Feb 2001

```
unicode_stop
```

<a name="description"></a>

# Description

.IX "unicode_stop command" "" "\fLunicode\_stop command"  

The
**unicode_stop**
command will more-or-less undo the effect of
**unicode_start**.
It puts the keyboard in ASCII (XLATE) mode, and clears
the console UTF-8 mode.

<a name="see-also"></a>

# See Also

**kbd_mode**(1),
**unicode_start**(1),
**utf-8(7),**
**setfont**(8)
