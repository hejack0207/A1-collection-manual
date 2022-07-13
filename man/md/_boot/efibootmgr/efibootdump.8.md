# efibootdump(8) - dump a boot entries from a variable or a file

"", 24 February 2016

```
efibootdump [-?|--help] [--usage]
	[-f <file1> [... -f <fileN>]]
	[[-g {guid}] <name0> [... [<nameN>]]]
```

<a name="description"></a>

# Description


**efibootdump** is a userspace application used to display individual UEFI boot options, from a file or a UEFI variable.  This allows e.g. saved files from efivarfs to be displayed, as well as variables on the running machine.


<a name="options"></a>

# Options

The following is a list of options accepted by efibootmgr:

* **-g | --guid** _{guid}_  
  Any variables specified by name have the specified GUID.
* **-f | --file** _&lt;file&gt;_  
  Read a single boot variable from the specified file.
* _&lt;nameN&gt;_  
  Display the specified variable on the local machine.  If no GUID is specified, EFI Global Variable is the default.

<a name="bugs"></a>

# Bugs


Please direct any bugs, features, patches, etc. to the Red Hat bootloader team at https://github.com/rhboot/efibootmgr .

<a name="see-also"></a>

# See Also


efibootmgr(8)
