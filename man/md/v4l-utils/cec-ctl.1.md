# cec-ctl(1) - An application to control cec devices

v4l-utils 1.16.7, August 2016

```
cec-ctl [-h] [-d <dev>] [many other options]
```

<a name="description"></a>

# Description

The cec-ctl tool is used to control cec devices. It is able to control almost
any aspect of such devices covering the full CEC API.


<a name="options"></a>

# Options


* **-d**, **--device** _&lt;dev&gt;_  
  Use device &lt;dev&gt; as the CEC device. If &lt;dev&gt; is a number, then /dev/cec&lt;dev&gt; is used.
* **-v**, **--verbose**  
  Turn on verbose reporting.
* **-w**, **--wall-clock**  
  Show timestamps as wall-clock time. This also turns on verbose reporting. 
* **-h**, **--help**  
  Prints the help message.
* **-p**, **--phys-addr** _&lt;addr&gt;_  
  Use this physical address. The address can be a number (e.g. 0 or 0x11b1)
  or formatted as a.b.c.d where each component is a hex value from 0-f
  (e.g. 0.0.0.0 or 1.1.b.1).
* **-o**, **--osd-name** _&lt;name&gt;_  
  Use this OSD name. The maximum length is 14 characters.
* **-V**, **--vendor-id** _&lt;id&gt;_  
  Use this vendor ID. The vendor ID is a number from 0x0 to 0xffffff.
