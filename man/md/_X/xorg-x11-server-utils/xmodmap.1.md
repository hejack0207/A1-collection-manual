# xmodmap(1) - utility for modifying keymaps and pointer button mappings in X

X Version 11, xmodmap 1.0.9

```
xmodmap [-options ...] [filename]
```

<a name="description"></a>

# Description


The _xmodmap_ program is used to edit and display the 
keyboard _modifier map_ and _keymap table_ that are used by client 
applications to convert event keycodes into keysyms.  It is usually run from 
the user's session startup script to configure the keyboard according to 
personal tastes.

<a name="options"></a>

# Options


The following options may be used with _xmodmap_:

* **-display _display_**  
  This option specifies the host and display to use.
* **-help**  
  This option indicates that a brief description of the command line arguments
  should be printed on the standard error channel.  This will be done whenever an
  unhandled argument is given to
  _xmodmap._
* **-grammar**  
  This option indicates that a help message describing the expression grammar 
  used in files and with -e expressions should be printed on the standard error.
* **-version**  
  This option indicates that
  _xmodmap_
  should print its version information and exit.
* **-verbose**  
  This option indicates that 
  _xmodmap_
  should print logging information as it parses its input.
* **-quiet**  
  This option turns off the verbose logging.  This is the default.
* **-n**  
  This option indicates that 
  _xmodmap_
  should not change the mappings, but should display what it would do, like
  _make(1)_ does when given this option.
* **-e expression**  
  This option specifies an expression to be executed.  Any number of expressions
  may be specified from the command line.
* **-pm**  
  This option indicates that the current modifier map should be printed on the
  standard output.   This is the default mode of operation if no other mode
  options are specified.
* **-pk**  
  This option indicates that the current keymap table should be printed on the
  standard output.
* **-pke**  
  This option indicates that the current keymap table should be printed on the
  standard output in the form of expressions that can be fed back to
  _xmodmap_.
* **-pp**  
  This option indicates that the current pointer map should be printed on the
  standard output.
* **-**  
  A lone dash means that the standard input should be used as the input file.

The _filename_ specifies a file containing _xmodmap_ expressions
to be executed.  This file is usually kept in the user's home directory with
a name like _.xmodmaprc_.

<a name="expression-grammar"></a>

# Expression Grammar


The
_xmodmap_
program reads a list of expressions and parses them all before attempting
to execute any of them.  This makes it possible to refer to keysyms that are
being redefined in a natural way without having to worry as much about name
conflicts.

The list of keysym names may be found in the header file
_&lt;X11/keysymdef.h&gt;_ (without the _XK\__ prefix),
supplemented by the keysym database _ /usr/share/X11/XKeysymDB_.
Keysyms matching Unicode characters may be specified as "U0020" to "U007E"
and "U00A0" to "U10FFFF" for all possible Unicode characters.

* **keycode _NUMBER_ = _KEYSYMNAME ..._**  
  The list of keysyms is assigned to the indicated keycode 
  (which may be specified in decimal, hex or octal and can be determined by 
  running the
  _xev_
  program).  Up to eight keysyms may be attached to a key, however the last four
  are not used in any major X server implementation.  The first keysym is used
  when no modifier key is pressed in conjunction with this key, the second with
  Shift, the third when the Mode_switch key is used with this key and the fourth
  when both the Mode_switch and Shift keys are used.
* **keycode any = _KEYSYMNAME ..._**  
  If no existing key has the specified list of keysyms assigned to it,
  a spare key on the keyboard is selected and the keysyms are assigned to it.
  The list of keysyms may be specified in decimal, hex or octal.
* **keysym _KEYSYMNAME_ = _KEYSYMNAME ..._**  
  The _KEYSYMNAME_ on the left hand side is translated into matching keycodes
  used to perform the corresponding set of **keycode** expressions.  Note that
  if the same keysym is bound to multiple keys, the expression is executed
  for each matching keycode.
