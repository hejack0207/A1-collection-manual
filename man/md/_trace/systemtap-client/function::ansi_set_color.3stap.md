# function::ansi_set_c(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ansi_set_color - Set the ansi Select Graphic Rendition mode.

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) ansi_set_color(fg:long)
<synopsis>


</synopsis>
    2) ansi_set_color(fg:long,bg:long)
<synopsis>


```
    3) ansi_set_color(fg:long,bg:long,attr:long)

<a name="arguments"></a>

# Arguments


_fg_
Foreground color to set.

_bg_
Background color to set.

_attr_
Color attribute to set.

<a name="description"></a>

# Description


1) Sends ansi code for Select Graphic Rendition mode for the given forground color. Black (30), Blue (34), Green (32), Cyan (36), Red (31), Purple (35), Brown (33), Light Gray (37).

2) Sends ansi code for Select Graphic Rendition mode for the given forground color, Black (30), Blue (34), Green (32), Cyan (36), Red (31), Purple (35), Brown (33), Light Gray (37) and the given background color, Black (40), Red (41), Green (42), Yellow (43), Blue (44), Magenta (45), Cyan (46), White (47).

3) Sends ansi code for Select Graphic Rendition mode for the given forground color, Black (30), Blue (34), Green (32), Cyan (36), Red (31), Purple (35), Brown (33), Light Gray (37), the given background color, Black (40), Red (41), Green (42), Yellow (43), Blue (44), Magenta (45), Cyan (46), White (47) and the color attribute All attributes off (0), Intensity Bold (1), Underline Single (4), Blink Slow (5), Blink Rapid (6), Image Negative (7).

<a name="see-alson-"></a>

# See Also\N 

_tapset::ansi_(3stap)
