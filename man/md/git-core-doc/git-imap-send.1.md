# git\-imap\-send(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-imap-send - Send a collection of patches from stdin to an IMAP folder

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git imap-send [-v] [-q] [--[no-]curl]
<synopsis>


```

<a name="description"></a>

# Description


This command uploads a mailbox generated with _git format-patch_ into an IMAP drafts folder. This allows patches to be sent as other email is when using mail clients that cannot read mailbox files directly. The command also works with any general mailbox in which emails have the fields "From", "Date", and "Subject" in that order.

Typical usage is something like:

git format-patch --signoff --stdout --attach origin | git imap-send

<a name="options"></a>

# Options


-v, --verbose
Be verbose.

-q, --quiet
Be quiet.

--curl
Use libcurl to communicate with the IMAP server, unless tunneling into it. Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND option set.

--no-curl
Talk to the IMAP server using git’s own IMAP routines instead of using libcurl. Ignored if Git was built with the NO_OPENSSL option set.

<a name="configuration"></a>

# Configuration


To use the tool, imap.folder and either imap.tunnel or imap.host must be set to appropriate values.

<a name="variables"></a>

### Variables


imap.folder
The folder to drop the mails into, which is typically the Drafts folder. For example: "INBOX.Drafts", "INBOX/Drafts" or "[Gmail]/Drafts". Required.

imap.tunnel
Command used to setup a tunnel to the IMAP server through which commands will be piped instead of using a direct network connection to the server. Required when imap.host is not set.

imap.host
A URL identifying the server. Use an
**imap://**
prefix for non-secure connections and an
**imaps://**
prefix for secure connections. Ignored when imap.tunnel is set, but required otherwise.

imap.user
The username to use when logging in to the server.

imap.pass
The password to use when logging in to the server.

imap.port
An integer port number to connect to on the server. Defaults to 143 for imap:// hosts and 993 for imaps:// hosts. Ignored when imap.tunnel is set.

imap.sslverify
A boolean to enable/disable verification of the server certificate used by the SSL/TLS connection. Default is
**true**. Ignored when imap.tunnel is set.

imap.preformattedHTML
A boolean to enable/disable the use of html encoding when sending a patch. An html encoded patch will be bracketed with &lt;pre&gt; and have a content type of text/html. Ironically, enabling this option causes Thunderbird to send the patch as a plain/text, format=fixed email. Default is
**false**.

imap.authMethod
Specify authenticate method for authentication with IMAP server. If Git was built with the NO_CURL option, or if your curl version is older than 7.34.0, or if you’re running git-imap-send with the
**--no-curl**
option, the only supported method is
_CRAM-MD5_. If this is not set then
_git imap-send_
uses the basic IMAP plaintext LOGIN command.

<a name="examples"></a>

### Examples


Using tunnel mode:

.if n \{.RS 4
.\}
    [imap]
        folder = "INBOX.Drafts"
        tunnel = "ssh -q -C user@example.com /usr/bin/imapd ./Maildir 2> /dev/null"
.if n \{.RE
.\}

Using direct mode:

.if n \{.RS 4
.\}
    [imap]
        folder = "INBOX.Drafts"
        host = imap://imap.example.com
        user = bob
        pass = p4ssw0rd
.if n \{.RE
.\}

Using direct mode with SSL:

.if n \{.RS 4
.\}
    [imap]
        folder = "INBOX.Drafts"
        host = imaps://imap.example.com
        user = bob
        pass = p4ssw0rd
        port = 123
        sslverify = false
.if n \{.RE
.\}

<a name="examples"></a>

# Examples


To submit patches using GMail’s IMAP interface, first, edit your ~/.gitconfig to specify your account settings:

.if n \{.RS 4
.\}
    [imap]
            folder = "[Gmail]/Drafts"
            host = imaps://imap.gmail.com
            user = user@gmail.com
            port = 993
            sslverify = false
.if n \{.RE
.\}


You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error that the "Folder doesn’t exist".

Once the commits are ready to be sent, run the following command:

.if n \{.RS 4
.\}
    $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
.if n \{.RE
.\}

Just make sure to disable line wrapping in the email client (GMail’s web interface will wrap lines no matter what, so you need to use a real IMAP client).

<a name="caution"></a>

# Caution


It is still your responsibility to make sure that the email message sent by your email program meets the standards of your project. Many projects do not like patches to be attached. Some mail agents will transform patches (e.g. wrap lines, send them as format=flowed) in ways that make them fail. You will get angry flames ridiculing you if you don’t check this.

Thunderbird in particular is known to be problematic. Thunderbird users may wish to visit this web page for more information: \m[blue]**http://kb.mozillazine.org/Plain\_text\_e-mail\_-\_Thunderbird#Completely\_plain\_email**\m[]

<a name="see-also"></a>

# See Also


**git-format-patch**(1), **git-send-email**(1), mbox(5)

<a name="git"></a>

# Git


Part of the **git**(1) suite
