# genl(8) - generic netlink utility frontend

iproute2, 29 Oct 2015

```
.in +8 .ti -8 genl [ -s[tatistics] ] [ -d[etails] ] [ -r[aw] ] OBJECT
</synopsis>

<synopsis>
.ti -8 genl { -V[ersion] | -h[elp] }
</synopsis>

<synopsis>
.ti -8 OBJECT := {  ctrl CTRL_OPTS }
</synopsis>

<synopsis>
.ti -8 CTRL_OPTS := {  help | list | monitor | get PARMS }
</synopsis>

<synopsis>
.ti -8 PARMS := {  name NAME |  id ID }
```

<a name="description"></a>

# Description

The
**genl**
utility provides a simple frontend to the generic netlink library. Although it's
designed to support multiple
_OBJECT_s,
for now only the
**ctrl**
object is available, which is used to query the generic netlink controller.

<a name="ctrl"></a>

### ctrl

The generic netlink controller can be queried in various ways:

* **help**  
  This command just prints a help text for the
  **ctrl**
  object.
* **list**  
  Show the registered netlink users.
* **monitor**  
  Listen for generic netlink notifications.
* **get**  
  Query the controller for a given user, identified either by
  **name** or **id**.

<a name="options"></a>

# Options

genl supports the following options.

* **-h, -help**  
  Show summary of options.
* **-V, -Version**  
  Show version of program.
* **-s, -stats, -statistics**  
  Show object statistics.
* **-d, -details**  
  Show object details.
* **-r, -raw**  
  Dump raw output only.

<a name="see-also"></a>

# See Also

**ip**(8)  

<a name="author"></a>

# Author

genl was written by Jamal Hadi Salim &lt;[hadi@cyberus.ca](mailto:hadi@cyberus.ca)&gt;.

This manual page was written by Petr Sabata &lt;[contyk@redhat.com](mailto:contyk@redhat.com)&gt;.
