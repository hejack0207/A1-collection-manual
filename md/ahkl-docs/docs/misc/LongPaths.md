# Long Paths [v1.1.31+]

In general, programs are affected by two kinds of path length limitations:

1. Functions provided by the operating system generally limit paths to 259 characters, with some exceptions.
2. Code for dealing with paths within the program may rely on the first limitation to simplify the code, effectively placing another 259 character limitation.

These limitations are often referred to as "MAX\_PATH limitations", after the constant `MAX_PATH`, which has the value 260. One character is generally reserved for a null terminator, leaving 259 characters for the actual path.

AutoHotkey [v1.1.31+] (excluding ANSI versions) removes the second kind in most cases, which enables the script to work around the first kind. There are two ways to do this:

- Long paths can be enabled for AutoHotkey and all other long-path-aware programs on Windows 10. Refer to the[Microsoft documentation](https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file#enable-long-paths-in-windows-10-version-1607-and-later) for details. In short, this enables most commands and functions to transparently work with long paths, but requires Windows 10 version 1607 or later.
- In many cases, prefixing the path with`\\?\` enables it to exceed the usual limit. However, some system functions do not support it (or long paths in general). See [Known Limitations](#limitations) for details.

## Long Path Prefix

If supported by the underlying system function, the `\\?\` prefix -- for example, in `\\?\C:\My Folder` \-\- increases the limit to 32,767 characters. However, it does this by skipping [path normalization](https://blogs.msdn.microsoft.com/jeremykuhne/2016/04/21/path-normalization/). Some elements of the path which would normally be removed or altered by normalization instead become part of the file's actual path. Care must be taken as this can allow the creation of paths that "normal" programs cannot access.

In particular, normalization:

- Resolves relative paths such as`dir\file.ext`, `\file.ext` and `C:file.ext` (note the absence of a slash).
- Resolves relative components such as`\..` and `\.`.
- Canonicalizes component/directory separators, replacing`/` with `\` and eliminating redundant separators.
- Trims certain characters, such as a single period at the end of a component ( `dir.\file`) or trailing spaces and periods ( `dir\filename . .`).

A path can be normalized explicitly by passing it to [GetFullPathName](https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getfullpathnamew) via the function defined below, before applying the prefix. For example:

```
MsgBox % "\\?\" NormalizePath("..\file.ext")
```

```
NormalizePath(path) {
    cc := DllCall("GetFullPathName", "str", path, "uint", 0, "ptr", 0, "ptr", 0, "uint")
    VarSetCapacity(buf, cc*2)
    DllCall("GetFullPathName", "str", path, "uint", cc, "str", buf, "ptr", 0)
    return buf
}
```

A path with the `\\?\` prefix can also be normalized by this function. However, in that case the working directory is never used, and the root is `\\?\` (for example, `\\?\C:\..` resolves to `\\?\` whereas `C:\..` resolves to `C:\`).

## Known Limitations

ANSI versions of AutoHotkey do not support long paths.

Even when the path itself is not limited to 259 characters, each component (file or directory name) cannot exceed the hard limit imposed by the file system (usually 255 characters).

These do not support long paths due to limitations of the underlying system function(s):

- [DllCall()](../commands/DllCall.htm) (for _DllFile_ and _Function_)
- [FileCopyDir](../commands/FileCopyDir.htm)
- [FileCreateShortcut](../commands/FileCreateShortcut.htm)
- [FileGetShortcut](../commands/FileGetShortcut.htm)
- [FileMoveDir](../commands/FileMoveDir.htm), unless the R option is used
- [FileRecycle](../commands/FileRecycle.htm)
- [FileRemoveDir](../commands/FileRemoveDir.htm), unless _Recurse_ is false
- [SoundPlay](../commands/SoundPlay.htm) (for this, the limit is 127 characters)
- [Drive Label](../commands/Drive.htm#Label) and [DriveGet](../commands/DriveGet.htm) (except Type)
- Built-in variables which return special folder paths (for which long paths might be impossible anyway):[A\_AppData](../Variables.htm#AppData), [A\_Desktop](../Variables.htm#Desktop), [A\_MyDocuments](../Variables.htm#MyDocuments), [ProgramFiles](../Variables.htm#ProgramFiles), [A\_ProgramFiles](../Variables.htm#ProgramFiles), [A\_Programs](../Variables.htm#Programs), [A\_StartMenu](../Variables.htm#StartMenu), [A\_Startup](../Variables.htm#Startup) and Common variants, [A\_Temp](../Variables.htm#Temp) and [A\_WinDir](../Variables.htm#WinDir)

[SetWorkingDir](../commands/SetWorkingDir.htm) and [A\_WorkingDir](../Variables.htm#WorkingDir) support long paths only when Windows 10 long path awareness is enabled, since the `\\?\` prefix cannot be used. If the working directory exceeds MAX\_PATH, it becomes impossible to launch programs with [Run](../commands/Run.htm). These limitations are imposed by the OS.

It does not appear to be possible to run an executable with a full path which exceeds MAX\_PATH. That being the case, it would not be possible to fully test any changes aimed at supporting longer executable paths. Therefore, MAX\_PATH limits have been left in place for the following:

- [ahk\_exe](WinTitle.htm#ahk_exe)
- The default script's path, which is based on the current executable's path.
- Retrieval of the AutoHotkey installation directory, which is used by[A\_AhkPath](../Variables.htm#AhkPath) in compiled scripts and may be used to launch Window Spy or the help file.
- [WinGet ProcessPath](../commands/WinGet.htm#ProcessPath).
- [WinGet ProcessName](../commands/WinGet.htm#ProcessName) (this theoretically isn't a problem since it is applied only to the name portion, and NTFS only supports names up to 255 chars).

Long [#Include](../commands/_Include.htm) paths shown in error messages may be truncated arbitrarily.

