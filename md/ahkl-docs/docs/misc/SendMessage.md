# PostMessage / SendMessage Tutorial by Rajat

This page explains how to send messages to a window or its controls via [PostMessage](../commands/PostMessage.htm) or [SendMessage](../commands/PostMessage.htm) and will answer some questions like:

- "How do I press a button on a minimized window?"
- "How do I select a menu item when[WinMenuSelectItem](../commands/WinMenuSelectItem.htm) doesn't work with it?!"
- "This is a skinnable window.... how do I send a command that works every time?"
- "and what about**hidden** windows?!"

Requirements: [AutoHotkey v1.0.09+] and Winspector Spy ( [can be found here](https://www.softpedia.com/get/Security/Security-Related/Winspector.shtml))

As a first example, note that [WinMenuSelectItem](../commands/WinMenuSelectItem.htm) fails to work with the menu bar on Outlook Express's "New Message" window. In other words, this code will not work:

```
WinMenuSelectItem, New Message,, &Insert, &Picture...
```

But [PostMessage](../commands/PostMessage.htm) can get the job done:

```
PostMessage, 0x0111, 40239, 0, , New Message
```

Works like a charm! But what the heck is that? 0x0111 is the hex code of [wm\_command message](SendMessageList.htm) and 40239 is the code that this particular window understands as menu-item 'Insert Picture' selection. Now let me tell you how to find a value such as 40239:

01. Open Winspector Spy and a "New Message" window.
02. Drag the crosshair from Winspector Spy's window to "New Message" window's titlebar (the portion not covered by Winspector Spy's overlay).
03. Right click the selected window in the list on left and select 'Messages'.
04. Right click the blank window and select 'Edit message filter'.
05. Press the 'filter all' button and then dbl click 'wm\_command' on the list on left. This way you will only monitor this message.
06. Now go to the "New Message" window and select from its menu bar: Insert > Picture.
07. Come back to Winspector Spy and press the traffic light button to pause monitoring.
08. Expand the wm\_command messages that've accumulated (forget others if any).
09. What you want to look for (usually) is a code 0 message. sometimes there are wm\_command messages saying 'win activated' or 'win destroyed' and other stuff.. not needed. You'll find that there's a message saying 'Control ID: 40239' ...that's it!
10. Now put that in the above command and you've got it! It's the wParam value.

For the next example I'm taking Paint because possibly everyone will have that. Now let's say it's an app where you have to select a tool from a toolbar using AutoHotkey; say the dropper tool is to be selected.

What will you do? Most probably a mouse click at the toolbar button, right? But toolbars can be moved and hidden! This one can be moved/hidden too. So if the target user has done any of this then your script will fail at that point. But the following command will still work:

```
PostMessage, 0x0111, 639,,, Untitled - Paint
```

Another advantage to [PostMessage](../commands/PostMessage.htm) is that the Window can be in the background; by contrast, sending mouse clicks would require it to be active.

Here are some more examples. Note: I'm using WinXP Pro (SP1) ... if you use a different OS then your params may change (only applicable to apps like Wordpad and Notepad that come with windows; for others the params shouldn't vary):

```
<em>;makes writing color teal in Wordpad</em>
<a href="../commands/PostMessage.htm" data-index="9">PostMessage</a>, 0x0111, 32788, 0, , Document - WordPad
```

```
<em>;opens about box in Notepad</em>
<a href="../commands/PostMessage.htm" data-index="10">PostMessage</a>, 0x0111, 65, 0, , Untitled - Notepad
```

```
<em>;toggles word-wrap in Notepad</em>
<a href="../commands/PostMessage.htm" data-index="11">PostMessage</a>, 0x0111, 32, 0, , Untitled - Notepad
```

```
<em>;play/pause in Windows Media Player</em>
<a href="../commands/PostMessage.htm" data-index="12">PostMessage</a>, 0x0111, 32808, 0, , Windows Media Player
```

```
<em>;suspend the hotkeys of a running AHK script</em>
DetectHiddenWindows, On
SetTitleMatchMode, 2
<em>; Use 65306 to Pause and 65303 to Reload instead of Suspend. (see <a href="../FAQ.htm#close" data-index="13">FAQ</a>)</em>
<a href="../commands/PostMessage.htm" data-index="14">PostMessage</a>, 0x0111, 65305,,, MyScript.ahk - AutoHotkey

```

```
<em>; Press CapsLock and Numpad2 to reload all AutoHotkey scripts</em>
CapsLock & Numpad2::
ReloadAllAhkScripts() {
    DetectHiddenWindows, On
    SetTitleMatchMode, 2
    WinGet, allAhkExe, List, ahk_class AutoHotkey
    Loop, % allAhkExe {
        hwnd := allAhkExe%A_Index%
        if (hwnd = A_ScriptHwnd)  <em>; ignore the current window for reloading</em>
        {
            continue
        }
        PostMessage, 0x0111, 65303,,, % "ahk_id" . hwnd
    }
    Reload
}

```

This above was for PostMessage. [SendMessage](../commands/PostMessage.htm) works the same way but additionally waits for a return value, which can be used for things such as getting the currently playing track in Winamp (see [Automating Winamp](Winamp.htm) for an example).

Here are some more notes:

- The note above regarding OS being XP and msg values changing with different OSes is purely cautionary. if you've found a msg that works on your system (with a certain version of a software) then you can be sure it'll work on another system too with the same version of the software. In addition, most apps keep these msg values the same even on different versions of themselves (e.g. Windows Media Player and Winamp).
- If you've set the filter to show only wm\_command in Winspector Spy and still you're getting a flood of messages then right click that message and select hide (msg name)... you don't want to have a look at a msg that appears without you interacting with the target software.
- The right pointing arrow in Winspector Spy shows the msg values and the blurred left pointing arrows show the returned value. A 0 (zero) value can by default safely be taken as 'no error' (use it with SendMessage, the return value will be in[%ErrorLevel%](ErrorLevel.htm)).
- For posting to partial title match add this to script:`SetTitleMatchMode, 2`
- For posting to hidden windows add this to script:`DetectHiddenWindows, On`

Note: There are apps with which this technique doesn't work. I've had mixed luck with VB and Delphi apps. This technique is best used with C, C++ apps. With VB apps the 'LParam' of the same command keeps changing from one run to another. With Delphi apps... the GUI of some apps doesn't even use wm\_command. It probably uses mouse pos & clicks.

Go and explore.... and share your experiences in the AutoHotkey Forum. Feedback is welcome!

This tutorial is not meant for total newbies (no offense meant) since these commands are considered advanced features. So if after reading the above you've not made heads or tails of it, please forget it.

-Rajat

