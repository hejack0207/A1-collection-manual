# Threads

The _current thread_ is defined as the flow of execution invoked by the most recent event; examples include [hotkeys](../Hotkeys.htm), [SetTimer subroutines](../commands/SetTimer.htm), [custom menu items](../commands/Menu.htm), and [GUI events](../commands/Gui.htm#Events). The _current thread_ can be executing commands within its own subroutine or within other subroutines called by that subroutine.

Although AutoHotkey doesn't actually use multiple threads, it simulates some of that behavior: If a second thread is started -- such as by pressing another hotkey while the previous is still running -- the _current thread_ will be interrupted (temporarily halted) to allow the new thread to become _current_. If a third thread is started while the second is still running, both the second and first will be in a dormant state, and so on.

When the _current thread_ finishes, the one most recently interrupted will be resumed, and so on, until all the threads finally finish. When resumed, a thread's settings for things such as [ErrorLevel](ErrorLevel.htm) and [SendMode](../commands/SendMode.htm) are automatically restored to what they were just prior to its interruption; in other words, a thread will experience no side-effects from having been interrupted (except for a possible change in the [active window](../commands/WinActivate.htm)).

**Note**: The [KeyHistory](../commands/KeyHistory.htm) command/menu-item shows how many threads are in an interrupted state and the [ListHotkeys](../commands/ListHotkeys.htm) command/menu-item shows which hotkeys have threads.

A single script can have multiple simultaneous [MsgBox](../commands/MsgBox.htm), [InputBox](../commands/InputBox.htm), [FileSelectFile](../commands/FileSelectFile.htm), and [FileSelectFolder](../commands/FileSelectFolder.htm) dialogs. This is achieved by launching a new thread (via [hotkey](../Hotkeys.htm), [timed subroutine](../commands/SetTimer.htm), [custom menu item](../commands/Menu.htm), etc.) while a prior thread already has a dialog displayed.

By default, a given [hotkey](../Hotkeys.htm) or [hotstring](../Hotstrings.htm) subroutine cannot be run a second time if it is already running. Use [#MaxThreadsPerHotkey](../commands/_MaxThreadsPerHotkey.htm) to change this behavior.

**Related:** The [Thread](../commands/Thread.htm) command sets the priority or interruptibility of threads.

## Thread Priority

Any thread ( [hotkey](../Hotkeys.htm), [timed subroutine](../commands/SetTimer.htm), [custom menu item](../commands/Menu.htm), etc.) with a priority lower than that of the _current thread_ cannot interrupt it. During that time, such timers will not run, and any attempt by the user to create a thread (such as by pressing a [hotkey](../Hotkeys.htm) or [GUI button](../commands/GuiControls.htm#Button)) will have no effect, nor will it be buffered. Because of this, it is usually best to design high priority threads to finish quickly, or use [Critical](../commands/Critical.htm) instead of making them high priority.

The default priority is 0. All threads use the default priority unless changed by one of the following methods:

- A timed subroutine is given a specific priority via[SetTimer](../commands/SetTimer.htm).
- A hotkey is given a specific priority via the[Hotkey](../commands/Hotkey.htm) command.
- A[hotstring](../Hotstrings.htm) is given a specific priority when it is defined, or via the [#Hotstring](../commands/_Hotstring.htm) directive.
- A custom menu item is given a specific priority via the[Menu](../commands/Menu.htm) command.
- The_current thread_ sets its own priority via the [Thread](../commands/Thread.htm) command.

The [OnExit](../commands/OnExit.htm) thread (if any) will always run when called for, regardless of the _current thread_'s priority.

## Thread Interruptibility

For most types of events, new threads are permitted to launch only if the current thread is _interruptible_. A thread can be _uninterruptible_ for a number of reasons, including:

- The thread has been marked as_critical_. [Critical](../commands/Critical.htm) may have been called by the thread itself or from within the [auto-execute section](../Scripts.htm#auto).
- The thread has not been running long enough to meet the conditions for becoming interruptible, as set by[Thread Interrupt](../commands/Thread.htm#Interrupt).
- One of the script's menus is being displayed (such as the tray icon menu or a menu bar).
- A delay is being performed by[Send](../commands/Send.htm) (most often due to [SetKeyDelay](../commands/SetKeyDelay.htm)), [WinActivate](../commands/WinActivate.htm), or a [Clipboard](Clipboard.htm) operation.
- An[OnExit](../commands/OnExit.htm) thread is executing.
- A warning dialog is being displayed due to the[#MaxHotkeysPerInterval](../commands/_MaxHotkeysPerInterval.htm) limit being reached, or due to a problem activating the keyboard or mouse hook (very rare).

### Behavior of Uninterruptible Threads

Unlike high-priority threads, events that occur while the thread is uninterruptible are not discarded. For example, if the user presses a [hotkey](../Hotkeys.htm) while the current thread is uninterruptible, the hotkey is buffered indefinitely until the current thread finishes or becomes interruptible, at which time the hotkey is launched as a new thread.

Any thread may be interrupted in emergencies. Emergencies consist of: 1) an [OnExit](../commands/OnExit.htm#function) callback; 2) any [OnMessage](../commands/OnMessage.htm) function that monitors a message number less than 0x0312 (or a [callback](../commands/RegisterCallback.htm) triggered by such a message); and 3) any [callback](../commands/RegisterCallback.htm) indirectly triggered by the thread itself (e.g. via [SendMessage](../commands/PostMessage.htm) or [DllCall](../commands/DllCall.htm)). To avoid these interruptions, temporarily disable such functions.

A [critical](../commands/Critical.htm) thread becomes interruptible when a [MsgBox](../commands/MsgBox.htm) or other dialog is displayed. However, unlike [Thread Interrupt](../commands/Thread.htm), the thread becomes critical (and therefore uninterruptible) again after the user dismisses the dialog.

