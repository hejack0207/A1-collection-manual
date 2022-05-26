# modesetting(4) - video driver for framebuffer device

X Version 11, xorg-server 1.20.11

    "Section Device*q"
      Identifier devname*q
     "  Driver modesetting*q"
      BusID  pci:bus:dev:func*q
    &nbsp;&nbsp;...
    EndSection

<a name="description"></a>

# Description

**modesetting**
is an Xorg driver for KMS devices.  This driver supports
TrueColor visuals at framebuffer depths of 15, 16, 24, and 30. RandR
1.2 is supported for multi-head configurations. Acceleration is available
through glamor for devices supporting at least OpenGL ES 2.0 or OpenGL 2.1.
If glamor is not enabled, a shadow framebuffer is configured based on the
KMS drivers' preference (unless the framebuffer is 24 bits per pixel, in
which case the shadow framebuffer is always used).

<a name="supported-hardware"></a>

# Supported Hardware

The 
**modesetting**
driver supports all hardware where a KMS driver is available.
modesetting uses the Linux DRM KMS ioctls and dumb object create/map.

<a name="configuration-details"></a>

# Configuration Details

Please refer to xorg.conf(5) for general configuration
details.  This section only covers configuration details specific to
this driver.

For this driver it is not required to specify modes in the screen 
section of the config file.  The
**modesetting**
driver can pick up the currently used video mode from the kernel
driver and will use it if there are no video modes configured.

For PCI boards you might have to add a BusID line to the Device
section.  See above for a sample line.

The following driver 
**Options**
are supported:

* **Option SWcursor\*q \*q**_boolean_**\*q**  
  Selects software cursor.  The default is
  **off.**
* **Option kmsdev\*q \*q**_string_**\*q**  
  The framebuffer device to use. Default: /dev/dri/card0.
* **Option ShadowFB\*q \*q**_boolean_**\*q**  
  Enable or disable use of the shadow framebuffer layer.  Default: on.
* **Option DoubleShadow\*q \*q**_boolean_**\*q**  
  Double-buffer shadow updates. When enabled, the driver will keep two copies of
  the shadow framebuffer. When the shadow framebuffer is flushed, the old and new
  versions of the shadow are compared, and only tiles that have actually changed
  are uploaded to the device. This is an optimization for server-class GPUs with
  a remote display function (typically VNC), where remote updates are triggered
  by any framebuffer write, so minimizing the amount of data uploaded is crucial.
  This defaults to enabled for ASPEED and Matrox G200 devices, and disabled
  otherwise.
* **Option AccelMethod\*q \*q**_string_**\*q**  
  One of glamor\*q or \*qnone\*q.  Default: glamor.
* **Option PageFlip\*q \*q**_boolean_**\*q**  
  Enable DRI3 page flipping.  The default is
  **on.**
* **Option ZaphodHeads\*q \*q**_string_**\*q**  
  Specify the RandR output(s) to use with zaphod mode for a particular driver
  instance.  If you use this option you must use this option for all instances
  of the driver.  
  For example:
  .B
  Option ZaphodHeads\*q \*qLVDS,VGA-0\*q
  will assign xrandr outputs LVDS and VGA-0 to this instance of the driver.
* 
<a name="see-also"></a>

# See Also

Xorg(1), xorg.conf(5), Xserver(1),
X(7)

<a name="authors"></a>

# Authors

Authors include: Dave Airlie
