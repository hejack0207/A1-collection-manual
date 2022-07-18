# Automating Winamp

This section demonstrates how to control Winamp via hotkey even when it is minimized or inactive. This information has been tested with Winamp 2.78c but should work for other major releases as well. Please post changes and improvements in the forum or contact the author.

This example makes the Ctrl+Alt+P hotkey equivalent to pressing Winamp's pause/unpause button:

```
^!p::
if not WinExist("ahk_class Winamp v1.x")
    return
<em>; Otherwise, the above has set the "last found" window for use below.</em>
<a href="../commands/ControlSend.htm" data-index="1">ControlSend</a>, ahk_parent, c  <em>; Pause/Unpause</em>
return
```

Here are some of the keyboard shortcuts available in Winamp 2.x (may work in other versions too). The above example can be revised to use any of these keys:

Key to sendEffect`c`Pause/UnPause`x`Play/Restart/UnPause`v`Stop`+v`Stop with Fadeout`^v`Stop after the current track`b`Next Track`z`Previous Track`{left}`Rewind 5 seconds`{right}`Fast-forward 5 seconds`{up}`Turn Volume Up`{down}`Turn Volume Down

The following example asks Winamp which track number is currently active:

```
<a href="../commands/PostMessage.htm" data-index="2">SendMessage</a>, 0x0400, 0, 120,, ahk_class Winamp v1.x
if (ErrorLevel != "FAIL")
{
    ErrorLevel += 1  <em>; Winamp's count starts at 0, so adjust by 1.</em>
    MsgBox, Track #%ErrorLevel% is active or playing.
}
```

