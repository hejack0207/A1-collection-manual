# wireless(7) - Wireless Tools and Wireless Extensions

wireless-tools, 4 March 2004

```
iwconfig
iwpriv -a

```




<a name="description"></a>

# Description

The
**Wireless Extensions**
is an API allowing you manipulate Wireless LAN networking interfaces.
It is composed of a variety of tools and configuration files. It is
documented in more detail in the Linux Wireless LAN Howto.  
The
**Wireless Tools**
are used to change the configuration of wireless LAN networking
interfaces on the fly, to get their current configuration, to get
statistics and diagnose them. They are described in their own man
page, see below for references.  
**Wireless configuration**
is specific to each Linux distribution. This man page will contain in
the future the configuration procedure for a few common
distributions. For the time being, check the file DISTRIBUTIONS.txt
included with the Wireless Tools package.




<a name="debian-30"></a>

# Debian 3.0

In Debian 3.0 (and later) you can configure wireless LAN networking
devices using the network configuration tool
**ifupdown**(8).

* **File :**  
  _/etc/network/interfaces_
* **Form :**  
  wireless-_&lt;function&gt; &lt;value&gt;_  
  wireless-essid Home  
  wireless-mode Ad-Hoc
* **See also :**  
  _/etc/network/if-pre-up.d/wireless-tools_  
  _/usr/share/doc/wireless-tools/README.Debian_
  
  
  

<a name="suse-80"></a>

# Suse 8.0

SuSE 8.0 (and later) has integrated wireless configuration in their
network scripts.

* **Tool :**  
  **Yast2**
* **File :**  
  _/etc/sysconfig/network/wireless_  
  _/etc/sysconfig/network/ifcfg-*_
* **Form :**  
  WIRELESS__&lt;function&gt;_=_&lt;value&gt;_  
  WIRELESS_ESSID="Home"  
  WIRELESS_MODE=Ad-Hoc
* **See also :**  
  man ifup  
  info scpm
  
  
  

<a name="original-pcmcia-scripts"></a>

# Original Pcmcia Scripts

If you are using the original configuration scripts from the Pcmcia
package, you can use this method.

* **File :**  
  _/etc/pcmcia/wireless.opts_
* **Form :**  
  *,*,*,*)  
      ESSID="Home"  
      MODE="Ad-Hoc"  
      ;;
* **See also :**  
  _/etc/pcmcia/wireless_  
  File
  _PCMCIA.txt_
  part of Wireless Tools package
  
  
  

<a name="author"></a>

# Author

Jean Tourrilhes - [jt@hpl.hp](mailto:jt@hpl.hp).com  
_http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/_




<a name="see-also"></a>

# See Also

**iwconfig**(8),
**iwlist**(8),
**iwspy**(8),
**iwpriv**(8),
**iwevent**(8).
