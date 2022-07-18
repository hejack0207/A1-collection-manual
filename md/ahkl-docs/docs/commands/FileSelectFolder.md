# FileSelectFolder

Displays a standard dialog that allows the user to select a folder.

```
<span class="func">FileSelectFolder</span>, OutputVar <span class="optional">, StartingFolder, Options, Prompt</span>
```

## Parameters

OutputVar

The name of the variable in which to store the user's selected folder. This will be made blank if the user cancels the dialog (i.e. does not wish to select a folder). If the user selects a root directory (such as C:\\), _OutputVar_ will contain a trailing backslash. If this is undesirable, remove it as follows:

```
FileSelectFolder, Folder
Folder := RegExReplace(Folder, "\\$")  <em>; Removes the trailing backslash, if present.</em>
```

StartingFolder

If blank or omitted, the dialog's initial selection will be the user's My Documents folder (or possibly My Computer). A [CLSID folder](../misc/CLSID-List.htm) such as `::{20d04fe0-3aea-1069-a2d8-08002b30309d}` (i.e. My Computer) may be specified start navigation at a specific special folder.

Otherwise, the most common usage of this parameter is an asterisk followed immediately by the absolute path of the drive or folder to be initially selected. For example, `*C:\` would initially select the C drive. Similarly, `*C:\My Folder` would initially select that particular folder.

The asterisk indicates that the user is permitted to navigate upward (closer to the root) from the starting folder. Without the asterisk, the user would be forced to select a folder inside _StartingFolder_ (or _StartingFolder_ itself). One benefit of omitting the asterisk is that _StartingFolder_ is initially shown in a tree-expanded state, which may save the user from having to click the first plus sign.

If the asterisk is present, upward navigation may optionally be restricted to a folder other than Desktop. This is done by preceding the asterisk with the absolute path of the uppermost folder followed by exactly one space or tab. For example, `C:\My Folder *C:\My Folder\Projects` would not allow the user to navigate any higher than C:\\My Folder (but the initial selection would be C:\\My Folder\\Projects).

Options

One of the following numbers:

**0**: The options below are all disabled (except on Windows 2000, where the "make new folder" button might appear anyway).

**1** (default): A button is provided that allows the user to create new folders.

**Add 2** to the above number to provide an edit field that allows the user to type the name of a folder. For example, a value of 3 for this parameter provides both an edit field and a "make new folder" button.

**Add 4** to the above number to omit the BIF\_NEWDIALOGSTYLE property. Adding 4 ensures that FileSelectFolder will work properly even in a Preinstallation Environment like WinPE or BartPE. However, this prevents the appearance of a "make new folder" button, at least on Windows XP. ["4" requires v1.0.48+]

If the user types an invalid folder name in the edit field, _OutputVar_ will be set to the folder selected in the navigation tree rather than what the user entered, at least on Windows XP.

This parameter can be an [expression](../Variables.htm#Expressions).

Prompt

Text displayed in the window to instruct the user what to do. If omitted or blank, it will default to "Select Folder - %A\_ScriptName%" (i.e. the name of the current script).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the user dismissed the dialog without selecting a folder (such as by pressing the Cancel button). It is also set to 1 if the system refused to show the dialog (rare). Otherwise, it is set to 0.

## Remarks

A folder-selection dialog usually looks like this:

![FileSelectFolder](../static/dlg_folder.png)

A GUI window may display a modal folder-selection dialog by means of [Gui +OwnDialogs](Gui.htm#OwnDialogs). A modal dialog prevents the user from interacting with the GUI window until the dialog is dismissed.

Known limitation: A [timer](SetTimer.htm) that launches during the display of a FileSelectFolder dialog will postpone the effect of the user's clicks inside the dialog until after the timer finishes. To work around this, avoid using timers whose subroutines take a long time to finish, or disable all timers during the dialog:

```
<a href="Thread.htm" data-index="7">Thread</a>, NoTimers
FileSelectFolder, OutputVar,, 3
Thread, NoTimers, false
```

## Related

[FileSelectFile](FileSelectFile.htm), [MsgBox](MsgBox.htm), [InputBox](InputBox.htm), [ToolTip](ToolTip.htm), [GUI](Gui.htm), [CLSID List](../misc/CLSID-List.htm), [FileCopyDir](FileCopyDir.htm), [FileMoveDir](FileMoveDir.htm), [SplitPath](SplitPath.htm)

Also, the operating system offers standard dialog boxes that prompt the user to pick a font, color, or icon. These dialogs can be displayed via [DllCall()](DllCall.htm) as demonstrated at [GitHub](https://github.com/majkinetor/mm-autohotkey/tree/master/Dlg).

## Examples

Allows the user to select a folder and provides both an edit field and a "make new folder" button.

```
FileSelectFolder, OutputVar, , 3
if OutputVar =
    MsgBox, You didn't select a folder.
else
    MsgBox, You selected folder "%OutputVar%".
```

A [CLSID](../misc/CLSID-List.htm) example. Allows the user to select a folder in the "My Computer" directory.

```
FileSelectFolder, OutputVar, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}  <em>; My Computer.</em>
```

