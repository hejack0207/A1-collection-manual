# \#MaxThreadsBuffer

Causes some or all [hotkeys](../Hotkeys.htm) to buffer rather than ignore keypresses when their [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm) limit has been reached.

```
<span class="func">#MaxThreadsBuffer</span> OnOff
```

## Parameters

OnOff

Specify one of the following words:

**On**: All hotkey subroutines between here and the next `#MaxThreadsBuffer OFF` directive will buffer rather than ignore presses of their hotkeys whenever their subroutines are at their [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm) limit.

**Off**: This is the default behavior. A hotkey press will be ignored whenever that hotkey is already running its maximum number of threads (usually 1, but this can be changed with [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm)).

## Remarks

This directive is rarely used because this type of buffering, which is OFF by default, usually does more harm than good. For example, if you accidentally press a hotkey twice, having this setting ON would cause that hotkey's subroutine to automatically run a second time if its first [thread](../misc/Threads.htm) takes less than 1 second to finish (this type of buffer expires after 1 second, by design). Note that AutoHotkey buffers hotkeys in several other ways (such as `<a href="Thread.htm" data-index="6">Thread</a> Interrupt` and `<a href="Critical.htm" data-index="7">Critical</a>`). It's just that this particular way can be detrimental, thus it is OFF by default.

The main use for this directive is to increase the responsiveness of the keyboard's auto-repeat feature. For example, when you hold down a hotkey whose [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm) setting is 1 (the default), incoming keypresses are ignored if that hotkey subroutine is already running. Thus, when the subroutine finishes, it must wait for the next auto-repeat keypress to come in, which might take 50ms or more due to being caught in between keystrokes of the auto-repeat cycle. This 50ms delay can be avoided by enabling this directive for any hotkey that needs the best possible response time while it is being auto-repeated.

As with all # directives, this one should not be positioned in the script as though it were a command (i.e. it is not necessary to have it contained within a subroutine). Instead, position it immediately before the first hotkey label you wish to have affected by it.

Like other directives, #MaxThreadsBuffer cannot be executed conditionally.

## Related

[#MaxThreads](_MaxThreads.htm), [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm), [Critical](Critical.htm), [Thread (command)](Thread.htm), [Threads](../misc/Threads.htm), [Hotkey](Hotkey.htm), [#MaxHotkeysPerInterval](_MaxHotkeysPerInterval.htm), [#HotkeyInterval](_HotkeyInterval.htm), [ListHotkeys](ListHotkeys.htm)

## Examples

Causes the first two hotkeys to buffer rather than ignore keypresses when their #MaxThreadsPerHotkey limit has been reached.

```
#MaxThreadsBuffer On
#x::MsgBox, This hotkey will use this type of buffering.
#y::MsgBox, And this one too.
#MaxThreadsBuffer Off
#z::MsgBox, But not this one.
```

