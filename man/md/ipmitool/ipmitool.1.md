# ipmitool(1) - utility for controlling IPMI\-enabled devices

Duncan Laurie, ""

```
ipmitool [ <options> ] <command> [ <sub-commands and sub-options> ]
</synopsis>

<synopsis>
<options>           := [ <general-options> | <conditional-opts> ]
Any recognized option is accepted. Conditional options may be ignored or it's usage postponed until shell or exec processes relevant command.

</synopsis>

<synopsis>
<general-options>   := [ -h | -V | -v | -I <interface> | -H <address> |                          -d <N> | -p <port> | -c | -U <username> |                          -L <privlvl> | -l <lun> | -m <local_address> |                          -N <sec> | -R <count> | <password-option> |                          <oem-option> | <bridge-options> ]
</synopsis>

<synopsis>
<conditional-opts>  := [ <lan-options> | <lanplus-options> |                          <command-options> ]
Bridging:
<bridge-options>    := -t <target_address> [ -b <channel> |                        [ -T <address> | -B <channel> ] ]

</synopsis>

<synopsis>
Options used with -I lan:
<lan-options>       := [ -A <authtype> ]

</synopsis>

<synopsis>
Options used with -I lanplus:
<lanplus-options>   := [ -C <ciphersuite> | <key-option> ]

</synopsis>

<synopsis>
Option groups setting same value:
<key-option>        := [ -k <key> | -K | -y <hex_key> | -Y ]
<password-option>   := [ -f <password_file> | -a | -P <password> | -E ]
<oem-option>        := [ -o <oemtype> | -g | -s ]

</synopsis>

<synopsis>
Options used with specific command <command-options>:
<options-sdr>       := [ -S <sdr_cache_file> ]
<options-sel>       := [ -O <sel_oem> ]
<options-sol>       := [ -e <sol_escape_char> ]
```



<a name="description"></a>

# Description

This program lets you manage Intelligent Platform Management Interface 
(IPMI) functions of either the local system, via a kernel device driver,
or a remote system, using IPMI v1.5 and IPMI v2.0. These functions include
printing FRU information, LAN configuration, sensor readings, and remote
chassis power control.

IPMI management of a local system interface requires a compatible IPMI
kernel driver to be installed and configured.  On Linux this driver is
called _OpenIPMI_ and it is included in standard distributions.
On Solaris this driver is called _BMC_ and is included in Solaris 10.
Management of a remote station requires the IPMI-over-LAN interface to be
enabled and configured.  Depending on the particular requirements of each
system it may be possible to enable the LAN interface using ipmitool over
the system interface.

<a name="options"></a>

# Options


* **-a**  
  Prompt for the remote server password.
* **-A** &lt;_authtype_&gt;  
  Specify an authentication type to use during IPMIv1.5 _lan_
  session activation.  Supported types are NONE, PASSWORD, MD2, MD5, or OEM.
* **-b** &lt;_channel_&gt;  
  Set destination channel for bridged request.
* **-B** &lt;_channel_&gt;  
  Set transit channel for bridged request (dual bridge).
* **-b** &lt;_channel_&gt;  
  Set destination channel for bridged request.
* **-B** &lt;_channel_&gt;  
  Set transit channel for bridged request. (dual bridge)
* **-c**  
  Present output in CSV (comma separated variable) format.  
  This is not available with all commands.
* **-C** &lt;_ciphersuite_&gt;  
  The remote server authentication, integrity, and encryption algorithms
  to use for IPMIv2.0 _lanplus_ connections.  See table 22-19 in the
  IPMIv2.0 specification.  The default is 3 which specifies RAKP-HMAC-SHA1 
  authentication, HMAC-SHA1-96 integrity, and AES-CBC-128 encryption algorithms.
* **-d N**  
  Use device number N to specify the /dev/ipmiN (or 
  /dev/ipmi/N or /dev/ipmidev/N) device to use for in-band 
  BMC communication.  Used to target a specific BMC on a 
  multi-node, multi-BMC system through the ipmi device 
  driver interface.  Default is 0.
* **-e** &lt;_sol\_escape\_char_&gt;  
  Use supplied character for SOL session escape character.  The default
  is to use _~_ but this can conflict with ssh sessions.
* **-E**  
  The remote server password is specified by the environment
  variable _IPMI\_PASSWORD_ or _IPMITOOL\_PASSWORD_. The _IPMITOOL\_PASSWORD_ takes precedence.
* **-f** &lt;_password\_file_&gt;  
  Specifies a file containing the remote server password. If this
  option is absent, or if password_file is empty, the password
  will default to NULL.
* **-g**  
  Deprecated. Use: -o intelplus
* **-h**  
  Get basic usage help from the command line.
* **-H** &lt;_address_&gt;  
  Remote server address, can be IP address or hostname.  This 
  option is required for _lan_ and _lanplus_ interfaces.
* **-I** &lt;_interface_&gt;  
  Selects IPMI interface to use.  Supported interfaces that are
  compiled in are visible in the usage help output.
* **-k** &lt;_key_&gt;  
  Use supplied Kg key for IPMIv2.0 authentication.  The default is not to
  use any Kg key.
* **-K**  
  Read Kg key from IPMI_KGKEY environment variable.
* **-l** &lt;_lun_&gt;  
  Set destination lun for raw commands.
* **-L** &lt;_privlvl_&gt;  
  Force session privilege level.  Can be CALLBACK, USER,
  OPERATOR, ADMINISTRATOR. Default is ADMINISTRATOR.
  This value is ignored and always set to ADMINISTRATOR when
  combined with _-t target address_.
* **-m** &lt;_local\_address_&gt;  
  Set the local IPMB address.  The local address defaults to 0x20
  or is auto discovered on PICMG platforms when -m is not specified.
  There should be no need to change the local address for normal operation.
* **-N** &lt;_sec_&gt;  
  Specify nr. of seconds between retransmissions of lan/lanplus messages.
  Defaults are 2 seconds for lan and 1 second for lanplus interfaces.
  Command _raw_ uses fixed value of 15 seconds.
  Command _sol_ uses fixed value of 1 second.
* **-o** &lt;_oemtype_&gt;  
  Select OEM type to support.  This usually involves minor hacks
  in place in the code to work around quirks in various BMCs from
  various manufacturers.  Use _-o list_ to see a list of
  current supported OEM types.
* **-O** &lt;_sel oem_&gt;  
  Open selected file and read OEM SEL event descriptions to be used
  during SEL listings.  See examples in contrib dir for file format.
* **-p** &lt;_port_&gt;  
  Remote server UDP port to connect to.  Default is 623.
* **-P** &lt;_password_&gt;  
  Remote server password is specified on the command line.
  If supported it will be obscured in the process list. 
  **Note!** Specifying the password as a command line
  option is not recommended.
* **-R** &lt;_count_&gt;  
  Set the number of retries for lan/lanplus interface (default=4).
  Command _raw_ uses fixed value of one try (no retries).
  Command _hpm_ uses fixed value of 10 retries.
* **-s**  
  Deprecated. Use: -o supermicro
* **-S** &lt;_sdr\_cache\_file_&gt;  
  Use local file for remote SDR cache.  Using a local SDR cache
  can drastically increase performance for commands that require
  knowledge of the entire SDR to perform their function.  Local
  SDR cache from a remote system can be created with the
  _sdr dump_ command.
* **-t** &lt;_target\_address_&gt;  
  Bridge IPMI requests to the remote target address. Default is 32.
  The _-L privlvl_ option is always ignored and value set to ADMINISTRATOR.
* **-T** &lt;_address_&gt;  
  Set transit address for bridge request (dual bridge).
* **-T** &lt;_transmit\_address_&gt;  
  Set transit address for bridge request. (dual bridge)
* **-U** &lt;_username_&gt;  
  Remote server username, default is NULL user.
* **-v**  
  Increase verbose output level.  This option may be specified
  multiple times to increase the level of debug output.  If given
  three times you will get hexdumps of all incoming and
  outgoing packets. Using it five times provides details
  on request and expected reply procesing. The _hpm_ commands
  _targetcap_ _compprop_ _abort_ _upgstatus_
  _rollback_ _rollbackstatus_ _selftestresult_ increases
  the verbosity level
* **-V**  
  Display version information.
* **-y** &lt;_hex key_&gt;  
  Use supplied Kg key for IPMIv2.0 authentication. The key is expected in
  hexadecimal format and can be used to specify keys with non-printable
  characters. E.g. '-k PASSWORD' and '-y 50415353574F5244' are
  equivalent.
  The default is not to use any Kg key.
* **-Y**  
  Prompt for the Kg key for IPMIv2.0 authentication.
* **-z** &lt;_size_&gt;  
  Change Size of Communication Channel. (OEM)
  

If no password method is specified then ipmitool will prompt the
user for a password. If no password is entered at the prompt,
the remote server password will default to NULL.

<a name="security"></a>

# Security

There are several security issues be be considered before enabling the
IPMI LAN interface. A remote station has the ability to control a system's power 
state as well as being able to gather certain platform information. To reduce 
vulnerability it is strongly advised that the IPMI LAN interface only be 
enabled in 'trusted' environments where system security is not an issue or 
where there is a dedicated secure 'management network'.

Further it is strongly advised that you should not enable IPMI for
remote access without setting a password, and that that password should
not be the same as any other password on that system.

When an IPMI password is changed on a remote machine with the IPMIv1.5
_lan_ interface the new password is sent across the network
as clear text.  This could be observed and then used to attack the remote
system.  It is thus recommended that IPMI password management only be done
over IPMIv2.0 _lanplus_ interface or the system interface on the
local station.

For IPMI v1.5, the maximum password length is 16 characters.
Passwords longer than 16 characters will be truncated.

For IPMI v2.0, the maximum password length is 20 characters;
longer passwords are truncated.

<a name="commands"></a>

# Commands


* _help_  
  This can be used to get command-line help  on  ipmitool
  commands.  It may also be placed at the end of commands
  to get option usage help.
  
  ipmitool help  
  Commands:
          bmc          Deprecated. Use mc
          channel      Configure Management Controller channels
          chassis      Get chassis status and set power state
          dcmi         Data Center Management Interface
          delloem      Manage Dell OEM Extensions.
          echo         Used to echo lines to stdout in scripts
          ekanalyzer   run FRU-Ekeying analyzer using FRU files
          event        Send events to MC
          exec         Run list of commands from file
          firewall     Configure Firmware Firewall
          fru          Print built-in FRU and scan for FRU locators
          fwum         Update IPMC using Kontron OEM Firmware Update Manager
          gendev       Read/Write Device associated with Generic Device locators sdr
          hpm          Update HPM components using PICMG HPM.1 file
          i2c          Send an I2C Master Write-Read command and print response
          ime          Upgrade/Query Intel ME firmware
          isol         Configure and connect Intel IPMIv1.5 Serial-over-LAN
          kontronoem   Manage Kontron OEM Extensions
          lan          Configure LAN Channels
          mc           Management Controller status and global enables
          nm           Node Manager
          pef          Configure Platform Event Filtering (PEF)
          picmg        Run a PICMG/ATA extended command
          power        Shortcut to chassis power commands
          raw          Send a RAW IPMI request and print response
          sdr          Print Sensor Data Repository entries and readings
          sel          Print System Event Log (SEL)
          sensor       Print detailed sensor information
          session      Print session information
          set          Set runtime variable for shell and exec
          shell        Launch interactive IPMI shell
          sol          Configure and connect IPMIv2.0 Serial-over-LAN
          spd          Print SPD info from remote I2C device
          sunoem       Manage Sun OEM Extensions
          tsol         Configure and connect Tyan IPMIv1.5 Serial-over-LAN
          user         Configure Management Controller users
  
