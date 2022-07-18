# Clipboard and [ClipboardAll](\#ClipboardAll)

_Clipboard_ is a built-in [variable](../Variables.htm) that reflects the current contents of the Windows clipboard if those contents can be expressed as text. By contrast, _[ClipboardAll](#ClipboardAll)_ contains everything on the clipboard, such as pictures and formatting.

Each line of text on _Clipboard_ typically ends with carriage return and linefeed (CR+LF), which can be expressed in the script as `` `r`n``. Files (such as those copied from an open Explorer window via Ctrl+C) are considered to be text: They are automatically converted to their filenames (with full path) whenever _Clipboard_ is referenced in the script. To extract the files one by one, follow this example:

```
<a href="../commands/LoopParse.htm" data-index="4">Loop, parse</a>, clipboard, `n, `r
{
    MsgBox, 4, , File number %A_Index% is %A_LoopField%.`n`nContinue?
    IfMsgBox, No, break
}
```

To arrange the filenames in alphabetical order, use the [Sort](../commands/Sort.htm) command. To write the filenames on the clipboard to a file, use ``<a href="../commands/FileAppend.htm" data-index="6">FileAppend</a>, %clipboard%`r`n, C:\My File.txt``. To change how long the script will keep trying to open the clipboard -- such as when it is in use by another application -- use [#ClipboardTimeout](../commands/_ClipboardTimeout.htm).

 **Basic examples:**

```
clipboard := "my text"   <em>; Give the clipboard entirely new contents.</em>
clipboard := ""   <em>; Empty the clipboard.</em>
clipboard := clipboard   <em>; Convert any copied files, HTML, or other formatted text to plain text.</em>
clipboard := clipboard " Text to append."   <em>; Append some text to the clipboard.</em>
StringReplace, clipboard, clipboard, ABC, DEF, All   <em>; Replace all occurrences of ABC with DEF (also converts the clipboard to plain text).</em>
```

**Using ClipWait to improve script reliability:**

```
clipboard := ""  <em>; Start off empty to allow ClipWait to detect when the text has arrived.</em>
Send ^c
<a href="../commands/ClipWait.htm" data-index="8">ClipWait</a>  <em>; Wait for the clipboard to contain text.</em>
MsgBox Control-C copied the following contents to the clipboard:`n`n%clipboard%
```

## ClipboardAll (saving and restoring everything on the clipboard)

_ClipboardAll_ contains everything on the clipboard (such as pictures and formatting). It is most commonly used to save the clipboard's contents so that the script can temporarily use the clipboard for an operation. When the operation is completed, the script restores the original clipboard contents as shown below:

```
ClipSaved := ClipboardAll   <em>; Save the entire clipboard to a variable of your choice.
; ... here make temporary use of the clipboard, such as for pasting Unicode text via <a href="../commands/Transform.htm#Unicode" data-index="9">Transform Unicode</a> ...</em>
Clipboard := ClipSaved   <em>; Restore the original clipboard. Note the use of <i>Clipboard</i> (not <i>ClipboardAll</i>).</em>
ClipSaved := ""   <em>; Free the memory in case the clipboard was very large.</em>
```

_ClipboardAll_ may also be saved to a file (in this mode, FileAppend always overwrites any existing file):

```
<a href="../commands/FileAppend.htm" data-index="10">FileAppend</a>, %ClipboardAll%, C:\Company Logo.clip <em>; The file extension does not matter.</em>
```

To later load the file back onto the clipboard (or into a variable), follow this example:

```
<a href="../commands/FileRead.htm" data-index="11">FileRead</a>, Clipboard, <strong>*c</strong> C:\Company Logo.clip <em>; Note the use of *c, which must precede the filename.</em>
```

### Limitations

Some limitations apply to the direct use of _ClipboardAll_:

- _ClipboardAll_ is blank when used in ways other than those described above.
- _ClipboardAll_ is not supported inside [comma-separated expressions](../Variables.htm#comma); that is, it should be assigned on a line by itself such as `ClipSaved := ClipboardAll`.

A variable containing binary clipboard data can be used as follows:

- Put the data back on the clipboard by assigning to_Clipboard_ as shown above.
- Write the clipboard data to file with[FileAppend](../commands/FileAppend.htm), as shown above.
- Copy it to another variable (or[ByRef](../Functions.htm#ByRef) parameter) as in this example: `ClipSaved2 := ClipSaved`.
- Pass it to a[user-defined function](../Functions.htm) [by reference](../Functions.htm#ByRef), or in [v1.0.46+], by value.
- Determine the size of the data by passing it to[StrLen()](../commands/StrLen.htm) as described [below](#len).
- Compare two such variables by using an old-style IF as shown[below](#compare).
- Take its[address](../Variables.htm#amp) or pass the variable itself to [NumGet](../commands/NumGet.htm) to examine the data.

Further limitations apply:

- When binary clipboard data is assigned to a variable, the variable is marked with a hidden attribute. This attribute can only be set by[FileRead](../commands/FileRead.htm) with the `*c` option, or by direct assignment from _ClipboardAll_ (as shown above) or another variable which has the attribute.
- When used in ways other than those described above, binary clipboard data is usually interpreted as text and truncated at the first null character, which is typically at the beginning of the data. For instance, this occurs when one attempts to return the data from a function or assign it to a property or array element.
- The clipboard attribute is removed when the variable is freed or assigned any other value, even by indirect means such as[StrReplace()](../commands/StrReplace.htm) or [StringReplace](../commands/StringReplace.htm).
- Variables without the clipboard attribute are treated as text when assigned to_Clipboard_ or passed to FileAppend, even if the data is in the appropriate binary format.

### Notes

If _ClipboardAll_ cannot retrieve one or more of the data objects (formats) on the clipboard, they will be omitted but all the remaining objects will be stored.

[ClipWait](../commands/ClipWait.htm) may be used to detect when the clipboard contains data (optionally including non-text data).

[StrLen()](../commands/StrLen.htm) may be used to discover the total size of a variable to which _ClipboardAll_ has been assigned. However, to get the size in bytes on Unicode versions of AutoHotkey, the length must be multiplied by 2. [A\_IsUnicode](../Variables.htm#IsUnicode) can be used to support ANSI and Unicode versions, as in this example: `size := StrLen(ClipSaved) * (A_IsUnicode ? 2 : 1)`.

Variables to which _ClipboardAll_ has been assigned can be compared to each other (but not directly to _ClipboardAll_) by means of [If[Not]Equal](../commands/IfEqual.htm), `If Var1 = %Var2%`, or `If Var1 != %Var2%`. In the following example, the length of each variable is checked first. If that is not enough to make the determination, the contents are compared to break the tie:

```
if ClipSaved1 != %ClipSaved2%   <em>; This <u>must</u> be an old-style IF statement, not an expression.</em>
    MsgBox The two saved clipboards are different.
```

Saving _ClipboardAll_ to a variable is not restricted by the memory limit set by [#MaxMem](../commands/_MaxMem.htm).

A saved clipboard file internally consists of a four-byte format type, followed by a four-byte (for 32-bit) or eight-byte (for 64-bit) data-block size, followed by the data-block for that format. If the clipboard contained more than one format (which is almost always the case), these three items are repeated until all the formats are included. The file ends with a four-byte format type of 0.

Known limitation: Retrieving _ClipboardAll_ while cells from Microsoft Excel are on the clipboard may cause Excel to display a "no printers" dialog.

Clipboard utilities written in AutoHotkey:

- Deluxe Clipboard: Provides unlimited number of private, named clipboards to Copy, Cut, Paste, Append or CutAppend of selected text.[www.autohotkey.com/forum/topic2665.html](https://www.autohotkey.com/forum/topic2665.html)
- ClipStep: Control multiple clipboards using only the keyboard'sCtrl-X-C-V. [www.autohotkey.com/forum/topic4836.html](https://www.autohotkey.com/forum/topic4836.html)

## OnClipboardChange

Scripts can detect changes to the content of the Clipboard by using [OnClipboardChange()](../commands/OnClipboardChange.htm#function) or the [OnClipboardChange label](../commands/OnClipboardChange.htm#label).

