# \#MaxHotkeysPerInterval

Along with [#HotkeyInterval](_HotkeyInterval.htm), specifies the rate of [hotkey](../Hotkeys.htm) activations beyond which a warning dialog will be displayed.

```
<span class="func">#MaxHotkeysPerInterval</span> Value
```

## Parameters

Value

The maximum number of hotkeys that can be pressed in the interval specified by [#HotkeyInterval](_HotkeyInterval.htm) without triggering a warning dialog.

## Remarks

Care should be taken not to make the above too lenient because if you ever inadvertently introduce an infinite loop of keystrokes (via a [Send](Send.htm) command that accidentally triggers other hotkeys), your computer could become unresponsive due to the rapid flood of keyboard events.

As an oversimplified example, the hotkey `^c::Send ^c` would produce an infinite loop of keystrokes. To avoid this, add the [$ prefix](../Hotkeys.htm#prefixdollar) to the hotkey definition (e.g. `$^c::`) so that the hotkey cannot be triggered by the Send command.

If this directive is unspecified in the script, it will behave as though set to 70.

Like other directives, #MaxHotkeysPerInterval cannot be executed conditionally.

## Related

[#HotkeyInterval](_HotkeyInterval.htm)

## Examples

Allows to press a maximum of 200 instead of 70 hotkeys per interval.

```
#MaxHotkeysPerInterval 200
```

