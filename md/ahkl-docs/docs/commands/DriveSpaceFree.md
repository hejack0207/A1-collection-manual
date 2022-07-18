# DriveSpaceFree

Retrieves the free disk space of a drive, in Megabytes.

```
<span class="func">DriveSpaceFree</span>, OutputVar, Path
```

## Parameters

OutputVar

The variable in which to store the result, which is rounded down to the nearest whole number.

Path

Path of drive to receive information from. Since NTFS supports mounted volumes and directory junctions, different amounts of free space might be available in different folders of the same "drive" in some cases.

## Remarks

_OutputVar_ is set to the amount of free disk space in Megabytes (rounded down to the nearest Megabyte).

## Related

[Drive](Drive.htm), [DriveGet](DriveGet.htm)

## Examples

Retrieves the free disk space of the C drive and stores it in _FreeSpace_.

```
DriveSpaceFree, FreeSpace, C:\
```

