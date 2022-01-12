# augenrules:(8) - a script that merges component audit rule files

Red Hat, Apr 2013

```
augenrules [--check]&nbsp;[--load]
```

<a name="description"></a>

# Description

**augenrules** is a script that merges all component audit rules files,
found in the audit rules directory, _/etc/audit/rules.d_, placing the
merged file in _/etc/audit/audit.rules_. Component audit rule files, must
end in _.rules_ in order to be processed. All other files in
_/etc/audit/rules.d_ are ignored.

The files are concatenated in order, based on their natural sort (see -v option of ls(1)) and stripped of empty and comment (#) lines.

The last processed -_D_ directive without an option, if present, is always
emitted as the first line in the resultant file. Those with an option are
replicated in place.
The last processed -_b_ directive, if present, is always
emitted as the second line in the resultant file.
The last processed -_f_ directive, if present, is always
emitted as the third line in the resultant file.
The last processed -_e_ directive, if present, is always
emitted as the last line in the resultant file.

The generated file is only copied to _/etc/audit/audit.rules_, if it differs.

<a name="options"></a>

# Options


* **--check**  
  test if rules have changed and need updating without overwriting audit.rules.
* **--load**  
  load old or newly built rules into the kernel.
  

<a name="files"></a>

# Files

/etc/audit/rules.d/
/etc/audit/audit.rules

<a name="see-also"></a>

# See Also

**audit.rules**(8),
**auditctl**(8),
**auditd**(8).
