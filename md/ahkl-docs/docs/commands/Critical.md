# Critical

Prevents the [current thread](../misc/Threads.htm) from being interrupted by other threads, or enables it to be interrupted.

```
<span class="func">Critical</span> <span class="optional">, OnOffNumeric</span>

```

## Parameters

OnOffNumeric

If blank or omitted, it defaults to On. Otherwise, specify one of the following:

**On**: The [current thread](../misc/Threads.htm) is made critical, meaning that it cannot be interrupted by another thread.

**Off**: The current thread immediately becomes interruptible, regardless of the settings of [Thread Interrupt](Thread.htm). See [Critical Off](#Off) for details.

**(Numeric)**[v1.0.47+]: Specify a positive number to turn on Critical but also change the number of milliseconds between checks of the internal message queue. See [Message Check Interval](#Interval) for details. [v1.0.48+]: Specifying 0 turns off Critical.

## Behavior of Critical Threads

Critical threads are _uninterruptible_; for details, see [Threads](../misc/Threads.htm#Behave).

A critical thread becomes interruptible when a [message box](MsgBox.htm) or other dialog is displayed. However, unlike [Thread Interrupt](Thread.htm), the thread becomes critical again after the user dismisses the dialog.

## Critical Off

When buffered events are waiting to start new threads, using `Critical Off` will not result in an immediate interruption of the current thread. Instead, an average of 5 milliseconds will pass before an interruption occurs. This makes it more than 99.999% likely that at least one line after `Critical Off` will execute before an interruption. You can force interruptions to occur immediately by means of a delay such as a `<a href="Sleep.htm" data-index="9">Sleep</a> -1` or a [WinWait](WinWait.htm) for a window that does not yet exist.

`Critical Off` cancels the current thread's period of uninterruptibility even if the thread was not Critical, thereby letting events such as [GuiSize](Gui.htm#GuiSize) be processed sooner or more predictably.

## Thread Settings

See [A\_IsCritical](../Variables.htm#IsCritical) for how to save and restore the current setting of Critical. However, since Critical is a thread-specific setting, when a critical thread ends, the underlying/resumed thread (if any) will be automatically noncritical. Consequently there is no need to do `Critical Off` right before ending a thread.

If Critical is not used in the auto-execute section (top part of the script), all threads start off as noncritical (though the settings of [Thread Interrupt](Thread.htm) will still apply). By contrast, if the auto-execute section turns on Critical but never turns it off, every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off critical.

The command [Thread NoTimers](Thread.htm) is similar to Critical except that it only prevents interruptions from [timers](SetTimer.htm).

[v1.0.47+]: Turning on Critical also puts `<a href="SetBatchLines.htm" data-index="20">SetBatchLines</a> -1` into effect for the [current thread](../misc/Threads.htm).

## Message Check Interval

[v1.0.47+]: Specifying a positive number as the first parameter (e.g. `Critical 30`) turns on Critical but also changes the number of milliseconds between checks of the internal message queue. If unspecified, messages are checked every 16 milliseconds while Critical is On, and every 5 ms while Critical is Off. Increasing the interval postpones the arrival of messages/events, which gives the [current thread](../misc/Threads.htm) more time to finish. This reduces the possibility that certain [OnMessage()](OnMessage.htm) and [GUI events](Gui.htm#DefaultWin) will be lost due to "thread already running". However, commands that wait such as [Sleep](Sleep.htm) and [WinWait](WinWait.htm) will check messages regardless of this setting (a workaround is `DllCall("Sleep", "UInt", 500)`).

**Note**: Increasing the message-check interval too much may reduce the responsiveness of various events such as [GUI](Gui.htm) window repainting.

## Related

[Thread (command)](Thread.htm), [Threads](../misc/Threads.htm), [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm), [#MaxThreadsBuffer](_MaxThreadsBuffer.htm), [OnMessage()](OnMessage.htm), [RegisterCallback()](RegisterCallback.htm), [Hotkey](Hotkey.htm), [Menu](Menu.htm), [SetTimer](SetTimer.htm)

## Examples

Press a hotkey to display a tooltip for 3 seconds. Due to Critical, any new thread that is launched during this time (e.g. by pressing the hotkey again) will be postponed until the tooltip disappears.

```
#space::  <em>; Win+Space hotkey.</em>
Critical
ToolTip No new threads will launch until after this ToolTip disappears.
Sleep 3000
ToolTip  <em>; Turn off the tip.</em>
return  <em>; Returning from a hotkey subroutine ends the thread. Any underlying thread to be resumed is noncritical by definition.</em>
```

