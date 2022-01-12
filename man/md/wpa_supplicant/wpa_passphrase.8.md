# wpa_passphrase(8) - Generate a WPA PSK from an ASCII passphrase for a SSID

"", 12 April 2019

```

 wpa_passphrase [ ssid ]  [ passphrase ] 
```

<a name="overview"></a>

# Overview


**wpa\_passphrase** pre-computes PSK entries for
network configuration blocks of a
_wpa\_supplicant.conf_ file. An ASCII passphrase
and SSID are used to generate a 256-bit PSK.

<a name="options"></a>

# Options


* **ssid**  
  The SSID whose passphrase should be derived.
* **passphrase**  
  The passphrase to use. If not included on the command line,
  passphrase will be read from standard input.

<a name="see-also"></a>

# See Also


**wpa\_supplicant.conf**(5)
**wpa\_supplicant**(8)

<a name="legal"></a>

# Legal


wpa_supplicant is copyright (c) 2003-2017,
Jouni Malinen &lt;j@w1.fi&gt; and
contributors.
All Rights Reserved.

This program is licensed under the BSD license (the one with
advertisement clause removed).
