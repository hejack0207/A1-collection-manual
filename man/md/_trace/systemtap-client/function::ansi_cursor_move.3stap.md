# function::ansi_curso(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ansi_cursor_move - Move cursor to new coordinates.

<a name="synopsis"></a>

# Synopsis

```


```
        ansi_cursor_move(x:long,y:long)

<a name="arguments"></a>

# Arguments


_x_
Row to move the cursor to.

_y_
Colomn to move the cursor to.

<a name="description"></a>

# Description


Sends ansi code for positioning the cursor at row x and column y. Coordinates start at one, (1,1) is the top-left corner.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ansi_(3stap)
