# OnClipboardChange

## OnClipboardChange() [v1.1.20+]

Registers a [function](../Functions.htm) or [function object](../objects/Functor.htm) to run whenever the clipboard's content changes.

```
<span class="func">OnClipboardChange</span>(Func <span class="optional">, AddRemove</span>)
```

### Parameters

Func

A function name or [function object](../objects/Functor.htm) to call. The function's parameter and return value are described [below](#Func).

AddRemove

If blank or omitted, it defaults to 1 (call the function after any previously registered functions). Otherwise, specify one of the following numbers:

- 1 = Call the function after any previously registered functions.
- -1 = Call the function before any previously registered functions.
- 0 = Do not call the function.

If an OnClipboardChange label exists, it is always called first.

### Func

```
<i>FunctionName</i>(Type)
```

Type

Contains one of the following numbers:

- 0 = Clipboard is now empty.
- 1 = Clipboard contains something that can be expressed as text (this includes[files copied](../misc/Clipboard.htm#CopiedFiles) from an Explorer window).
- 2 = Clipboard contains something entirely non-text such as a picture.

_Return Value_

If this is the last or only OnClipboardChange function, the return value is ignored. Otherwise, the function can return a non-zero integer to prevent subsequent functions from being called.

## OnClipboardChange Label

**Deprecated:** This approach is not recommended for use in new scripts. Use the [OnClipboardChange](#function) function instead.

A label named OnClipboardChange (if it exists) is launched automatically whenever any application (even the script itself) has changed the contents of the clipboard. The label also runs once when the script first starts.

The built-in variable A\_EventInfo contains one of the following numbers:

- 0 = Clipboard is now empty.
- 1 = Clipboard contains something that can be expressed as text (this includes[files copied](../misc/Clipboard.htm#CopiedFiles) from an Explorer window).
- 2 = Clipboard contains something entirely non-text such as a picture.

## Remarks

If the clipboard changes while an OnClipboardChange function or label is already running, that notification event is lost. If this is undesirable, specify [Critical](Critical.htm) as the label's first line. However, this will also buffer/defer other [threads](../misc/Threads.htm) (such as the press of a hotkey) that occur while the OnClipboardChange thread is running.

If the script itself changes the clipboard, its OnClipboardChange function or label is typically not executed immediately; that is, commands immediately below the command that changed the clipboard are likely to execute beforehand. To force the function or label to execute immediately, use a short delay such as `<a href="Sleep.htm" data-index="10">Sleep</a> 20` after changing the clipboard.

## Related

[Clipboard](../misc/Clipboard.htm), [OnExit()](OnExit.htm#function), [OnExit](OnExit.htm#command), [OnMessage()](OnMessage.htm), [RegisterCallback()](RegisterCallback.htm)

## Examples

Function vs. Label.

Despite the different approach, both examples have the same effect; that is, they briefly display a tooltip for each clipboard change. Note that the function is not called when the script first starts; only when the contents of the clipboard changes.

```
#Persistent
OnClipboardChange("ClipChanged")
return

ClipChanged(Type) {
    ToolTip Clipboard data type: %Type%
    Sleep 1000
    ToolTip  <em>; Turn off the tip.</em>
}
```

```
#Persistent
return

OnClipboardChange:
ToolTip Clipboard data type: %A_EventInfo%
Sleep 1000
ToolTip  <em>; Turn off the tip.</em>
return
```

