# Thread

Sets the priority or interruptibility of [threads](../misc/Threads.htm). It can also temporarily disable all [timers](SetTimer.htm).

```
<span class="func">Thread</span>, <a href="#SubCommands" data-index="3">SubCommand</a> <span class="optional">, Value1, Value2</span>
```

The _SubCommand_, _Value1_, and _Value2_ parameters are dependent upon each other and their usage is described below.

## Sub-commands

For _SubCommand_, specify one of the following:

- [NoTimers](#NoTimers): Prevents interruptions from any timers.
- [Priority](#Priority): Changes the priority level of the current thread.
- [Interrupt](#Interrupt): Changes the duration of interruptibility for newly launched threads.

### NoTimers

Prevents interruptions from any timers.

```
<span class="func">Thread</span>, NoTimers <span class="optional">, TrueOrFalse</span>
```

This sub-command prevents interruptions from any [timers](SetTimer.htm) until the [current thread](../misc/Threads.htm) either ends, executes `Thread, NoTimers, false`, or is interrupted by another thread that allows timers (in which case timers can interrupt the interrupting thread until it finishes).

If this sub-command is not used in the auto-execute section (top part of the script), all threads start off as interruptible by timers (though the settings of the [Interrupt](#Interrupt) sub-command [below] will still apply). By contrast, if the auto-execute section turns on this sub-command but never turns it off, every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm)) starts off immune to interruptions by timers.

Regardless of the default setting, timers will always operate when the script has no threads (unless [Pause](Pause.htm) has been turned on).

`Thread, NoTimers` is equivalent to `Thread, NoTimers, true`. In addition, since _TrueOrFalse_ is an [expression](../Variables.htm#Expressions), true resolves to 1, and false to 0.

### Priority

Changes the priority level of the current thread.

```
<span class="func">Thread</span>, Priority, Level
```

Specify for _Level_ an integer between -2147483648 and 2147483647 (or an [expression](../Variables.htm#Expressions)) to indicate the current thread's new priority. This has no effect on other threads. See [Threads](../misc/Threads.htm) for details.

Due to its ability to buffer events, the command [Critical](Critical.htm) is generally superior to this sub-command.

On a related note, the OS's priority level for the entire script can be changed via [Process Priority](Process.htm#Priority). For example:

```
Process, Priority,, High
```

### Interrupt

Changes the duration of interruptibility for newly launched threads.

```
<span class="func">Thread</span>, Interrupt <span class="optional">, Duration, LineCount</span>
```

**Note:** This sub-command should be used sparingly because most scripts perform more consistently with settings close to the defaults.

By default, every newly launched thread is uninterruptible for a _Duration_ of 15 milliseconds or a _LineCount_ of 1000 script lines, whichever comes first. This gives the thread a chance to finish rather than being immediately interrupted by another thread that is waiting to launch (such as a buffered [hotkey](../Hotkeys.htm) or a series of [timed subroutines](SetTimer.htm) that are all due to be run).

**Note:** Any _Duration_ less than 17 might result in a shorter actual duration or immediate interruption, since the system tick count has a minimum resolution of 10 to 16 milliseconds.

If either parameter is 0, each newly launched thread is immediately interruptible. If either parameter is -1, the thread cannot be interrupted as a result of that parameter. The maximum for both parameters is 2147483647.

This sub-command is global, meaning that all subsequent threads will obey it, even if the sub-command is used somewhere other than the [auto-execute section](../Scripts.htm#auto). However, [interrupted threads](../misc/Threads.htm) are unaffected because their period of uninterruptibility has already expired. Similarly, the [current thread](../misc/Threads.htm) is unaffected except if it is uninterruptible at the time the _LineCount_ parameter is changed, in which case the new _LineCount_ will be in effect for it.

If a [hotkey](../Hotkeys.htm) is pressed or a [custom menu item](Menu.htm) is selected while the [current thread](../misc/Threads.htm) is uninterruptible, that event will be buffered. In other words, it will launch when the current thread finishes or becomes interruptible, whichever comes first. The exception to this is when the current thread becomes interruptible before it finishes, and it is of higher [priority](#Priority) than the buffered event; in this case the buffered event is unbuffered and discarded.

Regardless of this sub-command, a thread will become interruptible the moment it displays a [MsgBox](MsgBox.htm), [InputBox](InputBox.htm), [FileSelectFile](FileSelectFile.htm), or [FileSelectFolder](FileSelectFolder.htm) dialog.

Either parameter can be left blank to avoid changing it.

If [Critical](Critical.htm) is specified as the first line of the thread's subroutine or function, the thread starts out uninterruptible and the Interrupt sub-command has no effect. However, this does not apply to bound functions or user-defined [function objects](../objects/Functor.htm).

## Remarks

Due to its greater flexibility and its ability to buffer events, the command [Critical](Critical.htm) is generally more useful than the sub-commands [Interrupt](#Interrupt) and [Priority](#Priority).

## Related

[Critical](Critical.htm), [Threads](../misc/Threads.htm), [Hotkey](Hotkey.htm), [Menu](Menu.htm), [SetTimer](SetTimer.htm), [Process](Process.htm)

## Examples

Makes the priority of the current thread slightly above average.

```
Thread, Priority, 1
```

Makes each newly launched thread immediately interruptible.

```
Thread, Interrupt, 0
```

Makes each thread interruptible after 50 ms or 2000 lines, whichever comes first.

```
Thread, Interrupt, 50, 2000
```

