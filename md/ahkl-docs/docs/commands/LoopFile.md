# Loop (files & folders)

Retrieves the specified files or folders, one at a time.

## New Syntax [v1.1.21+]

```
<span class="func">Loop, Files</span>, FilePattern <span class="optional">, Mode</span>
```

### Parameters

Files

The literal word `Files` (case-insensitive). This cannot be a variable or expression.

FilePattern

The name of a single file or folder, or a wildcard pattern such as `C:\Temp\*.tmp`. _FilePattern_ is assumed to be in [A\_WorkingDir](../Variables.htm#WorkingDir) if an absolute path isn't specified.

Both asterisks and question marks are supported as wildcards. A match occurs when the pattern appears in either the file's long/normal name or its [8.3 short name](#LoopFileShortName).

If this parameter is a single file or folder (i.e. no wildcards) and _Mode_ includes R, more than one match will be found if the specified file name appears in more than one of the folders being searched.

Patterns longer than 259 characters may fail to find any files due to [system limitations (MAX\_PATH)](../misc/LongPaths.htm). This limit can be bypassed by using the `\\?\` [long path prefix](../misc/LongPaths.htm#prefix), with some stipulations.

Mode

If blank or omitted, only files are included and subdirectories are not recursed into. Otherwise, specify one or more of the following letters:

- D = Include directories (folders).
- F = Include files. If both F and D are omitted, files are included but not folders.
- R = Recurse into subdirectories (subfolders). If R is omitted, files and folders in subfolders are not included.

## Old Syntax

**Deprecated:** This syntax is not recommended for use in new scripts. Use the [new syntax](#new) instead.

```
<span class="func">Loop</span>, FilePattern <span class="optional">, IncludeFolders?, Recurse?</span>
```

### Parameters

FilePattern

The name of a single file or folder, or a wildcard pattern such as `C:\Temp\*.tmp`. _FilePattern_ is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

Both asterisks and question marks are supported as wildcards. A match occurs when the pattern appears in either the file's long/normal name or its [8.3 short name](#LoopFileShortName).

If this parameter is a single file or folder (i.e. no wildcards) and _Recurse_ is set to 1, more than one match will be found if the specified file name appears in more than one of the folders being searched.

IncludeFolders?

If blank or omitted, it defaults to 0 (only files are retrieved). Otherwise, specify one of the following digits:

- 0 = Folders are not retrieved (only files).
- 1 = All files and folders that match the wildcard pattern are retrieved.
- 2 = Only folders are retrieved (no files).

Recurse?

If blank or omitted, it defaults to 0 (subfolders are not recursed into). Otherwise, specify one of the following digits:

- 0 = Subfolders are not recursed into.
- 1 = Subfolders are recursed into so that files and folders contained therein are retrieved if they match_FilePattern_. All subfolders will be recursed into, not just those whose names match _FilePattern_.

## Special Variables Available Inside a File-Loop

The following variables exist within any file-loop. If an inner file-loop is enclosed by an outer file-loop, the innermost loop's file will take precedence:

VariableDescriptionA\_LoopFileNameThe name of the file or folder currently retrieved (without the path).A\_LoopFileExtThe file's extension (e.g. TXT, DOC, or EXE). The period (.) is not included.A\_LoopFileFullPath

 A\_LoopFilePath

The path and name of the file/folder currently retrieved. If _FilePattern_ contains a relative path rather than an absolute path, the path here will also be relative. In addition, any short (8.3) folder names in _FilePattern_ will still be short (see next item to get the long version).

A\_LoopFilePath is available in [v1.1.28+] as an alias of A\_LoopFileFullPath, which is a misnomer.

A\_LoopFileLongPath

This is different than A\_LoopFileFullPath in the following ways: 1) It always contains the absolute/complete path of the file even if _FilePattern_ contains a relative path; 2) Any short (8.3) folder names in _FilePattern_ itself are converted to their long names; 3) Characters in _FilePattern_ are converted to uppercase or lowercase to match the case stored in the file system. This is useful for converting file names -- such as those passed into a script as command line parameters -- to their exact path names as shown by Explorer.

A\_LoopFileShortPath

The 8.3 short path and name of the file/folder currently retrieved. For example: C:\\MYDOCU~1\\ADDRES~1.txt. If _FilePattern_ contains a relative path rather than an absolute path, the path here will also be relative.

To retrieve the complete 8.3 path and name for a single file or folder, specify its name for _FilePattern_ as in this example:

```
Loop, C:\My Documents\Address List.txt
    ShortPathName := A_LoopFileShortPath
```

**Note**: This variable will be **blank** if the file does not have a short name, which can happen on systems where NtfsDisable8dot3NameCreation has been set in the registry. It will also be blank if _FilePattern_ contains a relative path and the body of the loop uses [SetWorkingDir](SetWorkingDir.htm) to switch away from the working directory in effect for the loop itself.

A\_LoopFileShortNameThe 8.3 short name, or alternate name of the file. If the file doesn't have one (due to the long name being shorter than 8.3 or perhaps because short-name generation is disabled on an NTFS file system), _A\_LoopFileName_ will be retrieved instead.A\_LoopFileDirThe path of the directory in which _A\_LoopFileName_ resides. If _FilePattern_ contains a relative path rather than an absolute path, the path here will also be relative. A root directory will not contain a trailing backslash. For example: C:A\_LoopFileTimeModifiedThe time the file was last modified. Format [YYYYMMDDHH24MISS](FileSetTime.htm).A\_LoopFileTimeCreatedThe time the file was created. Format [YYYYMMDDHH24MISS](FileSetTime.htm).A\_LoopFileTimeAccessedThe time the file was last accessed. Format [YYYYMMDDHH24MISS](FileSetTime.htm).A\_LoopFileAttribThe [attributes](FileGetAttrib.htm) of the file currently retrieved.A\_LoopFileSizeThe size in bytes of the file currently retrieved. Files larger than 4 gigabytes are also supported.A\_LoopFileSizeKBThe size in Kbytes of the file currently retrieved, rounded down to the nearest integer.A\_LoopFileSizeMBThe size in Mbytes of the file currently retrieved, rounded down to the nearest integer.

## Remarks

A file-loop is useful when you want to operate on a collection of files and/or folders, one at a time.

All matching files are retrieved, including hidden files. By contrast, OS features such as the DIR command omit hidden files by default. To avoid processing hidden, system, and/or read-only files, use something like the following inside the loop:

```
if A_LoopFileAttrib contains H,R,S  <em>; Skip any file that is either H (Hidden), R (Read-only), or S (System). Note: No spaces in "H,R,S".</em>
    continue  <em>; Skip this file and move on to the next one.</em>
```

To retrieve files' relative paths instead of absolute paths during a recursive search, use [SetWorkingDir](SetWorkingDir.htm) to change to the base folder prior to the loop, and then omit the path from the Loop (e.g. `Loop, *.*, 0, 1`). That will cause [A\_LoopFileFullPath](#LoopFileFullPath) to contain the file's path relative to the base folder.

A file-loop can disrupt itself if it creates or renames files or folders within its own purview. For example, if it renames files via [FileMove](FileMove.htm) or other means, each such file might be found twice: once as its old name and again as its new name. To work around this, rename the files only after creating a list of them. For example:

```
FileList := ""
Loop, Files, *.jpg
    FileList .= A_LoopFileName "`n"
Loop, Parse, FileList, `n
    FileMove, %A_LoopField%, renamed_%A_LoopField%
```

Files in an NTFS file system are probably always retrieved in alphabetical order. Files in other file systems are retrieved in no particular order. To ensure a particular ordering, use the [Sort](Sort.htm) command as shown in the Examples section below.

File patterns longer than 259 characters are supported only by Unicode versions of AutoHotkey [v1.1.31+], and only when at least one of the following is true:

- The system has[long path support](../misc/LongPaths.htm) enabled (requires Windows 10 version 1607 or later).
- The`\\?\` [long path prefix](../misc/LongPaths.htm#prefix) is used (caveats apply).

In all other cases, file patterns longer than 259 characters will not find any files or folders. This limit applies both to _FilePattern_ and any temporary pattern used during recursion into a subfolder. However, the combined length of each file's directory and filename can exceed 259 characters in [v1.1.31+]; on earlier versions such files are skipped over as though they do not exist.

See [Loop](Loop.htm) for information about [Blocks](Block.htm), [Break](Break.htm), [Continue](Continue.htm), and the A\_Index variable (which exists in every type of loop).

## Related

[Loop](Loop.htm), [Break](Break.htm), [Continue](Continue.htm), [Blocks](Block.htm), [SplitPath](SplitPath.htm), [FileSetAttrib](FileSetAttrib.htm), [FileSetTime](FileSetTime.htm)

## Examples

Reports the full path of each text file located in a directory and in its subdirectories.

```
Loop Files, %A_ProgramFiles%\*.txt, R  <em>; Recurse into subfolders.</em>
{
    MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
    IfMsgBox, No
        break
}
```

Calculates the size of a folder, including the files in all its subfolders.

```
SetBatchLines, -1  <em>; Make the operation run at maximum speed.</em>
FolderSizeKB := 0
FileSelectFolder, WhichFolder  <em>; Ask the user to pick a folder.</em>
Loop, Files, %WhichFolder%\*.*, R
    FolderSizeKB += A_LoopFileSizeKB
MsgBox Size of %WhichFolder% is %FolderSizeKB% KB.
```

Retrieves file names sorted by name (see next example to sort by date).

```
FileList := ""  <em>; Initialize to be blank.</em>
Loop, C:\*.*
    FileList .= A_LoopFileName "`n"
Sort, FileList, R  <em>; The R option sorts in reverse order. See <a href="Sort.htm" data-index="33">Sort</a> for other options.</em>
Loop, parse, FileList, `n
{
    if (A_LoopField = "")  <em>; Ignore the blank item at the end of the list.</em>
        continue
    MsgBox, 4,, File number %A_Index% is %A_LoopField%.  Continue?
    IfMsgBox, No
        break
}
```

Retrieves file names sorted by modification date.

```
FileList := ""
Loop, Files, %A_MyDocuments%\Photos\*.*, FD  <em>; Include Files and Directories</em>
    FileList .= A_LoopFileTimeModified "`t" A_LoopFileName "`n"
Sort, FileList  <em>; Sort by date.</em>
Loop, Parse, FileList, `n
{
    if (A_LoopField = "")  <em>; Omit the last linefeed (blank item) at the end of the list.</em>
        continue
    StringSplit, FileItem, A_LoopField, %A_Tab%  <em>; Split into two parts at the tab char.</em>
    MsgBox, 4,, The next file (modified at %FileItem1%) is:`n%FileItem2%`n`nContinue?
    IfMsgBox, No
        break
}
```

Copies only the source files that are newer than their counterparts in the destination.

```
CopyIfNewer:
<em>; Caller has set the variables CopySourcePattern and CopyDest for us.</em>
Loop, Files, %CopySourcePattern%
{
    copy_it := false
    if not FileExist(CopyDest "\" A_LoopFileName)  <em>; Always copy if target file doesn't yet exist.</em>
        copy_it := true
    else
    {
        FileGetTime, time, %CopyDest%\%A_LoopFileName%
        EnvSub, time, %A_LoopFileTimeModified%, seconds  <em>; Subtract the source file's time from the destination's.</em>
        if (time < 0)  <em>; Source file is newer than destination file.</em>
            copy_it := true
    }
    if copy_it
    {
        FileCopy, %A_LoopFileFullPath%, %CopyDest%\%A_LoopFileName%, 1   <em>; Copy with overwrite=yes</em>
        if ErrorLevel
            MsgBox, Could not copy "%A_LoopFileFullPath%" to "%CopyDest%\%A_LoopFileName%".
    }
}
Return
```

Converts filenames passed in via command-line parameters to long names, complete path, and correct uppercase/lowercase characters as stored in the file system.

```
Loop %0%  <em>; For each file dropped onto the script (or passed as a parameter).</em>
{
    GivenPath := %A_Index%  <em>; Retrieve the next command line parameter.</em>
    Loop %GivenPath%, 1
        LongPath := A_LoopFileLongPath
    MsgBox The case-corrected long path name of file`n%GivenPath%`nis:`n%LongPath%
}
```

