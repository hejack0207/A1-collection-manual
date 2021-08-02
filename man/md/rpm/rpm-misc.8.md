# rpm misc options(8)


<a name="name-rpm-lesser-need-options-for-rpm8"></a>

# Name Rpm \- Lesser Need Options for Rpm(8)



<a name="options"></a>

# Options


* **--predefine**='MACRO EXPR**'**  
  Defines _MACRO_ with value _EXPR_. before loading macro files.
  

<a name="switching-off-features"></a>

# Switching off Features


* **--color [never|auto|always]**  
  Use terminal colors for highlighting error and debug message. Default is  turning colors on for ttys only (**auto**).
*   
  **--nocontexts**
  Disable the SELinux plugin if available. This stops the plugin from setting SELinux contexts for files and scriptlets.
* **--noglob**  
  Do not glob arguments when installing package files.
* **--nocaps**  
  Don't verify capabilities of files.
* **--excludeconfigs, --noconfigs**  
  Do not install configuration files.
* **--nohdrchk**  
  Don't verify database header(s) when retrieved.
  

<a name="debugging"></a>

# Debugging



* **-d, --debug**  
  Print debugging information.
* **--deploops**  
  Print dependency loops as warning.
* **--fsmdebug**  
  Print debuging information of payload handling code.
* **--rpmfcdebug**  
  Print debug information about files packaged.
* **--rpmiodebug**  
  Print debug information about file IO.
* **--stats**  
  Print runtime statistics of often used functions. 
  

<a name="obsolete-options"></a>

# Obsolete Options


* **-K, --checksig**  
  See and use rpmkeys(8).
* **--nodocs**  
  Do not install documentation.
  Use **--excludedocs** instead.
* **--promoteepoch**  
  Enable obsolete epoch handling used in rpm 3.x time frame.
* **--prtpkts**  
  OBSOLETE! Used to print the packages containing and representing the pgp keys for debugging purposes.
