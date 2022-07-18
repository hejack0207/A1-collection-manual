# IsLabel()

Returns a non-zero number if the specified label exists in the script.

```
TrueOrFalse := <span class="func">IsLabel</span>(LabelName)
```

## Parameters

LabelName

The name of a [subroutine](Gosub.htm), [hotkey](../Hotkeys.htm), or [hotstring](../Hotstrings.htm) (do not include the trailing colon(s) in _LabelName_).

## Return Value

This function returns a non-zero number if _LabelName_ exists in the script.

## Remarks

This function is useful to avoid runtime errors when specifying a dynamic label in commands such as [Gosub](Gosub.htm), [Hotkey](Hotkey.htm), [Menu](Menu.htm), and [Gui](Gui.htm).

## Related

[Labels](../misc/Labels.htm)

## Examples

Reports "Subroutine exists" because the subroutine does exist.

```
if IsLabel("Label")
    MsgBox, Subroutine exists
else
    MsgBox, Subroutine doesn't exist

Label:
return
```

Reports "Hotkey exists" because the hotkey does exist.

```
if IsLabel("^#h")
    MsgBox, Hotkey exists
else
    MsgBox, Hotkey doesn't exist

^#h::return
```

Reports "Hotstring exists" because the hotstring does exist.

```
if IsLabel("::btw")
    MsgBox, Hotstring exists
else
    MsgBox, Hotstring doesn't exist

::btw::by the way
```

