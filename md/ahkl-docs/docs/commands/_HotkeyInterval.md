# \#HotkeyInterval

Along with [#MaxHotkeysPerInterval](_MaxHotkeysPerInterval.htm), specifies the rate of [hotkey](../Hotkeys.htm) activations beyond which a warning dialog will be displayed.

```
<span class="func">#HotkeyInterval</span> Milliseconds
```

## Parameters

Milliseconds

The length of the interval in milliseconds.

## Remarks

If this directive is unspecified in the script, it will behave as though set to 2000.

For details and remarks, see [#MaxHotkeysPerInterval](_MaxHotkeysPerInterval.htm).

Like other directives, #HotkeyInterval cannot be executed conditionally.

## Related

[#MaxHotkeysPerInterval](_MaxHotkeysPerInterval.htm)

## Examples

Allows a maximum of 200 hotkeys to be pressed within 2000 ms without triggering a warning dialog.

```
#HotkeyInterval 2000  <em>; This is the default value (milliseconds).</em>
#MaxHotkeysPerInterval 200
```

