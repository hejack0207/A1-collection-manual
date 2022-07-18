# Creating a Keyboard Macro or Mouse Macro

A macro is a series of scripted actions that is "played" upon demand. The most common activity of a macro is to send [simulated keystrokes](../commands/Send.htm) and [mouse clicks](../commands/Click.htm) to one or more windows. Such windows respond to each keystroke and mouse click as though you had performed it manually, which allows repetitive tasks to be automated with high speed and reliability.

One of the most convenient ways to play back a macro is to assign it to a [hotkey](../Hotkeys.htm) or [hotstring](../Hotstrings.htm). For example, the following hotkey would create an empty e-mail message and prepare it for a certain type recipient, allowing you to personalize it prior to sending:

```
^!s::  <em>; Control+Alt+S hotkey.</em>
if not WinExist("Inbox - Microsoft Outlook")
    return  <em>; Outlook isn't open to the right section, so do nothing.</em>
WinActivate  <em>; Activate the window found by the above command.</em>
Send ^n  <em>; Create new/blank e-mail via Control+N.</em>
WinWaitActive Untitled Message
Send {Tab 2}Product Recall for ACME Rocket Skates  <em>; Set the subject line.</em>
Send {Tab}Dear Sir or Madam,{Enter 2}We have recently discovered a minor defect ...  <em>; etc.</em>
return  <em>; This line serves to finish the hotkey.</em>
```

Hotkey macros like the above are especially useful for tasks you perform several times per day. By contrast, macros used less often can each be kept in a separate script accessible by means of a shortcut in the Start Menu or on the desktop.

To start creating your own macros and hotkeys right away, please read the [Quick-start Tutorial](../Tutorial.htm).

[\-\- Home --](../AutoHotkey.htm)

