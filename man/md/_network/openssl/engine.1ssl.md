# engine(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-engine, engine - load and query engines

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl engine [ engine... ] [-v] [-vv] [-vvv] [-vvv] [-vvv] [-c] [-t] [-tt] [-pre command] [-post command] [ engine... ]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **engine** command is used to query the status and capabilities
of the specified **engine**'s.
Engines may be specified before and after all other command-line flags.
Only those specified are queried.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-v** **-vv** **-vvv** **-vvvv**  
  .IX Item "-v -vv -vvv -vvvv"
  Provides information about each specified engine. The first flag lists
  all the possible run-time control commands; the second adds a
  description of each command; the third adds the input flags, and the
  final option adds the internal input flags.
* **-c**  
  .IX Item "-c"
  Lists the capabilities of each engine.
* **-t**  
  .IX Item "-t"
  Tests if each specified engine is available, and displays the answer.
* **-tt**  
  .IX Item "-tt"
  Displays an error trace for any unavailable engine.
* **-pre** _command_  
  .IX Item "-pre command"
* **-post** _command_  
  .IX Item "-post command"
  Command-line configuration of engines.
  The **-pre** command is given to the engine before it is loaded and
  the **-post** command is given after the engine is loaded.
  The _command_ is of the form _cmd:val_ where _cmd_ is the command,
  and _val_ is the value for the command.
  See the example below.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To list all the commands available to a dynamic engine:

.Vb 10
 $ openssl engine -t -tt -vvvv dynamic
 (dynamic) Dynamic engine loading support
      [ unavailable ]
      SO_PATH: Specifies the path to the new ENGINE shared library
           (input flags): STRING
      NO_VCHECK: Specifies to continue even if version checking fails (boolean)
           (input flags): NUMERIC
      ID: Specifies an ENGINE id name for loading
           (input flags): STRING
      LIST_ADD: Whether to add a loaded ENGINE to the internal list (0=no,1=yes,2=mandatory)
           (input flags): NUMERIC
      DIR_LOAD: Specifies whether to load from DIR_ADD\*(Aq directories (0=no,1=yes,2=mandatory)
           (input flags): NUMERIC
      DIR_ADD: Adds a directory from which ENGINEs can be loaded
           (input flags): STRING
      LOAD: Load up the ENGINE specified by other settings
           (input flags): NO_INPUT
.Ve

To list the capabilities of the _rsax_ engine:

.Vb 4
 $ openssl engine -c
 (rsax) RSAX engine support
  [RSA]
 (dynamic) Dynamic engine loading support
.Ve

<a name="environment"></a>

# Environment

.IX Header "ENVIRONMENT"

* **\s-1OPENSSL\_ENGINES\s0**  
  .IX Item "OPENSSL_ENGINES"
  The path to the engines directory.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**config**\|(5)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2016-2019 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
