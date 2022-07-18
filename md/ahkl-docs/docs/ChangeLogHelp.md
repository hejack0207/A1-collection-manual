# Archived Changes

This document contains a history of changes made within the original branch of AutoHotkey development, by Chris Mallett.

For newer changes, see [Changes & New Features](AHKL_ChangeLog.htm).

## 1.0.48.05 - September 25, 2009

Fixed crash of [SendMessage and PostMessage](commands/PostMessage.htm) when wParam or lParam is omitted (broken by 1.0.48.04). [thanks Lexikos]

## 1.0.48.04 - September 25, 2009

Fixed [StringSplit](commands/StringSplit.htm) to work properly inside [functions](Functions.htm) of [compiled scripts](Scripts.htm#ahk2exe) (broken by 1.0.35.01). [thanks engunneer & Lexikos]

Fixed [SendPlay](commands/Send.htm#SendPlayDetail) not to wait for the release of the Windows key prior to sending an "L" keystroke (broken by 1.0.48.01). [thanks Lexikos]

Fixed [A\_EndChar](Variables.htm#EndChar) to be valid when the [B0 option](Hotstrings.htm#b0) is present, and to be empty when there is no [ending character](Hotstrings.htm#EndChars) (broken by 1.0.44.09). [thanks Al2000]

Fixed [FormatTime](commands/FormatTime.htm) to yield a valid time of day even when the specified month is out-of-range (broken by 1.0.48.00). [thanks silveredge78]

Fixed [FileCreateDir](commands/FileCreateDir.htm) to support a leading backslash even when it is the only backslash; e.g. \\dir. [thanks jaco0646]

Fixed [GuiControl](commands/GuiControl.htm)/ [GuiControlGet](commands/GuiControlGet.htm)/ [Gui](commands/Gui.htm)/ [SendMessage](commands/PostMessage.htm) to work reliably even when they trigger a [callback](commands/RegisterCallback.htm) or [OnMessage](commands/OnMessage.htm) function. [thanks Lexikos]

Fixed [RegExMatch()](commands/RegExMatch.htm) not to produce too few replacements when an empty-string match is followed by a non-empty-string match.

Changed `While()` to be recognized as a [loop](commands/While.htm) rather than a [function](Functions.htm). [thanks Crash&Burn]

Improved [UrlDownloadToFile](commands/URLDownloadToFile.htm) to support FTP and Gopher. [thanks Lexikos]

Improved the [stdout/asterisk mode](commands/FileAppend.htm#stdout) of FileAppend to write immediately rather than lazily to standard output. [thanks Lexikos]

Added full support for `if % expression`. [thanks kenomby]

## 1.0.48.03 - May 3, 2009

Fixed `<a href="commands/ListLines.htm" data-index="23">ListLines On</a>` not to erase the most recent log entry in the line history. [thanks Lexikos]

Fixed [ListView](commands/ListView.htm) to respond properly to mouse dragging when [timers](commands/SetTimer.htm) are running. [thanks Solar]

Fixed [key-up hotkeys](Hotkeys.htm#keyup) so that if one is created while its key is being held down, the release of the key doesn't trigger the wrong hotkey. [thanks Peter & engunneer]

## 1.0.48.02 - April 19, 2009

Changed and fixed [Gosub](commands/Gosub.htm) and [GroupActivate](commands/GroupActivate.htm) so that when a function calls an [external/public subroutine](Functions.htm#GosubPublic), that subroutine will treat all dynamic variables as globals, and will have outside-of-function GUI behavior. [thanks kenomby & Lexikos]

Improved performance of [True](Variables.htm#True)/ [False](Variables.htm#False)/ [A\_EventInfo](Variables.htm#EventInfo) in [expressions](Variables.htm#Expressions) by treating them as integers vs. strings.

## 1.0.48.01 - April 15, 2009

Changed: For Windows Vista and later, hotkeys that include Win (e.g. #a) will wait for LWin and RWin to be released before sending any text containing an "L" keystroke. This prevents such a hotkey from locking the PC. This behavior applies to all sending modes except [SendPlay](commands/Send.htm#SendPlayDetail) (which doesn't need it) and [blind mode](commands/Send.htm#blind).

Fixed [A\_LoopFileExt](commands/LoopFile.htm#LoopFileExt) to be blank for any filename having no extension but a period in its pathname. [thanks Yek-Toho-Tua].

Fixed the [assignment](Variables.htm#AssignOp) of integers that are 19 or 20 characters long to work as they did prior to v1.0.48. [thanks Laszlo & Lexikos]

Fixed [function definitions](Functions.htm#define) to work properly inside a [block](commands/Block.htm). [thanks rmarko]

Improved performance of [A\_Index](Variables.htm#Index) in [expressions](Variables.htm#Expressions) by treating it as an integer rather than a string.

Improved performance of `<a href="commands/IfIn.htm" data-index="42">if var [not] in/contains</a>`. [developed by Lexikos]

Improved [ListLines](commands/ListLines.htm) with an option to turn line-logging Off or On. [thanks kenomby & ruespe]

## 1.0.48 - February 25, 2009

**Compatibility:** The change most likely to affect backward compatibility is that floating point numbers stored in variables now have higher precision. Scripts that rely on tiny differences in precision would either need to be reviewed and updated, or have their compatibility improved by using `<a href="commands/SetFormat.htm" data-index="44">SetFormat Float</a>` (e.g. `SetFormat, Float, 0.6`) _anywhere_ in the script. `SetFormat Float` disables the higher precision, but gives up some of the new, faster floating point performance.

**Performance:** The main theme of this release is faster performance. Almost all scripts should run faster -- especially those that make heavy use of [expressions](Variables.htm#Expressions) and integer math/comparisons (which may run up to three times as fast). To achieve the full benefit, a script either should avoid using SetFormat or should use [SetFormat's fast mode](commands/SetFormat.htm#Fast).

### Performance improvements

[Expressions](Variables.htm#Expressions) and [function calls](Functions.htm) are compiled more heavily, making them much faster (especially complex integer expressions, including those with [commas](Variables.htm#comma)).

Binary numbers are cached for variables to avoid conversions to/from strings. This makes numerical operations involving variables much faster.

Literal integers in expressions and math/comparison commands are replaced with binary integers, which makes them faster; e.g. `X+5` and `if x > 5`.

[LOOPs](commands/Loop.htm), [IFs](commands/IfExpression.htm), and [ELSEs](commands/Else.htm) that have blocks (braces) are faster due to skipping the opening '{'. A side-effect is that the '{' is omitted from [ListLines](commands/ListLines.htm).

[Thread-creation](misc/Threads.htm) performance is improved, which should help rapid-fire threads in [OnMessage()](commands/OnMessage.htm), [RegisterCallback()](commands/RegisterCallback.htm), and [GUI events](commands/Gui.htm#Events).

### Changes that might affect existing scripts (other than higher-precision floating point described at the top)

When `<a href="commands/SetFormat.htm#Integer" data-index="58">SetFormat, Integer, Hex</a>` is in effect, assigning a literal decimal integer to a variable also converts it to hex. Usually this is only a display issue.

For [OnMessage()](commands/OnMessage.htm) performance, the message number and HWND arrive as standard numbers rather than appearing unconditionally as hex. Usually this is only a display issue.

To achieve various improvements in performance, scripts now use slightly more memory (proportionate to the number of variables and expressions).

Changed and fixed `<a href="commands/IfIs.htm#time" data-index="60">if var is time</a>` and other uses of YYYYMMDDHHMISS date-time stamps to recognize that months outside the range 1-12 are invalid. [thanks Nick]

Changed and improved [dynamic function calling](Functions.htm#DynCall) to allow passing more parameters than defined by a function, in which case the parameters are evaluated but discarded. [developed by Lexikos]

### Other improvements

Added function [IsFunc()](commands/IsFunc.htm), which indicates whether a function may be [called dynamically](Functions.htm#DynCall). [developed by Lexikos]

Added the [while-loop](commands/While.htm), which repeats its commands until its [expression](Variables.htm#Expressions) evaluates to false. [developed by Lexikos]

Added an [assume-static mode](Functions.htm#AssumeStatic) for functions. [developed by Lexikos]

Added built-in variables [A\_IsPaused](Variables.htm#IsPaused) and [A\_IsCritical](Variables.htm#IsCritical). [developed by Lexikos]

Improved [NumPut()](commands/NumPut.htm) to support UInt64 like [DllCall()](commands/DllCall.htm#unsigned). [thanks Sean]

Improved mouse wheel support by adding [WheelLeft and WheelRight](Hotkeys.htm#Wheel) as hotkeys and supporting them in [Send](commands/Send.htm), [Click](commands/Click.htm), and related commands. However, WheelLeft/Right has no effect on operating systems older than Windows Vista. [developed by Lexikos]

Upgraded [compiled script](Scripts.htm#ahk2exe) compressor from UPX 3.00 to 3.03.

### Fixes

Fixed inability to use [MsgBox](commands/MsgBox.htm#Timeout)'s timeout parameter when the "Text" parameter had an expression containing commas.

Fixed `<a href="commands/Menu.htm#Delete" data-index="76">Menu, Delete, Item-that's-a-submenu</a>` not to disrupt the associated submenu. [thanks animeaime & Lexikos]

Fixed the [GUI Hotkey control](commands/GuiControls.htm#Hotkey) to return usable hotkey names even for dead keys (e.g. "^" instead of Zircumflex). [thanks DerRaphael]

Fixed [RegDelete](commands/RegDelete.htm) so that it won't delete an entire root key when SubKey is blank. [thanks Icarus]

Fixed [registry loops](commands/LoopReg.htm) to support subkey names longer than 259 (rare). In prior versions, such subkeys would either be skipped or cause a crash. [thanks Krzysztof Sliwinski & Eggi]

Fixed FileSelectFolder by providing [an option](commands/FileSelectFolder.htm#NewDialog) to make it compatible with BartPE/WinPE. [thanks markreflex]

Fixed [window/control IDs (HWNDs)](misc/WinTitle.htm#ahk_id), which in rare cases wrongly started with 0xFFFFFFFF instead of just 0x. [thanks Micahs]

Fixed inability of [Send commands](commands/Send.htm) to use the Down/Up modifiers with the "}" character. [thanks neovars]

## 1.0.47.06 - March 9, 2008

Fixed crash when a [function](Functions.htm) was called concurrently with an optional [ByRef parameter](Functions.htm#ByRef) omitted by one [thread](misc/Threads.htm) but not omitted by the other. [thanks DeathByNukes]

Fixed `<a href="commands/Menu.htm#MainWindow" data-index="86">Menu, Tray, MainWindow</a>` to enable the menu items in the main window's View menu. [thanks Lexikos]

Added [dynamic function calling](Functions.htm#DynCall). [developed by Lexikos]

## 1.0.47.05 - November 21, 2007

Fixed the [Sort command](commands/Sort.htm): 1) fixed the ["function" option](commands/Sort.htm#callback) not to misbehave when it's the last option in the list; 2) fixed the ["unique" option](commands/Sort.htm#unique) so that when the delimiter is CRLF, the last item can be detected as a duplicate even when it doesn't end in CRLF; 3) fixed the "unique" option not to append a trailing delimiter when the last item is a duplicate. [thanks Roland]

Fixed [RegExMatch()](commands/RegExMatch.htm) and [RegExReplace()](commands/RegExReplace.htm) to yield correct results even when Haystack and OutputVar are both the same variable. [thanks Superfraggle]

Fixed inability to pass a parameter that is "a variable to which [ClipboardAll](misc/Clipboard.htm#ClipboardAll) has been assigned". [thanks Joy2DWorld & Lexikos]

Updated RegEx/PCRE from 7.0 to 7.4. For a summary of the major changes, see [www.pcre.org/news.txt](http://www.pcre.org/news.txt). For full details of every change and fix, see [www.pcre.org/changelog.txt](http://www.pcre.org/changelog.txt).

Added GUI control " [Tab2](commands/GuiControls.htm#Tab2)" that fixes rare redrawing problems in the original "Tab" control (e.g. activating a GUI window by clicking on a control's scrollbar). The original Tab control is retained for backward compatibility because "Tab2" puts its tab control after its contained controls in the tab-key navigation order. [thanks Xander]

## 1.0.47.04 - August 28, 2007

Fixed [key-up hotkeys](Hotkeys.htm#keyup) like `a up::` not to block the pressing of the "a" key unless the hotkey's [#IfWin criteria](commands/_IfWinActive.htm) are met. [thanks Roland]

Fixed `<a href="commands/Math.htm#Round" data-index="99">Round(Var, NegativeNumber)</a>`, which in rare cases was off by 1. [thanks Icarus]

Fixed crash of scripts that end in a syntax error consisting of an orphaned IF-statement (broken by 1.0.47.00). [thanks msgbox of the German forum]

Eliminated the "GetClipboardData" error dialog. Instead, an empty string is retrieved when the data cannot be accessed within the [#ClipboardTimeout](commands/_ClipboardTimeout.htm) period. [thanks ManaUser & Sean]

Changed GUI [checkboxes](commands/GuiControls.htm#Checkbox) and [radio buttons](commands/GuiControls.htm#Radio) to default to ["no word-wrap"](commands/Gui.htm#Wrap) when no width, height, or CR/LF characters are specified. This solves display issues under certain unusual DPI settings. [thanks Boskoop]

## 1.0.47.03 - August 1, 2007

Fixed [expressions](Variables.htm#Expressions) to allow literal negative hexadecimal numbers that end in "E"; e.g. fn(-0xe). [thanks Laszlo]

Fixed [block syntax](commands/Block.htm) to allow a [function-call](Functions.htm) immediately to the right of a '}'. [thanks Roland]

## 1.0.47.02 - July 19, 2007

Fixed the [Number option](commands/GuiControls.htm#EditNum) of Edit controls to properly display a balloon tip when the user types something other than a digit. [thanks tfcahm]

Fixed WM\_TIMER not to be blocked unless it's posted to the script's main window. [thanks tfcahm]

Fixed [wildcard hotkeys](Hotkeys.htm#wildcard) not to acquire [tilde behavior](Hotkeys.htm#Tilde) when the same hotkey exists in the script with a tilde. [thanks Lexikos]

Fixed [declaration initializers](Functions.htm#DeclareInit) not to retain whitespace at the end of literal numbers. Also, they now allow spaces between a closing quote and the next comma. [thanks Hardeep]

## 1.0.47.01 - July 8, 2007

Fixed [RunAs](commands/RunAs.htm) not to crash or misbehave when a domain is specified. [thanks Markus Frohnmaier]

Changed [relational operators](Variables.htm#Operators) to yield integers even when the inputs are floating point; e.g. `1.0 < 2.0` yields 1 vs. 1.0. [thanks Lexikos]

## 1.0.47 - June 19, 2007

Added support for [function libraries](Functions.htm#lib), which allow a script to call a function in an external file without having to use [#Include](commands/_Include.htm).

Added [RegisterCallback()](commands/RegisterCallback.htm), which creates a machine-code address that when called, redirects the call to a function in the script. [developed by Jonathan Rennison (JGR)]

Added [NumGet()](commands/NumGet.htm) and [NumPut()](commands/NumPut.htm), which retrieve/store binary numbers with much greater speed than Extract/InsertInteger.

Improved [Sort](commands/Sort.htm#callback) with an option to do custom sorting according to the criteria in a callback function. [thanks Laszlo]

Improved [OnMessage()](commands/OnMessage.htm) with an option to allow more than one simultaneous [thread](misc/Threads.htm). [thanks JGR]

Improved Critical with an option to change the [message-check interval](commands/Critical.htm#Interval), which may improve reliability for some usages. [thanks Majkinetor and JGR]

Changed [Critical](commands/Critical.htm) to put [SetBatchLines -1](commands/SetBatchLines.htm) into effect.

Changed the error messages produced by [#ErrorStdOut](commands/_ErrorStdOut.htm) to contain a space before the colon. [thanks Toralf]

Fixed [OnMessage() functions](commands/OnMessage.htm) that return one of their own local variables to return the number in that variable, not 0.

Fixed potential crashing of built-in variables that access the registry (e.g. A\_AppData, A\_Desktop, A\_MyDocuments, A\_ProgramFiles). [thanks Tekl]

## 1.0.46.17 - May 31, 2007

Fixed [A\_UserName](Variables.htm#UserName) (broken by 1.0.46.16).

## 1.0.46.16 - May 30, 2007

Fixed `<a href="commands/GuiControls.htm#Tab" data-index="127">Gui, Tab, TabName</a>` when used after a previous `Gui Tab`. [thanks Toralf]

Improved SetTimer to treat [negative periods](commands/SetTimer.htm#once) as "run only once". [thanks Majkinetor]

Added `<a href="commands/GuiControlGet.htm#Hwnd" data-index="129">GuiControlGet Hwnd</a>`, which is a more modular/dynamic way to retrieve a control's HWND. [thanks Majkinetor]

Added built-in variables [A\_ThisLabel](Variables.htm#ThisLabel) and [A\_ThisFunc](Variables.htm#ThisFunc), which contain the names of the currently-executing label/function. [thanks Titan & Majkinetor]

## 1.0.46.15 - May 9, 2007

Fixed [GuiControl](commands/GuiControl.htm), [GuiControlGet](commands/GuiControlGet.htm), and `Gui <a href="commands/ListView.htm#GuiLV" data-index="134">ListView</a>/<a href="commands/TreeView.htm#GuiTV" data-index="135">TreeView</a>` to support [static variables](Functions.htm#static) and [ByRefs](Functions.htm#ByRef) that point to globals/statics. [thanks Peter]

Fixed [FileInstall](commands/FileInstall.htm) causing the [Random](commands/Random.htm) command to become non-random in [compiled scripts](Scripts.htm#ahk2exe). [thanks Velocity]

Reduced the size of [compiled scripts](Scripts.htm#ahk2exe) by about 16 KB due to UPX 3.0. [thanks to atnbueno for discovering the optimal command-line switches]

## 1.0.46.14 - May 2, 2007

Added the "require administrator" flag to the installer to avoid a warning dialog on Windows Vista. [thanks Roussi Nikolov]

## 1.0.46.13 - May 1, 2007

Fixed [hotkeys](Hotkeys.htm) like **\*x** to fire even when **x** is also a hotkey that is prevented from firing due to [#IfWin](commands/_IfWinActive.htm). [thanks Joy2DWorld & Engunneer]

Improved [optional parameters](Functions.htm#optional) to accept quoted/literal strings as default values.

Improved [ByRef parameters](Functions.htm#ByRef) with the ability to be [optional](Functions.htm#optional) (i.e. they may accept default values). [thanks Corrupt]

## 1.0.46.12 - April 24, 2007

Fixed inability to recognize a literal scientific notation number that begins with 0, such as 0.15e+1. [thanks Laszlo]

## 1.0.46.11 - April 23, 2007

Fixed inability to have a [function-call](Functions.htm) as the first item in certain [comma-separated expressions](Variables.htm#comma). [thanks Majkinetor]

Fixed WinTitles like `ahk_id %ControlHwnd%` in [ControlGet](commands/ControlGet.htm)'s FindString/Choice/List, and [Control](commands/Control.htm)'s Add/Delete/Choose. [thanks Freighter & PhiLho]

Improved floating point support to recognize scientific notation; e.g. 1.2e-5 (the decimal point is mandatory). Also improved " [SetFormat Float](commands/SetFormat.htm#sci)" with an option to output in scientific notation. [thanks Laszlo]

## 1.0.46.10 - March 22, 2007

Fixed [StringSplit](commands/StringSplit.htm) inside assume-local [functions](Functions.htm) so that it creates a local [array](misc/Arrays.htm) even when OutputArray0 exists as a global but not a local. [thanks KZ]

Improved [ListView's item-changed notification ("I")](commands/ListView.htm#ItemChanged) to indicate via ErrorLevel whether the item has been selected/deselected, focused/unfocused, and/or checked/unchecked. [thanks foom]

Added an additional layer of protection to [compiled scripts](Scripts.htm#ahk2exe). It is recommended that scripts containing sensitive data or source code be recompiled with the [/NoDecompile switch](Scripts.htm#ahk2exeCmd).

## 1.0.46.09 - March 4, 2007

Fixed `<a href="commands/SetExpression.htm" data-index="158">:=</a>` deep inside expressions when used to assign the result of a recursive [function](Functions.htm) to a [local variable](Functions.htm#Local) (broken by 1.0.46.06). [thanks Laszlo]

Fixed inability to pass certain [ternary expressions](Variables.htm#ternary) to [ByRef parameters](Functions.htm#ByRef). [thanks Titan]

Fixed `<a href="commands/GuiControlGet.htm" data-index="163">GuiControlGet</a>, OutputVar, Pos` so that it doesn't make the OutputVar blank. [thanks PhiLho]

Changed and fixed continuation sections so that the ["Comment" option](Scripts.htm#CommentOption) doesn't force the [LTrim option](Scripts.htm#LTrim) into effect. [thanks Titan]

Changed the [Terminal Server Awareness flag](http://msdn2.microsoft.com/en-us/library/01cfys9z.aspx) back to "disabled" on AutoHotkey.exe and compiled scripts. This improves flexibility and backward compatibility (see [discussion](https://www.autohotkey.com/forum/topic16041.html) at forum).

## 1.0.46.08 - February 7, 2007

Fixed unreliability of [ComSpec](Variables.htm#ComSpec) and [environment variables](Concepts.htm#environment-variables) on Windows 9x (broken by v1.0.46.07). [thanks Loriss]

Changed: When AutoHotkey.exe is launched without a script specified, it will now run (or prompt you to create) the file AutoHotkey.ahk in the [My Documents](Variables.htm#MyDocuments) folder. The only exception is when AutoHotkey.ini exists in the working directory, in which case it uses the old behavior of executing that file.

Improved [DllCall](commands/DllCall.htm) to support an integer in place of the function name, which is interpreted as the address of the function to call. [thanks Sean]

## 1.0.46.07 - January 23, 2007

Fixed crash of illegally-named [dynamic variables](misc/Arrays.htm) on the left of an equal-sign assignment (broken by v1.0.45). [thanks PhiLho]

Fixed [FileMoveDir](commands/FileMoveDir.htm)'s "Option 2" to work properly even when the directory is being both renamed and moved. [thanks bugmenot]

Fixed inability to pass a variable [ByRef](Functions.htm#ByRef) if that same expression changed it from empty to non-empty (when [#NoEnv](commands/_NoEnv.htm) is absent). [thanks Joy2DWorld]

Changed DllCall's [A\_LastError](commands/DllCall.htm#LastError) to reflect only changes made by the script, not by AutoHotkey itself. [thanks Azerty]

## 1.0.46.06 - January 16, 2007

Applied minor fixes and improvements to [regular expressions](misc/RegEx-QuickRef.htm) by upgrading from PCRE 6.7 to 7.0. One of the most notable improvements is the \`a option, which recognizes any type of newline (namely \`r, \`n, or \`r\`n). Similarly, the \\R escape sequence means "any single newline of any type". See also: [Full PCRE changelog](http://www.pcre.org/changelog.txt)

Changed and fixed all [Control commands](commands/Control.htm) and [StatusBarWait](commands/StatusBarWait.htm) to obey [SetTitleMatchMode RegEx](commands/SetTitleMatchMode.htm#RegEx) as documented.

Changed [RegExReplace()](commands/RegExReplace.htm) to return the original/unaltered string rather than "" when an error occurs.

Changed: Enabled the [Terminal Server Awareness flag](http://msdn2.microsoft.com/en-us/library/01cfys9z.aspx) on AutoHotkey.exe and [compiled scripts](Scripts.htm#ahk2exe).

Improved performance when [assigning](Variables.htm#AssignOp) large strings returned from [user-defined functions](Functions.htm). [thanks Laszlo]

## 1.0.46.05 - January 4, 2007

Fixed the [Input command](commands/Input.htm) to allow named end keys like {F9} to work even when the shift key is being held down (broken by v1.0.45). [thanks Halweg]

Fixed inability of " [Gui Show](commands/Gui.htm#Show)" to focus the GUI window when the tray menu is used both to reload the script and to show the GUI window. [thanks Rnon]

Fixed inability to pass some types of [assignments (:=)](Variables.htm#AssignOp) to a [ByRef](Functions.htm#ByRef) parameter. [thanks Laszlo]

## 1.0.46.04 - January 2, 2007

Fixed inability to pass the result of an [assignment (:=)](Variables.htm#AssignOp) to a [ByRef](Functions.htm#ByRef) parameter. [thanks Titan]

## 1.0.46.03 - December 18, 2006

Fixed [ListView](commands/ListView.htm)'s floating point sorting to produce the correct ordering. [thanks oldbrother/Goyyah/Laszlo]

## 1.0.46.02 - December 17, 2006

Fixed [environment variables](Concepts.htm#environment-variables) to work properly as input variables in various commands such as [StringLen](commands/StringLen.htm) and [StringReplace](commands/StringReplace.htm) (broken by 1.0.44.14). [thanks Camarade\_Tux]

## 1.0.46.01 - December 15, 2006

**NOTE:** Although this release has been extensively tested, several low-level enhancements were made. If you have any mission-critical scripts, it is recommended that you retest them and/or wait a few weeks for any bugs to get fixed.

Fixed comma-separated [declaration initializers](Functions.htm#DeclareInit) such as `local x = 1, y = 2` to work even when immediately below an if/else/loop statement.

Fixed [comma-separated expressions](Variables.htm#comma) so when the leftmost item is an assignment, it will occur before the others rather than after. [thanks Laszlo]

Changed and fixed [function-calls](Functions.htm) so that any changes they make to [dynamic variable names](Variables.htm#ref), [environment variables](Concepts.htm#environment-variables), and [built-in variables](Variables.htm#BuiltIn) (such as [Clipboard](misc/Clipboard.htm)) are always visible to subsequent parts of the expression that called them.

Changed: When a [multi-statement comma](Variables.htm#comma) is followed immediately by a variable and an equal sign, that equal sign is automatically treated as a [:= assignment](commands/SetExpression.htm). For example, all of the following are assignments: `x:=1, y=2, a=b=c`.

Changed [comma-separated expressions](Variables.htm#comma) to produce the following effects: 1) the leftmost **/=** operator becomes [true divide](Variables.htm#divide) rather than [EnvDiv](commands/EnvDiv.htm); 2) blank values are not treated as zero in math expressions (thus they yield blank results).

Improved the performance of [expressions](Variables.htm#Expressions) by 5 to 20% (depending on type).

Improved the [new assignment operators such as **.=**](Variables.htm#AssignOp) to support the [Clipboard variable](misc/Clipboard.htm) (even in [comma-separated expressions](Variables.htm#comma)).

Improved the [**.=** operator](Variables.htm#AssignOp) so that it doesn't require a space to its left.

Improved GUI controls to accept [static variables](Functions.htm#static) as their [associated variables](commands/Gui.htm#var) (formerly only globals were allowed).

Added option [HwndOutputVar](commands/Gui.htm#HwndOutputVar) to `Gui Add`, which stores a control's HWND in OutputVar. [thanks Corrupt & Toralf]

## 1.0.46 - November 29, 2006

**NOTE:** Although this release has been extensively tested and is not expected to break any existing scripts, several low-level enhancements were made. If you have any mission-critical scripts, it is recommended that you retest them and/or wait a few weeks for any bugs to get fixed.

Added function [SubStr()](commands/SubStr.htm), which retrieves the specified number of characters at the specified position in a string.

Added assignment operators [//=, **.** =, \|=, &=, ^=, >>=, and <<=](Variables.htm#AssignOp), which can be used anywhere in expressions. For example, `Var .= "abc"` appends the string "abc" to _Var_'s current contents.

Added full support in expressions for the operators [:=, ++, --, +=, -=, \*=, and /=](Variables.htm#AssignOp) (formerly, they could be used only as the leftmost operator on a line). All [assignment operators](Variables.htm#AssignOp) (especially [\+\+ and --](Variables.htm#IncDec)) behave in a C-like way when their result is used by some other operator.

Added the [ternary operator (?:)](Variables.htm#ternary), which is a shorthand replacement for the [if-else statement](commands/IfExpression.htm). For example, `var := x>y ? 2 : 3` assigns the value 2 if x is greater than y; otherwise it assigns 3.

Added support for [comma-separated expressions](Variables.htm#comma), which allow a single line to contain multiple assignments, function calls, and other expressions. [thanks PhiLho & Titan]

Improved [variable declarations](Functions.htm#DeclareInit) to support initialization on the same line. Note: A [static variable](Functions.htm#static)'s initialization occurs only once, before the script begins executing.

Improved [line continuation](Scripts.htm#continuation) to support all expression operators. For example, a line that starts with "?" or "+" is automatically appended to the line above it.

Improved performance of operators [" **.**"](Variables.htm#concat) and [" **.=**"](Variables.htm#concat) to be as fast as the percent-sign method of appending a string.

Improved expressions to allow more types of [consecutive unary operators](Variables.htm#unary) such as **!!** Var. [thanks Laszlo]

Changed [Critical](commands/Critical.htm) to check messages less often (20 vs. 10ms), which improves the reliability of frequently-called [OnMessage functions](commands/OnMessage.htm). [thanks Majkinetor]

Changed: A variable named simply "?" is no longer valid in expressions due to the new [ternary operator](Variables.htm#ternary).

Fixed [hotkeys](Hotkeys.htm) to support `:::` (colon as a hotkey) and `: & x` (colon as a [hotkey prefix](Hotkeys.htm#combo)).

Fixed the installer to remove psapi.dll from the AutoHotkey folder (except on Windows NT4). This avoids a conflict with Internet Explorer 7. [thanks to all who reported it]

## 1.0.45.04 - November 15, 2006

Fixed crash on Windows 9x when a script doesn't actually run (e.g. due to syntax error) (broken by v1.0.45). [thanks rogerg]

Changed `<a href="commands/Control.htm" data-index="236">Control Style|ExStyle</a>` to report ErrorLevel 0 vs. 1 when the requested style change wasn't necessary because it was already in effect.

Improved [#Include](commands/_Include.htm) to support [%A\_AppData%](Variables.htm#AppData) and [%A\_AppDataCommon%](Variables.htm#AppDataCommon). [thanks Tekl]

## 1.0.45.03 - November 12, 2006

Fixed [file-pattern loops](commands/LoopFile.htm) not to crash when recursing into paths longer than 259 characters. In addition, such paths and files are now ignored (skipped over) by file-pattern loops, [FileSetAttrib](commands/FileSetAttrib.htm), and [FileSetTime](commands/FileSetTime.htm). [thanks PhilR]

Fixed [functions](Functions.htm) that call themselves and assign the result to one of their own [locals](Functions.htm#Local) (broken by v1.0.45). [thanks bjennings]

Fixed crash of scripts containing [regular expressions](misc/RegEx-QuickRef.htm) that have compile errors. [thanks PhiLho]

Fixed [GuiControl](commands/GuiControl.htm) not to convert [checkboxes](commands/GuiControls.htm#Checkbox) into 3-state unless requested. [thanks JBensimon]

Changed [UrlDownloadToFile](commands/URLDownloadToFile.htm) to announce a user-agent of "AutoHotkey" to the server rather than a blank string. [thanks jaco0646]

Improved [continuation sections](Scripts.htm#continuation) to support semicolon comments inside the section via the option-word _Comments_.

## 1.0.45.02 - November 8, 2006

Fixed [StringUpper](commands/StringLower.htm) and [StringLower](commands/StringLower.htm) to work when OutputVar is the clipboard (broken by v1.0.45). [thanks songsoverruins]

Fixed the hotkeys ~Alt, ~Control, and ~Shift to fire upon press-down rather than release (broken by v1.0.44).

Background: Without the tilde, Alt/Control/Shift fire upon release to avoid taking over both the left and right key. But a specific left/right hotkey like LAlt or RShift fires upon press-down.

## 1.0.45.01 - November 7, 2006

Fixed [FileReadLine](commands/FileReadLine.htm) and [FileSelectFile](commands/FileSelectFile.htm) not to crash or misbehave when other [threads](misc/Threads.htm) interrupt them (broken by v1.0.45). [thanks toralf]

Fixed [RegExMatch()](commands/RegExMatch.htm) so that when there's no match, named subpatterns are properly set to "" in the output array. [thanks PhiLho]

Fixed [RegExMatch()](commands/RegExMatch.htm)'s "J" option to properly write duplicate named subpatterns to the output array. [thanks PhiLho]

Changed [SetWorkingDir](commands/SetWorkingDir.htm) and [#Include DirName](commands/_Include.htm) to succeed even for a root directory such as C: that lacks a backslash.

Improved [DllCall()](commands/DllCall.htm) to display a warning dialog if the called function writes to a variable of zero capacity.

## 1.0.45 - November 4, 2006

**NOTE:** Although this release has been extensively tested and is not expected to break any existing scripts, several low-level performance enhancements were made. If you have any mission-critical scripts, it is recommended that you retest them and/or wait a few weeks for any bugs to get fixed.

Added support for [regular expressions](misc/RegEx-QuickRef.htm) via [RegExMatch()](commands/RegExMatch.htm), [RegExReplace()](commands/RegExReplace.htm), and [SetTitleMatchMode RegEx](commands/SetTitleMatchMode.htm#RegEx). [thanks Philip Hazel & PhiLho]

Improved performance and memory utilization of [StringReplace](commands/StringReplace.htm).

Improved performance of the [:= operator](commands/SetExpression.htm) for expressions and functions involving long strings.

Improved [ControlClick](commands/ControlClick.htm) with a new option "NA" that avoids activating the target window (this mode also improves reliability in some cases). In addition, it's been documented that [SetControlDelay -1](commands/SetControlDelay.htm) can improve the reliability of ControlClick in some cases. [thanks nnesori]

Changed [GUI buttons](commands/GuiControls.htm#Button) to default to ["no word-wrap"](commands/Gui.htm#Wrap) when no width, height, or CR/LF characters were specified. This may solve button display issues under some desktop themes.

Fixed " [Transform HTML](commands/Transform.htm#HTML)" for the following characters: &\`n><

Fixed misinterpretation of lines starting with "if not is" such as "if not **Is** Done".

Fixed inability of " [Gui Show](commands/Gui.htm#Show)" to move a window vertically downward to where its bottommost row of pixels is now.

Fixed inability to use [GroupActivate](commands/GroupActivate.htm) as the only line beneath an IF or ELSE.

Fixed inability of the [Input command](commands/Input.htm) to differentiate between end-keys enclosed in braces and their (un)shifted counterparts; e.g. '{' vs. '['. [thanks Laszlo]

## Older Changes

Visit [www.autohotkey.com/changelog/](https://web.archive.org/web/20130620190653/http://www.autohotkey.com/changelog/) for even older changes.

