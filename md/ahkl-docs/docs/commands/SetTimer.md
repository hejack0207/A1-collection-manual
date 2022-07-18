# SetTimer

Causes a subroutine to be launched automatically and repeatedly at a specified time interval.

```
<span class="func">SetTimer</span> <span class="optional">, Label, PeriodOnOffDelete, Priority</span>
```

## Parameters

Label

The name of the [label](../misc/Labels.htm) or [hotkey label](../Hotkeys.htm) to which to jump, which causes the commands beneath _Label_ to be executed until a [Return](Return.htm) or [Exit](Exit.htm) is encountered. As with the parameters of almost all other commands, _Label_ can be a [variable](../Variables.htm) reference such as %MyLabel%, in which case the name stored in the variable is used as the target.

[v1.1.01+]: If _Label_ is omitted, [A\_ThisLabel](../Variables.htm#ThisLabel) will be used. For example, `SetTimer,, Off` can be used inside a timer subroutine to turn off the timer, while `SetTimer,, 1000` would either update the current timer's _Period_ or set a new timer using the label which is currently running. [v1.1.24+]: If A\_ThisLabel is empty but the current thread was launched by a timer, that timer is used. This is useful for timers which launch functions or function objects.

[v1.1.20+]: If not a valid label name, this parameter can be the name of a function whose parameter list has no mandatory parameters (see the [function example](#ExFunction)), or a single variable reference containing a [function object](../objects/Functor.htm). For example, `SetTimer %FuncObj%, 1000` or `SetTimer % FuncObj, 1000`. Other expressions which return objects are currently unsupported. See the [class example](#ExampleClass) for more details.

**Note:**[v1.1.24+]: Passing an empty variable or an expression which results in an empty value is considered an error. This parameter must be either given a non-empty value or completely omitted.

PeriodOnOffDelete

**On**: Re-enables a previously disabled timer at its former _period_. If the timer doesn't exist, it is created (with a default period of 250). The timer is also [reset](#reset). If the timer exists but was previously set to [run-only-once mode](#once), it will again run only once.

**Off**: Disables an existing timer.

**Delete**[v1.1.20+]: Disables and deletes an existing timer. If the timer is associated with a [function object](../objects/Functor.htm), the object is released. Turning off a timer does not release the object.

**Period**: Creates or updates a timer using the absolute value of this parameter as the [approximate](#Precision) number of milliseconds that must pass before the timer is executed. The timer will be automatically enabled and [reset](#reset). It can be set to repeat automatically or run only once:

- If_Period_ is positive, the timer will automatically repeat until it is explicitly disabled by the script.
- [v1.0.46.16+]: If _Period_ is negative, the timer will run only once. For example, specifying -100 would run the timer 100 ms from now then disable the timer as though `SetTimer, Label, Off` had been used.

  [v1.1.24+]: If _Label_ is an object created by the script (not an actual function or label), the timer is automatically deleted after the timer function returns, unless the timer was re-enabled. This allows the object to be freed if the script is no longer referencing it, but it also means the timer's _Period_ and _Priority_ are not retained.


_Period_ must be an integer, unless a variable or expression is used, in which case any fractional part is ignored. Its absolute value must be no larger than 4294967295 ms (49.7 days).

**Default**: If this parameter is blank and:

1) the timer does not exist: it will be created with a period of 250.

2) the timer already exists: it will be enabled and [reset](#reset) at its former _period_ unless a _Priority_ is specified.

Priority

This optional parameter is an integer between -2147483648 and 2147483647 (or an [expression](../Variables.htm#Expressions)) to indicate this timer's thread priority. If omitted, 0 will be used. See [Threads](../misc/Threads.htm) for details.

To change the priority of an existing timer without affecting it in any other way, leave the parameter before this one blank.

## Remarks

Timers are useful because they run asynchronously, meaning that they will run at the specified frequency (interval) even when the script is waiting for a window, displaying a dialog, or busy with another task. Examples of their many uses include taking some action when the user becomes idle (as reflected by [A\_TimeIdle](../Variables.htm#TimeIdle)) or closing unwanted windows the moment they appear.

Although timers may give the illusion that the script is performing more than one task simultaneously, this is not the case. Instead, timed subroutines are treated just like other threads: they can interrupt or be interrupted by another thread, such as a [hotkey subroutine](../Hotkeys.htm). See [Threads](../misc/Threads.htm) for details.

Whenever a timer is created, re-enabled, or updated with a new _period_, its subroutine will not run right away; its time _period_ must expire first. If you wish the timer's first execution to be immediate, use [Gosub](Gosub.htm) to execute the timer's subroutine (however, this will not start a new thread like the timer itself does; so settings such as [SendMode](SendMode.htm) will not start off at their defaults).

**Reset**: If SetTimer is used on an existing timer and parameter #2 is a number or the word ON (or it is omitted), the timer is reset; in other words, the entirety of its period must elapse before its subroutine will run again.

**Timer precision**: Due to the granularity of the OS's time-keeping system, _Period_ is typically rounded up to the nearest multiple of 10 or 15.6 milliseconds (depending on the type of hardware and drivers installed). For example, a _Period_ between 1 and 10 (inclusive) is usually equivalent to 10 or 15.6 on Windows 2000/XP. A shorter delay may be achieved via Loop+Sleep as demonstrated at [DllCall+timeBeginPeriod+Sleep](Sleep.htm#ShorterSleep).

**Reliability**: A timer might not be able to run at the expected time under the following conditions:

1. Other applications are putting a heavy load on the CPU.
2. The timer subroutine itself is still running when the timer period expires, or there are too many other competing timers (altering[SetBatchLines](SetBatchLines.htm) may help).
3. The timer has been interrupted by another[thread](../misc/Threads.htm), namely another timed subroutine, [hotkey subroutine](../Hotkeys.htm), or [custom menu item](Menu.htm) (this can be avoided via [Critical](Critical.htm)). If this happens and the interrupting thread takes a long time to finish, the interrupted timer will be effectively disabled for the duration. However, any other timers will continue to run by interrupting the [thread](../misc/Threads.htm) that interrupted the first timer.
4. The script is uninterruptible as a result of[Critical](Critical.htm) or [Thread Interrupt/Priority](Thread.htm). During such times, timers will not run. Later, when the script becomes interruptible again, any overdue timer will run once as soon as possible and then resume its normal schedule.

Although timers will operate when the script is [suspended](Suspend.htm), they will not run if the [current thread](../misc/Threads.htm) has " [Thread NoTimers](Thread.htm)" in effect or whenever any thread is [paused](Pause.htm). In addition, they do not operate when the user is navigating through one of the script's menus (such as the tray icon menu or a menu bar).

Because timers operate by temporarily interrupting the script's current activity, their subroutines should be kept short (so that they finish quickly) whenever a long interruption would be undesirable.

**Other remarks**: Timers that stay in effect for the duration of a script should usually be created in the [auto-execute section](../Scripts.htm#auto). By contrast, a temporary timer might often be disabled by its own subroutine (see examples at the bottom of this page).

Whenever a timed subroutine is run, it starts off fresh with the default values for settings such as [SendMode](SendMode.htm). These defaults can be changed in the [auto-execute section](../Scripts.htm#auto).

If [hotkey](../Hotkeys.htm) response time is crucial (such as in games) and the script contains any timers whose subroutines take longer than about 5 ms to execute, use the following command to avoid any chance of a 15 ms delay. Such a delay would otherwise happen if a hotkey is pressed at the exact moment a timer thread is in its period of uninterruptibility:

```
<a href="Thread.htm" data-index="40">Thread</a>, interrupt, 0  <em>; Make all threads always-interruptible.</em>
```

If a timer is disabled while its subroutine is currently running, that subroutine will continue until it completes.

The [KeyHistory](KeyHistory.htm) feature shows how many timers exist and how many are currently enabled.

To keep a script running -- such as one that contains only timers -- use [#Persistent](_Persistent.htm).

## Related

[Gosub](Gosub.htm), [Return](Return.htm), [Threads](../misc/Threads.htm), [Thread (command)](Thread.htm), [Critical](Critical.htm), [IsLabel()](IsLabel.htm), [Menu](Menu.htm), [#Persistent](_Persistent.htm)

## Examples

Closes unwanted windows whenever they appear.

```
#Persistent
SetTimer, CloseMailWarnings, 250
return

CloseMailWarnings:
WinClose, Microsoft Outlook, A timeout occured while communicating
WinClose, Microsoft Outlook, A connection to the server could not be established
return
```

Waits for a certain window to appear and then alerts the user.

```
#Persistent
SetTimer, Alert1, 500
return

Alert1:
if not WinExist("Video Conversion", "Process Complete")
    return
<em>; Otherwise:</em>
SetTimer, Alert1, Off  <em>; i.e. the timer turns itself off here.</em>
SplashTextOn, , , The video conversion is finished.
Sleep, 3000
SplashTextOff
return
```

Detects single, double, and triple-presses of a hotkey. This allows a hotkey to perform a different operation depending on how many times you press it.

```
#c::
if (winc_presses > 0) <em>; SetTimer already started, so we log the keypress instead.</em>
{
    winc_presses += 1
    return
}
<em>; Otherwise, this is the first press of a new series. Set count to 1 and start
; the timer:</em>
winc_presses := 1
SetTimer, KeyWinC, -400 <em>; Wait for more presses within a 400 millisecond window.</em>
return

KeyWinC:
if (winc_presses = 1) <em>; The key was pressed once.</em>
{
    Run, m:\  <em>; Open a folder.</em>
}
else if (winc_presses = 2) <em>; The key was pressed twice.</em>
{
    Run, m:\multimedia  <em>; Open a different folder.</em>
}
else if (winc_presses > 2)
{
    MsgBox, Three or more clicks detected.
}
<em>; Regardless of which action above was triggered, reset the count to
; prepare for the next series of presses:</em>
winc_presses := 0
return
```

A simple counter. Uses a [function](../Functions.htm) as the timer subroutine.

```
#Persistent
SetTimer, Tick, 1000

Tick()
{
    static count := 0
    ToolTip % count++
}
```

A more complex counter. Uses a [method](../Objects.htm#Custom_Classes_method) as the timer subroutine.

```
counter := new SecondCounter
counter.Start()
Sleep 5000
counter.Stop()
Sleep 2000

<em>; An example class for counting the seconds...</em>
class SecondCounter {
    __New() {
        this.interval := 1000
        this.count := 0
        <em>; Tick() has an implicit parameter "this" which is a reference to
        ; the object, so we need to create a function which encapsulates
        ; "this" and the method to call:</em>
        this.timer := ObjBindMethod(this, "Tick")
    }
    Start() {
        <em>; Known limitation: SetTimer requires a plain variable reference.</em>
        timer := this.timer
        SetTimer % timer, % this.interval
        ToolTip % "Counter started"
    }
    Stop() {
        <em>; To turn off the timer, we must pass the same object as before:</em>
        timer := this.timer
        SetTimer % timer, Off
        ToolTip % "Counter stopped at " this.count
    }
    <em>; In this example, the timer calls this method:</em>
    Tick() {
        ToolTip % ++this.count
    }
}
```

Tips relating to the above example:

- We can also use`this.timer := this.Tick.<a href="../objects/Func.htm#Bind" data-index="58">Bind</a>(this)`. When `this.timer` is called, it will effectively invoke `this.Tick.<a href="../objects/Func.htm#Call" data-index="59">Call</a>(this)` (except that `this.Tick` is not re-evaluated). By contrast, [ObjBindMethod()](ObjBindMethod.htm) produces an object which invokes `this.Tick()`.
- If we rename_Tick_ to _Call_, we can just use `this` directly instead of `this.timer`. This also removes the need for the temporary variable. However, ObjBindMethod() is useful when the object has multiple methods which should be called by different event sources, such as hotkeys, menu items, GUI controls, etc.
- If the timer is being modified or deleted from within a function/method called by the timer, it may be easier to[omit the _Label_ parameter](#OmitLabel). In some cases this avoids the need to retain the original object which was passed to SetTimer, which eliminates one temporary variable (like `timer` in the example above).

