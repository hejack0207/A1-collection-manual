# SplitPath

Separates a file name or URL into its name, directory, extension, and drive.

```
<span class="func">SplitPath</span>, InputVar <span class="optional">, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive</span>
```

## Parameters

InputVar

Name of the variable containing the file name to be analyzed.

[v1.1.21+]: This parameter can be an `% <a href="../Variables.htm#Expressions" data-index="1">expression</a>`, but the percent-space prefix must be used.

OutFileName

Name of the variable in which to store the file name without its path. The file's extension is included.

OutDir

Name of the variable in which to store the directory of the file, including drive letter or share name (if present). The final backslash is not included even if the file is located in a drive's root directory.

OutExtension

Name of the variable in which to store the file's extension (e.g. TXT, DOC, or EXE). The dot is not included.

OutNameNoExt

Name of the variable in which to store the file name without its path, dot and extension.

OutDrive

Name of the variable in which to store the drive letter or server name of the file. If the file is on a local or mapped drive, the variable will be set to the drive letter followed by a colon (no backslash). If the file is on a network path (UNC), the variable will be set to the share name, e.g. \\\Workstation01

## Remarks

Any of the output variables may be omitted if the corresponding information is not needed.

If _InputVar_ contains a filename that lacks a drive letter (that is, it has no path or merely a relative path), _OutDrive_ will be made blank but all the other output variables will be set correctly. Similarly, if there is no path present, _OutDir_ will be made blank; and if there is a path but no file name present, _OutFileName_ and _OutNameNoExt_ will be made blank.

Actual files and directories in the file system are not checked by this command. It simply analyzes the string given in _InputVar_.

Wildcards (\* and ?) and other characters illegal in filenames are treated the same as legal characters, with the exception of colon, backslash, and period (dot), which are processed according to their nature in delimiting the drive letter, directory, and extension of the file.

**Support for URLs**: If _InputVar_ contains a colon-double-slash, such as https://domain.com or ftp://domain.com, _OutDir_ is set to the protocol prefix + domain name + directory (e.g. https://domain.com/images) and _OutDrive_ is set to the protocol prefix + domain name (e.g. https://domain.com). All other variables are set according to their definitions above.

## Related

[A\_LoopFileExt](LoopFile.htm#LoopFileExt), [StrSplit()](StrSplit.htm), [StringGetPos](StringGetPos.htm), [StringMid](StringMid.htm), [StringTrimLeft](StringTrimLeft.htm), [StringLeft](StringLeft.htm), [FileSelectFile](FileSelectFile.htm), [FileSelectFolder](FileSelectFolder.htm), [StringSplit](StringSplit.htm)

## Examples

Demonstrates different usages.

```
FullFileName := "C:\My Documents\Address List.txt"

<em>; To fetch only the bare filename from the above:</em>
SplitPath, FullFileName, name

<em>; To fetch only its directory:</em>
SplitPath, FullFileName,, dir

<em>; To fetch all info:</em>
SplitPath, FullFileName, name, dir, ext, name_no_ext, drive

<em>; The above will set the variables as follows:
; name = Address List.txt
; dir = C:\My Documents
; ext = txt
; name_no_ext = Address List
; drive = C:</em>
```