* **clear _MODIFIERNAME_**  
  This removes all entries in the modifier map for the given modifier, where 
  valid name are:
  **Shift**,
  **Lock**,
  **Control**,
  **Mod1**,
  **Mod2**,
  **Mod3**,
  **Mod4**,
  and **Mod5** (case 
  does not matter in modifier names, although it does matter for all other
  names).  For example, \`\`clear Lock'' will remove
  all any keys that were bound to the shift lock modifier.
* **add _MODIFIERNAME_ = _KEYSYMNAME ..._**  
  This adds all keys containing the given keysyms to the indicated modifier map.
  The keysym names
  are evaluated after all input expressions are read to make it easy to write
  expressions to swap keys (see the EXAMPLES section).
* **remove _MODIFIERNAME_ = _KEYSYMNAME ..._**  
  This removes all keys containing the given keysyms from the indicated
  modifier map.  Unlike
  **add,**
  the keysym names are evaluated as the line is read in.  This allows you to
  remove keys from a modifier without having to worry about whether or not they
  have been reassigned.
* **pointer = default**  
  This sets the pointer map back to its default settings (button 1 generates a 
  code of 1, button 2 generates a 2, etc.).
* **pointer = _NUMBER ..._**  
  This sets the pointer map to contain the indicated button codes.  The list
  always starts with the first physical button.  Setting a button code to 0
  disables events from that button.

Lines that begin with an exclamation point (!) are taken as comments.

If you want to change the binding of a modifier key, you must also remove it
from the appropriate modifier map.

<a name="examples"></a>

# Examples


Many pointers are designed such that the first button is pressed using the
index finger of the right hand.  People who are left-handed frequently find
that it is more comfortable to reverse the button codes that get generated
so that the primary button is pressed using the index finger of the left hand.
This could be done on a 3 button pointer as follows:
.EX
%  xmodmap -e "pointer = 3 2 1"
.EE

Many applications support the notion of Meta keys (similar to Control 
keys except that Meta is held down instead of Control).  However,
some servers do not have a Meta keysym in the default keymap table, so one
needs to be added by hand.
The following command will attach Meta to the Multi-language key (sometimes
labeled Compose Character).  It also takes advantage of the fact that 
applications that need a Meta key simply need to get the keycode and don't
require the keysym to be in the first column of the keymap table.  This
means that applications that are looking for a Multi_key (including the
default modifier map) won't notice any change.
.EX
%  xmodmap -e "keysym Multi_key = Multi_key Meta_L"
.EE

Similarly, some keyboards have an Alt key but no Meta key.
In that case the following may be useful:
.EX
%  xmodmap -e "keysym Alt_L = Meta_L Alt_L"
.EE

One of the more simple, yet convenient, uses of _xmodmap_ is to set the
keyboard's "rubout" key to generate an alternate keysym.  This frequently
involves exchanging Backspace with Delete to be more comfortable to the user.
If the _ttyModes_ resource in _xterm_ is set as well, all terminal 
emulator windows will use the same key for erasing characters:
.EX
%  xmodmap -e "keysym BackSpace = Delete"
%  echo "XTerm*ttyModes:  erase ^?" | xrdb -merge
.EE

Some keyboards do not automatically generate less than and greater than
characters when the comma and period keys are shifted.  This can be remedied
with _xmodmap_ by resetting the bindings for the comma and period with
the following scripts:
.EX
!
! make shift-, be &lt; and shift-. be &gt;
!
keysym comma = comma less
keysym period = period greater
.EE

One of the more irritating differences between keyboards is the location of the
Control and CapsLock keys.  A common use of _xmodmap_ is to swap these
two keys as follows:
.EX
!
! Swap Caps_Lock and Control_L
!
remove Lock = Caps_Lock
remove Control = Control_L
keysym Control_L = Caps_Lock
keysym Caps_Lock = Control_L
add Lock = Caps_Lock
add Control = Control_L
.EE

This example can be run again to swap the keys back to their previous 
assignments.

The _keycode_ command is useful for assigning the same keysym to
multiple keycodes.  Although unportable, it also makes it possible to write
scripts that can reset the keyboard to a known state.  The following script
sets the backspace key to generate Delete (as shown above), flushes all 
existing caps lock bindings, makes the CapsLock
key be a control key, make F5 generate Escape, and makes Break/Reset be a
shift lock.
.EX
!
! On the HP, the following keycodes have key caps as listed:
!
!     101  Backspace
!      55  Caps
!      14  Ctrl
!      15  Break/Reset
!      86  Stop
!      89  F5
!
keycode 101 = Delete
keycode 55 = Control_R
clear Lock
add Control = Control_R
keycode 89 = Escape
keycode 15 = Caps_Lock
add Lock = Caps_Lock
.EE

<a name="environment"></a>

# Environment



* **DISPLAY**  
  to get default host and display number.

<a name="see-also"></a>

# See Also

X(7), xev(1), setxkbmap(1),
XStringToKeysym(3),
_Xlib_ documentation on key and pointer events

<a name="bugs"></a>

# Bugs


Every time a **keycode** expression is evaluated, the server generates
a _MappingNotify_ event on every client.  This can cause some thrashing.
All of the changes should be batched together and done at once.
Clients that receive keyboard input and ignore _MappingNotify_ events
will not notice any changes made to keyboard mappings.

_Xmodmap_
should generate "add" and "remove" expressions automatically
whenever a keycode that is already bound to a modifier is changed.

There should be a way to have the
_remove_
expression accept keycodes as well as keysyms for those times when you really
mess up your mappings.

<a name="author"></a>

# Author

Jim Fulton, MIT X Consortium, rewritten from an earlier version by
David Rosenthal of Sun Microsystems.

