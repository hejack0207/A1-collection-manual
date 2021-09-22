# aulastlog:(8) - a program similar to lastlog

Red Hat, June 2016

```
aulastlog [ options ]
```

<a name="description"></a>

# Description

**aulastlog** is a program that prints out the last login for all users of the **local** machine similar to the way lastlog does. The login-name, port, and last login time will be printed.

If the user has never logged in, the message **** Never logged in**** will be displayed instead of the port and time.


<a name="options"></a>

# Options


* **-u, --user**  
  Print the lastlog record for user with specified LOGIN only.
* **--stdin**  
  Use stdin as the source of audit records. The audit events must be in the raw format.

<a name="see-also"></a>

# See Also

**lastlog**(8),
**ausearch**(8),
**aureport**(8).


<a name="author"></a>

# Author

Steve Grubb
