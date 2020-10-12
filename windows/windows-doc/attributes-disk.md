# attributes disk



Displays, sets, or clears the attributes of a disk.

> [!IMPORTANT]
> This parameter is not available in any edition of Windows Vista.

## Syntax

```
attributes disk [{set | clear}] [readonly] [noerr]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|set|Sets the specified attribute of the disk with focus.|
|clear|Clears the specified attribute of the disk with focus.|
|readonly|Specifies that the disk is read-only.|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

-   When **attributes disk** is used to display the current attributes of a disk, the startup disk attribute denotes the disk that is used to start the computer. For a dynamic mirror, it is displayed for the disk that contains the boot plex of the boot volume.
-   A disk must be selected for the **attributes disk** command to succeed. Use the **select disk** command to select a disk and shift the focus to it.

## <a name="BKMK_examples"></a>Examples

To view the attributes of the selected disk, type:
```
attributes disk
```
To set the selected disk as read-only, type:
```
attributes disk set readonly
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
