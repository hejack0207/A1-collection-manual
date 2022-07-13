# i3-dmenu-desktop(1)

perl v5.28.2, 2020-04-23

.if n .ad l
.nh

<a name="name"></a>

# Name

.Vb 1
    i3-dmenu-desktop - run .desktop files with dmenu
.Ve

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1     i3-dmenu-desktop [--dmenu=dmenu -i\*(Aq] [--entry-type=name] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
i3-dmenu-desktop is a script which extracts the (localized) name from
application .desktop files, offers the user a choice via **dmenu**\|(1) and then
starts the chosen application via i3 (for startup notification support).
The advantage of using .desktop files instead of **dmenu\_run**\|(1) is that dmenu_run
offers **all** binaries in your \f(CW$PATH, including non-interactive utilities like
sed\*(R". Also, .desktop files contain a proper name, information about whether
the application runs in a terminal and whether it supports startup
notifications.

The .desktop files are searched in \f(CW$XDG\_DATA\_HOME/applications (by default
\f(CW$HOME/.local/share/applications) and in the applications\*(R" subdirectory of each
entry of \f(CW$XDG\_DATA\_DIRS (by default /usr/local/share/:/usr/share/).

Files with the same name in \f(CW$XDG\_DATA\_HOME/applications take precedence over
files in \f(CW$XDG\_DATA\_DIRS, so that you can overwrite parts of the system-wide
.desktop files by copying them to your local directory and making changes.

i3-dmenu-desktop displays the Name\*(R" value in the localized version depending
on \s-1LC_MESSAGES\s0 as specified in the Desktop Entry Specification.

You can pass a filename or \s-1URL\s0 (%f/%F and \f(CW%u/%U field codes in the .desktop
file respectively) by appending it to the name of the application. E.g., if you
want to launch \s-1GNU\s0 Emacs 24\*(R" with the patch /tmp/foobar.txt, you would type
emacs\*(R", press \s-1TAB,\s0 type \*(L" /tmp/foobar.txt\*(R" and press \s-1ENTER.\s0

.desktop files with Terminal=true are started using **i3-sensible-terminal**\|(1).

.desktop files with NoDisplay=true or Hidden=true are skipped.

\s-1UTF-8\s0 is supported, of course, but dmenu does not support displaying all
glyphs. E.g., xfce4-terminal.desktop's Name[fi]=Pääte will be displayed just
fine, but not its Name[ru]=Терминал.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--dmenu=command**  
  .IX Item "--dmenu=command"
  Execute command instead of 'dmenu -i'. This option can be used to pass custom
  parameters to dmenu, or to make i3-dmenu-desktop start a custom (patched?)
  version of dmenu.
* **--entry-type=type**  
  .IX Item "--entry-type=type"
  Display the (localized) Name\*(R" (type = name), the command (type = command) or
  the (*.desktop) filename (type = filename) in dmenu. This option can be
  specified multiple times.
  .Sp
  Examples are \s-1GNU\s0 Image Manipulation Program\*(R" (type = name), \*(L"gimp\*(R" (type =
  command), and libreoffice-writer\*(R" (type = filename).

<a name="version"></a>

# Version

.IX Header "VERSION"
Version 1.5

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Michael Stapelberg, \f(CW`&lt;michael at i3wm.org&gt;\*(C'

<a name="license-and-copyright"></a>

# License and Copyright

.IX Header "LICENSE AND COPYRIGHT"
Copyright 2012 Michael Stapelberg.

This program is free software; you can redistribute it and/or modify it
under the terms of the \s-1BSD\s0 license.
