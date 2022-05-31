# i3\-config\-wizard(1)

i3 4\&.18\&.1, 04/23/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

i3-config-wizard - creates a keysym based config based on your layout

<a name="synopsis"></a>

# Synopsis

```

 i3-config-wizard [-s socket] [-m modifier] [-v] [-h]
```

<a name="options"></a>

# Options


**-s, --socket** _socket_
Overwrites the path to the i3 IPC socket.

**-m, --modifier** _modifier_
Generates the configuration file headlessly. Accepts win or alt.

**-v, --version**
Display version number and exit.

**-h, --help**
Display a short help message and exit.

<a name="files"></a>

# Files


<a name="etci3configkeycodes"></a>

### /etc/i3/config\&.keycodes


This file contains the default configuration with keycodes. All the bindcode lines will be transformed to bindsym and the user-specified modifier will be used.

<a name="description"></a>

# Description


i3-config-wizard is started by i3 in its default config, unless /.i3/config exists. i3-config-wizard creates a keysym based i3 config file (based on /etc/i3/config.keycodes) in /.i3/config.

The advantage of using keysyms is that the config file is easy to read, understand and modify. However, if we shipped with a keysym based default config file, the key positions would not be consistent across different keyboard layouts (take for example the homerow for movement). Therefore, we ship with a keycode based default config and let the wizard transform it according to your current keyboard layout.

<a name="see-also"></a>

# See Also


i3(1)

<a name="author"></a>

# Author


Michael Stapelberg and contributors
