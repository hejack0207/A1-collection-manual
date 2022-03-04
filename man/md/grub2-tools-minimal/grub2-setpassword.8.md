# grub-set-password(3) - Generate the user.cfg file containing the hashed grub bootloader password.

Thu Jun 25 2015

```
grub-set-password [OPTION]
```


<a name="description"></a>

# Description

**grub-set-password** outputs the user.cfg file which contains the hashed GRUB bootloader password. This utility only supports configurations where there is a single root user.

The file has the format:
GRUB2\_PASSWORD=&lt;_hashed password_&gt;.


<a name="options"></a>

# Options


* -h, --help  
  Display program usage and exit.
* -v, --version  
  Display the current version.
* -o, --output=&lt;_DIRECTORY_&gt;  
  Choose the file path to which user.cfg will be written.
  

<a name="see-also"></a>

# See Also

**info grub**

**info grub2-mkpasswd-pbkdf2**
