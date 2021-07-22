# mouse-test(1) - a tool for determining mouse type and device it's attached to.

"", March 26, 1998

```
mouse-test [ device ... ]
```

<a name="description"></a>

# Description



This experimental and incomplete application tries to help in detecting
which protocol does your mouse speak. It is able to detect MouseMan
devices, and to choose between -t ms (three-buttons aware) and
-t bare old two-buttons-only serial mice.



<a name="bugs"></a>

# Bugs



I know the application is buggy, but I only own one mouse device.
If you are interested in this application, just call me and awake me
from my laziness.



<a name="options"></a>

### OPTIONS


* _device_  
  [ _device_ ... ]

Check this _device_ for a mouse.  If no devices are listed, mouse-test will try all possible devices.



<a name="author"></a>

# Author

Alessandro Rubini &lt;[rubini@linux.it](mailto:rubini@linux.it)&gt;



<a name="files"></a>

# Files

    /dev/*              The devices used to search for a mouse



<a name="see-also"></a>

# See Also

    gpm(8)
    
