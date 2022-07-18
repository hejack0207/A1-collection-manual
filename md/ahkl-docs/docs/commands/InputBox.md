# InputBox

Displays an input box to ask the user to enter a string.

```
<span class="func">InputBox</span>, OutputVar <span class="optional">, Title, Prompt, HIDE, Width, Height, X, Y, Locale, Timeout, Default</span>
```

## Parameters

OutputVar

The name of the variable in which to store the text entered by the user.

Title

The title of the input box. If blank or omitted, it defaults to the name of the script.

Prompt

The text of the input box, which is usually a message to the user indicating what kind of input is expected. If _Prompt_ is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

HIDE

If this parameter is the word HIDE, the user's input will be masked, which is useful for passwords.

Width

If this parameter is blank or omitted, the starting width of the window will be 375. This parameter can be an [expression](../Variables.htm#Expressions).

Height

If this parameter is blank or omitted, the starting height of the window will be 189. This parameter can be an [expression](../Variables.htm#Expressions).

X, Y

The X and Y coordinates of the window (use 0,0 to move it to the upper left corner of the desktop), which can be [expressions](../Variables.htm#Expressions). If either coordinate is blank or omitted, the dialog will be centered in that dimension. Either coordinate can be negative to position the window partially or entirely off the desktop.

Locale [v1.1.31+]

If this parameter is the word Locale, the OK and Cancel buttons are named according to the current user's locale (for example, Abbrechen instead of Cancel on a German OS). In addition, to display these names correctly, the buttons are made wider and the minimum width of the input box is increased. This becomes the default behavior in [AutoHotkey v2](https://www.autohotkey.com/v2/).

Timeout

Timeout in seconds (can contain a decimal point or be an [expression](../Variables.htm#Expressions)). If this value exceeds 2147483 (24.8 days), it will be set to 2147483. After the timeout has elapsed, the input box will be automatically closed and [ErrorLevel](../misc/ErrorLevel.htm) will be set to 2. _OutputVar_ will still be set to what the user entered.

Default

A string that will appear in the input box's edit field when the dialog first appears. The user can change it by backspacing or other means.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the user presses the CANCEL button, 0 if the user presses OK, or 2 if the dialog times out. In all three cases, _OutputVar_ is set to the value entered. This allows the CANCEL button to perform a function other than CANCEL should the script designer wish it.

## Remarks

An input box usually looks like this:

![InputBox](../static/dlg_input.png)

The dialog allows the user to enter text and then press OK or CANCEL. The user can resize the dialog window by dragging its borders.

A GUI window may display a modal input box by means of [Gui +OwnDialogs](Gui.htm#OwnDialogs). A modal input box prevents the user from interacting with the GUI window until the input box is dismissed.

## Related

[GUI](Gui.htm), [Input](Input.htm), [MsgBox](MsgBox.htm), [FileSelectFile](FileSelectFile.htm), [FileSelectFolder](FileSelectFolder.htm), [SplashTextOn](SplashTextOn.htm), [ToolTip](ToolTip.htm)

## Examples

Allows the user to enter a hidden password.

```
InputBox, password, Enter Password, (your input will be hidden), hide
```

Allows the user to enter a phone number.

```
InputBox, UserInput, Phone Number, Please enter a phone number., , 640, 480
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    MsgBox, You entered "%UserInput%"
```

