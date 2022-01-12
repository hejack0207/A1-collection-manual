# aureport:(8) - a tool that produces summary reports of audit daemon logs

Red Hat, March 2017

```
aureport [options]
```

<a name="description"></a>

# Description

**aureport** is a tool that produces summary reports of the audit system logs. The aureport utility can also take input from stdin as long as the input is the raw log data. The reports have a column label at the top to help with interpretation of the various fields. Except for the main summary report, all reports have the audit event number. You can subsequently lookup the full event with ausearch **-a** _event number_. You may need to specify start & stop times if you get multiple hits. The reports produced by aureport can be used as building blocks for more complicated analysis.


<a name="options"></a>

# Options


* **-au**,&nbsp;**--auth**  
  Report about authentication attempts
* **-a**,&nbsp;**--avc**  
  Report about avc messages
* **--comm**  
  Report about commands run
* **-c**,&nbsp;**--config**  
  Report about config changes
* **-cr**,&nbsp;**--crypto**  
  Report about crypto events
* **-e**,&nbsp;**--event**  
  Report about events
* **--escape**&nbsp;_option_  
  This option determines if the output is escaped to make the content safer for certain uses. The options are _raw_ , _tty_ , _shell_ , and _shell\_quote_. Each mode includes the characters of the preceding mode and escapes more characters. That is to say _shell_ includes all characters escaped by _tty_ and adds more. _tty_ is the default.
* **-f**,&nbsp;**--file**  
  Report about files and af_unix sockets
* **--failed**  
  Only select failed events for processing in the reports. The default is both success and failed events.
* **-h**,&nbsp;**--host**  
  Report about hosts
* **--help**  
  Print brief command summary
* **-i**,&nbsp;**--interpret**  
  Interpret  numeric  entities into text. For example, uid is converted to account name. The conversion is done using the current resources  of  the machine where the search is being run. If you have renamed the accounts, or don't have the  same  accounts  on your machine, you could get misleading results.
* **-if**,&nbsp;**--input**&nbsp;_file_&nbsp;|&nbsp;_directory_  
  Use the given _file_ or _directory_ instead of the logs. This is to aid analysis where the logs have been moved to another machine or only part of a log was saved.
* **--input-logs**  
  Use the log file location from auditd.conf as input for analysis. This is needed if you are using aureport from a cron job.
* **--integrity**  
  Report about integrity events
* **-k**,&nbsp;**--key**  
  Report about audit rule keys
* **-l**,&nbsp;**--login**  
  Report about logins
* **-m**,&nbsp;**--mods**  
  Report about account modifications
* **-ma**,&nbsp;**--mac**  
  Report about Mandatory Access Control (MAC) events
* **-n**,&nbsp;**--anomaly**  
  Report about anomaly events. These events include NIC going into promiscuous mode and programs segfaulting.
* **--node**&nbsp;_node-name_  
  Only select events originating from _node name_ string for processing in the reports. The default is to include all nodes. Multiple nodes are allowed.
* **-nc**,&nbsp;**--no-config**  
  Do not include the CONFIG_CHANGE event. This is particularly useful for the key report because audit rules have key labels in many cases. Using this option gets rid of these false positives.
* **-p**,&nbsp;**--pid**  
  Report about processes
* **-r**,&nbsp;**--response**  
  Report about responses to anomaly events
* **-s**,&nbsp;**--syscall**  
  Report about syscalls
* **--success**  
  Only select successful events for processing in the reports. The default is both success and failed events.
* **--summary**  
  Run the summary report that gives a total of the elements of the main report. Not all reports have a summary.
* **-t**,&nbsp;**--log**  
  This option will output a report of the start and end times for each log.
* **--tty**  
  Report about tty keystrokes
* **-te**,&nbsp;**--end**&nbsp;[_end-date_]&nbsp;[_end-time_]  
  Search for events with time stamps equal to or before the given end time. The format of end time depends on your locale. If the date is omitted,
  **today**
  is assumed. If the time is omitted, 
  **now**
  is assumed. Use 24 hour clock time rather than AM or PM to specify time. An example date using the en_US.utf8 locale is 09/03/2009. An example of time is 18:00:00. The date format accepted is influenced by the LC_TIME environmental variable.
  
  You may also use the word: **now**, **recent**, **boot**, **today**, **yesterday**, **this-week**, **week-ago**, **this-month**, **this-year**. **Now** means starting now. **Recent** is 10 minutes ago. **Boot** means the time of day to the second when the system last booted. **Today** means now. **Yesterday** is 1 second after midnight the previous day. **This-week** means starting 1 second after midnight on day 0 of the week determined by your locale (see **localtime**). **Week-ago** means 1 second after midnight exactly 7 days ago. **This-month** means 1 second after midnight on day 1 of the month. **This-year** means the 1 second after midnight on the first day of the first month.
* **-tm**,&nbsp;**--terminal**  
  Report about terminals
* **-ts**,&nbsp;**--start**&nbsp;[_start-date_]&nbsp;[_start-time_]  
  Search for events with time stamps equal to or after the given end time. The format of end time depends on your locale. If the date is omitted, 
  **today**
  is assumed. If the time is omitted, 
  **midnight**
  is assumed. Use 24 hour clock time rather than AM or PM to specify time. An example date using the en_US.utf8 locale is 09/03/2009. An example of time is 18:00:00. The date format accepted is influenced by the LC_TIME environmental variable.
  
  You may also use the word: **now**, **recent**, **boot**, **today**, **yesterday**, **this-week**, **week-ago**, **this-month**, **this-year**. **Boot** means the time of day to the second when the system last booted. **Today** means starting at 1 second after midnight. **Recent** is 10 minutes ago. **Yesterday** is 1 second after midnight the previous day. **This-week** means starting 1 second after midnight on day 0 of the week determined by your locale (see **localtime**). **Week-ago** means starting 1 second after midnight exactly 7 days ago. **This-month** means 1 second after midnight on day 1 of the month. **This-year** means the 1 second after midnight on the first day of the first month.
* **-u**,&nbsp;**--user**  
  Report about users
* **-v**,&nbsp;**--version**  
  Print the version and exit
* **--virt**  
  Report about Virtualization events
* **-x**,&nbsp;**--executable**  
  Report about executables
  

<a name="note"></a>

# Note

The boot time option is a convenience function and has limitations. The time it calculates is based on time now minus /proc/uptime. If after boot the system clock has been adjusted, perhaps by ntp, then the calculation may be wrong. In that case you'll need to fully specify the time. You can check the time it would use by running:

date -d "\`cut -f1 -d. /proc/uptime\` seconds ago"


<a name="see-also"></a>

# See Also

**ausearch**(8),
**auditd**(8).
