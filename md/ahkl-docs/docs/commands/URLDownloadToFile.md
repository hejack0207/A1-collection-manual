# UrlDownloadToFile

Downloads a file from the Internet.

```
<span class="func">UrlDownloadToFile</span>, URL, Filename
```

## Parameters

URL

URL of the file to download. For example, https://someorg.org might retrieve the welcome page for that organization.

Filename

**Download to a file**: Specify the name of the file to be created locally, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. Any existing file will be **overwritten** by the new file.

**Download to a variable**: See the [example](#WHR) below.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

The download might appear to succeed even when the remote file doesn't exist. This is because many web servers send an error page instead of the missing file. This error page is what will be saved in place of _Filename_.

Internet Explorer 3 or greater must be installed for this function to work. Firewalls or the presence of multiple network adapters may cause this function to fail. Also, some websites may block such downloads.

**Caching**:

- [v1.0.44.07+]: The URL is retrieved directly from the remote server (that is, never from Internet Explorer's cache). To permit caching, precede the URL with \*0 followed by a space; for example: `*0 https://someorg.org`. The zero following the asterisk may be replaced by any valid dwFlags number; for details, search [www.microsoft.com](https://www.microsoft.com) for InternetOpenUrl.
- In versions older than 1.0.44.07, the file is retrieved from the cache whenever possible. To avoid this, specify a query string at the end of the URL. For example:`https://www.someorg.org/doc.html?fakeParam=42`. Note: If you download the same file frequently, the query string should be varied.

**Proxies**: UrlDownloadToFile will use a proxy server to access the Internet if such a proxy has been configured in Microsoft Internet Explorer's settings.

**FTP and Gopher**: [v1.0.48.04+] supports FTP and Gopher URLs. For example:

```
UrlDownloadToFile, ftp://example.com/home/My File.zip, C:\My Folder\My File.zip  <em>; Log in anonymously.</em>
UrlDownloadToFile, ftp://user:pass@example.com:21/home/My File.zip, C:\My Folder\My File.zip  <em>; Log in as a specific user.</em>
UrlDownloadToFile, ftp://user:pass@example.com/My Directory, C:\Dir Listing.html  <em>; Gets a directory listing in HTML format.</em>
```

## Related

[FileRead](FileRead.htm), [FileCopy](FileCopy.htm)

## Examples

Downloads a text file.

```
UrlDownloadToFile, https://www.autohotkey.com/download/1.1/version.txt, C:\AutoHotkey Latest Version.txt
```

Downloads a zip file.

```
UrlDownloadToFile, https://someorg.org/archive.zip, C:\SomeOrg's Archive.zip
```

Downloads text to a variable.

```
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://www.autohotkey.com/download/1.1/version.txt", true)
whr.Send()
<em>; Using 'true' above and the call below allows the script to remain responsive.</em>
whr.WaitForResponse()
version := whr.ResponseText
MsgBox % version

```

Makes an asynchronous HTTP request.

```
req := ComObjCreate("Msxml2.XMLHTTP")
<em>; Open a request with async enabled.</em>
req.open("GET", "https://www.autohotkey.com/download/1.1/version.txt", true)
<em>; Set our callback function <span class="ver">[requires v1.1.17+]</span>.</em>
req.onreadystatechange := Func("Ready")
<em>; Send the request.  Ready() will be called when it's complete.</em>
req.send()
<em>/*
; If you're going to wait, there's no need for onreadystatechange.
; Setting async=true and waiting like this allows the script to remain
; responsive while the download is taking place, whereas async=false
; will make the script unresponsive.
while req.readyState != 4
    sleep 100
*/</em>
#Persistent

Ready() {
    global req
    if (req.readyState != 4)  <em>; Not done yet.</em>
        return
    if (req.status == 200) <em>; OK.</em>
        MsgBox % "Latest AutoHotkey version: " req.responseText
    else
        MsgBox 16,, % "Status " req.status
    ExitApp
}
```

