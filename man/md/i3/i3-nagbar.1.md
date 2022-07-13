# i3\-nagbar(1)

i3 4\&.18\&.1, 04/23/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

i3-nagbar - displays an error bar on top of your screen

<a name="synopsis"></a>

# Synopsis

```

 i3-nagbar [-m <message>] [-b <button> <action>] [-B <button> <action>] [-t warning|error] [-f <font>] [-v]
```

<a name="options"></a>

# Options


**-v, --version**
Display version number and exit.

**-h, --help**
Display a short help-message and exit.

**-t, --type** _type_
Display either a warning or error message. This only changes the color scheme for the i3-nagbar. Default: error.

**-m, --message** _message_
Display
_message_
as text on the left of the i3-nagbar.

**-f, --font** _font_
Select font that is being used.

**-b, --button** _button_ _action_
Create a button with text
_button_. The
_action_
are the shell commands that will be executed by this button. Multiple buttons can be defined. Will launch the shell commands inside a terminal emulator, using i3-sensible-terminal.

**-B, --button-no-terminal** _button_ _action_
Same as above, but will execute the shell commands directly, without launching a terminal emulator.

<a name="description"></a>

# Description


i3-nagbar is used by i3 to tell you about errors in your configuration file (for example). While these errors are logged to the logfile (if any), the past has proven that users are either not aware of their logfile or do not check it after modifying the configuration file.

<a name="example"></a>

# Example


.if n \{.RS 4
.\}
    i3-nagbar -m You have an error in your i3 config file!*(Aq e
    -b edit config*(Aq *(Aqi3-sensible-editor ~/.config/i3/config*(Aq
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


i3(1)

<a name="author"></a>

# Author


Michael Stapelberg and contributors
