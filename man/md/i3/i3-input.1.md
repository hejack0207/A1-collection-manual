# i3\-input(1)

i3 4\&.18\&.1, 04/23/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

i3-input - interactively take a command for i3 window manager

<a name="synopsis"></a>

# Synopsis

```

 i3-input [-s <socket>] [-F <format>] [-l <limit>] [-P <prompt>] [-f <font>] [-v]
```

<a name="description"></a>

# Description


i3-input is a tool to take commands (or parts of a command) composed by the user, and send it/them to i3. This is useful, for example, for the mark/goto command.

You can press Escape to close i3-input without sending any commands.

<a name="options"></a>

# Options


-s &lt;socket&gt;
Specify the path to the i3 IPC socket (it should not be necessary to use this option, i3-input will figure out the path on its own).

-F &lt;format&gt;
Every occurrence of "%s" in the &lt;format&gt; string is replaced by the user input, and the result is sent to i3 as a command. Default value is "%s".

-l &lt;limit&gt;
Set the maximum allowed length of the user input to &lt;limit&gt; characters. i3-input will automatically issue the command when the user input reaches that length.

-P &lt;prompt&gt;
Display the &lt;prompt&gt; string in front of user input text field. The prompt string is not included in the user input/command.

-f &lt;font&gt;
Use the specified X11 core font (use
xfontsel
to chose a font).

-v
Show version and exit.

<a name="examples"></a>

# Examples


Mark a container with a single character:

.if n \{.RS 4
.\}
    i3-input -F mark %s*(Aq -l 1 -P *(AqMark: *(Aq
.if n \{.RE
.\}

Go to the container marked with above example:

.if n \{.RS 4
.\}
    i3-input -F [con_mark="%s"] focus*(Aq -l 1 -P *(AqGo to: *(Aq
.if n \{.RE
.\}

<a name="environment"></a>

# Environment


<a name="i3sock"></a>

### I3SOCK


i3-input handles the different sources of socket paths in the following order:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  I3SOCK environment variable

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  I3SOCK gets overwritten by the -s parameter, if specified

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  if neither are available, i3-input reads the socket path from the X11 property, which is the recommended way

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  if everything fails, i3-input tries
  /tmp/i3-ipc.sock

The socket path is necessary to connect to i3 and actually issue the command.

<a name="see-also"></a>

# See Also


i3(1)

<a name="author"></a>

# Author


Michael Stapelberg and contributors
