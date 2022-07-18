# AutoIt v2 Compatibility

[AutoHotkey v1.1.09+] **do not support** AutoIt v2 (.aut) scripts. Older versions of AutoHotkey supported AutoIt v2 scripts by changing the default settings and behaviour of some commands. This page contains information which has been removed from other pages in the documentation.

**The following only applies to .aut files, and only on [v1.1.08.01] or earlier.**

Affected elementChange[#AllowSameLineComments](../commands/_AllowSameLineComments.htm)By default, comments are not allowed on the same line as a command.A\_ScriptDirA final backslash is included.DetectHiddenTextDefaults to Off.#EscapeCharDefaults to backslash (\\).FileCopyErrorLevel is set to 1 if any of the files could not be copied.IniDeleteErrorLevel is not changed.IniReadThe _Default_ parameter is not supported; the string ERROR will always be stored in _OutputVar_ if there was a problem reading the value.IniWriteErrorLevel is not changed.InputBoxIf the user presses the CANCEL button, _OutputVar_ is set to be blank. [ErrorLevel](ErrorLevel.htm) is not changed unless the dialog times out.SetBatchLinesDefaults to 1, which causes the script to sleep after every line.SetKeyDelayThe default _Delay_ for the traditional SendEvent mode is 20.SendThe character `#` is ignored.SplashTextOn_Height_ includes the window's title bar.

## Escape Char Conversion

Running a script file with the extension `.aut.ahk` on [AutoHotkey v1.1.08.01] or earlier does not execute the script; it instead converts the script from the AutoIt v2 default escape character (backslash) to the AutoHotkey default (backtick).

## Obsolete Commands

The following commands were supported by automatically translating them to the corresponding AutoHotkey commands (and this was previously undocumented): LeftClick, LeftClickDrag, RightClick, RightClickDrag, HideAutoItWin, Repeat, EndRepeat. This automatic translation has been removed in [v1.1.09].

