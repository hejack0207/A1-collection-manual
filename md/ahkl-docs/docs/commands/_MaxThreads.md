# \#MaxThreads

Sets the maximum number of simultaneous [threads](../misc/Threads.htm).

```
<span class="func">#MaxThreads</span> Value
```

## Parameters

Value

The maximum total number of [threads](../misc/Threads.htm) that can exist simultaneously. Specifying a number higher than 255 is the same as specifying 255 (in versions prior to 1.0.48, the limit was 20).

## Remarks

This setting is global, meaning that it needs to be specified only once (anywhere in the script) to affect the behavior of the entire script.

Although a value of 1 is allowed, it is not recommended because it would prevent new [hotkeys](../Hotkeys.htm) from launching whenever the script is displaying a [message box](MsgBox.htm) or other dialog. It would also prevent [timers](SetTimer.htm) from running whenever another [thread](../misc/Threads.htm) is sleeping or waiting.

Up to two of the following types of [threads](../misc/Threads.htm) may be created even when #MaxThreads has been reached: A [hotkey](../Hotkeys.htm), [hotstring](../Hotstrings.htm), [OnClipboardChange](OnClipboardChange.htm), or [GUI event](Gui.htm#Events) if the first line of its subroutine is [ExitApp](ExitApp.htm), [Pause](Pause.htm), [Edit](Edit.htm), [Reload](Reload.htm), [KeyHistory](KeyHistory.htm), [ListLines](ListLines.htm), [ListVars](ListVars.htm), or [ListHotkeys](ListHotkeys.htm). Also, an [OnExit thread](OnExit.htm) will always launch regardless of how many threads exist.

If this setting is lower than [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm), it effectively overrides that setting.

If this directive is unspecified in the script, it will behave as though set to 10.

Like other directives, #MaxThreads cannot be executed conditionally.

## Related

[#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm), [Threads](../misc/Threads.htm), [#MaxHotkeysPerInterval](_MaxHotkeysPerInterval.htm), [#HotkeyInterval](_HotkeyInterval.htm), [ListHotkeys](ListHotkeys.htm), [#MaxMem](_MaxMem.htm)

## Examples

Allows a maximum of 2 instead of 10 simultaneous threads.

```
#MaxThreads 2
```

