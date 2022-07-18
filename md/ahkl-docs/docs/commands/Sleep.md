# Sleep

Waits the specified amount of time before continuing.

```
<span class="func">Sleep</span>, Delay
```

## Parameters

Delay

The amount of time to pause (in milliseconds) between 0 and 2147483647 (24 days), which can be an [expression](../Variables.htm#Expressions).

## Remarks

Due to the granularity of the OS's time-keeping system, _Delay_ is typically rounded up to the nearest multiple of 10 or 15.6 milliseconds (depending on the type of hardware and drivers installed). For example, a delay between 1 and 10 (inclusive) is equivalent to 10 or 15.6 on most Windows 2000/XP systems. To achieve a shorter delay, see [Examples](#ShorterSleep).

The actual delay time might wind up being longer than what was requested if the CPU is under load. This is because the OS gives each needy process a slice of CPU time (typically 20 milliseconds) before giving another timeslice to the script.

A delay of 0 yields the remainder of the script's current timeslice to any other processes that need it (as long as they are not significantly lower in [priority](Process.htm#Priority) than the script). Thus, a delay of 0 produces an actual delay between 0 and 20ms (or more), depending on the number of needy processes (if there are no needy processes, there will be no delay at all). However, a _Delay_ of 0 should always wind up being shorter than any longer _Delay_ would have been.

While sleeping, new [threads](../misc/Threads.htm) can be launched via [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm).

**Sleep -1**: A delay of -1 does not sleep but instead makes the script immediately check its message queue. This can be used to force any pending [interruptions](../misc/Threads.htm) to occur at a specific place rather than somewhere more random. See [Critical](Critical.htm) for more details.

## Related

[SetKeyDelay](SetKeyDelay.htm), [SetMouseDelay](SetMouseDelay.htm), [SetControlDelay](SetControlDelay.htm), [SetWinDelay](SetWinDelay.htm), [SetBatchLines](SetBatchLines.htm)

## Examples

Waits 1 second before continuing execution.

```
Sleep 1000
```

Waits 30 minutes before continuing execution.

```
MyVar := 30 * 60000 <em>; 30 means minutes and times 60000 gives the time in milliseconds.</em>
Sleep MyVar <em>; Sleep for 30 minutes.</em>
```

Demonstrates how to sleep for less time than the normal 10 or 15.6 milliseconds. Note: While a script like this is running, the entire operating system and all applications are affected by timeBeginPeriod below.

```
SetBatchLines -1  <em>; Ensures maximum effectiveness of this method.</em>

SleepDuration := 1  <em>; This can sometimes be finely adjusted (e.g. 2 is different than 3) depending on the value below.</em>
TimePeriod := 3 <em>; Try 7 or 3.  See comment below.
; On a PC whose sleep duration normally rounds up to 15.6 ms, try TimePeriod:=7 to allow
; somewhat shorter sleeps, and try TimePeriod:=3 or less to allow the shortest possible sleeps.</em>

DllCall("Winmm\timeBeginPeriod", "UInt", TimePeriod)  <em>; Affects all applications, not just this script's DllCall("Sleep"...), but does not affect SetTimer.</em>
Iterations := 50
StartTime := A_TickCount

Loop %Iterations%
    DllCall("Sleep", "UInt", SleepDuration)  <em>; Must use DllCall instead of the Sleep command.</em>

DllCall("Winmm\timeEndPeriod", "UInt", TimePeriod)  <em>; Should be called to restore system to normal.</em>
MsgBox % "Sleep duration = " . (A_TickCount - StartTime) / Iterations
```

