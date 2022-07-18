# SetWorkingDir

Changes the script's current working directory.

```
<span class="func">SetWorkingDir</span>, DirName
```

## Parameters

DirName

The name of the new working directory, which is assumed to be a subfolder of the current [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

The script's working directory is the default directory that is used to access files and folders when an absolute path has not been specified. In the following example, the file _My Filename.txt_ is assumed to be in %A\_WorkingDir%: `<a href="FileAppend.htm" data-index="4">FileAppend</a>, A Line of Text, My Filename.txt`.

A script's initial working directory is determined by how it was launched. For example, if it was run via shortcut -- such as on the Start Menu -- its working directory is determined by the "Start in" field within the shortcut's properties.

To make a script unconditionally use its own folder as its working directory, make its first line the following:

```
SetWorkingDir %A_ScriptDir%
```

Once changed, the new working directory is instantly and globally in effect throughout the script. All interrupted, [paused](Pause.htm), and newly launched [threads](../misc/Threads.htm) are affected, including [Timers](SetTimer.htm).

## Related

[%A\_WorkingDir%](../Variables.htm#WorkingDir), [%A\_ScriptDir%](../Variables.htm#ScriptDir), [FileSelectFolder](FileSelectFolder.htm)

## Examples

Changes the script's current working directory.

```
SetWorkingDir, D:\My Folder\Temp
```

Forces the script to use its own folder as its working directory. Recommended for new scripts to ensure consistency.

```
SetWorkingDir %A_ScriptDir%
```

