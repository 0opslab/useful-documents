# bdehdcfg: target



Prepares a partition for use as a system drive by BitLocker and Windows Recovery. By default, this partition is created without a drive letter. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
bdehdcfg -target {default|unallocated|<DriveLetter> shrink|<DriveLetter> merge}
```

### Parameters

|Parameter|Description|
|---------|-----------|
|default|Indicates that the command-line tool will follow the same process as the BitLocker setup wizard.|
|unallocated|Creates the system partition out of the unallocated space available on the disk.|
|\<DriveLetter> shrink|Reduces the drive specified by the amount necessary to create an active system partition. To use this command, the drive specified must have at least 5 percent free space.|
|\<DriveLetter> merge|Uses the drive specified as the active system partition. The operating system drive cannot be a target for merge.|

## <a name="BKMK_Examples"></a>Examples

The following example depicts using the **target** command to designate an existing drive (P) as the system drive.
```
bdehdcfg -target P: merge
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Bdehdcfg](bdehdcfg.md)