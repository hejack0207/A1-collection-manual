# androiddump(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

androiddump - Provide interfaces to capture from Android devices

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" androiddump [&nbsp;--help&nbsp;] [&nbsp;--version&nbsp;] [&nbsp;--extcap-version&nbsp;] [&nbsp;--debug&nbsp;] [&nbsp;--extcap-interfaces&nbsp;] [&nbsp;--extcap-dlts&nbsp;] [&nbsp;--extcap-interface=<interface>&nbsp;] [&nbsp;--extcap-config&nbsp;] [&nbsp;--capture&nbsp;] [&nbsp;--fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe>&nbsp;] [&nbsp;--adb-server-ip=<\s-1IP\s0&nbsp;address>&nbsp;] [&nbsp;--adb-server-tcp-port=<\s-1TCP\s0&nbsp;port>&nbsp;] [&nbsp;--logcat-text=<\s-1TRUE\s0&nbsp;or&nbsp;\s-1FALSE\s0>&nbsp;] [&nbsp;--bt-server-tcp-port=<\s-1TCP\s0&nbsp;port>&nbsp;] [&nbsp;--bt-forward-socket=<\s-1TRUE\s0&nbsp;or&nbsp;\s-1FALSE\s0>&nbsp;] [&nbsp;--bt-local-ip=<\s-1IP\s0&nbsp;address>&nbsp;] [&nbsp;--bt-local-tcp-port=<\s-1TCP\s0&nbsp;port>&nbsp;] 
 androiddump &nbsp;--extcap-interfaces&nbsp; [&nbsp;--adb-server-ip=<\s-1IP\s0&nbsp;address>&nbsp;] [&nbsp;--adb-server-tcp-port=<\s-1TCP\s0&nbsp;port>&nbsp;] 
 androiddump &nbsp;--extcap-interface=<interface>&nbsp; [&nbsp;--extcap-dlts&nbsp;] 
 androiddump &nbsp;--extcap-interface=<interface>&nbsp; [&nbsp;--extcap-config&nbsp;] 
 androiddump &nbsp;--extcap-interface=<interface>&nbsp; &nbsp;--fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe>&nbsp; &nbsp;--capture&nbsp;```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Androiddump** is a extcap tool that provide interfaces to capture from
Android device. There is only two requirements:

1. You must have Android \s-1SDK\s0 and add it \s-1PATH\s0 environment variable.
\s-1PATH\s0 should contain directory with tools like adb\*(R" and \*(L"android\*(R".
Android \s-1SDK\s0 for various platform are available on:
https://developer.android.com/sdk/index.html#Other

2. You must have permission to Android devices. Some Android devices requires
on-screen authentication.

Supported interfaces:

* 1. Logcat Main (binary [&lt;=Jelly Bean] or text)  
  .IX Item "1. Logcat Main (binary [&lt;=Jelly Bean] or text)"
* 2. Logcat System (binary [&lt;=Jelly Bean] or text)  
  .IX Item "2. Logcat System (binary [&lt;=Jelly Bean] or text)"
* 3. Logcat Events (binary [&lt;=Jelly Bean] or text)  
  .IX Item "3. Logcat Events (binary [&lt;=Jelly Bean] or text)"
* 4. Logcat Radio (binary [&lt;=Jelly Bean] or text)  
  .IX Item "4. Logcat Radio (binary [&lt;=Jelly Bean] or text)"
* 5. Logcat Crash (text; from Lollipop)  
  .IX Item "5. Logcat Crash (text; from Lollipop)"
* 6. Bluetooth Hcidump [&lt;=Jelly Bean]  
  .IX Item "6. Bluetooth Hcidump [&lt;=Jelly Bean]"
* 7. Bluetooth Bluedroid External Parser [Kitkat]  
  .IX Item "7. Bluetooth Bluedroid External Parser [Kitkat]"
* 8. Bluetooth BtsnoopNet [&gt;=Lollipop]  
  .IX Item "8. Bluetooth BtsnoopNet [&gt;=Lollipop]"
* 9. WiFi tcpdump [need tcpdump on phone]  
  .IX Item "9. WiFi tcpdump [need tcpdump on phone]"

Please note that it will work also for FirefoxOS or other Android-based stuffs.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* --help  
  .IX Item "--help"
  Print program arguments.
* --version  
  .IX Item "--version"
  Print program version.
* --extcap-version  
  .IX Item "--extcap-version"
  Print extcapized version.
* --debug  
  .IX Item "--debug"
  Print additional messages.
* --extcap-interfaces  
  .IX Item "--extcap-interfaces"
  List available interfaces.
* --extcap-interface=&lt;interface&gt;  
  .IX Item "--extcap-interface=&lt;interface&gt;"
  Use specified interfaces.
* --extcap-dlts  
  .IX Item "--extcap-dlts"
  List DLTs of specified interface.
* --extcap-config  
  .IX Item "--extcap-config"
  List configuration options of specified interface.
* --capture  
  .IX Item "--capture"
  Start capturing from specified interface save saved it in place specified by --fifo.
* --fifo=&lt;path to file or pipe&gt;  
  .IX Item "--fifo=&lt;path to file or pipe&gt;"
  Save captured packet to file or send it through pipe.
* --adb-server-ip=&lt;\s-1IP\s0 address&gt;  
  .IX Item "--adb-server-ip=&lt;IP address&gt;"
  Use other then default (127.0.0.1) \s-1ADB\s0 daemon's \s-1IP\s0 address.
* --adb-server-tcp-port=&lt;\s-1TCP\s0 port&gt;  
  .IX Item "--adb-server-tcp-port=&lt;TCP port&gt;"
  Use other then default (5037) \s-1ADB\s0 daemon's \s-1TCP\s0 port.
* --logcat-text=&lt;\s-1TRUE\s0 or \s-1FALSE\s0&gt;  
  .IX Item "--logcat-text=&lt;TRUE or FALSE&gt;"
  If \s-1TRUE\s0 then use text logcat rather then binary. This option has effect only on
  Logcat interfaces. This have no effect from Lollipop where is no binary Logcat
  available.
  .Sp
  Defaults to \s-1FALSE.\s0
* --bt-server-tcp-port=&lt;\s-1TCP\s0 port&gt;  
  .IX Item "--bt-server-tcp-port=&lt;TCP port&gt;"
  Use other then default Bluetooth server \s-1TCP\s0 port on Android side.
  On Lollipop defaults is 8872, earlier 4330.
* --bt-forward-socket=&lt;\s-1TRUE\s0 or \s-1FALSE\s0&gt;  
  .IX Item "--bt-forward-socket=&lt;TRUE or FALSE&gt;"
  If \s-1TRUE\s0 then socket from Android side is forwarded to host side.
  .Sp
  Defaults to \s-1FALSE.\s0
* --bt-local-ip=&lt;\s-1IP\s0 address&gt;  
  .IX Item "--bt-local-ip=&lt;IP address&gt;"
  Use other then default (127.0.0.1) \s-1IP\s0 address on host side for forwarded socket.
* --bt-local-tcp-port=&lt;\s-1TCP\s0 port&gt;  
  .IX Item "--bt-local-tcp-port=&lt;TCP port&gt;"
  Specify port to be used on host side for forwarded socket.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see program arguments:

.Vb 1
    androiddump --help
.Ve

To see program version:

.Vb 1
    androiddump --version
.Ve

To see interfaces:

.Vb 1
    androiddump --extcap-interfaces

  Example output:
    interface {display=Android Logcat Main unknown MSM7627A}{value=android-logcat-main-MSM7627A}
    interface {display=Android Logcat System unknown MSM7627A}{value=android-logcat-system-MSM7627A}
    interface {display=Android Logcat Radio unknown MSM7627A}{value=android-logcat-radio-MSM7627A}
    interface {display=Android Logcat Events unknown MSM7627A}{value=android-logcat-events-MSM7627A}
    interface {display=Android Bluetooth Hcidump unknown MSM7627A}{value=android-bluetooth-hcidump-MSM7627A}

    Human-readable display name of interfaces contains interface type, one of:
        android-logcat-main (Android Logcat Main)
        android-logcat-system (Android Logcat System)
        android-logcat-radio (Android Logcat Radio)
        android-logcat-events (Android Logcat Events)
        android-logcat-text-main (Android Logcat Main)
        android-logcat-text-system (Android Logcat System)
        android-logcat-text-radio (Android Logcat Radio)
        android-logcat-text-events (Android Logcat Events)
        android-logcat-text-crash (Android Logcat Crash)
        android-bluetooth-hcidump (Android Bluetooth Hcidump)
        android-bluetooth-external-parser (Android Bluetooth External Parser)
        android-bluetooth-btsnoop-net (Android Bluetooth Btsnoop Net)
        android-wifi-tcpdump (Android WiFi)
    Then Android Devices name if available, otherwise "unknown".
    Last part of it is DeviceID - the identificator of the device provided by Android SDK (see "adb devices").

    For example:
    "Android Logcat Main unknown MSM7627A"

    "Android Logcat Main" - user-friendly type of interface
    "unknown" - name of Android Device
    "MSM7627A" - device ID
.Ve

To see interface DLTs:

.Vb 1
    androiddump --extcap-interface=android-bluetooth-hcidump-MSM7627A --extcap-dlts

  Example output:
    dlt {number=99}{name=BluetoothH4}{display=Bluetooth HCI UART transport layer plus pseudo-header}
.Ve

To see interface configuration options:

.Vb 1
    androiddump --extcap-interface=android-bluetooth-hcidump-MSM7627A --extcap-config

  Example output:
    arg {number=0}{call=--adb-server-ip}{display=ADB Server IP Address}{type=string}{default=127.0.0.1}
    arg {number=1}{call=--adb-server-tcp-port}{display=ADB Server TCP Port}{type=integer}{range=0,65535}{default=5037}
.Ve

To capture:

.Vb 1
    androiddump --extcap-interface=android-bluetooth-hcidump-MSM7627A --fifo=/tmp/bluetooth.pcapng --capture
.Ve

\s-1NOTE:\s0 To stop capturing CTRL+C/kill/terminate application.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1), **dumpcap**\|(1), **extcap**\|(4)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**Androiddump** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  -------- ------
  Michal Labedzki             &lt;michal.labedzki[AT]tieto.com&gt;


  Contributors
  ------------
  Roland Knall              &lt;rknall[AT]gmail.com&gt;
.Ve
