# i3-save-tree(1)

perl v5.28.2, 2020-04-23

.if n .ad l
.nh

<a name="name"></a>

# Name

.Vb 1
    i3-save-tree - save (parts of) the layout tree for restoring
.Ve

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1     i3-save-tree [--workspace=name|number] [--output=name] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Dumps a workspace (or an entire output) to stdout. The data is supposed to be
edited a bit by a human, then later fed to i3 via the append_layout command.

The append_layout command will create placeholder windows, arranged in the
layout the input file specifies. Each container should have a swallows
specification. When a window is mapped (made visible on the screen) that
matches the specification, i3 will put it into that place and kill the
placeholder.

If neither argument is specified, the currently focused workspace will be used.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--workspace=name|number**  
  .IX Item "--workspace=name|number"
  Specifies the workspace that should be dumped, e.g. 1. This can either be a
  name or the number of a workspace.
* **--output=name**  
  .IX Item "--output=name"
  Specifies the output that should be dumped, e.g. \s-1LVDS-1.\s0

<a name="version"></a>

# Version

.IX Header "VERSION"
Version 0.1

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Michael Stapelberg, \f(CW`&lt;michael at i3wm.org&gt;\*(C'

<a name="license-and-copyright"></a>

# License and Copyright

.IX Header "LICENSE AND COPYRIGHT"
Copyright 2013 Michael Stapelberg.

This program is free software; you can redistribute it and/or modify it
under the terms of the \s-1BSD\s0 license.
