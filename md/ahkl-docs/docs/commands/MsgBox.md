# MsgBox

Displays the specified text in a small window containing one or more buttons (such as Yes and No).

```
<span class="func">MsgBox</span>, Text
<span class="func">MsgBox</span> <span class="optional">, Options, Title, Text, Timeout</span>

```

## Parameters

Text

If all the parameters are omitted, the message box will display the text "Press OK to continue.". Otherwise, this parameter is the text displayed inside the message box to instruct the user what to do, or to present information.

[Escape sequences](../misc/EscapeChar.htm) can be used to denote special characters. For example, \`n indicates a linefeed character, which ends the current line and begins a new one. Thus, using text1\`n\`ntext2 would create a blank line between text1 and text2.

If _Text_ is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

Options

Indicates the type of message box and the possible button combinations. If blank or omitted, it defaults to 0. See the tables below for allowed values.

This parameter must be either a literal number or [in v1.1.06+] a forced expression such as `% Options`. Any other non-blank value will not be recognized as this parameter, but instead as part of _Text_ in the single-parameter mode.

Title

The title of the message box window. If omitted or blank, it defaults to the name of the script (without path).

Timeout

(optional) Timeout in seconds, which can contain a decimal point but is not an expression by default. [v1.1.06+]: This can be a forced expression such as `% mins*60`.

If this value exceeds 2147483 (24.8 days), it will be set to 2147483. After the timeout has elapsed the message box will be automatically closed and the [IfMsgBox](IfMsgBox.htm) command will see the value TIMEOUT.

The following limitation was fixed in [v1.1.30.01]: If the message box contains only an OK button, [IfMsgBox](IfMsgBox.htm) will think that the OK button was pressed if the message box times out while its own [thread](../misc/Threads.htm) is inactive due to being interrupted by another.

## Values for the _Options_ parameter

The _Options_ parameter can be a combination (sum) of values from the following groups.

### Group \#1: Buttons

To indicate the buttons displayed in the message box, add **one** of the following values:

FunctionDecimal ValueHex ValueOK (that is, only an OK button is displayed)00x0OK/Cancel10x1Abort/Retry/Ignore20x2Yes/No/Cancel30x3Yes/No40x4Retry/Cancel50x5Cancel/Try Again/Continue60x6

### Group \#2: Icon

To display an icon in the message box, add **one** of the following values:

FunctionDecimal ValueHex ValueIcon Hand (stop/error)160x10Icon Question320x20Icon Exclamation480x30Icon Asterisk (info)640x40

### Group \#3: Default Button

To indicate the default button, add **one** of the following values:

FunctionDecimal ValueHex ValueMakes the 2nd button the default2560x100Makes the 3rd button the default5120x200Makes the 4th button the default

(requires the Help button to be present)7680x300

### Group \#4: Modality

To indicate the modality of the dialog box, add **one** of the following values:

FunctionDecimal ValueHex ValueSystem Modal (always on top)40960x1000Task Modal81920x2000Always-on-top (style WS\_EX\_TOPMOST)

 (like System Modal but omits title bar icon)2621440x40000

### Group \#5: Other Options

To specify other options, add **one or more** of the following values:

FunctionDecimal ValueHex ValueAdds a Help button (see remarks below)163840x4000Make the text right-justified5242880x80000Right-to-left reading order for Hebrew/Arabic10485760x100000

## Remarks

A message box usually looks like this:

![MsgBox](../static/dlg_message.png)

The tables above are used by adding up the values you wish to be present in the message box. For example, to specify a Yes/No box with the default button being No instead of Yes, the _Options_ value would be 256+4 (260). In hex, it would be 0x100+0x4 (0x104).

MsgBox has smart comma handling, so it is usually not necessary to [escape](../misc/EscapeChar.htm) commas in the _Text_ parameter.

To determine which button the user pressed in the most recent message box, use the [IfMsgBox](IfMsgBox.htm) command. For example:

```
MsgBox, 4,, Would you like to continue? (press Yes or No)
IfMsgBox Yes
    MsgBox You pressed Yes.
else
    MsgBox You pressed No.
```

The names of the buttons can be customized by following [this example](../scripts/index.htm#MsgBoxButtonNames).

**Tip**: Pressing Ctrl+C while a message box is active will copy its text to the clipboard. This applies to all message boxes, not just those produced by AutoHotkey.

**Using MsgBox with GUI windows**: A GUI window may display a _modal_ message box by means of [Gui +OwnDialogs](Gui.htm#OwnDialogs). A _modal_ message box prevents the user from interacting with the GUI window until the message box is dismissed. In such a case, it is not necessary to specify the System Modal or Task Modal options from the table above.

When [Gui +OwnDialogs](Gui.htm#OwnDialogs) is _not_ in effect, the Task Modal option (8192) can be used to disable all the script's windows until the user dismisses the message box.

**The Help button**: When the Help button option (16384) is present in _Options_, pressing the Help button will have no effect unless both of the following are true:

1. The message box is owned by a GUI window by means of[Gui +OwnDialogs](Gui.htm#OwnDialogs).
2. The script is monitoring the WM\_HELP message (0x0053). For example:`<a href="OnMessage.htm" data-index="12">OnMessage</a>(0x0053, "WM_HELP")`. When the WM\_HELP() function is called, it may guide the user by means such as showing another window or MsgBox.

**The Close button (in the message box's title bar)**: Since the message box is a built-in feature of the operating system, its **X** button is enabled only when certain buttons are present. If there is only an OK button, clicking the **X** button is the same as pressing OK. Otherwise, the X button is disabled unless there is a Cancel button, in which case clicking the **X** is the same as pressing Cancel.

## Related

[IfMsgBox](IfMsgBox.htm), [InputBox](InputBox.htm), [FileSelectFile](FileSelectFile.htm), [FileSelectFolder](FileSelectFolder.htm), [ToolTip](ToolTip.htm), [GUI](Gui.htm)

## Examples

The 1-parameter method. A quick and easy way to show information. The user can press an OK button to close the message box and continue execution.

```
MsgBox This is the 1-parameter method. Commas (,) do not need to be escaped.
```

The 3-parameter method. Use the first and second parameter to specify the options and the title.

```
MsgBox, 4, , This is the 3-parameter method. Commas (,) do not need to be escaped.
```

Use [IfMsgBox](IfMsgBox.htm) to determine which button the user pressed in the most recent message box.

```
MsgBox, 4, , Do you want to continue? (Press YES or NO)
IfMsgBox No
    return
```

The 4-parameter method. Use the fourth parameter (Timeout) to automatically close the message box after a certain number of seconds.

```
MsgBox, 4, , 4-parameter method: this MsgBox will time out in 5 seconds.  Continue?, 5
IfMsgBox Timeout
    MsgBox You didn't press YES or NO within the 5-second period.
else IfMsgBox No
    return
```

By preceding any parameter with `% `, it becomes an [expression](../Variables.htm#Expressions). In the following example, math is performed, a [pseudo-array](../misc/Arrays.htm#pseudo) element is accessed, and a function is called. All these items are concatenated via the "." operator to form a single string displayed by MsgBox.

```
MsgBox % "New width for object #" . A_Index . " is: " . RestrictWidth(ObjectWidth%A_Index% * ScalingFactor)
```

Alerts the user that a message box is going to steal focus (in case the user is typing).

```
SplashTextOn,,, A message box is about to appear.
Sleep 3000
SplashTextOff
MsgBox The backup process has completed.
```

