# git\-http\-backend(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-http-backend - Server side implementation of Git over HTTP

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git http-backend
<synopsis>


```

<a name="description"></a>

# Description


A simple CGI program to serve the contents of a Git repository to Git clients accessing the repository over http:// and https:// protocols. The program supports clients fetching using both the smart HTTP protocol and the backwards-compatible dumb HTTP protocol, as well as clients pushing using the smart HTTP protocol.

It verifies that the directory has the magic file "git-daemon-export-ok", and it will refuse to export any Git directory that hasn’t explicitly been marked for export this way (unless the **GIT\_HTTP\_EXPORT\_ALL** environmental variable is set).

By default, only the **upload-pack** service is enabled, which serves _git fetch-pack_ and _git ls-remote_ clients, which are invoked from _git fetch_, _git pull_, and _git clone_. If the client is authenticated, the **receive-pack** service is enabled, which serves _git send-pack_ clients, which is invoked from _git push_.

<a name="services"></a>

# Services


These services can be enabled/disabled using the per-repository configuration file:

http.getanyfile
This serves Git clients older than version 1.6.6 that are unable to use the upload pack service. When enabled, clients are able to read any file within the repository, including objects that are no longer reachable from a branch but are still present. It is enabled by default, but a repository can disable it by setting this configuration item to
**false**.

http.uploadpack
This serves
_git fetch-pack_
and
_git ls-remote_
clients. It is enabled by default, but a repository can disable it by setting this configuration item to
**false**.

http.receivepack
This serves
_git send-pack_
clients, allowing push. It is disabled by default for anonymous users, and enabled by default for users authenticated by the web server. It can be disabled by setting this item to
**false**, or enabled for all users, including anonymous users, by setting it to
**true**.

<a name="url-translation"></a>

# Url Translation


To determine the location of the repository on disk, _git http-backend_ concatenates the environment variables PATH_INFO, which is set automatically by the web server, and GIT_PROJECT_ROOT, which must be set manually in the web server configuration. If GIT_PROJECT_ROOT is not set, _git http-backend_ reads PATH_TRANSLATED, which is also set automatically by the web server.

<a name="examples"></a>

# Examples


All of the following examples map **http://$hostname/git/foo/bar.git** to **/var/www/git/foo/bar.git**.

Apache 2.x
Ensure mod_cgi, mod_alias, and mod_env are enabled, set GIT_PROJECT_ROOT (or DocumentRoot) appropriately, and create a ScriptAlias to the CGI:

.if n \{.RS 4
.\}
    SetEnv GIT_PROJECT_ROOT /var/www/git
    SetEnv GIT_HTTP_EXPORT_ALL
    ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
.if n \{.RE
.\}

To enable anonymous read access but authenticated write access, require authorization for both the initial ref advertisement (which we detect as a push via the service parameter in the query string), and the receive-pack invocation itself:

.if n \{.RS 4
.\}
    RewriteCond %{QUERY_STRING} service=git-receive-pack [OR]
    RewriteCond %{REQUEST_URI} /git-receive-pack$
    RewriteRule ^/git/ - [E=AUTHREQUIRED:yes]
    
    <LocationMatch "^/git/">
            Order Deny,Allow
            Deny from env=AUTHREQUIRED
    
            AuthType Basic
            AuthName "Git Access"
            Require group committers
            Satisfy Any
            ...
    </LocationMatch>
.if n \{.RE
.\}

If you do not have
**mod\_rewrite**
available to match against the query string, it is sufficient to just protect
**git-receive-pack**
itself, like:

.if n \{.RS 4
.\}
    <LocationMatch "^/git/.*/git-receive-pack$">
            AuthType Basic
            AuthName "Git Access"
            Require group committers
            ...
    </LocationMatch>
.if n \{.RE
.\}

In this mode, the server will not request authentication until the client actually starts the object negotiation phase of the push, rather than during the initial contact. For this reason, you must also enable the
**http.receivepack**
config option in any repositories that should accept a push. The default behavior, if
**http.receivepack**
is not set, is to reject any pushes by unauthenticated users; the initial request will therefore report
**403 Forbidden**
to the client, without even giving an opportunity for authentication.

To require authentication for both reads and writes, use a Location directive around the repository, or one of its parent directories:

.if n \{.RS 4
.\}
    <Location /git/private>
            AuthType Basic
            AuthName "Private Git Access"
            Require group committers
            ...
    </Location>
.if n \{.RE
.\}

To serve gitweb at the same url, use a ScriptAliasMatch to only those URLs that
_git http-backend_
can handle, and forward the rest to gitweb:

.if n \{.RS 4
.\}
    ScriptAliasMatch e
            "(?x)^/git/(.*/(HEAD | e
                            info/refs | e
                            objects/(info/[^/]+ | e
                                     [0-9a-f]{2}/[0-9a-f]{38} | e
                                     pack/pack-[0-9a-f]{40}e.(pack|idx)) | e
                            git-(upload|receive)-pack))$" e
            /usr/libexec/git-core/git-http-backend/$1
    
    ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
.if n \{.RE
.\}

To serve multiple repositories from different
**gitnamespaces**(7)
in a single repository:

.if n \{.RS 4
.\}
    SetEnvIf Request_URI "^/git/([^/]*)" GIT_NAMESPACE=$1
    ScriptAliasMatch ^/git/[^/]*(.*) /usr/libexec/git-core/git-http-backend/storage.git$1
.if n \{.RE
.\}


Accelerated static Apache 2.x
Similar to the above, but Apache can be used to return static files that are stored on disk. On many systems this may be more efficient as Apache can ask the kernel to copy the file contents from the file system directly to the network:

.if n \{.RS 4
.\}
    SetEnv GIT_PROJECT_ROOT /var/www/git
    
    AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$          /var/www/git/$1
    AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /var/www/git/$1
    ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
.if n \{.RE
.\}

This can be combined with the gitweb configuration:

.if n \{.RS 4
.\}
    SetEnv GIT_PROJECT_ROOT /var/www/git
    
    AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$          /var/www/git/$1
    AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /var/www/git/$1
    ScriptAliasMatch e
            "(?x)^/git/(.*/(HEAD | e
                            info/refs | e
                            objects/info/[^/]+ | e
                            git-(upload|receive)-pack))$" e
            /usr/libexec/git-core/git-http-backend/$1
    ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
.if n \{.RE
.\}


Lighttpd
Ensure that
**mod\_cgi**,
**mod\_alias**,
**mod\_auth**,
**mod\_setenv**
are loaded, then set
**GIT\_PROJECT\_ROOT**
appropriately and redirect all requests to the CGI:

.if n \{.RS 4
.\}
    alias.url += ( "/git" => "/usr/lib/git-core/git-http-backend" )
    $HTTP["url"] =~ "^/git" {
            cgi.assign = ("" => "")
            setenv.add-environment = (
                    "GIT_PROJECT_ROOT" => "/var/www/git",
                    "GIT_HTTP_EXPORT_ALL" => ""
            )
    }
.if n \{.RE
.\}

To enable anonymous read access but authenticated write access:

.if n \{.RS 4
.\}
    $HTTP["querystring"] =~ "service=git-receive-pack" {
            include "git-auth.conf"
    }
    $HTTP["url"] =~ "^/git/.*/git-receive-pack$" {
            include "git-auth.conf"
    }
.if n \{.RE
.\}

where
**git-auth.conf**
looks something like:

.if n \{.RS 4
.\}
    auth.require = (
            "/" => (
                    "method" => "basic",
                    "realm" => "Git Access",
                    "require" => "valid-user"
                   )
    )
    # ...and set up auth.backend here
.if n \{.RE
.\}

To require authentication for both reads and writes:

.if n \{.RS 4
.\}
    $HTTP["url"] =~ "^/git/private" {
            include "git-auth.conf"
    }
.if n \{.RE
.\}


<a name="environment"></a>

# Environment


_git http-backend_ relies upon the **CGI** environment variables set by the invoking web server, including:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  PATH_INFO (if GIT_PROJECT_ROOT is set, otherwise PATH_TRANSLATED)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  REMOTE_USER

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  REMOTE_ADDR

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  CONTENT_TYPE

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  QUERY_STRING

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  REQUEST_METHOD

The **GIT\_HTTP\_EXPORT\_ALL** environmental variable may be passed to _git-http-backend_ to bypass the check for the "git-daemon-export-ok" file in each repository before allowing export of that repository.

The **GIT\_HTTP\_MAX\_REQUEST\_BUFFER** environment variable (or the **http.maxRequestBuffer** config variable) may be set to change the largest ref negotiation request that git will handle during a fetch; any fetch requiring a larger buffer will not succeed. This value should not normally need to be changed, but may be helpful if you are fetching from a repository with an extremely large number of refs. The value can be specified with a unit (e.g., **100M** for 100 megabytes). The default is 10 megabytes.

The backend process sets GIT_COMMITTER_NAME to _$REMOTE\_USER_ and GIT_COMMITTER_EMAIL to _${REMOTE\_USER}@http.${REMOTE\_ADDR}_, ensuring that any reflogs created by _git-receive-pack_ contain some identifying information of the remote user who performed the push.

All **CGI** environment variables are available to each of the hooks invoked by the _git-receive-pack_.

<a name="git"></a>

# Git


Part of the **git**(1) suite
