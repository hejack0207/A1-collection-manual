# alsa-info.sh(1) - command\-line utility to gather information about

13 January 2016

the ALSA subsystem

<a name="synopsis"></a>

# Synopsis

```
alsa-info.sh [options]
```


<a name="description"></a>

# Description

**alsa-info.sh** is a command-line utility gathering information
about the ALSA subsystem. It is used mostly for debugging purposes.


<a name="options"></a>

# Options


* _--upload_  
  Upload contents to the server (www.alsa-project.org or pastebin.ca).
* _--no-upload_  
  Do not upload contents to the remote server.
* _--stdout_  
  Print information to standard output.
* _--output FILE_  
  Specify file for output in no-upload mode.
* _--debug_  
  Run utility as normal, but will not delete file (usually
  /tmp/alsa-info.txt).
* _--with-aplay_  
  Includes output from _aplay -l_.
* _--with-amixer_  
  Includes output from _amixer_.
* _--with-alsactl_  
  Includes output from _alsactl_.
* _--with-configs_  
  Includes output from ~/.asoundrc and /etc/asound.conf if they exist.
* _--update_  
  Check server for updates.
* _--about_  
  Print information about authors.
  

<a name="examples"></a>

# Examples



* **alsa-info.sh --no-upload**  
  Will gather all information and show the output file.
  

<a name="see-also"></a>

# See Also


aplay(1)
amixer(1)
alsactl(1)



<a name="author"></a>

# Author

**alsa-info.sh** was created by the ALSA team, see _--about_ .
