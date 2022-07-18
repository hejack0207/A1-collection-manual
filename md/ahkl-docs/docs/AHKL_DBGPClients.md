# Debugging Clients

Additional debugging features are supported via [DBGp](https://xdebug.org/docs/dbgp), a common debugger protocol for languages and debugger UI communication. See [Interactive Debugging](Scripts.htm#idebug) for more details. Some UIs or "clients" known to be compatible with AutoHotkey are listed on this page:

- [SciTE4AutoHotkey](#SciTE4AutoHotkey)
- [XDebugClient](#XDebugClient)
- [Notepad++ DBGp Plugin](#Notepad++)
- [Script-based Clients](#dbgp.ahk)
- [Command-line Client](#command-line-client)
- [Others](#others)

## SciTE4AutoHotkey

[SciTE4AutoHotkey](http://fincs.ahk4.net/scite4ahk/) is a free, [SciTE](https://www.scintilla.org/SciTE.html)-based AutoHotkey script editor. In addition to DBGp support, it provides syntax highlighting, calltips/parameter info and auto-complete for AutoHotkey, and other useful editing features and scripting tools.

Debugging features include:

- Breakpoints.
- Run, Step Over/Into/Out.
- View the call stack.
- List name and contents of variables in local/global scope.
- Hover over variable to show contents.
- Inspect or edit variable contents.
- View structure of objects.

[http://fincs.ahk4.net/scite4ahk/](http://fincs.ahk4.net/scite4ahk/)

## XDebugClient

[XDebugClient](https://code.google.com/archive/p/xdebugclient/) is a simple open-source front-end DBGp client based on the **.NET Framework 2.0**. XDebugClient was originally designed for PHP with Xdebug, but a custom build compatible with AutoHotkey is available below.

**Changes:**

- Allow the debugger engine to report a language other than "php".
- Added AutoHotkey syntax highlighting.
- Automatically listen for a connection from the debugger engine, rather than waiting for the user to click_Start Listening_.
- Truncate property values at the first null-character, since AutoHotkey currently returns the entire variable contents and XDebugClient has no suitable interface for displaying binary content.

**Download:** [Binary](https://www.autohotkey.com/download/tools/XDebugClient.zip); [Source Code](https://www.autohotkey.com/download/tools/XDebugClient_src.zip) (also see [SharpDevelop](https://github.com/icsharpcode), [Dockpanel Suite](https://sourceforge.net/projects/dockpanelsuite/) and [Advanced TreeView](https://www.codeproject.com/Articles/14741/Advanced-TreeView-for-NET).)

**Usage:**

- Launch XDebugClient.
- Launch AutoHotkey /Debug. XDebugClient should automatically open the script file.
- Click the left margin to set at least one breakpoint.
- Choose Run from the Debug menu, or pressF5.
- When execution hits a breakpoint, use the Debug menu or shortcut keys to step through or resume the script.

**Features:**

- Syntax highlighted, read-only view of the source code.
- Breakpoints.
- Run, Step Over/Into/Out.
- View the call stack.
- Inspect variables - select a variable name, right-click, Inspect.

**Issues:**

- The user interface does not respond to user input while the script is running.
- No mechanisms are provided to list variables or set their values.

## Notepad++ DBGp Plugin

A DBGp client is available as a plugin for [Notepad++](https://notepad-plus-plus.org/). It is designed for PHP, but also works well with AutoHotkey.

**Download:** See [DBGp plugin for Notepad++](https://sourceforge.net/projects/npp-plugins/files/DBGP%20Plugin/).

**Usage:**

- Launch Notepad++.
- Configure the DBGp plugin via_Plugins_, _DBGp_, _Config..._
  **Note:** File Mapping must be configured. Most users will not be debugging remotely, and therefore may simply put a checkmark next to _Bypass all mapping (local windows setup)_.

- Show the debugger pane via the toolbar or**Plugins**, **DBGp**, **Debugger**.
- Open the script file to be debugged.
- Set at least one breakpoint.
- Launch AutoHotkey /Debug.
- Use the debugger toolbar or shortcut keys to control the debugger.

**Features:**

- Syntax highlighting, if configured by the user.
- Breakpoints.
- Run, Step Over/Into/Out, Run to cursor, Stop.
- View local/global variables.
- Watch user-specified variables.
- View the call stack.
- Hover over a variable to view its contents.
- User-configurable shortcut keys - Settings, Shortcut Mapper..., Plugin commands.

**Issues:**

- Hovering over a single-letter variable name does not work - for instance, hovering over`a` will attempt to retrieve ` a` or `a `.
- Hovering over text will attempt to retrieve a variable even if the text contains invalid characters.
- Notepad++ becomes unstable if property\_get fails, which is particularly problematic in light of the above. As a workaround, AutoHotkey sends an empty property instead of an error code when a non-existent or invalid variable is requested.

## Script-based Clients

A script-based DBGp library and example clients are available from GitHub.

- dbgp\_console.ahk: Simple command-line client.
- dbgp\_test.ahk: Demonstrates asynchronous debugging.
- dbgp\_listvars.ahk: Example client which justs lists the variables of all running scripts.

GitHub: [Lexikos / **dbgp**](https://github.com/Lexikos/dbgp)

The DebugVars script provides a graphical user interface for inspecting and changing the contents of variables and objects in any running script (except compiled scripts). It also serves as a demonstration of the dbgp.ahk library.

GitHub: [Lexikos / **DebugVars**](https://github.com/Lexikos/DebugVars.ahk#debugvars)

## Command-line Client

A command-line client is available from [xdebug.org](https://xdebug.org/), however this is not suitable for most users as it requires a decent understanding of DBGp (the protocol).

## Others

A number of other DBGp clients are available, but have not been tested with AutoHotkey. For a list, see [Xdebug: Documentation](https://xdebug.org/docs/remote).

