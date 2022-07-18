# FileRecycleEmpty

Empties the recycle bin.

```
<span class="func">FileRecycleEmpty</span> <span class="optional">, DriveLetter</span>
```

## Parameters

DriveLetter

If omitted, the recycle bin for all drives is emptied. Otherwise, specify a drive letter such as C:\

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

This commands requires that MS Internet Explorer 4 or later be installed.

## Related

[FileRecycle](FileRecycle.htm), [FileDelete](FileDelete.htm), [FileCopy](FileCopy.htm), [FileMove](FileMove.htm)

## Examples

Empties the recycle bin of the C drive.

```
FileRecycleEmpty, C:\
```

