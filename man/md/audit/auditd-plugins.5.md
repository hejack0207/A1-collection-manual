# audit-plugins:(8) - realtime event receivers

Red Hat, Aug 2018


<a name="description"></a>

# Description

**auditd** can multiplex audit events in realtime. It takes audit events and distributes them to child programs that want to analyze events in realtime. When the audit daemon receives a SIGTERM or SIGHUP, it passes that signal to its child processes so that can reload the configuration or terminate.

The child programs install a configuration file in a plugins directory which defaults to _/etc/audit/plugins.d_. This can be controlled by a auditd.conf config option
**plugin_dir**
if the admin wished to locate plugins somewhere else. But auditd will install its plugins in the default location.

The plugin directory will be scanned and every pluging that is active will be started. If the plugin has a problem and exits, it will be started a maximum of
**max_restarts**
times as found in auditd.conf.

Config file names are not allowed to have more than one '.' in the name or it will be treated as a backup copy and skipped. Config file options are given one per line with an equal sign between the keyword and its value. The available options are as follows:


* _active_  
  The options for this are 
  _yes_
  or
  _no._
* _direction_  
  The option is dictated by the plugin.
  _In_
  or
  _out_
  are the only choices. You cannot make a plugin operate in a way it wasn't designed just by changing this option. This option is to give a clue to the event dispatcher about which direction events flow. NOTE: inbound events are not supported yet.
* _path_  
  This is the absolute path to the plugin executable. In the case of internal plugins, it would be the name of the plugin.
* _type_  
  This tells the dispatcher how the plugin wants to be run. Choices are
  _builtin_
  and
  _always._
  _Builtin_
  should always be given for plugins that are internal to the audit event dispatcher. These are af_unix and syslog. The option
  _always_
  should be given for most if not all plugins. The default setting is
  _always._
* _args_  
  This allows you to pass arguments to the child program. Generally plugins do not take arguments and have their own config file that instructs them how they should be configured. At the moment, there is a limit of 2 args.
* _format_  
  The valid options for this are
  _binary_
  and
  _string._
  _Binary_
  passes the data exactly as the audit event dispatcher gets it from the audit daemon. The
  _string_
  option tells the dispatcher to completely change the event into a string suitable for parsing with the audit parsing library. The default value is
  _string._
   

<a name="files"></a>

# Files

/etc/auditd/auditd.conf
/etc/audit/plugins.d

<a name="see-also"></a>

# See Also

**auditd.conf**(5),
**auditd**(8).

<a name="author"></a>

# Author

Steve Grubb
