# consoletype(1)

RH, Red Hat, Inc

consoletype
- print type of the console connected to standard input

<a name="synopsis"></a>

# Synopsis

```
consoletype [stdout] [fg]
```

<a name="description"></a>

# Description

consoletype
prints the type of console connected to standard input, and checks
whether the console connected to standard input is the current
foreground virtual console. With no arguments, it prints
_vt_
if console is a virtual terminal (/dev/tty* or /dev/console device if not on
a serial console),
_serial_
if standard input is a serial console (/dev/console or /dev/ttyS*) and
_pty_
if standard input is a pseudo terminal.

<a name="return-value"></a>

# Return Value

consoletype
when passed no arguments returns 

* 0  
  if on virtual terminal
* 1  
  if on serial console
* 2  
  if on a pseudo terminal.
* When passed the _stdout_ argument, **consoletype** returns  
* 0  
  in all cases, and prints the console type to stdout.
* When passed the _fg_ argument, **consoletype** returns  
* 0  
  if the console connected to standard input is the current virtual
  terminal
* 1  
  otherwise.
