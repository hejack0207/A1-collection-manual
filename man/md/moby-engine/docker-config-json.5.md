# config.json(5)

Docker Community,  Docker User Manuals

.nh



<a name="name"></a>

# Name


HOME/.docker/config.json - Default Docker configuration file



<a name="introduction"></a>

# Introduction


By default, the Docker command line stores its configuration files in a
directory called **\fC.docker** within your **\fC$HOME** directory.  Docker manages most of
the files in the configuration directory and you should not modify them.
However, you _can modify_ the **\fCconfig.json** file to control certain aspects of
how the **\fCdocker** command behaves.


Currently, you can modify the **\fCdocker** command behavior using environment
variables or command-line options. You can also use options within
**\fCconfig.json** to modify some of the same behavior. When using these
mechanisms, you must keep in mind the order of precedence among them. Command
line options override environment variables and environment variables override
properties you specify in a **\fCconfig.json** file.


The **\fCconfig.json** file stores a JSON encoding of several properties:


* ·  
  

The **\fCHttpHeaders** property specifies a set of headers to include in all messages
sent from the Docker client to the daemon. Docker does not try to interpret or
understand these header; it simply puts them into the messages. Docker does not
allow these headers to change any headers it sets for itself.

* ·  
  

The **\fCpsFormat** property specifies the default format for **\fCdocker ps** output.
When the **\fC--format** flag is not provided with the **\fCdocker ps** command,
Docker's client uses this property. If this property is not set, the client
falls back to the default table format. For a list of supported formatting
directives, see **docker-ps(1)**.

* ·  
  

The **\fCdetachKeys** property specifies the default key sequence which
detaches the container. When the **\fC--detach-keys** flag is not provide
with the **\fCdocker attach**, **\fCdocker exec**, **\fCdocker run** or \fCdocker
start, Docker's client uses this property. If this property is not
set, the client falls back to the default sequence **\fCctrl-p,ctrl-q**.

* ·  
  

The **\fCimagesFormat** property  specifies the default format for **\fCdocker images**
output. When the **\fC--format** flag is not provided with the **\fCdocker images**
command, Docker's client uses this property. If this property is not set, the
client falls back to the default table format. For a list of supported
formatting directives, see **docker-images(1)**.



You can specify a different location for the configuration files via the
**\fCDOCKER\\_CONFIG** environment variable or the **\fC--config** command line option. If
both are specified, then the **\fC--config** option overrides the **\fCDOCKER\\_CONFIG**
environment variable:



    docker --config &nbsp;/testconfigs/ ps
    


This command instructs Docker to use the configuration files in the
**\fC&nbsp;/testconfigs/** directory when running the **\fCps** command.


<a name="examples"></a>

# Examples


Following is a sample **\fCconfig.json** file:



    {
      "HttpHeaders": {
        "MyHeader": "MyValue"
      },
      "psFormat": "table {{.ID}}\\t{{.Image}}\\t{{.Command}}\\t{{.Labels}}",
      "imagesFormat": "table {{.ID}}\\t{{.Repository}}\\t{{.Tag}}\\t{{.CreatedAt}}",
      "detachKeys": "ctrl-e,e"
    }
    



<a name="history"></a>

# History


January 2016, created by Moxiegirl 
\[la]mary@docker.com\[ra]
