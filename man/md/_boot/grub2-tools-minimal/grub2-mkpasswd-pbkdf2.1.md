# grub-mkpasswd-pbkdf2(3) - Generate a PBKDF2 password hash.

Wed Feb 26 2014

```
grub-mkpasswd-pbkdf2 [-c | --iteration-count=NUM] [-l | --buflen=NUM] .RS 22 [-s | --salt=NUM]
```


<a name="description"></a>

# Description

**grub-mkpasswd-pbkdf2** generates a PBKDF2 password string suitable for use in a GRUB configuration file.


<a name="options"></a>

# Options


* --iteration-count=_NUM_  
  Number of PBKDF2 iterations.
  
* --buflen=_NUM_  
  Length of generated hash.
  
* --salt=_NUM_  
  Length of salt to use.
  

<a name="see-also"></a>

# See Also

**info grub**