* _channel_  
    * _authcap_ &lt;**channel number**&gt; &lt;**max priv**&gt;  
      
      Displays information about the authentication capabilities of
      the selected channel at the specified privilege level.
        * Possible privilege levels are:    
          _1_   Callback level  
          _2_   User level  
          _3_   Operator level  
          _4_   Administrator level  
          _5_   OEM Proprietary level  
          _15_   No access
    * _info_ [**channel number**]  
      
      Displays  information  about  the selected  channel.  If no channel 
      is given it will display information about the currently used channel.

&gt; ipmitool channel info  
Channel 0xf info:  
  Channel Medium Type   : System Interface  
  Channel Protocol Type : KCS  
  Session Support       : session-less  
  Active Session Count  : 0  
  Protocol Vendor ID    : 7154

* _getaccess_ &lt;**channel number**&gt; [&lt;**userid**&gt;]  
      
      Configure the given userid as the default on the given channel number.  
      When the given channel is subsequently used, the user is identified 
      implicitly by the given userid.
    * _setaccess_ &lt;**channel number**&gt; &lt;**userid**&gt; [&lt;_callin_=**on**|**off**&gt;]  
      [&lt;_ipmi_=**on**|**off**&gt;] [&lt;_link_=**on**|**off**&gt;] [&lt;_privilege_=**level**&gt;]  
      
      Configure user access information on the given channel for the given userid.
    * _getciphers_ &lt;_ipmi_|_sol_&gt; [&lt;**channel**&gt;]    
      
      Displays the list of cipher suites supported for the given
      application (ipmi or sol) on the given channel.
    * _setkg_ &lt;_hex_|_plain_&gt; &lt;**key**&gt; [&lt;**channel**&gt;]    
      
      Sets K_g key to given value. Use _plain_ to specify **key** as simple ASCII string.
      Use _hex_ to specify **key** as sequence of hexadecimal codes of ASCII charactes.
      I.e. following two examples are equivalent:
      
          ipmitool channel setkg plain PASSWORD
          
          ipmitool channel setkg hex 50415353574F5244
      

* _chassis_  
    * _status_  
      
      Status information related to power, buttons, cooling, drives and faults.
    * _power_  
        * _status_  
        * _on_  
        * _off_  
        * _cycle_  
        * _reset_  
        * _diag_  
        * _soft_  
    * _identify_ [&lt;seconds&gt;|force]  
      
      Identify interval.  
      Default is 15 seconds.  
      0 - Off  
      force - To turn on indefinitely
    * _policy_  
      
      What to do when power is restored.
        * _list_  
          
          Show available options.
        * _always-on_  
        * _previous_  
        * _always-off_  
      
    * _restart\_cause_  
      
      Last restart cause.
    * _poh_  
      
      Get power on hours.
    * _bootdev_  
        * _none_  
          
          Do not change boot device order.
        * _pxe_  
          
          Force PXE boot.
        * _disk_  
          
          Force boot from default Hard-drive.
        * _safe_  
          
          Force boot from default Hard-drive, request Safe Mode.
        * _diag_  
          
          Force boot from Diagnostic Partition.
        * _cdrom_  
          
          Force boot from CD/DVD.
        * _bios_  
          
          Force boot into BIOS Setup.
        * _floppy_  
          
          Force boot from Floppy/primary removable media.
    * _bootparam_  
        * _force\_pxe_  
          
          Force PXE boot
        * _force\_disk_  
          
          Force boot from default Hard-drive
        * _force\_safe_  
          
          Force boot from default Hard-drive, request Safe Mode
        * _force\_diag_  
          
          Force boot from Diagnostic Partition
        * _force\_cdrom_  
          
          Force boot from CD/DVD
        * _force\_bios_  
          
          Force boot into BIOS Setup
    * _selftest_  
* _dcmi_  
    * _discover_    
      
      This command is used to discover supported capabilities in DCMI.
      
    * _power_ &lt;**command**&gt;    
      
      Platform power limit command options are:
      
        * _reading_    
          
          Get power related readings from the system.
        * _get\_limit_    
          
          Get the configured power limits.
        * _set\_limit_  &lt;**parameter**&gt; &lt;**value**&gt;    
          
          Set a power limit option.  
          
            * Possible parameters/values are:  
              
            * _action_ &lt;**No Action | Hard Power Off & Log Event to SEL | Log Event to SEL**&gt;    
              
              Exception Actions are taken as "No Action", "Hard Power Off system and log events to SEL", or "Log event to SEL only".
            * _limit_ &lt;**number in Watts**&gt;    
              
              Power Limit Requested in Watts.
            * _correction_ &lt;**number in milliseconds**&gt;    
              
              Correction Time Limit in milliseconds.
            * _sample_ &lt;**number in seconds**&gt;    
              
              Statistics Sampling period in seconds.
              
        * _activate_    
          
          Activate the set power limit.
        * _deactivate_    
          
          Deactivate the set power limit.
    * _sensors_    
      
      Prints the available DCMI sensors.
    * _asset\_tag_    
      
      Prints the platforms asset tag.
    * _set\_asset\_tag_  &lt;**string**&gt;    
      
      Sets the platforms asset tag
    * _get\_mc\_id\_string_    
      
      Get management controller identifier string.
    * _set\_mc\_id\_string_  &lt;**string**&gt;    
      
      Set management controller identifier string.  The maximum length is 64 bytes including a null terminator.
    * _thermalpolicy_  [&lt;**get** | **set**&gt;]    
      
      Thermal Limit policy get/set.    
      
        * The commands are:  
          
        * _Get_  &lt;**entityID**&gt; &lt;**instanceID**&gt;    
          
          Get Thermal Limit values.
          
          **entityID** is the physical entity that a sensor or device is associated with.   
          **instanceID** is a particular instance of an entity.  Entity Instance can be in one of two ranges, system-relative or device-relative.  For example, a system with four processors could use an Entity Instance value of "0" to identify the first processor.  
        * _Set_  &lt;**entityID**&gt; &lt;**instanceID**&gt;    
          
          Set Thermal Limit values.  
          
          **entityID** is the physical entity that a sensor or device is associated with.   
          **instanceID** is a particular instance of an entity.  Entity Instance can be in one of two ranges, system-relative or device-relative.  For example, a system with four processors could use an Entity Instance value of "0" to identify the first processor.  
    * _get\_temp\_reading_    
      
      Get Temperature Sensor Readings.
    * _get\_conf\_param_    
      
      Get DCMI Configuration Parameters.
    * _set\_conf\_param_ &lt;**parameters**&gt;    
      
      Set DCMI Configuration Parameters.  
        * The Configuration Parameters are:  
        * _activate\_dhcp_    
          
          Activate/restart DHCP
        * _dhcp\_config_    
          
          Discover DHCP Configuration.
        * _init_     
          
          Set DHCP Initial timeout interval, in seconds.  The recommended default is four seconds.
        * _timeout_    
          
          Set DHCP Server contact timeout interval, in seconds.  The recommended default timeout is two minutes.
        * _retry_    
          
          Set DHCP Server contact retry interval, in seconds.  The recommended default timeout is sixty-four seconds.
    * _oob\_discover_    
      
      Ping/Pong Message for DCMI Discovery.
      

* _delloem_    
      
      The delloem commands provide information on Dell-specific features.
    * _setled {b:d.f} {state..}_    
          
          Sets the drive backplane LEDs for a device.  
          {b:d.f} = PCI Address of device (eg. 06:00.0)  
          {state} = one or more of the following:
              _online | present | hotspare | identify | rebuilding | fault | predict | critical | failed_  
      
    * _lcd_     
          _set {mode}_|_{lcdqualifier}_|_{errordisplay}_  
              
              Allows you to set the LCD mode and user-defined string.
        * _lcd set mode_    
              _{none}_|_{modelname}_|_{ipv4address}_|_{macaddress}_|  
              _{systemname}_|_{servicetag}_|_{ipv6address}_|  
              _{ambienttemp}_|_{systemwatt}_|_{assettag}_|  
              _{userdefined}&lt;text&gt;_  
              
              Allows you to set the LCD display mode to any of the preceding parameters.
              
        * _lcd set lcdqualifier_    
              _{watt}_|_{btuphr}_|  
              _{celsius}_|_{fahrenheit}_  
              
              Allows you to set the unit for the system ambient temperature mode.
              
        * _lcd set errordisplay_    
              _{sel}_|_{simple}_  
              
              Allows you to set the error display.
        * _lcd info_    
              
              Displays the LCD screen information.
        * _lcd set vkvm_  
              _{active}_|_{inactive}_  
              
              Allows you to set the vKVM status to active or inactive. When it is active and session is in progress, a message appears on LCD.
        * _lcd status_    
              
              Displays the LCD status for vKVM display active or inactive and Front Panel access mode (viewandmodify, view-only or disabled).
    * _mac_    
          
          Displays the information about the system NICs.
        * _mac list_    
          
          Displays the NIC MAC address and status of all NICs. It also displays the DRAC/iDRAC MAC address.
          
        * _mac get_  
              _&lt;NIC number&gt;_  
              
              Displays the selected NICs MAC address and status.
    * _lan_    
          Displays the information of Lan.
          
        * _lan set_  
              _&lt;Mode&gt;_  
              
              Sets the NIC selection mode (dedicated, shared with lom1, shared with lom2,shared with lom3,shared with lom4,shared with failover lom1,shared with failover lom2,shared with failover lom3,shared with failover lom4,shared with Failover all loms, shared with Failover None).
        * _lan get_    
          
          Returns the current NIC selection mode (dedicated, shared with lom1, shared with lom2, shared with lom3, shared with lom4,shared with failover lom1, shared with failover lom2,shared with failover lom3,shared with failover lom4,shared with Failover all loms,shared with Failover None).
          
        * _lan get active_    
          
          Returns the current active NIC (dedicated, LOM1, LOM2, LOM3 or LOM4).
    * _powermonitor_    
          
          Displays power tracking statistics.
          
        * _powermonitor clear cumulativepower_    
              
              Reset cumulative power reading.
        * _powermonitor clear peakpower_    
              
              Reset peak power reading.
        * _powermonitor powerconsumption_  
              _&lt;watt&gt;_|_&lt;btuphr&gt;_  
              Displays the power consumption in watt or btuphr.
        * _powermonitor powerconsumptionhistory_  
              _&lt;watt&gt;_|_&lt;btuphr&gt;_  
              Displays the power consumption history in watt or btuphr.
        * _powermonitor getpowerbudget_  
              _&lt;watt&gt;_|_&lt;btuphr&gt;_  
              Displays the power cap in watt or btuphr.
        * _powermonitor setpowerbudget_  
              _&lt;val&gt;__&lt;watt_|_btuphr_|_percent&gt;_  
              Allows you to set the  power cap in watt, BTU/hr or percentage.
        * _powermonitor enablepowercap_    
              Enables set power cap.
        * _powermonitor disablepowercap_    
              
              Disables set power cap.
  
    * _vFlash info Card_    
          
          Shows Extended SD Card information.
* _echo_  
  
  For echoing lines to stdout in scripts.
