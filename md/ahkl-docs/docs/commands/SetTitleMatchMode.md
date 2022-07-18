# SetTitleMatchMode

Sets the matching behavior of the WinTitle parameter in commands such as [WinWait](WinWait.htm).

```
<span class="func">SetTitleMatchMode</span>, MatchMode
<span class="func">SetTitleMatchMode</span>, Speed

```

## Parameters

MatchMode

Specify one of the following digits or the word RegEx:

- 1 = A window's title must start with the specified_WinTitle_ to be a match.
- 2 = A window's title can contain_WinTitle_ anywhere inside it to be a match.
- 3 = A window's title must exactly match_WinTitle_ to be a match.
- RegEx[v1.0.45+] = Changes _WinTitle_, _WinText_, _ExcludeTitle_, and _ExcludeText_ to accept [regular expressions](../misc/RegEx-QuickRef.htm). Do not enclose such expressions in quotes when using them with commands. For example: `<a href="WinActivate.htm" data-index="3">WinActivate</a> Untitled.*Notepad`.

  RegEx also applies to [ahk\_class](../misc/WinTitle.htm#ahk_class) and [ahk\_exe](../misc/WinTitle.htm#ahk_exe); for example, `ahk_class IEFrame` searches for any window whose class name contains _IEFrame_ anywhere (this is because by default, regular expressions find a match _anywhere_ in the target string).

  For _WinTitle_, each component is separate. For example, in `i)^untitled ahk_class i)^notepad$ ahk_pid %mypid%`, `i)^untitled` and `i)^notepad$` are separate regex patterns and `%mypid%` is always compared numerically (it is not a regex pattern).

  For _WinText_, each text element (i.e. each control's text) is matched against the RegEx separately. Therefore, it is not possible to have a match span more than one text element.


The modes above also affect _ExcludeTitle_ in the same way as _WinTitle_. For example, mode 3 requires that a window's title exactly match _ExcludeTitle_ for that window to be excluded.

Speed

One of the following words to specify how the _WinText_ and _ExcludeText_ parameters should be matched:

**Fast**: This is the default behavior. Performance may be substantially better than _Slow_, but certain types of controls are not detected. For instance, text is typically detected within Static and Button controls, but not Edit controls, unless they are owned by the script.

**Slow**: Can be much slower, but works with all controls which respond to the [WM\_GETTEXT](https://msdn.microsoft.com/en-us/library/ms632627) message.

## Remarks

This command affects the behavior of all windowing functions and commands, e.g. [WinExist()](WinExist.htm) and [WinActivate](WinActivate.htm). [WinGetText](WinGetText.htm) is affected in the same way as other commands, but it always uses the _Slow_ method to retrieve text.

If unspecified, TitleMatchMode defaults to 1 and _fast_.

If a [window group](../misc/WinTitle.htm#ahk_group) is used, the current title match mode applies to each individual rule in the group.

Generally, the _slow_ mode should be used only if the target window cannot be uniquely identified by its title and _fast_-mode text. This is because the slow mode can be extremely slow if there are any application windows that are busy or "not responding".

Window Spy has an option for _Slow TitleMatchMode_ so that its easy to determine whether the _Slow_ mode is needed.

If you wish to change both attributes, run the command twice as in this example:

```
SetTitleMatchMode, 2
SetTitleMatchMode, slow
```

The built-in variables **A\_TitleMatchMode** and **A\_TitleMatchModeSpeed** contain the current settings.

Regardless of the current TitleMatchMode, _WinTitle_, _WinText_, _ExcludeTitle_ and _ExcludeText_ are case sensitive. The only exception is the [case-insensitive option](../misc/RegEx-QuickRef.htm#Options) of the RegEx mode; for example: `<strong>i)</strong>untitled - notepad`.

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[SetWinDelay](SetWinDelay.htm), [WinExist()](WinExist.htm), [WinActivate](WinActivate.htm), [RegExMatch()](RegExMatch.htm)

## Examples

Allows windowing functions and commands to operate upon windows whose titles contain WinTitle anywhere instead of at the beginning.

```
SetTitleMatchMode 2
```

Allows windowing functions and commands to detect more control types, but with lower performance. Note that Slow/Fast can be set independently of all the other modes.

```
SetTitleMatchMode Slow
```

