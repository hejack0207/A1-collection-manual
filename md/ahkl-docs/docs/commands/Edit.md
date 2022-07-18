# Edit

Opens the current script for editing in the associated editor.

```
<span class="func">Edit</span>
```

The Edit command opens the current script for editing using the associated "edit" verb in the registry (or Notepad if no verb). However, if an editor window appears to have the script already open (based on its window title), that window is activated instead of opening a new instance of the editor.

This command has no effect when operating from within a compiled script.

On a related note, AutoHotkey syntax highlighting can be enabled for various editors - see below. In addition, context sensitive help for AutoHotkey commands can be enabled in any editor via [this example](../scripts/index.htm#ContextSensitiveHelp). Finally, your productivity may be improved by using an auto-completion utility like [the script by boiler](https://www.autohotkey.com/boards/viewtopic.php?f=60&t=31484) or [the script by Helgef](https://www.autohotkey.com/boards/viewtopic.php?f=60&t=27882), which works in almost any editor. It watches what you type and displays menus and parameter lists, which does some of the typing for you and reminds you of the order of parameters.

## Related

[Reload](Reload.htm), [How to edit a script](../Program.htm#edit)

## Examples

Opens the script for editing.

```
Edit
```

If your editor's command-line usage is something like `Editor.exe "Full path of script.ahk"`, the following can be used to set it as the default editor for ahk files. When you run the script, it will prompt you to select the executable file of your editor.

```
FileSelectFile Editor, 2,, Select your editor, Programs (*.exe)
if ErrorLevel
    ExitApp
RegWrite REG_SZ, HKCR, AutoHotkeyScript\Shell\Edit\Command,, "%Editor%" "`%1"
```

## Editors with AutoHotkey Support

**SciTE4AutoHotkey** is a custom version of the text editor known as SciTE, tailored for editing AutoHotkey scripts. Its features include:

- Syntax highlighting
- Smart auto-indent
- Auto-complete
- Calltips (also known as IntelliSense)
- Code folding
- Support for[interactive debugging](../Scripts.htm#idebug)
- Other tools for AutoHotkey scripting

SciTE4AutoHotkey can be found here: [http://fincs.ahk4.net/scite4ahk/](http://fincs.ahk4.net/scite4ahk/)

**AHK Studio** is a script editor built using AutoHotkey, for editing AutoHotkey scripts. See the following forum thread for details, demonstration videos and an ever-growing list of features: [AHK Studio](https://www.autohotkey.com/boards/viewtopic.php?t=300)

**AutoGUI** is an integrated development environment for AutoHotkey which combines a GUI designer with a script editor. It can be found here: [AutoGUI - GUI Designer and Script Editor](https://www.autohotkey.com/boards/viewtopic.php?f=6&t=10157)

**Other editors** for which AutoHotkey syntax highlighting can be enabled:

- [AkelPad](https://www.autohotkey.com/forum/topic23586.html)
- [Crimson Editor](https://www.autohotkey.com/forum/topic5506.html)
- [Eclipse, FAR manager, and any other editors which use Colorer take5](https://www.autohotkey.com/forum/topic10378.html)
- [Emacs](https://github.com/tinku99/ahk-org-mode)
- [Notepad++](https://www.autohotkey.com/forum/topic58792.html)
- [Notepad2](https://www.autohotkey.com/board/index.php?showtopic=34495)
- [PSPad](https://www.autohotkey.com/forum/topic9294.html)
- [SciTE and possibly other Scintilla based editors](https://www.autohotkey.com/forum/topic9656.html)
- [Sublime Text Editor](https://www.autohotkey.com/board/index.php?showtopic=46447#entry349495)
- [Total Commander with Synplus plugin](https://www.autohotkey.com/forum/topic7278.html)
- [Visual Studio Code with AutoHotkey Extension by Mark Wiemer](https://github.com/mark-wiemer/vscode-autohotkey-plus-plus)

Additionally, the zip download of AutoHotkey Basic ( [https://www.autohotkey.com/download/1.0/](https://www.autohotkey.com/download/1.0/)) includes files for enabling syntax highlighting in the following editors. However, some of these files are badly out of date and may or may not work:

- ConTEXT
- EditPlus
- EmEditor
- jEdit
- MED
- TextPad
- UltraEdit
- Vim

If your favourite editor isn't listed here, try your luck by searching the [forums](https://www.autohotkey.com/boards/).

To get an editor added to this page, contact Lexikos [via the forums](https://www.autohotkey.com/boards/ucp.php?i=pm&mode=compose&u=77) or [GitHub](https://github.com/Lexikos/AutoHotkey_L-Docs/).