* _ekanalyzer_ &lt;**command**&gt; &lt;**xx=filename1**&gt; &lt;**xx=filename2**&gt; [&lt;**rc=filename3**&gt;] **...**  
    *         _NOTE_ : This command can support a maximum of 8 files per command line
    *         _filename1_ : binary file that stores FRU data of a Carrier or an AMC module
    *         _filename2_ : binary file that stores FRU data of an AMC module.
            These binary files can be generated from command:
            _ipmitool fru read &lt;id&gt; &lt;filename&gt;_
    *         _filename3_ : configuration file used for configuring On-Carrier Device ID
      or OEM GUID. This file is optional.
    *         _xx_ : indicates the type of the file. It can take the following value:
        *             _oc_ : On-Carrier device
        *             _a1_ : AMC slot A1
        *             _a2_ : AMC slot A2
        *             _a3_ : AMC slot A3
        *             _a4_ : AMC slot A4
        *             _b1_ : AMC slot B1
        *             _b2_ : AMC slot B2
        *             _b3_ : AMC slot B3
        *             _b4_ : AMC slot B4
        *             _sm_ : Shelf Manager
          
    *         The available commands for ekanalyzer are:
      
    * _print_ [&lt;**carrier** | **power** | **all**&gt;]  
        * _carrier_ (default) &lt;**oc=filename1**&gt; &lt;**oc=filename2**&gt; **...**    
          
          Display point to point physical connectivity between carriers and AMC modules.
           Example:
             &gt; ipmitool ekanalyzer print carrier oc=fru oc=carrierfru
             From Carrier file: fru
                Number of AMC bays supported by Carrier: 2 
                AMC slot B1 topology:
                   Port 0 =====&gt; On Carrier Device ID 0, Port 16
                   Port 1 =====&gt; On Carrier Device ID 0, Port 12
                   Port 2 =====&gt; AMC slot B2, Port 2
                AMC slot B2 topology:
                   Port 0 =====&gt; On Carrier Device ID 0, Port 3
                   Port 2 =====&gt; AMC slot B1, Port 2
             *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
             From Carrier file: carrierfru
                On Carrier Device ID 0 topology:
                   Port 0 =====&gt; AMC slot B1, Port 4
                   Port 1 =====&gt; AMC slot B1, Port 5
                   Port 2 =====&gt; AMC slot B2, Port 6
                   Port 3 =====&gt; AMC slot B2, Port 7
                AMC slot B1 topology:
                   Port 0 =====&gt; AMC slot B2, Port 0
                AMC slot B1 topology:
                   Port 1 =====&gt; AMC slot B2, Port 1
                Number of AMC bays supported by Carrier: 2
          
        * _power_ &lt;**xx=filename1**&gt; &lt;**xx=filename2**&gt; ...\fr    
          
          Display power supply information between carrier and AMC modules.
        * _all_ &lt;**xx=filename**&gt; &lt;**xx=filename**&gt; ...\fr    
          
          Display both physical connectivity and power supply of each carrier and AMC
          modules.
          
    * _frushow_ &lt;**xx=filename**&gt;    
      Convert a binary FRU file into human readable text format. Use -v option to get
      more display information.
      
    * _summary_ [&lt;**match** | **unmatch** | **all**&gt;]  
        * _match_ (default) &lt;**xx=filename**&gt; &lt;**xx=filename**&gt; **...**    
          Display only matched results of Ekeying match between an On-Carrier device
          and an AMC module or between 2 AMC modules. Example:
           &gt; ipmitool ekanalyzer summary match oc=fru b1=amcB1 a2=amcA2
           On-Carrier Device vs AMC slot B1
            AMC slot B1 port 0 ==&gt; On-Carrier Device 0 port 16
             Matching Result
             - From On-Carrier Device ID 0
              -Channel ID 11 || Lane 0: enable
              -Link Type: AMC.2 Ethernet
              -Link Type extension: 1000BASE-BX (SerDES Gigabit) Ethernet link
              -Link Group ID: 0 || Link Asym. Match: exact match
             - To AMC slot B1
              -Channel ID 0 || Lane 0: enable
              -Link Type: AMC.2 Ethernet
              -Link Type extension: 1000BASE-BX (SerDES Gigabit) Ethernet link
              -Link Group ID: 0 || Link Asym. Match: exact match
             *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            AMC slot B1 port 1 ==&gt; On-Carrier Device 0 port 12
             Matching Result
             - From On-Carrier Device ID 0
              -Channel ID 6 || Lane 0: enable
              -Link Type: AMC.2 Ethernet
              -Link Type extension: 1000BASE-BX (SerDES Gigabit) Ethernet link
              -Link Group ID: 0 || Link Asym. Match: exact match
             - To AMC slot B1
              -Channel ID 1 || Lane 0: enable
              -Link Type: AMC.2 Ethernet
              -Link Type extension: 1000BASE-BX (SerDES Gigabit) Ethernet link
              -Link Group ID: 0 || Link Asym. Match: exact match
             *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
           On-Carrier Device vs AMC slot A2
            AMC slot A2 port 0 ==&gt; On-Carrier Device 0 port 3
             Matching Result
             - From On-Carrier Device ID 0
              -Channel ID 9 || Lane 0: enable
              -Link Type: AMC.2 Ethernet
              -Link Type extension: 1000BASE-BX (SerDES Gigabit) Ethernet link
              -Link Group ID: 0 || Link Asym. Match: exact match
             - To AMC slot A2
              -Channel ID 0 || Lane 0: enable
              -Link Type: AMC.2 Ethernet
              -Link Type extension: 1000BASE-BX (SerDES Gigabit) Ethernet link
              -Link Group ID: 0 || Link Asym. Match: exact match
             *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
           AMC slot B1 vs AMC slot A2
            AMC slot A2 port 2 ==&gt; AMC slot B1 port 2
             Matching Result
             - From AMC slot B1
              -Channel ID 2 || Lane 0: enable
              -Link Type: AMC.3 Storage
              -Link Type extension: Serial Attached SCSI (SAS/SATA)
              -Link Group ID: 0 || Link Asym. Match: FC or SAS interface {exact match}
             - To AMC slot A2
              -Channel ID 2 || Lane 0: enable
              -Link Type: AMC.3 Storage
              -Link Type extension: Serial Attached SCSI (SAS/SATA)
              -Link Group ID: 0 || Link Asym. Match: FC or SAS interface {exact match}
           *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
        * _unmatch_ &lt;**xx=filename**&gt; &lt;**xx=filename**&gt; ...\fr    
          
          Display the unmatched results of Ekeying match between an On-Carrier device
          and an AMC module or between 2 AMC modules
        * _all_ &lt;**xx=filename**&gt; &lt;**xx=filename**&gt; ...\fr    
          
          Display both matched result and unmatched results of Ekeying match between two
          cards or two modules.
