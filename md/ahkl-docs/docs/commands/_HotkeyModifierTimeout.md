# \#HotkeyModifierTimeout

Affects the behavior of [hotkey](../Hotkeys.htm) modifiers: Ctrl, Alt, Win, and Shift.

```
<span class="func">#HotkeyModifierTimeout</span> Milliseconds
```

## Parameters

Milliseconds

The length of the interval in milliseconds. The value can be -1 so that it never times out (modifier keys are always pushed back down after the Send), or 0 so that it always times out (modifier keys are never pushed back down).

## Remarks

This directive **need not** be used when:

- Hotkeys send their keystrokes via the[SendInput](Send.htm#SendInput) or [SendPlay](Send.htm#SendPlay) methods. This is because those methods postpone the user's physical pressing and releasing of keys until after the Send completes.
- The script has the keyboard hook installed (you can see if your script uses the hook via the "View->Key history" menu item in the main window, or via the[KeyHistory](KeyHistory.htm) command). This is because the hook can keep track of which modifier keys (Alt/Ctrl/Win/Shift) the user is physically holding down and doesn't need to use the timeout.

To illustrate the effect of this directive, consider this example: `^!a::Send, abc`.

When the [Send](Send.htm) command executes, the first thing it does is release Ctrl and Alt so that the characters get sent properly. After sending all the keys, the command doesn't know whether it can safely push back down Ctrl and Alt (to match whether the user is still holding them down). But if less than the specified number of milliseconds have elapsed, it will assume that the user hasn't had a chance to release the keys yet and it will thus push them back down to match their physical state. Otherwise, the modifier keys will not be pushed back down and the user will have to release and press them again to get them to modify the same or another key.

The timeout should be set to a value less than the amount of time that the user typically holds down a hotkey's modifiers before releasing them. Otherwise, the modifiers may be restored to the down position (get stuck down) even when the user isn't physically holding them down.

You can reduce or eliminate the need for this directive with one of the following:

- Install the keyboard hook by adding the line[#InstallKeybdHook](_InstallKeybdHook.htm) anywhere in the script.
- Use the[SendInput](Send.htm#SendInput) or [SendPlay](Send.htm#SendPlay) methods rather than the traditional [SendEvent](Send.htm#SendEvent) method.
- When using the traditional[SendEvent](Send.htm#SendEvent) method, reduce [SetKeyDelay](SetKeyDelay.htm) to 0 or -1, which should help because it sends the keystrokes more quickly.

If this is directive is unspecified in a script, it behaves as though set to 50.

Like other directives, #HotkeyModifierTimeout cannot be executed conditionally.

## Related

[GetKeyState()](GetKeyState.htm#function)

## Examples

Sets the hotkey modifier timeout to 100 ms instead of 50 ms.

```
#HotkeyModifierTimeout 100
```

