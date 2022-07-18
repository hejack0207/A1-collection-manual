# Remapping Keys (Keyboard, Mouse and Joystick)

## Table of Contents

- [Introduction](#intro)
- [Remapping the Keyboard and Mouse](#Remap)
- [Remarks](#remarks)
- [Moving the Mouse Cursor via the Keyboard](#moving-the-mouse-cursor)
- [Remapping via the Registry's "Scancode Map"](#registry)
- [Related Topics](#related)

## Introduction

**Limitation**: AutoHotkey's remapping feature described below is generally not as pure and effective as remapping directly via the Windows registry. For the advantages and disadvantages of each approach, see [registry remapping](#registry).

## Remapping the Keyboard and Mouse

The syntax for the built-in remapping feature is `OriginKey::DestinationKey`. For example, a [script](../Scripts.htm) consisting only of the following line would make A behave like B:

```
a::b
```

The above example does not alter B itself. B would continue to send the "b" keystroke unless you remap it to something else as shown in the following example:

```
a::b
b::a
```

The examples above use lowercase, which is recommended for most purposes because it also remaps the corresponding uppercase letters (that is, it will send uppercase when CapsLock is "on" or Shift is held down). By contrast, specifying an uppercase letter on the right side forces uppercase. For example, the following line would produce an uppercase B when you type either "a" or "A" (as long as CapsLock is off):

```
a::B
```

However, a remapping opposite to the one above would not work as one might expect, as a remapping never "releases" the modifier keys which are used to trigger it. For example, `A::b` is typically equivalent to `A::B` and `^a::b` is equivalent to `^a::^b`. This is because each remapping [internally uses {Blind}](#actually) to allow the key or key combination to be combined with other modifiers.

### Mouse Remapping

To remap the mouse instead of the keyboard, use the same approach. For example:

ExampleDescription`MButton::Shift`Makes the middle button behave like Shift.`XButton1::LButton`Makes the fourth mouse button behave like the left mouse button.`RAlt::RButton`Makes the right Alt behave like the right mouse button.

### Other Useful Remappings

ExampleDescription`CapsLock::Ctrl`Makes CapsLock become Ctrl. To retain the ability to turn CapsLock on and off, add the remapping `+CapsLock::CapsLock` first. This toggles CapsLock on and off when you hold down Shift and press CapsLock. Because both remappings allow additional modifier keys to be held down, the more specific `+CapsLock::CapsLock` remapping must be placed first for it to work.`XButton2::^LButton`Makes the fifth mouse button (XButton2) produce a control-click.`RAlt::AppsKey`Makes the right Alt become Menu (which is the key that opens the context menu).`RCtrl::RWin`Makes the right Ctrl become the right Win.`Ctrl::Alt`Makes both Ctrl behave like Alt. However, see [alt-tab issues](#AltTab).`^x::^c`Makes Ctrl+X produce Ctrl+C. It also makes Ctrl+Alt+X produce Ctrl+Alt+C, etc.`RWin::Return`Disables the right Win by having it simply [return](../commands/Return.htm).

You can try out any of these examples by copying them into a new text file such as "Remap.ahk", then launching the file.

See the [Key List](../KeyList.htm) for a complete list of key and mouse button names.

## Remarks

The directives [#IfWinActive/Exist](../commands/_IfWinActive.htm) can be used to make selected remappings active only in the windows you specify. For example:

```
#IfWinActive ahk_class Notepad
a::b  <em>; Makes the 'a' key send a 'b' key, but only in Notepad.</em>
#IfWinActive  <em>; This puts subsequent remappings and hotkeys in effect for all windows.</em>
```

Remapping a key or button is "complete" in the following respects:

- Holding down a modifier such asCtrl or Shift while typing the origin key will put that modifier into effect for the destination key. For example, `b::a` would produce Ctrl+A if you press Ctrl+B.
- CapsLock generally affects remapped keys in the same way as normal keys.
- The destination key or button is held down for as long as you continue to hold down the origin key. However, some games do not support remapping; in such cases, the keyboard and mouse will behave as though not remapped.
- Remapped keys will auto-repeat while being held down (except keys remapped to become mouse buttons).

Although a remapped key can trigger normal hotkeys, by default it cannot trigger mouse hotkeys or [hook hotkeys](../commands/_UseHook.htm) (use [ListHotkeys](../commands/ListHotkeys.htm) to discover which hotkeys are "hook"). For example, if the remapping `a::b` is in effect, pressing Ctrl+Alt+A would trigger the `^!b` hotkey only if `^!b` is not a hook hotkey. If `^!b` is a hook hotkey, you can define `^!a` as a hotkey if you want Ctrl+Alt+A to perform the same action as Ctrl+Alt+B. For example:

```
a::b
^!a::
^!b::
ToolTip You pressed %A_ThisHotkey%.
return
```

Alternatively, in [v1.1.06] and later, [#InputLevel](../commands/_InputLevel.htm) can be used to override the default behaviour. For example:

```
#InputLevel 1
a::b

#InputLevel 0
^!b::
ToolTip You pressed %A_ThisHotkey%.
return
```

If [SendMode](../commands/SendMode.htm) is used in the auto-execute section (top part of the script), it affects all remappings. However, since remapping uses [Send {Blind}](../commands/Send.htm#blind) and since the [SendPlay mode](../commands/SendMode.htm) does not fully support {Blind}, some remappings might not function properly in SendPlay mode (especially Ctrl, Shift, Alt, and Win). To work around this, avoid SendPlay in auto-execute section when you have remappings; then use the command [SendPlay](../commands/Send.htm#SendPlay) vs. Send in other places throughout the script. Alternatively, you could translate your remappings into hotkeys (as described below) that explicitly call SendEvent vs. Send.

When a script is launched, each remapping is translated into a pair of [hotkeys](../Hotkeys.htm). For example, a script containing `a::b` actually contains the following two hotkeys instead:

```
*<strong>a</strong>::
SetKeyDelay -1   <em>; If the destination key is a mouse button, SetMouseDelay is used instead.</em>
Send <a href="../commands/Send.htm#blind" data-index="22">{Blind}</a>{<strong>b</strong> DownR}  <em>; <a href="../commands/Send.htm#DownR" data-index="23">DownR</a> is like Down except that other Send commands in the script won't assume "b" should stay down during their Send.</em>
return

*<strong>a up</strong>::
SetKeyDelay -1  <em>; See note below for why press-duration is not specified with either of these SetKeyDelays.</em>
Send {Blind}{<strong>b</strong> up}
return
```

However, the above hotkeys vary under the following circumstances:

1. When the source key is the leftCtrl and the destination key is Alt, the line `Send {Blind}{LAlt DownR}` is replaced by `Send {Blind}<strong>{LCtrl up}</strong>{LAlt DownR}`. The same is true if the source is the right Ctrl, except that `{RCtrl up}` is used.
2. When a keyboard key is being remapped to become a mouse button (e.g.`RCtrl::RButton`), the hotkeys above use SetMouseDelay in place of SetKeyDelay. In addition, the first hotkey above is replaced by the following, which prevents the keyboard's auto-repeat feature from generating repeated mouse clicks:


   ```
   *RCtrl::
   SetMouseDelay -1
   if not GetKeyState("RButton")  <em>; i.e. the right mouse button isn't down yet.</em>
       Send {Blind}{RButton DownR}
   return
   ```

3. When the source is a[custom combination](../Hotkeys.htm#combo) in [v1.1.27.01+], the wildcard modifier (\*) is omitted to allow the hotkeys to work.

Prior to [v1.1.27], [DownTemp](../commands/Send.htm#DownTemp) was used instead of [DownR](../commands/Send.htm#DownR).

Note that SetKeyDelay's second parameter ( [press duration](../commands/SetKeyDelay.htm#dur)) is omitted in the hotkeys above. This is because press-duration does not apply to down-only or up-only events such as `{b down}` and `{b up}`. However, it does apply to changes in the state of the modifier keys (Shift, Ctrl, Alt, and Win), which affects remappings such as `a::B` or `a::^b`. Consequently, any press-duration a script puts into effect via its [auto-execute section](../Scripts.htm#auto) will apply to all such remappings.

Since remappings are translated into hotkeys as described above, the [Suspend](../commands/Suspend.htm) command affects them. Similarly, the [Hotkey](../commands/Hotkey.htm) command can disable or modify a remapping. For example, the following two commands would disable the remapping `a::b`.

```
Hotkey, *a, Off
Hotkey, *a up, Off
```

Alt-tab issues: If you remap a key or mouse button to become Alt, that key will probably not be able to alt-tab properly. A possible work-around is to add the hotkey `*Tab::Send {Blind}{Tab}` \-\- but be aware that it will likely interfere with using the real Alt to alt-tab. Therefore, it should be used only when you alt-tab solely by means of remapped keys and/or [alt-tab hotkeys](../Hotkeys.htm#alttab).

In addition to the keys and mouse buttons on the [Key List](../KeyList.htm) page, the source key may also be a virtual key (VKnn) or scan code (SCnnn) as described on the [special keys](../KeyList.htm#SpecialKeys) page. The same is true for the destination key except that it may optionally specify a scan code after the virtual key. For example, `sc01e::vk42sc030` is equivalent to `a::b` on most keyboard layouts.

To disable a key rather than remapping it, make it a hotkey that simply [returns](../commands/Return.htm). For example, `F1::return` would disable F1.

The following keys are not supported by the built-in remapping method:

- The mouse wheel (WheelUp/Down/Left/Right).
- Pause and Break as destination key names (since they match the names of commands).[v1.1.32+]: `vk13` or the corresponding scan code can be used instead.
- Curly braces {} as destination keys. Instead use the[VK/SC method](../commands/Send.htm#vk); e.g. `x::+sc01A` and `y::+sc01B`.
- A percent sign (%) as a destination key. Instead use the[VK/SC method](../commands/Send.htm#vk).
- "Return" as a destination key. Instead use "Enter".

## Moving the Mouse Cursor via the Keyboard

The keyboard can be used to move the mouse cursor as demonstrated by the fully-featured [Keyboard-To-Mouse script](../scripts/index.htm#NumpadMouse). Since that script offers smooth cursor movement, acceleration, and other features, it is the recommended approach if you plan to do a lot of mousing with the keyboard. By contrast, the following example is a simpler demonstration:

```
*#up::MouseMove, 0, -10, 0, R  <em>; Win+UpArrow hotkey => Move cursor upward</em>
*#Down::MouseMove, 0, 10, 0, R  <em>; Win+DownArrow => Move cursor downward</em>
*#Left::MouseMove, -10, 0, 0, R  <em>; Win+LeftArrow => Move cursor to the left</em>
*#Right::MouseMove, 10, 0, 0, R  <em>; Win+RightArrow => Move cursor to the right</em>

*<#RCtrl::  <em>; LeftWin + RightControl => Left-click (hold down Control/Shift to Control-Click or Shift-Click).</em>
SendEvent {Blind}{LButton down}
KeyWait RCtrl  <em>; Prevents keyboard auto-repeat from repeating the mouse click.</em>
SendEvent {Blind}{LButton up}
return

*<#AppsKey::  <em>; LeftWin + AppsKey => Right-click</em>
SendEvent {Blind}{RButton down}
KeyWait AppsKey  <em>; Prevents keyboard auto-repeat from repeating the mouse click.</em>
SendEvent {Blind}{RButton up}
return
```

## Remapping via the Registry's "Scancode Map"

**Advantages:**

- Registry remapping is generally more pure and effective than[AutoHotkey's remapping](#Remap). For example, it works in a broader variety of games, it has no known [alt-tab issues](#AltTab), and it is capable of firing AutoHotkey's hook hotkeys (whereas AutoHotkey's remapping requires a [workaround](#HookHotkeys)).
- If you choose to make the registry entries manually (explained below), absolutely no external software is needed to remap your keyboard. Even if you use[KeyTweak](https://www.bleepingcomputer.com/download/keytweak/) to make the registry entries for you, KeyTweak does not need to stay running all the time (unlike AutoHotkey).

**Disadvantages:**

- Registry remapping is relatively permanent: a reboot is required to undo the changes or put new ones into effect.
- Its effect is global: it cannot create remappings specific to a particular user, application, or locale.
- It cannot send keystrokes that are modified byShift, Ctrl, Alt, or AltGr. For example, it cannot remap a lowercase character to an uppercase one.
- It supports only the keyboard (AutoHotkey has[mouse remapping](#RemapMouse) and some [limited joystick remapping](RemapJoystick.htm)).

**How to Apply Changes to the Registry:** There are at least two methods to remap keys via the registry:

1. Use a program like[KeyTweak](https://www.bleepingcomputer.com/download/keytweak/) (freeware) to visually remap your keys. It will change the registry for you.
2. Remap keys manually by creating a .reg file (plain text) and loading it into the registry. This is demonstrated in the[archived forums](https://www.autohotkey.com/board/index.php?showtopic=8359#entry52760).

## Related Topics

- [List of keys and mouse buttons](../KeyList.htm#Joystick)
- [GetKeyState()](../commands/GetKeyState.htm#function)
- [Remapping a joystick](RemapJoystick.htm)

