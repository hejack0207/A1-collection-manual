# btattach(1) - attach serial devices to BlueZ stack

BlueZ, November 2015

```
btattach [\|-B device\|] [\|-A device\|] [\|-P protocol\|] [\|-R\|]
```


<a name="description"></a>

# Description


btattach is used to attach a serial UART to the Bluetooth stack as a
transport interface.


<a name="options"></a>

# Options


* **-B**_ device_**,**_ _**--bredr**_ device_  
  Attach a BR/EDR controller.
* **-A**_ device_**,**_ _**--amp**_ device_  
  Attach an AMP controller.
* **-P**_ protocol_**,**_ _**--protocol**_ protocol_  
  Specify the protocol type for talking to the device.
  Supported values are:
    * ·  
      **h4**
    * ·  
      **bcsp**
    * ·  
      **3wire**
    * ·  
      **h4ds**
    * ·  
      **ll**
    * ·  
      **ath3k**
    * ·  
      **intel**
    * ·  
      **bcm**
    * ·  
      **qca**
* **-R**  
  Set the device into raw mode (the kernel and bluetoothd will ignore it).