* _event_  
    * &lt;**predefined event number** _N_&gt;    
      
      Send a pre-defined test event to the System Event Log.  The following
      events are included as a means to test the functionality of the 
      System Event Log component of the BMC (an entry will be added each 
      time the event _N_ command is executed).
      
      Currently supported values for _N_ are:  
      _1_	Temperature: Upper Critical: Going High  
      _2_	Voltage Threshold: Lower Critical: Going Low  
      _3_	Memory: Correctable ECC   
      
      **NOTE**: These pre-defined events will likely not produce
      "accurate" SEL records for a particular system because they will
      not be correctly tied to a valid sensor number, but they are
      sufficient to verify correct operation of the SEL.
      
    * _file_ &lt;**filename**&gt;    
      
      Event log records specified in &lt;**filename**&gt; will be added to
      the System Event Log.
      
      The format of each line in the file is as follows:
      
      &lt;{_EvM Revision_} {_Sensor Type_} {_Sensor Num_} {_Event Dir/Type_} {_Event Data 0_} {_Event Data 1_} {_Event Data 2_}&gt;[_# COMMENT_]
      
      e.g.:
      0x4 0x2 0x60 0x1 0x52 0x0 0x0 # Voltage threshold: Lower Critical: Going Low  
      
      _EvM Revision_ - 
      The "Event Message Revision" is 0x04 for messages that comply with the IPMI 2.0 
      Specification and 0x03 for messages that comply with the IPMI 1.0 Specification.
      
      _Sensor Type_ - 
      Indicates the Event Type or Class.
      
      _Sensor Num_ - 
      Represents the 'sensor' within the management controller that generated 
      the Event Message.
      
      _Event Dir/Type_ - 
      This field is encoded with the event direction as the high bit 
      (bit 7) and the event type as the low 7 bits.  Event direction is 
      0 for an assertion event and 1 for a deassertion event. 
      
      See the IPMI 2.0 specification for further details on the definitions for
      each field.
      
    * &lt;**sensorid**&gt; &lt;**list**&gt;    
      
      Get a list of all the possible Sensor States and pre-defined Sensor State
      Shortcuts available for a particular sensor.   **sensorid** is the character 
      string representation of the sensor and must be enclosed in double quotes
      if it includes white space.  Several different commands including 
      _ipmitool sensor list_ may be used to obtain a list that includes 
      the **sensorid** strings representing the sensors on a given system. 

&gt; ipmitool -I open event "PS 2T Fan Fault" list  
Finding sensor PS 2T Fan Fault... ok  
Sensor States:  
  State Deasserted  
  State Asserted  
Sensor State Shortcuts:  
  present    absent  
  assert     deassert  
  limit      nolimit  
  fail       nofail  
  yes        no  
  on         off  
  up         down


* &lt;**sensorid**&gt; &lt;**sensor state**&gt; [&lt;**direction**&gt;]  
  
  Generate a custom event based on existing sensor information.
  The optional event **direction can be either assert** 
  (the default) or _deassert_.  
  

&gt; ipmitool event "PS 2T Fan Fault" "State Asserted"  
Finding sensor PS 2T Fan Fault... ok  
   0 | Pre-Init Time-stamp   | Fan PS 2T Fan Fault | State Asserted

&gt; ipmitool event "PS 2T Fan Fault" "State Deasserted"  
Finding sensor PS 2T Fan Fault... ok  
   0 | Pre-Init Time-stamp   | Fan PS 2T Fan Fault | State Desserted


* _exec_ &lt;**filename**&gt;  
  
      Execute ipmitool commands from _filename_.  Each line is a
      complete command.  The syntax of the commands are defined by the
      COMMANDS section in this manpage.  Each line may have an optional
      comment at the end of the line, delimited with a \`#' symbol.
      
      e.g., a command file with two lines:
      
      sdr list # get a list of sdr records  
      sel list # get a list of sel records
* _firewall_    
  
  This command supports the Firmware Firewall capability.  It may be used to 
  add or remove security-based restrictions on certain commands/command 
  sub-functions  or to list the current firmware firewall restrictions set on 
  any commands.  For each firmware firewall command listed below, parameters 
  may be included to cause the command to be executed with increasing 
  granularity on a specific LUN, for a specific NetFn, for a specific IPMI 
  Command, and finally for a specific command's sub-function (see Appendix H in the 
  IPMI 2.0 Specification for a listing of any sub-function numbers that may 
  be associated with a particular command).
  
  Parameter syntax and dependencies are as follows:
  
  [&lt;_channel_ **H**&gt;] [&lt;_lun_ **L**&gt; [ &lt;_netfn_ **N**&gt; [&lt;_command_ **C** [&lt;_subfn_ **S**&gt;]]]] 
  
  Note that if "netfn &lt;**N**&gt;" is specified, then "lun &lt;**L**&gt;" must also be 
  specified;  if "command &lt;**C**&gt;" is specified, then "netfn &lt;**N**&gt;" (and
  therefore "lun &lt;**L**&gt;") must also be specified, and so forth.
  
  "channel &lt;**H**&gt;" is an optional and standalone parameter.  If not specified,
  the requested operation will be performed on the current channel.  Note that
  command support may vary from channel to channel. 
  
  Firmware firewall commands:
    * _info_ [&lt;**Parms as described above**&gt;]    
      
      List firmware firewall information for the specified LUN, NetFn, and 
      Command (if supplied) on the current or specified channel.  Listed
      information includes the support, configurable, and enabled bits for
      the specified command or commands.
      
      Some usage examples:
        * _info_ [&lt;**channel H**&gt;] [&lt;**lun L**&gt;]     
          
          This command will list firmware firewall information for all NetFns for the 
          specified LUN on either the current or the specified channel.
        * _info_ [&lt;**channel H**&gt;] [&lt;**lun L**&gt; [ &lt;**netfn N**&gt; ]     
          
          This command will print out all command information for a single LUN/NetFn pair.
        * _info_ [&lt;**channel H**&gt;] [&lt;**lun L**&gt; [ &lt;**netfn N**&gt; [&lt;**command C**] ]]     
          
          This prints out detailed, human-readable information showing the support, configurable,
          and enabled bits for the specified command on the specified LUN/NetFn pair.  Information
          will be printed about each of the command subfunctions.
        * _info_ [&lt;**channel H**&gt;] [&lt;**lun L**&gt; [ &lt;**netfn N**&gt; [&lt;**command C** [&lt;**subfn S**&gt;]]]]     
          
          Print out information for a specific sub-function.
    * _enable_ [&lt;**Parms as described above**&gt;]    
      
      This command is used to enable commands for a given NetFn/LUN combination on
      the specified channel. 
    * _disable_ [&lt;**Parms as described above**&gt;] [**force**]    
      
      This command is used to disable commands for a given NetFn/LUN combination on
      the specified channel.   Great care should be taken if using the "force"
      option so as not to disable the "Set Command Enables" command.
    * _reset_ [&lt;**Parms as described above**&gt;]    
      
      This command may be used to reset the firmware firewall back to a state
      where all commands and command sub-functions are enabled.
* _fru_  
    * _print_    
      
      Read all Field  Replaceable  Unit (FRU) inventory data and extract 
      such information as serial number, part number, asset tags, and 
      short strings describing the chassis, board, or product.
    * _read_ &lt;**fru id**&gt; &lt;**fru file**&gt;    
      
      **fru id** is the digit ID of the FRU (see output of 'fru print').
      **fru file** is the absolute pathname of a file in which to dump the
      binary FRU data pertaining to the specified FRU entity.
    * _write_ &lt;**fru id**&gt; &lt;**fru file**&gt;    
      
      **fru id** is the digit ID of the FRU (see output of 'fru print').
      **fru file** is the absolute pathname of a file from which to pull
      the binary FRU data before uploading it to the specified FRU.
    * _upgEkey_ &lt;**fru id**&gt; &lt;**fru file**&gt;    
      
      Update a multirecord FRU location.
      **fru id** is the digit ID of the FRU (see output of 'fru print').
      **fru file** is the absolute pathname of a file from which to pull the
      binary FRU data to upload into the specified multirecord FRU entity.
      
    * _edit_ &lt;**fru id**&gt;     
      
      This command provides interactive editing of some supported records, namely
      PICMG Carrier Activation Record.  **fru id** is the digit ID of the FRU 
      (see output of 'fru print'); default is 0.
      
    * _edit_ &lt;**fru id**&gt; **field** &lt;**section**&gt; &lt;**index**&gt; &lt;**string**&gt;    
      
      This command may be used to set a field string to a new value.  It replaces 
      the FRU data found at **index** in the specified **section** with the 
      supplied **string**.  
      
        * **fru id** is the digit ID of the FRU (see output of 'fru print').    
          
        * &lt;**section**&gt; is a string which refers to FRU Inventory Information  
          Storage Areas and may be refer to:
            * _c_ FRU Inventory Chassis Info Area    
            * _b_ FRU Inventory Board Info Area    
            * _p_ FRU Inventory Product Info Area    
          
        * &lt;**index**&gt; specifies the field number. Field numbering starts on the first 'english text' field type. For instance in the &lt;**board**&gt; info area field '0' is &lt;**Board Manufacturer**&gt; and field '2' is &lt;**Board Serial Number**&gt;; see IPMI Platform Management FRU Information Storage Definition v1.0 R1.1 for field locations.    
          
        * &lt;**string**&gt; must be the same length as the string being replaced and must be 8-bit ASCII (0xCx).    
          
      
    * _edit_ &lt;**fru id**&gt; **oem** **iana** &lt;**record**&gt; &lt;**format**&gt; [&lt;**args**&gt;]    
      
      This command edits the data found in the multirecord area. Support for
      OEM specific records is limited. 
* _fwum_  
      Update IPMC using Kontron OEM Firmware Update Manager.
    * _info_    
      Show information about current firmware.
      
    * _status_    
      Show status of each firmware bank present in the hardware.
      
    * _download_ &lt;**filename**&gt;    
      
      Download specified firmware.
      
    * _upgrade_ [**filename**]    
      
      Install firmware upgrade. If the filename is specified, the file is downloaded
      first, otherwise the last firmware downloaded is used.
      
    * _rollback_    
      
      Ask IPMC to rollback to previous version.
      
    * _tracelog_    
      
      Show firmware upgrade log.
      
* _gendev_  
    * _list_  
      
      List All Generic Device Locators.
    * _read_ &lt;**sdr name**&gt; &lt;**file**&gt;  
      
      Read to file eeprom specify by Generic Device Locators.
    * _write_ &lt;**sdr name**&gt; &lt;**file**&gt;  
      
      Write from file eeprom specify by Generic Device Locators
* _hpm_  
      PICMG HPM.1 Upgrade Agent
    * _check_    
      Check the target information.
      
    * _check_ &lt;**filename**&gt;    
      Display both the existing target version and image version on the screen.
      
    * _download_ &lt;**filename**&gt;    
      
      Download specified firmware.
      
    * _upgrade_ &lt;**filename**&gt; [**all**] [**component &lt;x&gt;**] [**activate**]    
      Upgrade the firmware using a valid HPM.1 image file. If no option is specified,
      the firmware versions are checked first and the firmware is upgraded only if they
      are different.
      
        * _all_    
          Upgrade all components even if the firmware versions are the same
          (use this only after using "check" command).
          
        * _component_ &lt;**x**&gt;    
          Upgrade only given component from the given file.  
          component 0 - BOOT  
          component 1 - RTK
          
        * _activate_    
          Activate new firmware right away.
          
      
    * _activate_    
      
      Activate the newly uploaded firmware.
      
    * _targetcap_    
      
      Get the target upgrade capabilities.
      
    * _compprop_ &lt;**id**&gt; &lt;**select**&gt;    
      Get the specified component properties. Valid component **id**: 0-7.
      **Select** can be one of following:  
      0 - General properties  
      1 - Current firmware version  
      2 - Description string  
      3 - Rollback firmware version  
      4 - Deferred firmware version
      
    * _abort_    
      
      Abort the on-going firmware upgrade.
      
    * _upgstatus_    
      Show status of the last long duration command.
      
    * _rollback_    
      Perform manual rollback on the IPM Controller firmware.
      
    * _rollbackstatus_    
      
      Show the rollback status.
      
    * _selftestresult_    
      
      Query the self test results.
      
* _i2c_ &lt;**i2caddr**&gt; &lt;**read bytes**&gt; [&lt;**write data**&gt;]    
  
  This command may be used to execute raw I2C commands with the Master
  Write-Read IPMI command.

* _ime_  
    * _help_    
      
      Print usage information
    * _info_  
      
      Displays information about the Manageability Engine (ME)
    * _update_ &lt;**file**&gt;    
      
      Upgrade the ME firmware with the specified image file  
      **WARNING** You MUST use a supported image provided by your board vendor  
    * _rollback_  
      
      Perform manual rollback of the ME firmware
      

* _isol_  
    * _info_    
      
      Retrieve information about the Intel IPMI v1.5 Serial-Over-LAN
      configuration.
    * _set_ &lt;**parameter**&gt; &lt;**value**&gt;    
      
      Configure parameters for Intel IPMI v1.5 Serial-over-LAN.
        * Valid parameters and values are:    
        * _enabled_  
          true, false.
        * _privilege-level_  
          user, operator, admin, oem.
        * _bit-rate_  
          9.6, 19.2, 38.4, 57.6, 115.2.
    * _activate_    
      
      Causes ipmitool to enter Intel IPMI v1.5 Serial Over LAN mode. An RMCP+
      connection is made to the BMC, the terminal is set to raw mode, and user
      input is sent to the serial console on the remote server. On exit, 
      the SOL payload mode is deactivated and the terminal is reset to its
      original settings.
          
          Special escape sequences are provided to control the SOL session:
            * _~._        Terminate connection  
            * _~^Z_       Suspend ipmitool  
            * _~^X_       Suspend ipmitool, but don't restore tty on restart  
            * _~B_        Send break  
            * _~~_        Send the escape character by typing it twice  
            * _~?_        Print the supported escape sequences  
          
          Note that escapes are only recognized immediately after newline.
* _kontronoem_  
      
      OEM commands specific to Kontron devices.
    * _setsn_    
      
      Set FRU serial number.
    * _setmfgdate_    
      
      Set FRU manufacturing date.
    * _nextboot_ &lt;**boot device**&gt;    
      
      Select the next boot order on the Kontron CP6012.
* _lan_  
      
      These commands will allow you to configure IPMI LAN channels
      with network information so they can be used with the ipmitool
      _lan_ and _lanplus_ interfaces.  _NOTE_: To
      determine on which channel the LAN interface is located, issue
      the \`channel info _number_' command until you come across
      a valid 802.3 LAN channel.  For example:
        
      &gt; ipmitool -I open channel info 1  
      Channel 0x1 info:  
        Channel Medium Type   : 802.3 LAN
        Channel Protocol Type : IPMB-1.0
        Session Support       : session-based
        Active Session Count  : 8
        Protocol Vendor ID    : 7154
      
    * _print_ [&lt;**channel**&gt;]    
      
      Print the  current  configuration  for  the  given channel.
      The default will print information on the first found LAN channel.
    * _set_ &lt;**channel number**&gt; &lt;**command**&gt; &lt;**parameter**&gt;    
      
      Set the given command and parameter on the specified channel.  Valid 
      command/parameter options are:
        * _ipaddr_ &lt;**x.x.x.x**&gt;    
          
          Set the IP address for this channel.
        * _netmask_ &lt;**x.x.x.x**&gt;    
          
          Set the netmask for this channel.
        * _macaddr_ &lt;**xx:xx:xx:xx:xx:xx**&gt;    
          
          Set the MAC address for this channel.
        * _defgw ipaddr_ &lt;**x.x.x.x**&gt;    
          
          Set the default gateway IP address.
        * _defgw macaddr_ &lt;**xx:xx:xx:xx:xx:xx**&gt;    
          
          Set the default gateway MAC address.
        * _bakgw ipaddr_ &lt;**x.x.x.x**&gt;    
          
          Set the backup gateway IP address.
        * _bakgw macaddr_ &lt;**xx:xx:xx:xx:xx:xx**&gt;    
          
          Set the backup gateway MAC address.
        * _password_ &lt;**pass**&gt;    
          
          Set the null user password.
        * _snmp_ &lt;**community string**&gt;    
          
          Set the SNMP community string.
        * _user_    
          
          Enable user access mode for userid 1 (issue the \`user'
          command to display information about userids for a given channel).
        * _access_ &lt;**on|off**&gt;    
          
          Set LAN channel access mode.
        * _alert_ &lt;**on|off**&gt;    
          
          Enable or disable PEF alerting for this channel.
        * _ipsrc_ &lt;**source**&gt;    
          
          Set the IP address source:  
          _none_	unspecified  
          _static_	manually configured static IP address  
          _dhcp_	address obtained by BMC running DHCP  
          _bios_	address loaded by BIOS or system software
        * _arp respond_ &lt;**on**|**off**&gt;    
          
          Set BMC generated ARP responses.
        * _arp generate_ &lt;**on**|**off**&gt;    
          
          Set BMC generated gratuitous ARPs.
        * _arp interval_ &lt;**seconds**&gt;    
          
          Set BMC generated gratuitous ARP interval.
        * _vlan id_ &lt;**off**|**id**&gt;    
          
          Disable VLAN operation or enable VLAN and set the ID.  
          ID: value of the virtual lan identifier between 1 and 4094 inclusive.
        * _vlan priority_ &lt;**priority**&gt;    
          
          Set the priority associated with VLAN frames.  
          ID: priority of the virtual lan frames between 0 and 7 inclusive.
        * _auth_ &lt;**level**,**...**&gt; &lt;**type**,**...**&gt;    
          
          Set the valid  authtypes  for  a  given  auth level.  
          Levels: callback, user, operator, admin  
          Types: none, md2, md5, password, oem
        * _cipher\_privs_ &lt;**privlist**&gt;    
          
          Correlates cipher suite numbers with the maximum privilege
          level that is allowed to use it.  In this way, cipher suites can restricted
          to users with a given privilege level, so that, for example,
          administrators are required to use a stronger cipher suite than
          normal users.
          
          The format of _privlist_ is as follows.  Each character represents
          a privilege level and the character position identifies the cipher
          suite number.  For example, the first character represents cipher
          suite 0, the second represents cipher suite 1, and so on.
          _privlist_ must be 15 characters in length.
          
          Characters used in _privlist_ and their associated privilege levels are:
          
          _X_	Cipher Suite Unused  
          _c_	CALLBACK  
          _u_	USER  
          _o_	OPERATOR  
          _a_	ADMIN  
          _O_	OEM  
          
          So, to set the maximum privilege for cipher suite 0 to USER and suite 1 to
          ADMIN, issue the following command:
          
          &gt; ipmitool -I _interface_ lan set _channel_ cipher_privs uaXXXXXXXXXXXXX
          
        *   
          _bad\_pass\_thresh_ &lt;**thresh\_num**&gt; &lt;**1|0**&gt; &lt;**reset\_interval**&gt; &lt;**lockout\_interval**&gt;  
          
          Sets the Bad Password Threshold.
          
          &lt;**thresh\_num**&gt; If non-zero, this value determines the number of sequential bad passwords
          that will be allowed to be entered for the identified user before the user is automatically
          disabled from access on the channel.
          
          &lt;**1|0**&gt; 1 = generate a Session Audit sensor "Invalid password disable" event message.
          0 = do not generate an event message when the user is disabled.
          
          &lt;**reset\_interval**&gt; Attempt Count Reset Interval. The interval, in tens of seconds, for
          which the accumulated count of bad password attempts is retained before being automatically
          reset to zero.
          
          &lt;**lockout\_interval**&gt; User Lockout Interval. The interval, in tens of seconds, that the user
          will remain disabled after being disabled because the Bad Password Threshold number was reached.
          
    * _alert_ _print_ [&lt;**channel**&gt;] [&lt;**alert destination**&gt;]    
      
      Print alert information for the specified channel and destination.  
      The default will print all alerts for all alert destinations on the 
      first found LAN channel.
      
    * _alert_ _set_ &lt;**channel number**&gt; &lt;**alert destination**&gt; &lt;**command**&gt; &lt;**parameter**&gt;    
      
      Set an alert on the given LAN channel and destination.   Alert Destinations are
      listed via the '_lan alert print_' command.  Valid command/parameter options are:
        * _ipaddr_ &lt;**x.x.x.x**&gt;    
          
          Set alert IP address.
        * _macaddr_ &lt;**xx:xx:xx:xx:xx:xx**&gt;    
          
          Set alert MAC address.
        * _gateway_ &lt;**default | backup**&gt;    
          
          Set the channel gateway to use for alerts.
        * _ack_ &lt;**on | off**&gt;    
          
          Set Alert Acknowledge on or off.
        * _type_ &lt;**pet | oem1 | oem2**&gt;    
          
          Set the destination type as PET or OEM.
        * _time_ &lt;**seconds**&gt;    
          
          Set ack timeout or unack retry interval.
        * _retry_ &lt;**number**&gt;    
          
          Set the number of alert retries.
    * _stats_ _get_ [&lt;**channel number**&gt;]    
      
      Retrieve information about the IP connections on the specified channel.
      The default will retrieve statistics on the first found LAN channel.
    * _stats_ _clear_ [&lt;**channel number**&gt;]    
      
      Clear all IP/UDP/RMCP Statistics to 0 on the specified channel.
      The default will clear statistics on the first found LAN channel.
* _mc | bmc_  
    * _reset_ &lt;**warm**|**cold**&gt;    
      
      Instructs the BMC to perform a warm or cold reset.
    * _guid_  
      
      Display the Management Controller Globally Unique IDentifier.
    * _info_    
      
      Displays information about the BMC hardware, including device
      revision, firmware revision, IPMI version supported, manufacturer ID,
      and information on additional device support.
    * _watchdog_    
      
      These commands allow a user to view and change the current 
      state of the watchdog timer.
        * _get_    
          
          Show current Watchdog Timer settings and countdown state.
        * _reset_    
          
          Reset the Watchdog Timer to its most recent state and restart the 
          countdown timer.
        * _off_    
          
          Turn off a currently running Watchdog countdown timer.
    * _selftest_    
      
      Check on the basic health of the BMC by executing the Get Self Test
      results command and report the results.
    * _getenables_    
      
      Displays a list of the currently enabled options for the BMC.  
    * _setenables_ &lt;**option**&gt;=[_on_|_off_]    
      
      Enables or disables the given _option_.  This command is
      only supported over the system interface according to the IPMI
      specification.  Currently supported values for _option_ include:
        * _recv\_msg\_intr_    
          
          Receive Message Queue Interrupt
        * _event\_msg\_intr_    
          
          Event Message Buffer Full Interrupt
        * _event\_msg_    
          
          Event Message Buffer
        * _system\_event\_log_    
          
          System Event Logging
        * _oem0_    
          
          OEM-Defined option #0
        * _oem1_    
          
          OEM-Defined option #1
        * _oem2_    
          
          OEM-Defined option #2
          
    * _getsysinfo_ &lt;**argument**&gt;  
      Retrieves system info from bmc for given argument.  
      See _setsysinfo_ for argument definitions
    * _setsysinfo_  &lt;**argument**&gt; &lt;**string**&gt;  
      Stores system info string to bmc for given argument
        * Possible arguments are:  
            * _primary\_os\_name_     Primary Operating System Name  
            * _os\_name_             Operating System Name  
            * _system\_name_         System Name of Server  
            * _delloem\_os\_version_ Running version of operating system  
            * _delloem\_URL_        URL of BMC Webserver  
    * _chassis_  
        * _status_    
          
          Displays information regarding the high-level
          status of the system chassis and main power
          subsystem.
        * _poh_    
          
          This command will return the Power-On Hours counter.
        * _identify_ &lt;**interval**&gt;  
          
          Control the front panel identify  light.   Default interval
          is 15 seconds.  Use 0 to turn off.  Use "force" to turn on 
          indefinitely.
        * _restart\_cause_    
          
          Query the chassis for the cause of the last system restart.
        * _selftest_    
          
          Check on the basic health of the BMC by executing the Get Self Test
          results command and report the results.
        * _policy_    
          
          Set the chassis power policy in  the  event  power failure.
            * _list_    
              
              Return supported policies.
            * _always-on_    
              
              Turn on when power is restored.
            * _previous_    
              
              Returned to  previous  state  when  power  is restored.
            * _always-off_    
              
              Stay off after power is restored.
        * _power_    
          
          Performs a chassis control  command  to  view  and
          change the power state.
            * _status_    
              
              Show current chassis power status.
            * _on_    
              
              Power up chassis.
            * _off_    
              
              Power down chassis into soft off (S4/S5 state).
              **WARNING**: This command does not initiate a clean 
              shutdown of the operating system prior to powering down the system.
            * _cycle_    
              
              Provides a power off interval of at least 1 second.  No action
              should occur if chassis power is in S4/S5 state, but it is
              recommended to check power state first and only issue a power
              cycle command if the  system  power is on or in lower sleep
              state than S4/S5.
            * _reset_    
              
              This command will perform a hard reset.
            * _diag_    
              
              Pulse a diagnostic interrupt (NMI) directly to the processor(s).
            * _soft_    
              
              Initiate a soft-shutdown of OS via ACPI.  This can be done in a
              number of ways, commonly by simulating an overtemperture or by
              simulating a power button press.  It is necessary for there to
              be Operating System support for ACPI and some sort of daemon
              watching for events for this soft power to work.
        * _bootdev_ &lt;**device**&gt; [&lt;_clear-cmos_=**yes**|**no**&gt;] [&lt;_options_=**help,...**&gt;]    
          
          Request the system to boot from an alternate boot device on next reboot.
          The _clear-cmos_ option, if supplied, will instruct the BIOS to
          clear its CMOS on the next reboot.  Various options may be used to modify 
          the boot device settings.  Run _"bootdev none options=help"_ for a list of 
          available boot device modifiers/options.  
          
            * Currently supported values for &lt;device&gt; are:  
            * _none_    
              
              Do not change boot device
            * _pxe_    
              
              Force PXE boot
            * _disk_    
              
              Force boot from BIOS default boot device
            * _safe_    
              
              Force boot from BIOS default boot device, request Safe Mode
            * _diag_    
              
              Force boot from diagnostic partition
            * _cdrom_    
              
              Force boot from CD/DVD
            * _bios_    
              
              Force boot into BIOS setup
            * _floppy_    
              
              Force boot from Floppy/primary removable media
        * _bootparam_    
          
          Get or set various system boot option parameters.
            * _get_ &lt;**param #**&gt;    
              
              Get boot parameter. Currently supported values for &lt;**param #**&gt; are:
              
              _0_ - Set In Progress
              
              _1_ - Service Partition Selector
              
              _2_ - Service Partition Scan
              
              _3_ - BMC Boot Flag Valid Bit Clearing
              
              _4_ - Boot Info Acknowledge 
              
              _5_ - Boot Flags
              
              _6_ - Boot Initiator Info
              
              _7_ - Boot Initiator Mailbox  
              
            * _set_ &lt;**device**&gt; [&lt;_options_=**help,...**&gt;]    
              
              Set boot device parameter used for next boot.  Various options may be used
              to change when the the next boot device is cleared.
              Run _"options=help"_ for a list of available bootparam set device options.
              
                * Currently supported bootparam **device** settings are:  
                * _force\_pxe_    
                  
                  Force PXE boot
                * _force\_disk_    
                  
                  Force boot from default hard-drive
                * _force\_safe_    
                  
                  Force boot from default hard-drive, request Safe Mode
                * _force\_diag_    
                  
                  Force boot from diagnostic partition
                * _force\_cdrom_    
                  
                  Force boot from CD/DVD 
                * _force\_bios_    
                  
                  Force boot into BIOS setup
                  
                * Currently supported bootparam **options** settings are associated with BMC Boot Valid Bit Clearing and are as follows:   Any option can be prefixed with "no-" to invert the sense of the operation.  
                * _PEF_    
                  
                  Clear valid bit on reset/power cycle caused by PEF
                * _timeout_    
                  
                  Automatically clear boot flag valid bit if Chassis Control command is
                  not received within 60 seconds.
                * _watchdog_    
                  
                  Clear valid bit on reset/power cycle caused by watchdog timeout
                * _reset_    
                  
                  Clear valid bit on push button reset / soft-reset
                * _power_    
                  
                  Clear valid bit on power up via power push button or wake event
                  
* _nm_  
    * _alert_  
        * _clear dest_ &lt;**dest**&gt;    
          
          Clear the Node Manager Alert lan destination.
          
        * _get_    
          Get the Node Manager Alert settings.
          
        * _set chan_ &lt;**chan**&gt; _dest_ &lt;**dest**&gt; _string_ &lt;**string**&gt;    
          
          Set the Node Manager alert channel, lan destination, and alert string number.
          
    * _capability_    
      
      Obtain the Node Manager power control capabilities and ranges.
      
    * _control_  
        * _enable_|_disable _  
            * _global_    
              
              Enable/disable all policies for all domains.
            * _per\_domain_ &lt;platform|CPU|Memory&gt;    
              
              Enable/disable all policies of the specified domain.
            * _per\_policy_ &lt;0-7&gt;    
              
              Enable/disable the policy for the specified domain/policy combination.
    * _discover_    
      
      Discover Node Manager presence as well as the Node Manager version, revision, and patch number.
      
    * _policy_  
        * _add_  
            * _power_ &lt;watts&gt; _policy\_id_ &lt;0-7&gt; [_correction_ auto|soft|hard] _trig\_lim_ &lt;seconds&gt; _stats_ &lt;seconds&gt; [_domain_ &lt;platform|CPU|Memory&gt;] _enable_|_disable_    
              
              Add a new power policy, or overwrite an existing policy.
              The _correction_ parameter is the agressiveness of frequency limiting, default is auto.
              The _trig\_lim_ is the correction time limit and must be at least 6000 and not greater than 65535.
              The _stats_ setting is the averaging period in seconds and ranges from 1-65535.
              If domain is not supplied a default of platform is used.
              
              
            * _inlet_ &lt;temp&gt; _policy\_id_ &lt;0-7&gt; [_correction_ auto|soft|hard] _trig\_lim_ &lt;seconds&gt; _stats_ &lt;seconds&gt; [_domain_ &lt;platform|CPU|Memory&gt;] _enable_|_disable_    
              
              Add a new inlet temp policy, or overwrite an existing policy.
              The _correction_ parameter is the agressiveness of frequency limiting, default is auto.
              The _trig\_lim_ is the correction time limit and must be at least 6000 and not greater than 65535.
              The _stats_ setting is the averaging period in seconds and ranges from 1-65535.
              If domain is not supplied a default of platform is used.
              
              
        * _get_ _policy\_id_ &lt;0-7&gt;    
          
          Get a previously stored policy.
        * _limiting_    
          
          Report policy number if any policy is limiting power.
        * _remove_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Remove a policy. If domain is not supplied a default of platform is used.
    * _power_ _min_ &lt;minimum&gt; _max_ &lt;maximum&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
      
      Configure Node Manager power minimum and maximum power draw limits.
      The _min_ and _max_ values must be in the range of 0-65535.
      If domain is not supplied a default of platform is used.
      
    * _reset_  
        * _comm_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Reset Node Manager communication statistics.
          If domain is not supplied a default of platform is used.
          
        * global     
          
          Reset Node Manager global statistics.
          
        * _memory_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Reset Node Manager memory throttling statistics.
          If domain is not supplied a default of platform is used.
          
        * _per\_policy_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Reset Node Manager per policy statistics.
          If domain is not supplied a default of platform is used.
          
        * _requests_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Reset Node Manager unhandled requests statistics.
          If domain is not supplied a default of platform is used.
          
        * _response_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Reset Node Manager response time statistics.
          If domain is not supplied a default of platform is used.
          
        * _throttling_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Reset Node Manager throttling statistics.
          If domain is not supplied a default of platform is used.
          
    * _statistics_  
        * _comm\_fail_    
          
          Report Node Manager communication failure statistics.
          
        * _cpu\_throttling_    
          
          Report Node Manager cpu throttling statistics.
          
        * _mem\_throttling_    
          
          Report Node Manager memory throttling statistics.
          
        * _policy\_power_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Report Node Manager per policy power statistics (policy must be a power limit type policy).
          If domain is not supplied a default of platform is used.
          
        * _policy\_temps_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Report Node Manager per policy temp statistics (policy must be an inlet temp limit policy).
          If domain is not supplied a default of platform is used.
          
        * _policy\_throt_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Report Node Manager per policy throttling statistics.
          If domain is not supplied a default of platform is used.
          
        * _requests_    
          
          Report Node Manager unhandled requests statistics.
          
        * _response_    
          
          Report Node Manager response time statistics.
          
    * _suspend_  
        * _get_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Get Node Manager policy suspend periods.
          If domain is not supplied a default of platform is used.
          
        * _set_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;] &lt;start&gt; &lt;stop&gt; &lt;repeat&gt;    
          
          Set Node Manager policy suspend periods.
          If domain is not supplied a default of platform is used.
          The &lt;start&gt; and &lt;stop&gt; values must be in the range of 0-239, which is the number of minutes past midnight divided by 6.
          The &lt;repeat&gt; value is the daily recurrence pattern. Bit 0 is repeat every Monday, bit 1 is repeat every Tuesday, on through bit 6 for Sunday.
          
    * _threshold_  
        * _get_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;]    
          
          Get Node Manager policy Alert Threshold settings.
          If domain is not supplied a default of platform is used.
          
        * _set_ _policy\_id_ &lt;0-7&gt; [_domain_ &lt;platform|CPU|Memory&gt;] _thresh\_array_    
          
          Set Node Manager policy Alert Threshold values.
          If domain is not supplied a default of platform is used.
          The _thresh\_array_ is 1, 2, or 3 integers that set three alert threshold settings. The setting type is a power or temperature value which must match the type of policy.
          
  
* _pef_  
    * _info_    
      
      This command will query the BMC and print information about the PEF 
      supported features.
    * _status_    
      
      This command prints the current PEF status (the last SEL entry 
      processed by the BMC, etc).
    * _policy_    
      
      This command lists the PEF policy table entries.  Each policy 
      entry describes an alert destination.  A policy set is a 
      collection of table entries.  PEF alert actions reference policy sets.
    * _list_    
      
      This command lists the PEF table entries.  Each PEF entry 
      relates a sensor event to an action.  When PEF is active, 
      each platform event causes the BMC to scan this table for 
      entries matching the event, and possible actions to be taken.
      Actions are performed in priority order (higher criticality first).
* _picmg_ &lt;**properties**&gt;   
      
      Run a PICMG/ATA extended command. Get PICMG properties may be used to
      obtain and print Extension major version information, PICMG identifier,
      FRU Device ID and Max FRU Device ID.
    * _addrinfo_    
      
      Get address information.  This command may return information on the Hardware
      address, IPMB-0 Address, FRU ID, Site/Entity ID, and Site/Entity Type.
    * _frucontrol_ &lt;**fru id**&gt; &lt;**options**&gt;    
      
      Set various control options:
        * _0x00_      - Cold Reset    
        * _0x01_      - Warm Reset    
        * _0x02_      - Graceful Reboot    
        * _0x03_      - Issue Diagnostic Interrupt    
        * _0x04_      - Quiesce [AMC only]    
        * _0x05-0xFF_ - Cold Reset    
    * _activate_ &lt;**fru id**&gt;    
      
      Activate the specified FRU.
    * _deactivate_ &lt;**fru id**&gt;    
      
      Deactivate the specified FRU.
    * _policy_ _get_ &lt;**fru id**&gt;    
      
      Get FRU activation policy.
    * _policy_ _set_ &lt;**fru id**&gt; &lt;**lockmask**&gt; &lt;**lock**&gt;    
      
      Set FRU activation policy.  **lockmask** is 1 or 0 to indicate action
      on the deactivation or activation locked bit respectively.  **lock** is
      1 or 0 to set/clear locked bit.
    * _portstate_ **set**|**getall**|**getgranted**|**getdenied** &lt;**parameters**&gt;     
      Get or set various port states.  See usage for parameter details.
* _power_ &lt;**chassis power command**&gt;    
  
  Shortcut to the _chassis power_ commands.
  See the _chassis power_ commands for usage information.

* _raw_ &lt;**netfn**&gt; &lt;**cmd**&gt; [&lt;**data**&gt;]    
  
  This will allow you to execute raw IPMI commands.   For
  example to query the POH counter with a raw command:
  
  &gt; ipmitool -v raw 0x0 0xf  
  RAW REQ (netfn=0x0 cmd=0xf data_len=0)  
  RAW RSP (5 bytes)  
  3c 72 0c 00 00
  
  **Note** that the OpenIPMI driver provided by the Linux kernel will reject the Get Message, Send Message and Read Event Message Buffer commands because it handles the message sequencing internally.

* _sdr_  
    * _get_ &lt;**id**&gt; ... [&lt;**id**&gt;]    
      
      Prints information for sensor data records specified by sensor id.
    * _info_    
      
      This command will query the BMC for Sensor Data Record (SDR) Repository information.
    * _type_ [&lt;**sensor type**&gt;]  
      
      This command will display all records from the SDR Repository of a specific type.
      Run with type _list_ (or simply with no type) to see the list of available types.
      For example to query for all Temperature sensors:
      
      &gt; ipmitool sdr type Temperature  
      Baseboard Temp   | 30h | ok  |  7.1 | 28 degrees C  
      FntPnl Amb Temp  | 32h | ok  | 12.1 | 24 degrees C  
      Processor1 Temp  | 98h | ok  |  3.1 | 57 degrees C  
      Processor2 Temp  | 99h | ok  |  3.2 | 53 degrees C
      
    * _list_ | _elist_ [&lt;**all**|**full**|**compact**|**event**|**mcloc**|**fru**|**generic**&gt;]    
      
      This command will read the Sensor Data Records (SDR) and extract sensor
      information of a given type,  then query each sensor and print its name,
      reading, and status.  If invoked as _elist_ then it will also print
      sensor number, entity id and instance, and asserted discrete states.
      
      The default output will only display _full_ and _compact_ sensor
      types, to see all sensors use the _all_ type with this command.
        * Valid types are:  
            * _all_    
              
              All SDR records (Sensor and Locator) 
            * _full_    
              
              Full Sensor Record
            * _compact_    
              
              Compact Sensor Record
            * _event_    
              
              Event-Only Sensor Record
            * _mcloc_    
              
              Management Controller Locator Record
            * _fru_    
              
              FRU Locator Record
            * _generic_    
              
              Generic SDR records
    * _entity_ &lt;**id**&gt;[.&lt;**instance**&gt;]    
      
      Displays all sensors associated with an entity.  Get a list of
      valid entity ids on the target system by issuing the _sdr elist_ command.
      A list of all entity ids can be found in the IPMI specifications.
    * _dump_ &lt;**file**&gt;    
      
      Dumps raw SDR data to a file.  This data file can then be used as
      a local SDR cache of the remote managed system with the _-S &lt;file&gt;_
      option on the ipmitool command line.  This can greatly improve performance
      over system interface or remote LAN.
    * _fill_ _sensors_    
      
      Create the SDR Repository for the current configuration.  Will perform
      a 'Clear SDR Repository' command so be careful.
    * _fill_ _file_ &lt;**filename**&gt;    
      
      Fill the SDR Repository using records stored in a binary data file. Will perform
      a 'Clear SDR Repository' command so be careful.
* _sel_    
  
  NOTE: System Event Log (SEL) entry-times are displayed as 
  \`Pre-Init Time-stamp' if the SEL clock needs to be set.
  Ensure that the SEL clock is accurate by invoking the
  _sel time get_ and
  _sel time set &lt;time string&gt;_ commands.
    * _info_    
      
      This command will query the BMC for information
      about the System Event Log (SEL) and its contents.
    * _clear_    
      
      This command will clear the contents of the SEL.
      It cannot be undone so be careful.
    * _list_ | _elist_    
      
      When this command is invoked without arguments, the entire
      contents of the System Event Log are displayed.  If invoked as
      _elist_ (extended list) it will also use the Sensor Data 
      Record entries to display the sensor ID for the sensor that caused 
      each event.  **Note** this can take a long time over the 
      system interface.
      
        * &lt;**count**&gt; | _first_ &lt;**count**&gt;    
          
          Displays the first _count_ (least-recent) entries in the SEL.
          If _count_ is zero, all entries are displayed.
        * _last_ &lt;**count**&gt;    
          
          Displays the last _count_ (most-recent) entries in the SEL.
          If _count_ is zero, all entries are displayed.
    * _delete_ &lt;**SEL Record ID**&gt; ... &lt;**SEL Record ID**&gt;    
      
      Delete one or more SEL event records.
    * _add_ &lt;**filename ID**&gt;    
      
      Read event entries from a file and add them to the SEL.  New SEL
      entries area added onto the SEL after the last record in the SEL.
      Record added is of type 2 and is automatically timestamped.
    * _get_ &lt;**SEL Record ID**&gt;    
      
      Print information on the specified SEL Record entry.
    * _save_ &lt;**file**&gt;  
      
      Save SEL records to a text file that can be fed back into the
      _event file_ ipmitool command.  This can be useful for
      testing Event generation by building an appropriate Platform
      Event Message file based on existing events.  Please see the
      available help for the 'event file ...' command for a description of
      the format of this file.
    * _writeraw_ &lt;**file**&gt;  
      
      Save SEL records to a file in raw, binary format.  This file can
      be fed back to the _sel readraw_ ipmitool command for viewing.
    * _readraw_ &lt;**file**&gt;  
      
      Read and display SEL records from a binary file.  Such a file can
      be created using the _sel writeraw_ ipmitool command.
    * _time_  
        * _get_    
          Displays the SEL clock's current time.
        * _set_ &lt;**time string**&gt;    
          
          Sets the SEL clock.  Future SEL entries will use the time
          set by this command.  &lt;**time string**&gt; is of the
          form "MM/DD/YYYY HH:MM:SS".  Note that hours are in 24-hour
          form.  It is recommended that the SEL be cleared before
          setting the time.
* _sensor_  
    * _list_    
      
      Lists sensors and thresholds in a wide table format.
    * _get_ &lt;**id**&gt; ... [&lt;**id**&gt;]    
      
      Prints information for sensors specified by name.
    * _thresh_ &lt;**id**&gt; &lt;**threshold**&gt; &lt;**setting**&gt;    
      
      This allows you to set a particular sensor threshold 
      value.  The sensor is specified by name.
        * Valid _thresholds_ are:    
          _unr_	Upper Non-Recoverable  
          _ucr_	Upper Critical  
          _unc_	Upper Non-Critical  
          _lnc_	Lower Non-Critical  
          _lcr_	Lower Critical  
          _lnr_	Lower Non-Recoverable
    * _thresh_ &lt;**id**&gt; _lower_ &lt;**lnr**&gt; &lt;**lcr**&gt; &lt;**lnc**&gt;  
      
      This allows you to set all lower thresholds for a sensor at the same time.
      The sensor is specified by name and the thresholds are listed in order of
      Lower Non-Recoverable, Lower Critical, and Lower Non-Critical.
    * _thresh_ &lt;**id**&gt; _upper_ &lt;**unc**&gt; &lt;**ucr**&gt; &lt;**unr**&gt;  
      
      This allows you to set all upper thresholds for a sensor at the same time.
      The sensor is specified by name and the thresholds are listed in order of
      Upper Non-Critical, Upper Critical, and Upper Non-Recoverable.
* _session_  
    * _info_ &lt;**active**|**all**|**id 0xnnnnnnnn**|**handle 0xnn**&gt;    
      
      Get information about the specified session(s).  You may identify
      sessions by their id, by their handle number, by their active status,
      or by using the keyword \`all' to specify all sessions.
* _set_  
    * _hostname_ &lt;**host**&gt;  
      
      Session hostname.
    * _username_ &lt;**user**&gt;  
      
      Session username.
    * _password_ &lt;**pass**&gt;  
      
      Session password.
    * _privlvl_ &lt;**level**&gt;  
      
      Session privilege level force.
    * _authtype_ &lt;**type**&gt;  
      
      Authentication type force.
    * _localaddr_ &lt;**addr**&gt;  
      
      Local IPMB address.
    * _targetaddr_ &lt;**addr**&gt;  
      
      Remote target IPMB address.
    * _port_ &lt;**port**&gt;  
      
      Remote RMCP port.
    * _csv_ [**level**]  
      
      Enable output in comma separated format.
      Affects following commands:
      _user_, _channel_, _isol_, _sunoem_,
      _sol_, _sensor_, _sdr_, _sel_, _session_.
    * _verbose_ [**verbose**]  
      
      Verbosity level.
* _shell_  
      This command will launch an interactive shell which you can use
      to send multiple ipmitool commands to a BMC and see the responses.
      This can be useful instead of running the full ipmitool command each
      time.  Some commands will make use of a Sensor Data Record cache
      and you will see marked improvement in speed if these commands
      are able to reuse the same cache in a shell session.  LAN sessions
      will send a periodic keepalive command to keep the IPMI session
      from timing out.
* _sol_  
    * _info_ [&lt;**channel number**&gt;]    
      
      Retrieve information about the Serial-Over-LAN configuration on 
      the specified channel.  If no channel is given, it will display 
      SOL configuration data for the currently used channel.
    * _payload_ &lt;_enable_ | _disable_ | _status_&gt; &lt;**channel number**&gt; &lt;**userid**&gt;    
      
      Enable, disable or show status of SOL payload for the user on the specified channel. 
    * _set_ &lt;**parameter**&gt; &lt;**value**&gt; [&lt;**channel**&gt;] [**noguard**]    
      
      Configure parameters for Serial Over Lan.  If no channel is given,
      it will display SOL configuration data for the currently used
      channel.  Configuration parameter updates are automatically guarded
      with the updates to the set-in-progress parameter, unless _noguard_
      parameter is present.
        * Valid parameters and values are:    
        * _set-in-progress_  
          set-complete set-in-progress commit-write
        * _enabled_  
          true false
        * _force-encryption_  
          true false
        * _force-authentication_  
          true false
        * _privilege-level_  
          user operator admin oem
        * _character-accumulate-level_  
          Decimal number given in 5 milliseconds increments
        * _character-send-threshold_  
          Decimal number
        * _retry-count_  
          Decimal number.  0 indicates no retries after packet is transmitted.
        * _retry-interval_  
          Decimal number in 10 millisecond increments.  0 indicates 
          that retries should be sent back to back.
        * _non-volatile-bit-rate_  
          serial, 19.2, 38.4, 57.6, 115.2.  Setting this value to 
          serial indicates that the BMC should use the setting used 
          by the IPMI over serial channel.
        * _volatile-bit-rate_  
          serial, 19.2, 38.4, 57.6, 115.2.  Setting this value to 
          serial indicates that the BMC should use the setting used 
          by the IPMI over serial channel.
    * _activate_ [_usesolkeepalive_ | _nokeepalive_] [_instance=&lt;number&gt;_]    
      
      Causes ipmitool to enter Serial Over LAN
      mode, and is only available when using the lanplus
      interface.  An RMCP+ connection is made to the BMC,
      the terminal is set to raw mode, and user input is
      sent to the serial console on the remote server.
      On exit, the the SOL payload mode is deactivated and
      the terminal is reset to its original settings.
      
      If the instance is given, it will activate using the given instance
      number.  The default is 1.
          
          Special escape sequences are provided to control the SOL session:
            * _~._	Terminate connection  
            * _~^Z_	Suspend ipmitool  
            * _~^X_	Suspend ipmitool, but don't restore tty on restart  
            * _~B_	Send break  
            * _~~_	Send the escape character by typing it twice  
            * _~?_	Print the supported escape sequences  
          
          Note that escapes are only recognized immediately after newline.
    * _deactivate_ [_instance=&lt;number&gt;_]    
      
      Deactivates Serial Over LAN mode on the BMC.
      Exiting Serial Over LAN mode should automatically cause
      this command to be sent to the BMC, but in the case of an
      unintentional exit from SOL mode, this command may be
      necessary to reset the state of the BMC.
      
      If the instance is given, it will deactivate the given instance
      number.  The default is 1.
* _spd_ &lt;**i2cbus**&gt; &lt;**i2caddr**&gt; [&lt;**channel**&gt;] [&lt;\fmaxread&gt;]    
  
  This command may be used to read SPD (Serial Presence Detect) data using the 
  I2C Master Write-Read IPMI command.
  
* _sunoem_  
    * _cli_ [&lt;**command string**&gt; ...]    
      
      Execute the service processor command line interface commands.
      Without any command string, an interactive session is started
      in the service processor command line environment.  If a
      command string is specified, the command string is executed
      on the service processor and the connection is closed.
    * _led_  
          
          These commands provide a way to get and set the status of LEDs
          on a Sun Microsystems server.  Use 'sdr list generic' to get a
          list of devices that are controllable LEDs.  The _ledtype_
          parameter is optional and not necessary to provide on the command
          line unless it is required by hardware.
        * _get_ &lt;**sensorid**&gt; [&lt;**ledtype**&gt;]  
          
          Get status of a particular LED described by a Generic Device Locator
          record in the SDR.  A sensorid of _all_ will get the status
          of all available LEDS.
        * _set_ &lt;**sensorid**&gt; &lt;**ledmode**&gt; [&lt;**ledtype**&gt;]  
          
          Set status of a particular LED described by a Generic Device Locator
          record in the SDR.  A sensorid of _all_ will set the status
          of all available LEDS to the specified _ledmode_ and _ledtype_.
        * LED Mode is required for set operations:    
          _OFF_         Off  
          _ON_          Steady On  
          _STANDBY_     100ms on 2900ms off blink rate  
          _SLOW_        1HZ blink rate  
          _FAST_        4HZ blink rate
        * LED Type is optional:    
          _OK2RM_       Ok to Remove  
          _SERVICE_     Service Required  
          _ACT_         Activity  
          _LOCATE_      Locate
          
    * _nacname_ &lt;**ipmi name**&gt;    
      
      Return the full NAC name of a target identified by ipmi name.
    * _ping_ &lt;**count**&gt; [&lt;**q**&gt;]    
      
      Send and receive count packets. Each packet is 64 bytes.
      
      q - Quiet. Displays output only at the start and end of the process.
    * _getval_ &lt;**property name**&gt;    
      
      Returns value of specified ILOM property.
    * _setval_ &lt;**property name**&gt; &lt;**property value**&gt; [&lt;**timeout**&gt;]    
      
      Sets value of ILOM  property. If timeout is not specified, the
      default value is 5 seconds. NOTE: setval must be executed locally on host!
    * _sshkey_  
        * _set_ &lt;**userid**&gt; &lt;**keyfile**&gt;  
          
          This command will allow you to specify an SSH key to use for a particular
          user on the Service Processor. This key will be used for CLI logins to
          the SP and not for IPMI sessions. View available users and their userids
          with the 'user list' command.
        * _del_ &lt;**userid**&gt;  
          
          This command will delete the SSH key for a specified userid.
    * _version_    
      
      Display the version of ILOM firmware.
    * _getfile_ &lt;**file identifier**&gt; &lt;**destination file name**&gt;    
      
      This command will return various files from service processor and store them
      in specified destination file. Note that some files may not be present or
      be supported by your SP.  
      
          File identifiers:  
              _SSH\_PUBKEYS_  
              _DIAG\_PASSED_  
              _DIAG\_FAILED_  
              _DIAG\_END\_TIME_  
              _DIAG\_INVENTORY_  
              _DIAG\_TEST\_LOG_  
              _DIAG\_START\_TIME_  
              _DIAG\_UEFI\_LOG_  
              _DIAG\_TEST\_LOG_  
              _DIAG\_LAST\_LOG_  
              _DIAG\_LAST\_CMD_
      
    * _getbehavior_ &lt;**feature identifier**&gt;    
      
      This command will test if various ILOM features are enabled.  
      
          Feature identifiers:  
              _SUPPORTS\_SIGNED\_PACKAGES_  
              _REQUIRES\_SIGNED\_PACKAGES_
* _tsol_  
      
      This command allows Serial-over-LAN sessions to be established with Tyan
      IPMIv1.5 SMDC such as the M3289 or M3290.  The default command run with
      no arguments will establish default SOL session back to local IP address.
      Optional arguments may be supplied in any order.
      
    * _&lt;ipaddr&gt;_    
      
      Send receiver IP address to SMDC which it will use to send serial
      traffic to.  By default this detects the local IP address and establishes
      two-way session.  Format of ipaddr is XX.XX.XX.XX
      
    * _port=NUM_    
      
      Configure UDP port to receive serial traffic on.  By default this is 6230.
      
    * _ro|rw_    
      
      Confiure SOL session as read-only or read-write.  Sessions are read-write
      by default.
      
  
* _user_  
    * _summary_    
      
      Displays a summary of userid information, including maximum number of userids,
      the number of enabled users, and the number of fixed names defined.
    * _list_    
      
      Displays a list of user information for all defined userids.
    * _set_  
        * _name_ &lt;**userid**&gt; &lt;**username**&gt;    
          
          Sets the username associated with the given userid.
        * _password_ &lt;**userid**&gt; [&lt;**password**&gt;]    
          
          Sets the password for the given userid.  If no password is given,
          the password is cleared (set to the NULL password).  Be careful when
          removing passwords from administrator-level accounts.
    * _disable_ &lt;**userid**&gt;    
      
      Disables access to the BMC by the given userid.
    * _enable_ &lt;**userid**&gt;    
      
      Enables access to the BMC by the given userid.
    * _priv_ &lt;**userid**&gt; &lt;**privilege level**&gt; [&lt;**channel number**&gt;]    
      
      Set user privilege level on the specified channel.  If the channel is not 
      specified, the current channel will be used.
    * _test_ &lt;**userid**&gt; &lt;**16**|**20**&gt; [&lt;**password**&gt;]    
      
      Determine whether a password has been stored as 16 or 20 bytes.
  

<a name="open-interface"></a>

# Open Interface

The ipmitool _open_ interface utilizes the OpenIPMI
kernel device driver.  This driver is present in all modern
2.4 and all 2.6 kernels and it should be present in recent
Linux distribution kernels.  There are also IPMI driver
kernel patches for different kernel versions available from
the OpenIPMI homepage.

The required kernel modules is different for 2.4 and 2.6
kernels.  The following kernel modules must be loaded on
a 2.4-based kernel in order for ipmitool to work:

* **ipmi_msghandler**  
  Incoming and outgoing message handler for IPMI interfaces.
* **ipmi_kcs_drv**  
  An IPMI Keyboard Controller Style (KCS) interface driver for the message handler.
* **ipmi_devintf**  
  Linux character device interface for the message handler.

The following kernel modules must be loaded on
a 2.6-based kernel in order for ipmitool to work:

* **ipmi_msghandler**  
  Incoming and outgoing message handler for IPMI interfaces.
* **ipmi_si**  
  An IPMI system interface driver for the message handler.
  This module supports various IPMI system interfaces such
  as KCS, BT, SMIC, and even SMBus in 2.6 kernels.
* **ipmi_devintf**  
  Linux character device interface for the message handler.

Once the required modules are loaded there will be a dynamic
character device entry that must exist at **/dev/ipmi0**.
For systems that use devfs or udev this will appear at
**/dev/ipmi/0**.

To create the device node first determine what dynamic major
number it was assigned by the kernel by looking in
**/proc/devices** and checking for the _ipmidev_
entry.  Usually if this is the first dynamic device it will
be major number **254** and the minor number for the first
system interface is **0** so you would create the device
entry with:

_mknod /dev/ipmi0 c 254 0_

ipmitool includes some sample initialization scripts that
can perform this task automatically at start-up.

In order to have ipmitool use the OpenIPMI device interface
you can specify it on the command line:

ipmitool **-I** _open_ &lt;_command_&gt;

<a name="bmc-interface"></a>

# Bmc Interface

The ipmitool bmc interface utilizes the _bmc_ device driver as
provided by Solaris 10 and higher.  In order to force ipmitool to make
use of this interface you can specify it on the command line:

ipmitool **-I** _bmc_ &lt;_command_&gt;

The following files are associated with the bmc driver:


* **/platform/i86pc/kernel/drv/bmc**  
  32-bit **ELF** kernel module for the bmc driver.
* **/platform/i86pc/kernel/drv/amd64/bmc**  
  64-bit **ELF** kernel module for the bmc driver.
* **/dev/bmc**  
  Character device node used to communicate with the bmc driver.

<a name="lipmi-interface"></a>

# Lipmi Interface

The ipmitool _lipmi_ interface uses the Solaris 9 IPMI kernel device driver.
It has been superceeded by the _bmc_ interface on Solaris 10.  You can tell
ipmitool to use this interface by specifying it on the command line.

ipmitool **-I** _lipmi_ &lt;_expression_&gt;

<a name="lan-interface"></a>

# Lan Interface

The ipmitool _lan_ interface communicates with the BMC
over an Ethernet LAN connection using UDP under IPv4.  UDP
datagrams are formatted to contain IPMI request/response 
messages with a IPMI session headers and RMCP headers.

IPMI-over-LAN uses version 1 of the Remote Management Control
Protocol (RMCP) to support pre-OS and OS-absent management.  
RMCP is a request-response protocol delivered using UDP 
datagrams to port 623.

The LAN interface is an authentication multi-session connection;
messages delivered to the BMC can (and should) be authenticated
with a challenge/response protocol with either straight
password/key or MD5 message-digest algorithm.  ipmitool will
attempt to connect with administrator privilege level as this
is required to perform chassis power functions.

You can tell ipmitool to use the lan interface with the
**-I** _lan_ option:


ipmitool **-I** _lan_ **-H** &lt;_hostname_&gt;
[**-U** &lt;_username_&gt;] [**-P** &lt;_password_&gt;] &lt;_command_&gt;

A hostname must be given on the command line in order to use the 
lan interface with ipmitool.  The password field is optional;
if you do not provide a password on the command line, ipmitool
will attempt to connect without authentication.  If you specify a 
password it will use MD5 authentication if supported by the BMC
and straight password/key otherwise, unless overridden with a
command line option.

<a name="lanplus-interface"></a>

# Lanplus Interface

Like the _lan_ interface, the _lanplus_ interface
communicates with the BMC over an Ethernet LAN connection using 
UDP under IPv4.  The difference is that the _lanplus_
interface uses the RMCP+ protocol as described in the IPMI v2.0
specification.  RMCP+ allows for improved authentication and data 
integrity checks, as well as encryption and the ability to carry
multiple types of payloads.  Generic Serial Over LAN support 
requires RMCP+, so the ipmitool _sol activate_ command
requires the use of the _lanplus_ interface.

RMCP+ session establishment uses a symmetric challenge-response
protocol called RAKP (**Remote Authenticated Key-Exchange Protocol**)
which allows the negotiation of many options.  ipmitool does not
yet allow the user to specify the value of every option, defaulting
to the most obvious settings marked as required in the v2.0 
specification.  Authentication and integrity HMACS are produced with
SHA1, and encryption is performed with AES-CBC-128.  Role-level logins
are not yet supported.

ipmitool must be linked with the _OpenSSL_ library in order to
perform the encryption functions and support the _lanplus_
interface.  If the required packages are not found it will not be
compiled in and supported.

You can tell ipmitool to use the lanplus interface with the
**-I** _lanplus_ option:


ipmitool **-I** _lanplus_ 
**-H** &lt;_hostname_&gt;
[**-U** &lt;_username_&gt;]
[**-P** &lt;_password_&gt;]
&lt;_command_&gt;

A hostname must be given on the command line in order to use the 
lan interface with ipmitool.  With the exception of the **-A** and
**-C** options the rest of the command line options are identical to
those available for the _lan_ interface.

The **-C** option allows you specify the authentication, integrity,
and encryption algorithms to use for for _lanplus_ session based
on the cipher suite ID found in the IPMIv2.0 specification in table
22-19.  The default cipher suite is _3_ which specifies
RAKP-HMAC-SHA1 authentication, HMAC-SHA1-96 integrity, and AES-CBC-128
encryption algorightms.


<a name="free-interface"></a>

# Free Interface


The ipmitool _free_ interface utilizes the FreeIPMI libfreeipmi
drivers.  

You can tell ipmitool to use the FreeIPMI interface with the -I option:

ipmitool **-I** _free_ &lt;_command_&gt;



<a name="imb-interface"></a>

# Imb Interface


The ipmitool _imb_ interface supports the Intel IMB (Intel
Inter-module Bus) Interface through the /dev/imb device.  

You can tell ipmitool to use the IMB interface with the -I option:

ipmitool **-I** _imb_ &lt;_command_&gt;


<a name="examples"></a>

# Examples


* _Example 1_: Listing remote sensors  
  
  &gt; ipmitool -I lan -H 1.2.3.4 -f passfile sdr list  
  Baseboard 1.25V  | 1.24 Volts        | ok  
  Baseboard 2.5V   | 2.49 Volts        | ok  
  Baseboard 3.3V   | 3.32 Volts        | ok
* _Example 2_: Displaying status of a remote sensor  
  
  &gt; ipmitool -I lan -H 1.2.3.4 -f passfile sensor get "Baseboard 1.25V"  
  Locating sensor record...  
  Sensor ID              : Baseboard 1.25V (0x10)  
  Sensor Type (Analog)   : Voltage  
  Sensor Reading         : 1.245 (+/- 0.039) Volts  
  Status                 : ok  
  Lower Non-Recoverable  : na  
  Lower Critical         : 1.078  
  Lower Non-Critical     : 1.107  
  Upper Non-Critical     : 1.382  
  Upper Critical         : 1.431  
  Upper Non-Recoverable  : na 
* _Example 3_: Displaying the power status of a remote chassis  
  
  &gt; ipmitool -I lan -H 1.2.3.4 -f passfile chassis power status  
  Chassis Power is on
* _Example 4_: Controlling the power on a remote chassis  
  
  &gt; ipmitool -I lan -H 1.2.3.4 -f passfile chassis power on  
  Chassis Power Control: Up/On
  	

<a name="author"></a>

# Author

Duncan Laurie &lt;[duncan@iceblink.org](mailto:duncan@iceblink.org)&gt;

<a name="see-also"></a>

# See Also


* IPMItool Homepage  
  http://ipmitool.sourceforge.net
* Intelligent Platform Management Interface Specification  
  http://www.intel.com/design/servers/ipmi
* OpenIPMI Homepage  
  http://openipmi.sourceforge.net
* FreeIPMI Homepage  
  http://www.gnu.org/software/freeipmi/
