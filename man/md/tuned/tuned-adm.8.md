# tuned_adm(8) - command line tool for switching between different tuning profiles

Fedora Power Management SIG, 30 Mar 2017

```
tuned-adm  [list | active | profile [profile]... | off | verify | recommend]
```


<a name="description"></a>

# Description

This command line utility allows you to switch between user definable tuning
profiles. Several predefined profiles are already included. You can even
create your own profile, either based on one of the existing ones by copying
it or make a completely new one. The distribution provided profiles are stored
in subdirectories below _/usr/lib/tuned_ and the user defined profiles in
subdirectories below _/etc/tuned_. If there are profiles with the same name
in both places, user defined profiles have precedence.


<a name="options"></a>

# Options


.SS

* **list**  
  List all available profiles.
  

**profiles**
List all available profiles.


**plugins**
List all available plugins.


**-v, --verbose**
List plugin's configuration options and their hints.


* **active**  
  Show current active profile.
  
* **profile **_[PROFILE_NAME]_**...**  
  Switches to the given profile. If more than one profile is given, the
  profiles are merged (in case of conflicting settings, the setting from
  the last profile is used) and the resulting profile is applied. If no
  profile is given, then all available profiles are listed. If the
  profile given is not valid, the command gracefully exits without
  performing any operation.
  
* **verify**  
  Verifies current profile against system settings. Outputs information whether
  system settings match current profile or not (e.g. somebody modified
  a sysfs/sysctl value by hand). Detailed information about what is checked, what
  value is set and what value is expected can be found in the log.
  
* **recommend**  
  Recommend a profile suitable for your system. Currently only static detection is
  implemented - it decides according to data in _/etc/system-release-cpe_
  and virt-what output. The rules for autodetection are defined in the file
  _/usr/lib/tuned/recommend.d/50-tuned.conf_. The default rules recommend profiles
  targeted to the best performance, or the balanced profile if unsure.
  
  The default rules can be overridden by the user by putting a file named
  _recommend.conf_ into /etc/tuned, or by creating a file in the
  _/etc/tuned/recommend.d_ directory. The file _/etc/tuned/recommend.conf_
  is evaluated first. If no match is found, the files in the
  _/etc/tuned/recommend.d_ directory are merged with the files in the
  _/usr/lib/tuned/recommend.d_ directory (if there is a file with the same
  name in both directories, the one from _/etc/tuned/recommend.d_ is used)
  and the files are evaluated in alphabetical order. The first matching
  entry is used.
  
* **off**  
  Unload tunings.
  

<a name="files"></a>

# Files

    /etc/tuned/*
    /usr/lib/tuned/*
    

<a name="see-also"></a>

# See Also

**tuned**(8)
**tuned.conf**(5)
**tuned-profiles**(7)
**tuned-profiles-atomic**(7)
**tuned-profiles-sap**(7)
**tuned-profiles-sap-hana**(7)
**tuned-profiles-oracle**(7)
**tuned-profiles-realtime**(7)
**tuned-profiles-nfv-host**(7)
**tuned-profiles-nfv-guest**(7)
**tuned-profiles-compat**(7)
**tuned-profiles-postgresql**(7)

<a name="author"></a>

# Author

    Jaroslav Škarvada <jskarvad@redhat.com>
    Jan Kaluža <jkaluza@redhat.com>
    Jan Včelák <jvcelak@redhat.com>
    Marcela Mašláňová <mmaslano@redhat.com>
    Phil Knirsch <pknirsch@redhat.com>