* **-l**, **--logical-address**  
  Show first configured logical address or nothing if the device is unconfigured.
  Useful for scripts, e.g.: la=\`cec-ctl -s -l\`
* **-L**, **--logical-addresses**  
  Show all configured logical addresses or nothing if the device is unconfigured.
  Useful for scripts, e.g.: las=\`cec-ctl -s -L\`
* **-C**, **--clear**  
  Clear all logical addresses, leaving the CEC device unconfigured.
* **-n**, **--no-reply**  
  By default when sending a CEC message that expects a reply this utility will
  wait for that reply. With this option it will just send it without waiting
  for the reply. This option applies to the messages following this option.
  It acts as a toggle, so after you specify it a second time then the following
  messages will wait for a reply again. 
* **-N**, **--non-blocking**  
  Transmit messages in non-blocking mode.
* **-t**, **--to** _&lt;la&gt;_  
  Send the message to the given logical address (0-15).
* **-f**, **--from** _&lt;la&gt;_  
  Send message from the given logical address. It is only necessary to use this
  option if multiple logical addresses are claimed. By default the first assigned
  logical address will be used.
* **-r**, **--show-raw**  
  Show the raw CEC message in hex.
* **-s**, **--skip-info**  
  Skip the Driver Info output section.
* **-S**, **--show-topology**  
  Show the CEC topology, detecting which other CEC devices are on the CEC bus.
* **-P**, **--poll**  
  Send a poll message.
* **-T**, **--trace**  
  Trace all called ioctls. Useful for debugging.
* **--cec-version-1.4**  
  Use CEC Version 1.4 instead of 2.0 (the default).
* **--allow-unreg-fallback**  
  Allow fallback to Unregistered if all logical addresses are claimed.
  By default the adapter will remain unconfigured.
* **--no-rc-passthrough**  
  Disable the RC passthrough. By default remote control CEC messages are
  passed on as input keystrokes (the **CEC\_LOG\_ADDRS\_FL\_ALLOW\_RC\_PASSTHRU**
  flag is set when calling the **CEC\_ADAP\_S\_LOG\_ADDRS** ioctl), but this
  can be blocked by using this option.
* **--reply-to-followers**  
  The reply will be sent to followers as well. By default the reply will only
  go to the follower that initiated the CEC message. But if you have other
  followers running as well, then by giving this option they will also receive
  the reply.
* **--timeout** _&lt;ms&gt;_  
  Set the reply timeout in milliseconds (default is 1000 ms).
* **--list-ui-commands**  
  List all UI commands that can be used with option **--control-pressed**.
* **--tv**  
  Configure the CEC adapter as a TV.
* **--record**  
  Configure the CEC adapter as a recording and playback device.
* **--tuner**  
  Configure the CEC adapter as a tuner device.
* **--playback**  
  Configure the CEC adapter as a playback device.
* **--audio**  
  Configure the CEC adapter as an audio system device.
* **--processor**  
  Configure the CEC adapter as a processor device.
* **--switch**  
  Configure the CEC adapter as a pure CEC switch.
* **--cdc-only**  
  Configure the CEC adapter as a CDC-only device.
* **--unregistered**  
  Configure the CEC adapter as an unregistered device.
  **--feat-record-tv-screen**
  Signal the Record TV Screen feature.
* **--feat-set-osd-string**  
  Signal the Set OSD String feature.
* **--feat-deck-control**  
  Signal the Deck Control feature.
* **--feat-set-audio-rate**  
  Signal the Set Audio Rate feature.
* **--feat-sink-has-arc-tx**  
  Signal the sink ARC Tx feature.
* **--feat-source-has-arc-rx**  
  Signal the source ARC Rx feature.
* **--rc-tv-profile-1**  
  Signal RC TV Profile 1.
* **--rc-tv-profile-2**  
  Signal RC TV Profile 2.
* **--rc-tv-profile-3**  
  Signal RC TV Profile 3.
* **--rc-tv-profile-4**  
  Signal RC TV Profile 4.
* **--rc-src-dev-root**  
  Signal that the RC source has a Dev Root Menu.
* **--rc-src-dev-setup**  
  Signal that the RC source has a Dev Setup Menu.
* **--rc-src-contents**  
  Signal that the RC source has a Contents Menu.
* **--rc-src-media-top**  
  Signal that the RC source has a Media Top Menu.
* **--rc-src-media-context**  
  Signal that the RC source has a Media Context Menu.
* **-m**, **--monitor**  
  Start monitoring CEC traffic. This will monitor broadcast messages,
  messages directed to this CEC adapter and messages transmitted by this
  CEC adapter. Directed messages between other CEC devices are not
  monitored. This option requires root.
* **-M**, **--monitor-all**  
  Start monitoring all CEC traffic. This will monitor all CEC messages,
  including directed messages between other CEC devices. This option requires root.
  Not all CEC devices support this monitoring mode. It will fallback to regular
  monitoring mode if it is not supported.
* **--monitor-pin**  
  Start monitoring and analyzing the low-level CEC pin transitions. This is only
  possible if the device has the CEC_CAP_MONITOR_PIN capability. This option requires root.
  When in pin monitoring mode all 0-&gt;1 and 1-&gt;0 CEC pin transitions are monitored and
  analysed. This is effectively a cheap CEC bus analyzer.
* **--monitor-time** _&lt;secs&gt;_  
  Monitor for the given number of seconds, then exit. The default (0) is to monitor
  forever.
* **--ignore** _&lt;la&gt;_,_&lt;opcode&gt;_  
  Ignore messages from logical address &lt;la&gt; and opcode &lt;opcode&gt; when monitoring.
  "all" can be used for &lt;la&gt; or &lt;opcode&gt; to match all logical addresses or opcodes.
  To ignore poll messages use "poll" as &lt;opcode&gt;.
* **--store-pin** _&lt;to&gt;_  
  Store the CEC pin events to the given file. This can be read and analyzed later
  via the **--analyze-pin** option. Use - to write to stdout instead of to a file.
* **--analyze-pin** _&lt;from&gt;_  
  Read and analyze the CEC pin events from the given file. Use - to read from stdin
  instead of from a file.
* **--help-all**  
  Prints the help message for all options.
* **--help-audio-rate-control**  
  Show help for the Audio Rate Control feature.
* **--help-audio-return-channel-control**  
  Show help for the Audio Return Channel Control feature.
* **--help-capability-discovery-and-control**  
  Show help for the Capability Discovery and Control feature.
* **--help-deck-control**  
  Show help for the Deck Control feature.
* **--help-device-menu-control**  
  Show help for the Device Menu Control feature.
* **--help-device-osd-transfer**  
  Show help for the Device OSD Transfer feature.
* **--help-dynamic-audio-lipsync**  
  Show help for the Dynamic Audio Lipsync feature.
* **--help-htng**  
  Show help for the Hospitality Profile Next Generation feature.
  This is an optional CEC extension for Hotel displays and is not
  generally available for regular displays. See http://www.htng.org
  for more information.
* **--help-osd-display**  
  Show help for the OSD Display feature.
* **--help-one-touch-play**  
  Show help for the One Touch Play feature.
* **--help-one-touch-record**  
  Show help for the One Touch Record feature.
* **--help-power-status**  
  Show help for the Power Status feature.
* **--help-remote-control-passthrough**  
  Show help for the Remote Control Passthrough feature.
* **--help-routing-control**  
  Show help for the Routing Control feature.
* **--help-standby**  
  Show help for the Standby feature.
* **--help-system-audio-control**  
  Show help for the System Audio Control feature.
* **--help-system-information**  
  Show help for the System Information feature.
* **--help-timer-programming**  
  Show help for the Timer Programming feature.
* **--help-tuner-control**  
  Show help for the Tuner Control feature.
* **--help-vendor-specific-commands**  
  Show help for the Vendor Specific Commands feature.

<a name="exit-status"></a>

# Exit Status

On success, it returns 0. Otherwise, it will return the error code.

<a name="bugs"></a>

# Bugs

This manual page is a work in progress.

Bug reports or questions about this utility should be sent to the linux-media@vger.kernel.org
mailinglist.
