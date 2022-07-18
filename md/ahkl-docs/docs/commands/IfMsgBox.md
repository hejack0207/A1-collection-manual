# IfMsgBox

Checks which button was pushed by the user during the most recent [MsgBox](MsgBox.htm) command.

```
<span class="func">IfMsgBox</span>, ButtonName
```

## Parameters

ButtonName

One of the following strings to represent which button the user pressed in the most recent [MsgBox](MsgBox.htm) command:

- Yes
- No
- OK
- Cancel
- Abort
- Ignore
- Retry
- Continue[v1.0.44.08+]
- TryAgain[v1.0.44.08+]
- Timeout (that is, the word "timeout" is present if the message box[timed out](MsgBox.htm#Timeout))

## Related

[MsgBox](MsgBox.htm)

## Examples

Shows a yes-no message box which automatically stops execution after 5 seconds. The user can press the "No" button to initiate the stop immediately.

```
MsgBox, 4, , Would you like to continue?, 5  <em>; 5-second timeout.</em>
IfMsgBox, No
    Return  <em>; User pressed the "No" button.</em>
IfMsgBox, Timeout
    Return <em>; i.e. Assume "No" if it timed out.
; Otherwise, continue:</em>
<em>; ...</em>
```

