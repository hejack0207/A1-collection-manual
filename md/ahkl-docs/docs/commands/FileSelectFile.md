# FileSelectFile

Displays a standard dialog that allows the user to open or save file(s).

```
<span class="func">FileSelectFile</span>, OutputVar <span class="optional">, Options, RootDir\Filename, Title, Filter</span>
```

## Parameters

OutputVar

The name of the variable in which to store the filename(s) selected by the user. This will be made blank if the user cancels the dialog (i.e. does not wish to select a file).

Options

If omitted, it will default to zero, which is the same as having none of the options below.

**M**: Multi-select. Specify the letter M to allow the user to select more than one file via shift-click, control-click, or other means. **M** may optionally be followed by a number as described below (for example, both M and M1 are valid). To extract the individual files, see the example at the bottom of this page.

**S**: Save dialog. Specify the letter S to cause the dialog to always contain a Save button instead of an Open button. **S** may optionally be followed by a number (or sum of numbers) as described below (for example, both S and S16 are valid).

Even if **M** and **S** are absent, the following numbers can be used. To put more than one of them into effect, add them up. For example, to use 1 and 2, specify the number 3.

**1**: File Must Exist

**2**: Path Must Exist

**8**: Prompt to Create New File

**16**: Prompt to Overwrite File

**32**[v1.0.43.09+]:
Shortcuts (.lnk files) are selected as-is rather than being resolved to their targets. This option also prevents navigation into a folder via a folder shortcut.

As the "Prompt to Overwrite" option is supported only by the Save dialog, specifying that option without the "Prompt to Create" option also puts the "S" option into effect. Similarly, the "Prompt to Create" option has no effect when the "S" option is present. Specifying the number 24 enables whichever type of prompt is supported by the dialog.

RootDir\\Filename

If present, this parameter contains one or both of the following:

**RootDir**: The root (starting) directory, which is assumed to be a subfolder in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path is not specified. If omitted or blank, the starting directory will be a default that might depend on the OS version (it will likely be the directory most recently selected by the user during a prior use of FileSelectFile). [v1.0.43.10+]: On Windows XP/2003 and earlier, a [CLSID](../misc/CLSID-List.htm) such as `::{20d04fe0-3aea-1069-a2d8-08002b30309d}` (i.e. My Computer) may also be specified, in which case any subdirectory present after the CLSID should end in a backslash (otherwise, the string after the last backslash will be interpreted as the default filename, below).

**Filename**: The default filename to initially show in the dialog's edit field. Only the naked filename (with no path) will be shown. To ensure that the dialog is properly shown, ensure that no illegal characters are present (such as /<\|:").

Examples:

```
C:\My Pictures\Default Image Name.gif  <em>; Both <i>RootDir</i> and <i>Filename</i> are present.</em>
C:\My Pictures  <em>; Only <i>RootDir</i> is present.</em>
My Pictures  <em>; Only <i>RootDir</i> is present, and it's relative to the current working directory.</em>
My File  <em>; Only <i>Filename</i> is present (but if "My File" exists as a folder, it is assumed to be <i>RootDir</i>).</em>
```

Title

The title of the file-selection window. If omitted or blank, it will default to "Select File - %A\_ScriptName%" (i.e. the name of the current script).

Filter

Indicates which types of files are shown by the dialog.

Example: Documents (\*.txt)

Example: Audio (\*.wav; \*.mp2; \*.mp3)

If omitted, the filter defaults to All Files (\*.\*). An option for Text Documents (\*.txt) will also be available in the dialog's "files of type" menu.

Otherwise, the filter uses the indicated string but also provides an option for All Files (\*.\*) in the dialog's "files of type" drop-down list. To include more than one file extension in the filter, separate them with semicolons as illustrated in the example above.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the user dismissed the dialog without selecting a file (such as by pressing the Cancel button). It is also set to 1 if the system refused to show the dialog (rare). Otherwise, it is set to 0.

## Remarks

A file-selection dialog usually looks like this:

![FileSelectFile](../static/dlg_file.png)

If the user didn't select anything (e.g. pressed CANCEL), _OutputVar_ is made blank.

If multi-select is not in effect, _OutputVar_ is set to the full path and name of the single file chosen by the user.

If the M option (multi-select) is in effect, _OutputVar_ is set to a list of items, each of which except the last is followed by a linefeed (\`n) character. The first item in the list is the path that contains all the selected files (this path will end in a backslash only if it is a root folder such as C:\\). The other items are the selected filenames (without path). For example:

```
C:\My Documents\New Folder [this is the path in which all the files below reside]
test1.txt [these are the naked filenames: no path info]
test2.txt
... etc.
```

(The example at the bottom of this page demonstrates how to extract the files one by one.)

When multi-select is in effect, the sum of the lengths of the selected filenames is limited to 64 KB. Although this is typically enough to hold several thousand files, _OutputVar_ will be made blank if the limit is exceeded.

A GUI window may display a modal file-selection dialog by means of [Gui +OwnDialogs](Gui.htm#OwnDialogs). A modal dialog prevents the user from interacting with the GUI window until the dialog is dismissed.

Known limitation: A [timer](SetTimer.htm) that launches during the display of a FileSelectFile dialog will postpone the effect of the user's clicks inside the dialog until after the timer finishes. To work around this, avoid using timers whose subroutines take a long time to finish, or disable all timers during the dialog:

```
<a href="Thread.htm" data-index="7">Thread</a>, NoTimers
FileSelectFile, OutputVar
Thread, NoTimers, false
```

[v1.0.25.06+]: The multi-select option "4" is obsolete. However, for compatibility with older scripts, it still functions as it did before. Specifically, if the user selects only one file, _OutputVar_ will contain its full path and name followed by a linefeed (\`n) character. If the user selects more than one file, the format is the same as that of the M option described above, except that the last item also ends in a linefeed (\`n).

## Related

[FileSelectFolder](FileSelectFolder.htm), [MsgBox](MsgBox.htm), [InputBox](InputBox.htm), [ToolTip](ToolTip.htm), [GUI](Gui.htm), [CLSID List](../misc/CLSID-List.htm), [parsing loop](LoopParse.htm), [SplitPath](SplitPath.htm)

Also, the operating system offers standard dialog boxes that prompt the user to pick a font, color, or icon. These dialogs can be displayed via [DllCall()](DllCall.htm) as demonstrated at [GitHub](https://github.com/majkinetor/mm-autohotkey/tree/master/Dlg).

## Examples

Allows the user to select an existing .txt or .doc file.

```
FileSelectFile, SelectedFile, 3, , Open a file, Text Documents (*.txt; *.doc)
if (SelectedFile = "")
    MsgBox, The user didn't select anything.
else
    MsgBox, The user selected the following:`n%SelectedFile%
```

A [CLSID](../misc/CLSID-List.htm) example. Allows the user to select a file in the recycle bin. Note that this example only works on Windows XP/2003 or earlier.

```
FileSelectFile, OutputVar,, ::{645ff040-5081-101b-9f08-00aa002f954e}  <em>; Recycle Bin.</em>
```

Allows the user to select multiple existing files.

```
FileSelectFile, files, M3  <em>; M3 = Multiselect existing files.</em>
if (files = "")
{
    MsgBox, The user pressed cancel.
    return
}
Loop, parse, files, `n
{
    if (A_Index = 1)
        MsgBox, The selected files are all contained in %A_LoopField%.
    else
    {
        MsgBox, 4, , The next file is %A_LoopField%.  Continue?
        IfMsgBox, No, break
    }
}
return
```

