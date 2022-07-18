# SetCapsLockState / SetNumLockState / SetScrollLockState

Sets the state of CapsLock/NumLock/ScrollLock. Can also force the key to stay on or off.

```
<span class="func">SetCapsLockState</span> <span class="optional">, State</span>
<span class="func">SetNumLockState</span> <span class="optional">, State</span>
<span class="func">SetScrollLockState</span> <span class="optional">, State</span>

```

## Parameters

State

If this parameter is omitted, the AlwaysOn/Off attribute of the key is removed (if present). Otherwise, specify one of the following words:

**On**: Turns on the key and removes the AlwaysOn/Off attribute of the key (if present).

**Off**: Turns off the key and removes the AlwaysOn/Off attribute of the key (if present).

**AlwaysOn**: Forces the key to stay on permanently.

**AlwaysOff**: Forces the key to stay off permanently.

[v1.1.30+]: The decimal values 1 and 0 may be used in place of On and Off, respectively.

## Remarks

Alternatively to [example #3](#ExToggle) below, a key can also be toggled to its opposite state via the [Send](Send.htm) command; for example: `Send {CapsLock}`. However, sending {CapsLock} might require `<a href="SetStoreCapslockMode.htm" data-index="3">SetStoreCapsLockMode</a> Off` beforehand.

Keeping a key _AlwaysOn_ or _AlwaysOff_ requires the [keyboard hook](_InstallKeybdHook.htm), which will be automatically installed in such cases.

## Related

[SetStoreCapsLockMode](SetStoreCapslockMode.htm), [GetKeyState()](GetKeyState.htm#function)

## Examples

Turns on NumLock and removes the AlwaysOn/Off attribute of the key (if present).

```
SetNumLockState, On
```

Forces ScrollLock to stay off permanently.

```
SetScrollLockState, AlwaysOff
```

Toggles CapsLock to its opposite state.

```
SetCapsLockState % !GetKeyState("CapsLock", "T") <em>; requires <span class="ver">[v1.1.30+]</span></em>
```

