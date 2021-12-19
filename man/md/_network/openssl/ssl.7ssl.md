# ssl(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

ssl - OpenSSL SSL/TLS library

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" See the individual manual pages for details.
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The OpenSSL **ssl** library implements the Secure Sockets Layer (\s-1SSL\s0 v2/v3) and
Transport Layer Security (\s-1TLS\s0 v1) protocols. It provides a rich \s-1API\s0 which is
documented here.

An **\s-1SSL\_CTX\s0** object is created as a framework to establish
\s-1TLS/SSL\s0 enabled connections (see **SSL\_CTX\_new**\|(3)).
Various options regarding certificates, algorithms etc. can be set
in this object.

When a network connection has been created, it can be assigned to an
**\s-1SSL\s0** object. After the **\s-1SSL\s0** object has been created using
**SSL\_new**\|(3), **SSL\_set\_fd**\|(3) or
**SSL\_set\_bio**\|(3) can be used to associate the network
connection with the object.

When the \s-1TLS/SSL\s0 handshake is performed using
**SSL\_accept**\|(3) or **SSL\_connect**\|(3)
respectively.
**SSL\_read\_ex**\|(3), **SSL\_read**\|(3), **SSL\_write\_ex**\|(3) and **SSL\_write**\|(3) are
used to read and write data on the \s-1TLS/SSL\s0 connection.
**SSL\_shutdown**\|(3) can be used to shut down the
\s-1TLS/SSL\s0 connection.

<a name="data-structures"></a>

# Data Structures

.IX Header "DATA STRUCTURES"
Currently the OpenSSL **ssl** library functions deals with the following data
structures:

* **\s-1SSL\_METHOD\s0** (\s-1SSL\s0 Method)  
  .IX Item "SSL_METHOD (SSL Method)"
  This is a dispatch structure describing the internal **ssl** library
  methods/functions which implement the various protocol versions (SSLv3
  TLSv1, ...). It's needed to create an **\s-1SSL\_CTX\s0**.
* **\s-1SSL\_CIPHER\s0** (\s-1SSL\s0 Cipher)  
  .IX Item "SSL_CIPHER (SSL Cipher)"
  This structure holds the algorithm information for a particular cipher which
  are a core part of the \s-1SSL/TLS\s0 protocol. The available ciphers are configured
  on a **\s-1SSL\_CTX\s0** basis and the actual ones used are then part of the
  **\s-1SSL\_SESSION\s0**.
* **\s-1SSL\_CTX\s0** (\s-1SSL\s0 Context)  
  .IX Item "SSL_CTX (SSL Context)"
  This is the global context structure which is created by a server or client
  once per program life-time and which holds mainly default values for the
  **\s-1SSL\s0** structures which are later created for the connections.
* **\s-1SSL\_SESSION\s0** (\s-1SSL\s0 Session)  
  .IX Item "SSL_SESSION (SSL Session)"
  This is a structure containing the current \s-1TLS/SSL\s0 session details for a
  connection: **\s-1SSL\_CIPHER\s0**s, client and server certificates, keys, etc.
* **\s-1SSL\s0** (\s-1SSL\s0 Connection)  
  .IX Item "SSL (SSL Connection)"
  This is the main \s-1SSL/TLS\s0 structure which is created by a server or client per
  established connection. This actually is the core structure in the \s-1SSL API.\s0
  At run-time the application usually deals with this structure which has
  links to mostly all other structures.

<a name="header-files"></a>

# Header Files

.IX Header "HEADER FILES"
Currently the OpenSSL **ssl** library provides the following C header files
containing the prototypes for the data structures and functions:

* **ssl.h**  
  .IX Item "ssl.h"
  This is the common header file for the \s-1SSL/TLS API.\s0  Include it into your
  program to make the \s-1API\s0 of the **ssl** library available. It internally
  includes both more private \s-1SSL\s0 headers and headers from the **crypto** library.
  Whenever you need hard-core details on the internals of the \s-1SSL API,\s0 look
  inside this header file.
* **ssl2.h**  
  .IX Item "ssl2.h"
  Unused. Present for backwards compatibility only.
* **ssl3.h**  
  .IX Item "ssl3.h"
  This is the sub header file dealing with the SSLv3 protocol only.
  Usually you don't have to include it explicitly because
  it's already included by ssl.h.
* **tls1.h**  
  .IX Item "tls1.h"
  This is the sub header file dealing with the TLSv1 protocol only.
  Usually you don't have to include it explicitly because
  it's already included by ssl.h.

<a name="api-functions"></a>

# Api Functions

.IX Header "API FUNCTIONS"
Currently the OpenSSL **ssl** library exports 214 \s-1API\s0 functions.
They are documented in the following:

<a name="dealing-with-protocol-methods"></a>

### Dealing with Protocol Methods

.IX Subsection "Dealing with Protocol Methods"
Here we document the various \s-1API\s0 functions which deal with the \s-1SSL/TLS\s0
protocol methods defined in **\s-1SSL\_METHOD\s0** structures.

* const \s-1SSL_METHOD\s0 ***TLS\_method**(void);  
  .IX Item "const SSL_METHOD *TLS_method(void);"
  Constructor for the _version-flexible_ \s-1SSL_METHOD\s0 structure for clients,
  servers or both.
  See **SSL\_CTX\_new**\|(3) for details.
* const \s-1SSL_METHOD\s0 ***TLS\_client\_method**(void);  
  .IX Item "const SSL_METHOD *TLS_client_method(void);"
  Constructor for the _version-flexible_ \s-1SSL_METHOD\s0 structure for clients.
  Must be used to support the TLSv1.3 protocol.
* const \s-1SSL_METHOD\s0 ***TLS\_server\_method**(void);  
  .IX Item "const SSL_METHOD *TLS_server_method(void);"
  Constructor for the _version-flexible_ \s-1SSL_METHOD\s0 structure for servers.
  Must be used to support the TLSv1.3 protocol.
* const \s-1SSL_METHOD\s0 ***TLSv1\_2\_method**(void);  
  .IX Item "const SSL_METHOD *TLSv1_2_method(void);"
  Constructor for the TLSv1.2 \s-1SSL_METHOD\s0 structure for clients, servers or both.
* const \s-1SSL_METHOD\s0 ***TLSv1\_2\_client\_method**(void);  
  .IX Item "const SSL_METHOD *TLSv1_2_client_method(void);"
  Constructor for the TLSv1.2 \s-1SSL_METHOD\s0 structure for clients.
* const \s-1SSL_METHOD\s0 ***TLSv1\_2\_server\_method**(void);  
  .IX Item "const SSL_METHOD *TLSv1_2_server_method(void);"
  Constructor for the TLSv1.2 \s-1SSL_METHOD\s0 structure for servers.
* const \s-1SSL_METHOD\s0 ***TLSv1\_1\_method**(void);  
  .IX Item "const SSL_METHOD *TLSv1_1_method(void);"
  Constructor for the TLSv1.1 \s-1SSL_METHOD\s0 structure for clients, servers or both.
* const \s-1SSL_METHOD\s0 ***TLSv1\_1\_client\_method**(void);  
  .IX Item "const SSL_METHOD *TLSv1_1_client_method(void);"
  Constructor for the TLSv1.1 \s-1SSL_METHOD\s0 structure for clients.
* const \s-1SSL_METHOD\s0 ***TLSv1\_1\_server\_method**(void);  
  .IX Item "const SSL_METHOD *TLSv1_1_server_method(void);"
  Constructor for the TLSv1.1 \s-1SSL_METHOD\s0 structure for servers.
* const \s-1SSL_METHOD\s0 ***TLSv1\_method**(void);  
  .IX Item "const SSL_METHOD *TLSv1_method(void);"
  Constructor for the TLSv1 \s-1SSL_METHOD\s0 structure for clients, servers or both.
* const \s-1SSL_METHOD\s0 ***TLSv1\_client\_method**(void);  
  .IX Item "const SSL_METHOD *TLSv1_client_method(void);"
  Constructor for the TLSv1 \s-1SSL_METHOD\s0 structure for clients.
* const \s-1SSL_METHOD\s0 ***TLSv1\_server\_method**(void);  
  .IX Item "const SSL_METHOD *TLSv1_server_method(void);"
  Constructor for the TLSv1 \s-1SSL_METHOD\s0 structure for servers.
* const \s-1SSL_METHOD\s0 ***SSLv3\_method**(void);  
  .IX Item "const SSL_METHOD *SSLv3_method(void);"
  Constructor for the SSLv3 \s-1SSL_METHOD\s0 structure for clients, servers or both.
* const \s-1SSL_METHOD\s0 ***SSLv3\_client\_method**(void);  
  .IX Item "const SSL_METHOD *SSLv3_client_method(void);"
  Constructor for the SSLv3 \s-1SSL_METHOD\s0 structure for clients.
* const \s-1SSL_METHOD\s0 ***SSLv3\_server\_method**(void);  
  .IX Item "const SSL_METHOD *SSLv3_server_method(void);"
  Constructor for the SSLv3 \s-1SSL_METHOD\s0 structure for servers.

<a name="dealing-with-ciphers"></a>

### Dealing with Ciphers

.IX Subsection "Dealing with Ciphers"
Here we document the various \s-1API\s0 functions which deal with the \s-1SSL/TLS\s0
ciphers defined in **\s-1SSL\_CIPHER\s0** structures.

* char ***SSL\_CIPHER\_description**(\s-1SSL_CIPHER\s0 *cipher, char *buf, int len);  
  .IX Item "char *SSL_CIPHER_description(SSL_CIPHER *cipher, char *buf, int len);"
  Write a string to _buf_ (with a maximum size of _len_) containing a human
  readable description of _cipher_. Returns _buf_.
* int **SSL\_CIPHER\_get\_bits**(\s-1SSL_CIPHER\s0 *cipher, int *alg_bits);  
  .IX Item "int SSL_CIPHER_get_bits(SSL_CIPHER *cipher, int *alg_bits);"
  Determine the number of bits in _cipher_. Because of export crippled ciphers
  there are two bits: The bits the algorithm supports in general (stored to
  _alg\_bits_) and the bits which are actually used (the return value).
* const char ***SSL\_CIPHER\_get\_name**(\s-1SSL_CIPHER\s0 *cipher);  
  .IX Item "const char *SSL_CIPHER_get_name(SSL_CIPHER *cipher);"
  Return the internal name of _cipher_ as a string. These are the various
  strings defined by the _SSL3\_TXT\_xxx_ and _TLS1\_TXT\_xxx_
  definitions in the header files.
* const char ***SSL\_CIPHER\_get\_version**(\s-1SSL_CIPHER\s0 *cipher);  
  .IX Item "const char *SSL_CIPHER_get_version(SSL_CIPHER *cipher);"
  Returns a string like "\f(CW`SSLv3\*(C'\*(L" or \*(R"\f(CW\*(C\`TLSv1.2\*(C'" which indicates the
  \s-1SSL/TLS\s0 protocol version to which _cipher_ belongs (i.e. where it was defined
  in the specification the first time).

<a name="dealing-with-protocol-contexts"></a>

### Dealing with Protocol Contexts

.IX Subsection "Dealing with Protocol Contexts"
Here we document the various \s-1API\s0 functions which deal with the \s-1SSL/TLS\s0
protocol context defined in the **\s-1SSL\_CTX\s0** structure.

* int **SSL\_CTX\_add\_client\_CA**(\s-1SSL_CTX\s0 *ctx, X509 *x);  
  .IX Item "int SSL_CTX_add_client_CA(SSL_CTX *ctx, X509 *x);"
* long **SSL\_CTX\_add\_extra\_chain\_cert**(\s-1SSL_CTX\s0 *ctx, X509 *x509);  
  .IX Item "long SSL_CTX_add_extra_chain_cert(SSL_CTX *ctx, X509 *x509);"
* int **SSL\_CTX\_add\_session**(\s-1SSL_CTX\s0 *ctx, \s-1SSL_SESSION\s0 *c);  
  .IX Item "int SSL_CTX_add_session(SSL_CTX *ctx, SSL_SESSION *c);"
* int **SSL\_CTX\_check\_private\_key**(const \s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_check_private_key(const SSL_CTX *ctx);"
* long **SSL\_CTX\_ctrl**(\s-1SSL_CTX\s0 *ctx, int cmd, long larg, char *parg);  
  .IX Item "long SSL_CTX_ctrl(SSL_CTX *ctx, int cmd, long larg, char *parg);"
* void **SSL\_CTX\_flush\_sessions**(\s-1SSL_CTX\s0 *s, long t);  
  .IX Item "void SSL_CTX_flush_sessions(SSL_CTX *s, long t);"
* void **SSL\_CTX\_free**(\s-1SSL_CTX\s0 *a);  
  .IX Item "void SSL_CTX_free(SSL_CTX *a);"
* char ***SSL\_CTX\_get\_app\_data**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "char *SSL_CTX_get_app_data(SSL_CTX *ctx);"
* X509_STORE ***SSL\_CTX\_get\_cert\_store**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "X509_STORE *SSL_CTX_get_cert_store(SSL_CTX *ctx);"
* \s-1STACK\s0 ***SSL\_CTX\_get\_ciphers**(const \s-1SSL_CTX\s0 *ctx);  
  .IX Item "STACK *SSL_CTX_get_ciphers(const SSL_CTX *ctx);"
* \s-1STACK\s0 ***SSL\_CTX\_get\_client\_CA\_list**(const \s-1SSL_CTX\s0 *ctx);  
  .IX Item "STACK *SSL_CTX_get_client_CA_list(const SSL_CTX *ctx);"
* int (***SSL\_CTX\_get\_client\_cert\_cb**(\s-1SSL_CTX\s0 *ctx))(\s-1SSL\s0 *ssl, X509 **x509, \s-1EVP_PKEY\s0 **pkey);  
  .IX Item "int (*SSL_CTX_get_client_cert_cb(SSL_CTX *ctx))(SSL *ssl, X509 **x509, EVP_PKEY **pkey);"
* void **SSL\_CTX\_get\_default\_read\_ahead**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "void SSL_CTX_get_default_read_ahead(SSL_CTX *ctx);"
* char ***SSL\_CTX\_get\_ex\_data**(const \s-1SSL_CTX\s0 *s, int idx);  
  .IX Item "char *SSL_CTX_get_ex_data(const SSL_CTX *s, int idx);"
* int **SSL\_CTX\_get\_ex\_new\_index**(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))  
  .IX Item "int SSL_CTX_get_ex_new_index(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))"
* void (***SSL\_CTX\_get\_info\_callback**(\s-1SSL_CTX\s0 *ctx))(\s-1SSL\s0 *ssl, int cb, int ret);  
  .IX Item "void (*SSL_CTX_get_info_callback(SSL_CTX *ctx))(SSL *ssl, int cb, int ret);"
* int **SSL\_CTX\_get\_quiet\_shutdown**(const \s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_get_quiet_shutdown(const SSL_CTX *ctx);"
* void **SSL\_CTX\_get\_read\_ahead**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "void SSL_CTX_get_read_ahead(SSL_CTX *ctx);"
* int **SSL\_CTX\_get\_session\_cache\_mode**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_get_session_cache_mode(SSL_CTX *ctx);"
* long **SSL\_CTX\_get\_timeout**(const \s-1SSL_CTX\s0 *ctx);  
  .IX Item "long SSL_CTX_get_timeout(const SSL_CTX *ctx);"
* int (***SSL\_CTX\_get\_verify\_callback**(const \s-1SSL_CTX\s0 *ctx))(int ok, X509_STORE_CTX *ctx);  
  .IX Item "int (*SSL_CTX_get_verify_callback(const SSL_CTX *ctx))(int ok, X509_STORE_CTX *ctx);"
* int **SSL\_CTX\_get\_verify\_mode**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_get_verify_mode(SSL_CTX *ctx);"
* int **SSL\_CTX\_load\_verify\_locations**(\s-1SSL_CTX\s0 *ctx, const char *CAfile, const char *CApath);  
  .IX Item "int SSL_CTX_load_verify_locations(SSL_CTX *ctx, const char *CAfile, const char *CApath);"
* \s-1SSL_CTX\s0 ***SSL\_CTX\_new**(const \s-1SSL_METHOD\s0 *meth);  
  .IX Item "SSL_CTX *SSL_CTX_new(const SSL_METHOD *meth);"
* int SSL_CTX_up_ref(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_up_ref(SSL_CTX *ctx);"
* int **SSL\_CTX\_remove\_session**(\s-1SSL_CTX\s0 *ctx, \s-1SSL_SESSION\s0 *c);  
  .IX Item "int SSL_CTX_remove_session(SSL_CTX *ctx, SSL_SESSION *c);"
* int **SSL\_CTX\_sess\_accept**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_accept(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_accept\_good**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_accept_good(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_accept\_renegotiate**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_accept_renegotiate(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_cache\_full**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_cache_full(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_cb\_hits**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_cb_hits(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_connect**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_connect(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_connect\_good**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_connect_good(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_connect\_renegotiate**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_connect_renegotiate(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_get\_cache\_size**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_get_cache_size(SSL_CTX *ctx);"
* \s-1SSL_SESSION\s0 *(***SSL\_CTX\_sess\_get\_get\_cb**(\s-1SSL_CTX\s0 *ctx))(\s-1SSL\s0 *ssl, unsigned char *data, int len, int *copy);  
  .IX Item "SSL_SESSION *(*SSL_CTX_sess_get_get_cb(SSL_CTX *ctx))(SSL *ssl, unsigned char *data, int len, int *copy);"
* int (***SSL\_CTX\_sess\_get\_new\_cb**(\s-1SSL_CTX\s0 *ctx)(\s-1SSL\s0 *ssl, \s-1SSL_SESSION\s0 *sess);  
  .IX Item "int (*SSL_CTX_sess_get_new_cb(SSL_CTX *ctx)(SSL *ssl, SSL_SESSION *sess);"
* void (***SSL\_CTX\_sess\_get\_remove\_cb**(\s-1SSL_CTX\s0 *ctx)(\s-1SSL_CTX\s0 *ctx, \s-1SSL_SESSION\s0 *sess);  
  .IX Item "void (*SSL_CTX_sess_get_remove_cb(SSL_CTX *ctx)(SSL_CTX *ctx, SSL_SESSION *sess);"
* int **SSL\_CTX\_sess\_hits**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_hits(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_misses**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_misses(SSL_CTX *ctx);"
* int **SSL\_CTX\_sess\_number**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_number(SSL_CTX *ctx);"
* void **SSL\_CTX\_sess\_set\_cache\_size**(\s-1SSL_CTX\s0 *ctx, t);  
  .IX Item "void SSL_CTX_sess_set_cache_size(SSL_CTX *ctx, t);"
* void **SSL\_CTX\_sess\_set\_get\_cb**(\s-1SSL_CTX\s0 *ctx, \s-1SSL_SESSION\s0 *(*cb)(\s-1SSL\s0 *ssl, unsigned char *data, int len, int *copy));  
  .IX Item "void SSL_CTX_sess_set_get_cb(SSL_CTX *ctx, SSL_SESSION *(*cb)(SSL *ssl, unsigned char *data, int len, int *copy));"
* void **SSL\_CTX\_sess\_set\_new\_cb**(\s-1SSL_CTX\s0 *ctx, int (*cb)(\s-1SSL\s0 *ssl, \s-1SSL_SESSION\s0 *sess));  
  .IX Item "void SSL_CTX_sess_set_new_cb(SSL_CTX *ctx, int (*cb)(SSL *ssl, SSL_SESSION *sess));"
* void **SSL\_CTX\_sess\_set\_remove\_cb**(\s-1SSL_CTX\s0 *ctx, void (*cb)(\s-1SSL_CTX\s0 *ctx, \s-1SSL_SESSION\s0 *sess));  
  .IX Item "void SSL_CTX_sess_set_remove_cb(SSL_CTX *ctx, void (*cb)(SSL_CTX *ctx, SSL_SESSION *sess));"
* int **SSL\_CTX\_sess\_timeouts**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_sess_timeouts(SSL_CTX *ctx);"
* \s-1LHASH\s0 ***SSL\_CTX\_sessions**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "LHASH *SSL_CTX_sessions(SSL_CTX *ctx);"
* int **SSL\_CTX\_set\_app\_data**(\s-1SSL_CTX\s0 *ctx, void *arg);  
  .IX Item "int SSL_CTX_set_app_data(SSL_CTX *ctx, void *arg);"
* void **SSL\_CTX\_set\_cert\_store**(\s-1SSL_CTX\s0 *ctx, X509_STORE *cs);  
  .IX Item "void SSL_CTX_set_cert_store(SSL_CTX *ctx, X509_STORE *cs);"
* void **SSL\_CTX\_set1\_cert\_store**(\s-1SSL_CTX\s0 *ctx, X509_STORE *cs);  
  .IX Item "void SSL_CTX_set1_cert_store(SSL_CTX *ctx, X509_STORE *cs);"
* void **SSL\_CTX\_set\_cert\_verify\_cb**(\s-1SSL_CTX\s0 *ctx, int (*cb)(), char *arg)  
  .IX Item "void SSL_CTX_set_cert_verify_cb(SSL_CTX *ctx, int (*cb)(), char *arg)"
* int **SSL\_CTX\_set\_cipher\_list**(\s-1SSL_CTX\s0 *ctx, char *str);  
  .IX Item "int SSL_CTX_set_cipher_list(SSL_CTX *ctx, char *str);"
* void **SSL\_CTX\_set\_client\_CA\_list**(\s-1SSL_CTX\s0 *ctx, \s-1STACK\s0 *list);  
  .IX Item "void SSL_CTX_set_client_CA_list(SSL_CTX *ctx, STACK *list);"
* void **SSL\_CTX\_set\_client\_cert\_cb**(\s-1SSL_CTX\s0 *ctx, int (*cb)(\s-1SSL\s0 *ssl, X509 **x509, \s-1EVP_PKEY\s0 **pkey));  
  .IX Item "void SSL_CTX_set_client_cert_cb(SSL_CTX *ctx, int (*cb)(SSL *ssl, X509 **x509, EVP_PKEY **pkey));"
* int **SSL\_CTX\_set\_ct\_validation\_callback**(\s-1SSL_CTX\s0 *ctx, ssl_ct_validation_cb callback, void *arg);  
  .IX Item "int SSL_CTX_set_ct_validation_callback(SSL_CTX *ctx, ssl_ct_validation_cb callback, void *arg);"
* void **SSL\_CTX\_set\_default\_passwd\_cb**(\s-1SSL_CTX\s0 *ctx, int (*cb);(void))  
  .IX Item "void SSL_CTX_set_default_passwd_cb(SSL_CTX *ctx, int (*cb);(void))"
* void **SSL\_CTX\_set\_default\_read\_ahead**(\s-1SSL_CTX\s0 *ctx, int m);  
  .IX Item "void SSL_CTX_set_default_read_ahead(SSL_CTX *ctx, int m);"
* int **SSL\_CTX\_set\_default\_verify\_paths**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "int SSL_CTX_set_default_verify_paths(SSL_CTX *ctx);"
  Use the default paths to locate trusted \s-1CA\s0 certificates. There is one default
  directory path and one default file path. Both are set via this call.
* int **SSL\_CTX\_set\_default\_verify\_dir**(\s-1SSL_CTX\s0 *ctx)  
  .IX Item "int SSL_CTX_set_default_verify_dir(SSL_CTX *ctx)"
  Use the default directory path to locate trusted \s-1CA\s0 certificates.
* int **SSL\_CTX\_set\_default\_verify\_file**(\s-1SSL_CTX\s0 *ctx)  
  .IX Item "int SSL_CTX_set_default_verify_file(SSL_CTX *ctx)"
  Use the file path to locate trusted \s-1CA\s0 certificates.
* int **SSL\_CTX\_set\_ex\_data**(\s-1SSL_CTX\s0 *s, int idx, char *arg);  
  .IX Item "int SSL_CTX_set_ex_data(SSL_CTX *s, int idx, char *arg);"
* void **SSL\_CTX\_set\_info\_callback**(\s-1SSL_CTX\s0 *ctx, void (*cb)(\s-1SSL\s0 *ssl, int cb, int ret));  
  .IX Item "void SSL_CTX_set_info_callback(SSL_CTX *ctx, void (*cb)(SSL *ssl, int cb, int ret));"
* void **SSL\_CTX\_set\_msg\_callback**(\s-1SSL_CTX\s0 *ctx, void (*cb)(int write_p, int version, int content_type, const void *buf, size_t len, \s-1SSL\s0 *ssl, void *arg));  
  .IX Item "void SSL_CTX_set_msg_callback(SSL_CTX *ctx, void (*cb)(int write_p, int version, int content_type, const void *buf, size_t len, SSL *ssl, void *arg));"
* void **SSL\_CTX\_set\_msg\_callback\_arg**(\s-1SSL_CTX\s0 *ctx, void *arg);  
  .IX Item "void SSL_CTX_set_msg_callback_arg(SSL_CTX *ctx, void *arg);"
* unsigned long **SSL\_CTX\_clear\_options**(\s-1SSL_CTX\s0 *ctx, unsigned long op);  
  .IX Item "unsigned long SSL_CTX_clear_options(SSL_CTX *ctx, unsigned long op);"
* unsigned long **SSL\_CTX\_get\_options**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "unsigned long SSL_CTX_get_options(SSL_CTX *ctx);"
* unsigned long **SSL\_CTX\_set\_options**(\s-1SSL_CTX\s0 *ctx, unsigned long op);  
  .IX Item "unsigned long SSL_CTX_set_options(SSL_CTX *ctx, unsigned long op);"
* void **SSL\_CTX\_set\_quiet\_shutdown**(\s-1SSL_CTX\s0 *ctx, int mode);  
  .IX Item "void SSL_CTX_set_quiet_shutdown(SSL_CTX *ctx, int mode);"
* void **SSL\_CTX\_set\_read\_ahead**(\s-1SSL_CTX\s0 *ctx, int m);  
  .IX Item "void SSL_CTX_set_read_ahead(SSL_CTX *ctx, int m);"
* void **SSL\_CTX\_set\_session\_cache\_mode**(\s-1SSL_CTX\s0 *ctx, int mode);  
  .IX Item "void SSL_CTX_set_session_cache_mode(SSL_CTX *ctx, int mode);"
* int **SSL\_CTX\_set\_ssl\_version**(\s-1SSL_CTX\s0 *ctx, const \s-1SSL_METHOD\s0 *meth);  
  .IX Item "int SSL_CTX_set_ssl_version(SSL_CTX *ctx, const SSL_METHOD *meth);"
* void **SSL\_CTX\_set\_timeout**(\s-1SSL_CTX\s0 *ctx, long t);  
  .IX Item "void SSL_CTX_set_timeout(SSL_CTX *ctx, long t);"
* long **SSL\_CTX\_set\_tmp\_dh**(SSL_CTX* ctx, \s-1DH\s0 *dh);  
  .IX Item "long SSL_CTX_set_tmp_dh(SSL_CTX* ctx, DH *dh);"
* long **SSL\_CTX\_set\_tmp\_dh\_callback**(\s-1SSL_CTX\s0 *ctx, \s-1DH\s0 *(*cb)(void));  
  .IX Item "long SSL_CTX_set_tmp_dh_callback(SSL_CTX *ctx, DH *(*cb)(void));"
* void **SSL\_CTX\_set\_verify**(\s-1SSL_CTX\s0 *ctx, int mode, int (*cb);(void))  
  .IX Item "void SSL_CTX_set_verify(SSL_CTX *ctx, int mode, int (*cb);(void))"
* int **SSL\_CTX\_use\_PrivateKey**(\s-1SSL_CTX\s0 *ctx, \s-1EVP_PKEY\s0 *pkey);  
  .IX Item "int SSL_CTX_use_PrivateKey(SSL_CTX *ctx, EVP_PKEY *pkey);"
* int **SSL\_CTX\_use\_PrivateKey\_ASN1**(int type, \s-1SSL_CTX\s0 *ctx, unsigned char *d, long len);  
  .IX Item "int SSL_CTX_use_PrivateKey_ASN1(int type, SSL_CTX *ctx, unsigned char *d, long len);"
* int **SSL\_CTX\_use\_PrivateKey\_file**(\s-1SSL_CTX\s0 *ctx, const char *file, int type);  
  .IX Item "int SSL_CTX_use_PrivateKey_file(SSL_CTX *ctx, const char *file, int type);"
* int **SSL\_CTX\_use\_RSAPrivateKey**(\s-1SSL_CTX\s0 *ctx, \s-1RSA\s0 *rsa);  
  .IX Item "int SSL_CTX_use_RSAPrivateKey(SSL_CTX *ctx, RSA *rsa);"
* int **SSL\_CTX\_use\_RSAPrivateKey\_ASN1**(\s-1SSL_CTX\s0 *ctx, unsigned char *d, long len);  
  .IX Item "int SSL_CTX_use_RSAPrivateKey_ASN1(SSL_CTX *ctx, unsigned char *d, long len);"
* int **SSL\_CTX\_use\_RSAPrivateKey\_file**(\s-1SSL_CTX\s0 *ctx, const char *file, int type);  
  .IX Item "int SSL_CTX_use_RSAPrivateKey_file(SSL_CTX *ctx, const char *file, int type);"
* int **SSL\_CTX\_use\_certificate**(\s-1SSL_CTX\s0 *ctx, X509 *x);  
  .IX Item "int SSL_CTX_use_certificate(SSL_CTX *ctx, X509 *x);"
* int **SSL\_CTX\_use\_certificate\_ASN1**(\s-1SSL_CTX\s0 *ctx, int len, unsigned char *d);  
  .IX Item "int SSL_CTX_use_certificate_ASN1(SSL_CTX *ctx, int len, unsigned char *d);"
* int **SSL\_CTX\_use\_certificate\_file**(\s-1SSL_CTX\s0 *ctx, const char *file, int type);  
  .IX Item "int SSL_CTX_use_certificate_file(SSL_CTX *ctx, const char *file, int type);"
* int **SSL\_CTX\_use\_cert\_and\_key**(\s-1SSL_CTX\s0 *ctx, X509 *x, \s-1EVP_PKEY\s0 *pkey, \s-1STACK_OF\s0(X509) *chain, int override);  
  .IX Item "int SSL_CTX_use_cert_and_key(SSL_CTX *ctx, X509 *x, EVP_PKEY *pkey, STACK_OF(X509) *chain, int override);"
* X509 ***SSL\_CTX\_get0\_certificate**(const \s-1SSL_CTX\s0 *ctx);  
  .IX Item "X509 *SSL_CTX_get0_certificate(const SSL_CTX *ctx);"
* \s-1EVP_PKEY\s0 ***SSL\_CTX\_get0\_privatekey**(const \s-1SSL_CTX\s0 *ctx);  
  .IX Item "EVP_PKEY *SSL_CTX_get0_privatekey(const SSL_CTX *ctx);"
* void **SSL\_CTX\_set\_psk\_client\_callback**(\s-1SSL_CTX\s0 *ctx, unsigned int (*callback)(\s-1SSL\s0 *ssl, const char *hint, char *identity, unsigned int max_identity_len, unsigned char *psk, unsigned int max_psk_len));  
  .IX Item "void SSL_CTX_set_psk_client_callback(SSL_CTX *ctx, unsigned int (*callback)(SSL *ssl, const char *hint, char *identity, unsigned int max_identity_len, unsigned char *psk, unsigned int max_psk_len));"
* int **SSL\_CTX\_use\_psk\_identity\_hint**(\s-1SSL_CTX\s0 *ctx, const char *hint);  
  .IX Item "int SSL_CTX_use_psk_identity_hint(SSL_CTX *ctx, const char *hint);"
* void **SSL\_CTX\_set\_psk\_server\_callback**(\s-1SSL_CTX\s0 *ctx, unsigned int (*callback)(\s-1SSL\s0 *ssl, const char *identity, unsigned char *psk, int max_psk_len));  
  .IX Item "void SSL_CTX_set_psk_server_callback(SSL_CTX *ctx, unsigned int (*callback)(SSL *ssl, const char *identity, unsigned char *psk, int max_psk_len));"

<a name="dealing-with-sessions"></a>

### Dealing with Sessions

.IX Subsection "Dealing with Sessions"
Here we document the various \s-1API\s0 functions which deal with the \s-1SSL/TLS\s0
sessions defined in the **\s-1SSL\_SESSION\s0** structures.

* int **SSL\_SESSION\_cmp**(const \s-1SSL_SESSION\s0 *a, const \s-1SSL_SESSION\s0 *b);  
  .IX Item "int SSL_SESSION_cmp(const SSL_SESSION *a, const SSL_SESSION *b);"
* void **SSL\_SESSION\_free**(\s-1SSL_SESSION\s0 *ss);  
  .IX Item "void SSL_SESSION_free(SSL_SESSION *ss);"
* char ***SSL\_SESSION\_get\_app\_data**(\s-1SSL_SESSION\s0 *s);  
  .IX Item "char *SSL_SESSION_get_app_data(SSL_SESSION *s);"
* char ***SSL\_SESSION\_get\_ex\_data**(const \s-1SSL_SESSION\s0 *s, int idx);  
  .IX Item "char *SSL_SESSION_get_ex_data(const SSL_SESSION *s, int idx);"
* int **SSL\_SESSION\_get\_ex\_new\_index**(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))  
  .IX Item "int SSL_SESSION_get_ex_new_index(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))"
* long **SSL\_SESSION\_get\_time**(const \s-1SSL_SESSION\s0 *s);  
  .IX Item "long SSL_SESSION_get_time(const SSL_SESSION *s);"
* long **SSL\_SESSION\_get\_timeout**(const \s-1SSL_SESSION\s0 *s);  
  .IX Item "long SSL_SESSION_get_timeout(const SSL_SESSION *s);"
* unsigned long **SSL\_SESSION\_hash**(const \s-1SSL_SESSION\s0 *a);  
  .IX Item "unsigned long SSL_SESSION_hash(const SSL_SESSION *a);"
* \s-1SSL_SESSION\s0 ***SSL\_SESSION\_new**(void);  
  .IX Item "SSL_SESSION *SSL_SESSION_new(void);"
* int **SSL\_SESSION\_print**(\s-1BIO\s0 *bp, const \s-1SSL_SESSION\s0 *x);  
  .IX Item "int SSL_SESSION_print(BIO *bp, const SSL_SESSION *x);"
* int **SSL\_SESSION\_print\_fp**(\s-1FILE\s0 *fp, const \s-1SSL_SESSION\s0 *x);  
  .IX Item "int SSL_SESSION_print_fp(FILE *fp, const SSL_SESSION *x);"
* int **SSL\_SESSION\_set\_app\_data**(\s-1SSL_SESSION\s0 *s, char *a);  
  .IX Item "int SSL_SESSION_set_app_data(SSL_SESSION *s, char *a);"
* int **SSL\_SESSION\_set\_ex\_data**(\s-1SSL_SESSION\s0 *s, int idx, char *arg);  
  .IX Item "int SSL_SESSION_set_ex_data(SSL_SESSION *s, int idx, char *arg);"
* long **SSL\_SESSION\_set\_time**(\s-1SSL_SESSION\s0 *s, long t);  
  .IX Item "long SSL_SESSION_set_time(SSL_SESSION *s, long t);"
* long **SSL\_SESSION\_set\_timeout**(\s-1SSL_SESSION\s0 *s, long t);  
  .IX Item "long SSL_SESSION_set_timeout(SSL_SESSION *s, long t);"

<a name="dealing-with-connections"></a>

### Dealing with Connections

.IX Subsection "Dealing with Connections"
Here we document the various \s-1API\s0 functions which deal with the \s-1SSL/TLS\s0
connection defined in the **\s-1SSL\s0** structure.

* int **SSL\_accept**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_accept(SSL *ssl);"
* int **SSL\_add\_dir\_cert\_subjects\_to\_stack**(\s-1STACK\s0 *stack, const char *dir);  
  .IX Item "int SSL_add_dir_cert_subjects_to_stack(STACK *stack, const char *dir);"
* int **SSL\_add\_file\_cert\_subjects\_to\_stack**(\s-1STACK\s0 *stack, const char *file);  
  .IX Item "int SSL_add_file_cert_subjects_to_stack(STACK *stack, const char *file);"
* int **SSL\_add\_client\_CA**(\s-1SSL\s0 *ssl, X509 *x);  
  .IX Item "int SSL_add_client_CA(SSL *ssl, X509 *x);"
* char ***SSL\_alert\_desc\_string**(int value);  
  .IX Item "char *SSL_alert_desc_string(int value);"
* char ***SSL\_alert\_desc\_string\_long**(int value);  
  .IX Item "char *SSL_alert_desc_string_long(int value);"
* char ***SSL\_alert\_type\_string**(int value);  
  .IX Item "char *SSL_alert_type_string(int value);"
* char ***SSL\_alert\_type\_string\_long**(int value);  
  .IX Item "char *SSL_alert_type_string_long(int value);"
* int **SSL\_check\_private\_key**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_check_private_key(const SSL *ssl);"
* void **SSL\_clear**(\s-1SSL\s0 *ssl);  
  .IX Item "void SSL_clear(SSL *ssl);"
* long **SSL\_clear\_num\_renegotiations**(\s-1SSL\s0 *ssl);  
  .IX Item "long SSL_clear_num_renegotiations(SSL *ssl);"
* int **SSL\_connect**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_connect(SSL *ssl);"
* int **SSL\_copy\_session\_id**(\s-1SSL\s0 *t, const \s-1SSL\s0 *f);  
  .IX Item "int SSL_copy_session_id(SSL *t, const SSL *f);"
  Sets the session details for **t** to be the same as in **f**. Returns 1 on
  success or 0 on failure.
* long **SSL\_ctrl**(\s-1SSL\s0 *ssl, int cmd, long larg, char *parg);  
  .IX Item "long SSL_ctrl(SSL *ssl, int cmd, long larg, char *parg);"
* int **SSL\_do\_handshake**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_do_handshake(SSL *ssl);"
* \s-1SSL\s0 ***SSL\_dup**(\s-1SSL\s0 *ssl);  
  .IX Item "SSL *SSL_dup(SSL *ssl);"
  **SSL\_dup()** allows applications to configure an \s-1SSL\s0 handle for use
  in multiple \s-1SSL\s0 connections, and then duplicate it prior to initiating
  each connection with the duplicated handle.
  Use of **SSL\_dup()** avoids the need to repeat the configuration of the
  handles for each connection.
  .Sp
  For **SSL\_dup()** to work, the connection \s-1MUST\s0 be in its initial state
  and \s-1MUST NOT\s0 have not yet have started the \s-1SSL\s0 handshake.
  For connections that are not in their initial state **SSL\_dup()** just
  increments an internal reference count and returns the _same_
  handle.
  It may be possible to use **SSL\_clear**\|(3) to recycle an \s-1SSL\s0 handle
  that is not in its initial state for re-use, but this is best
  avoided.
  Instead, save and restore the session, if desired, and construct a
  fresh handle for each connection.
* \s-1STACK\s0 ***SSL\_dup\_CA\_list**(\s-1STACK\s0 *sk);  
  .IX Item "STACK *SSL_dup_CA_list(STACK *sk);"
* void **SSL\_free**(\s-1SSL\s0 *ssl);  
  .IX Item "void SSL_free(SSL *ssl);"
* \s-1SSL_CTX\s0 ***SSL\_get\_SSL\_CTX**(const \s-1SSL\s0 *ssl);  
  .IX Item "SSL_CTX *SSL_get_SSL_CTX(const SSL *ssl);"
* char ***SSL\_get\_app\_data**(\s-1SSL\s0 *ssl);  
  .IX Item "char *SSL_get_app_data(SSL *ssl);"
* X509 ***SSL\_get\_certificate**(const \s-1SSL\s0 *ssl);  
  .IX Item "X509 *SSL_get_certificate(const SSL *ssl);"
* const char ***SSL\_get\_cipher**(const \s-1SSL\s0 *ssl);  
  .IX Item "const char *SSL_get_cipher(const SSL *ssl);"
* int **SSL\_is\_dtls**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_is_dtls(const SSL *ssl);"
* int **SSL\_get\_cipher\_bits**(const \s-1SSL\s0 *ssl, int *alg_bits);  
  .IX Item "int SSL_get_cipher_bits(const SSL *ssl, int *alg_bits);"
* char ***SSL\_get\_cipher\_list**(const \s-1SSL\s0 *ssl, int n);  
  .IX Item "char *SSL_get_cipher_list(const SSL *ssl, int n);"
* char ***SSL\_get\_cipher\_name**(const \s-1SSL\s0 *ssl);  
  .IX Item "char *SSL_get_cipher_name(const SSL *ssl);"
* char ***SSL\_get\_cipher\_version**(const \s-1SSL\s0 *ssl);  
  .IX Item "char *SSL_get_cipher_version(const SSL *ssl);"
* \s-1STACK\s0 ***SSL\_get\_ciphers**(const \s-1SSL\s0 *ssl);  
  .IX Item "STACK *SSL_get_ciphers(const SSL *ssl);"
* \s-1STACK\s0 ***SSL\_get\_client\_CA\_list**(const \s-1SSL\s0 *ssl);  
  .IX Item "STACK *SSL_get_client_CA_list(const SSL *ssl);"
* \s-1SSL_CIPHER\s0 ***SSL\_get\_current\_cipher**(\s-1SSL\s0 *ssl);  
  .IX Item "SSL_CIPHER *SSL_get_current_cipher(SSL *ssl);"
* long **SSL\_get\_default\_timeout**(const \s-1SSL\s0 *ssl);  
  .IX Item "long SSL_get_default_timeout(const SSL *ssl);"
* int **SSL\_get\_error**(const \s-1SSL\s0 *ssl, int i);  
  .IX Item "int SSL_get_error(const SSL *ssl, int i);"
* char ***SSL\_get\_ex\_data**(const \s-1SSL\s0 *ssl, int idx);  
  .IX Item "char *SSL_get_ex_data(const SSL *ssl, int idx);"
* int **SSL\_get\_ex\_data\_X509\_STORE\_CTX\_idx**(void);  
  .IX Item "int SSL_get_ex_data_X509_STORE_CTX_idx(void);"
* int **SSL\_get\_ex\_new\_index**(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))  
  .IX Item "int SSL_get_ex_new_index(long argl, char *argp, int (*new_func);(void), int (*dup_func)(void), void (*free_func)(void))"
* int **SSL\_get\_fd**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_get_fd(const SSL *ssl);"
* void (***SSL\_get\_info\_callback**(const \s-1SSL\s0 *ssl);)()  
  .IX Item "void (*SSL_get_info_callback(const SSL *ssl);)()"
* int **SSL\_get\_key\_update\_type**(\s-1SSL\s0 *s);  
  .IX Item "int SSL_get_key_update_type(SSL *s);"
* \s-1STACK\s0 ***SSL\_get\_peer\_cert\_chain**(const \s-1SSL\s0 *ssl);  
  .IX Item "STACK *SSL_get_peer_cert_chain(const SSL *ssl);"
* X509 ***SSL\_get\_peer\_certificate**(const \s-1SSL\s0 *ssl);  
  .IX Item "X509 *SSL_get_peer_certificate(const SSL *ssl);"
* const \s-1STACK_OF\s0(\s-1SCT\s0) ***SSL\_get0\_peer\_scts**(\s-1SSL\s0 *s);  
  .IX Item "const STACK_OF(SCT) *SSL_get0_peer_scts(SSL *s);"
* \s-1EVP_PKEY\s0 ***SSL\_get\_privatekey**(const \s-1SSL\s0 *ssl);  
  .IX Item "EVP_PKEY *SSL_get_privatekey(const SSL *ssl);"
* int **SSL\_get\_quiet\_shutdown**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_get_quiet_shutdown(const SSL *ssl);"
* \s-1BIO\s0 ***SSL\_get\_rbio**(const \s-1SSL\s0 *ssl);  
  .IX Item "BIO *SSL_get_rbio(const SSL *ssl);"
* int **SSL\_get\_read\_ahead**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_get_read_ahead(const SSL *ssl);"
* \s-1SSL_SESSION\s0 ***SSL\_get\_session**(const \s-1SSL\s0 *ssl);  
  .IX Item "SSL_SESSION *SSL_get_session(const SSL *ssl);"
* char ***SSL\_get\_shared\_ciphers**(const \s-1SSL\s0 *ssl, char *buf, int size);  
  .IX Item "char *SSL_get_shared_ciphers(const SSL *ssl, char *buf, int size);"
* int **SSL\_get\_shutdown**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_get_shutdown(const SSL *ssl);"
* const \s-1SSL_METHOD\s0 ***SSL\_get\_ssl\_method**(\s-1SSL\s0 *ssl);  
  .IX Item "const SSL_METHOD *SSL_get_ssl_method(SSL *ssl);"
* int **SSL\_get\_state**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_get_state(const SSL *ssl);"
* long **SSL\_get\_time**(const \s-1SSL\s0 *ssl);  
  .IX Item "long SSL_get_time(const SSL *ssl);"
* long **SSL\_get\_timeout**(const \s-1SSL\s0 *ssl);  
  .IX Item "long SSL_get_timeout(const SSL *ssl);"
* int (***SSL\_get\_verify\_callback**(const \s-1SSL\s0 *ssl))(int, X509_STORE_CTX *)  
  .IX Item "int (*SSL_get_verify_callback(const SSL *ssl))(int, X509_STORE_CTX *)"
* int **SSL\_get\_verify\_mode**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_get_verify_mode(const SSL *ssl);"
* long **SSL\_get\_verify\_result**(const \s-1SSL\s0 *ssl);  
  .IX Item "long SSL_get_verify_result(const SSL *ssl);"
* char ***SSL\_get\_version**(const \s-1SSL\s0 *ssl);  
  .IX Item "char *SSL_get_version(const SSL *ssl);"
* \s-1BIO\s0 ***SSL\_get\_wbio**(const \s-1SSL\s0 *ssl);  
  .IX Item "BIO *SSL_get_wbio(const SSL *ssl);"
* int **SSL\_in\_accept\_init**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_in_accept_init(SSL *ssl);"
* int **SSL\_in\_before**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_in_before(SSL *ssl);"
* int **SSL\_in\_connect\_init**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_in_connect_init(SSL *ssl);"
* int **SSL\_in\_init**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_in_init(SSL *ssl);"
* int **SSL\_is\_init\_finished**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_is_init_finished(SSL *ssl);"
* int **SSL\_key\_update**(\s-1SSL\s0 *s, int updatetype);  
  .IX Item "int SSL_key_update(SSL *s, int updatetype);"
* \s-1STACK\s0 ***SSL\_load\_client\_CA\_file**(const char *file);  
  .IX Item "STACK *SSL_load_client_CA_file(const char *file);"
* \s-1SSL\s0 ***SSL\_new**(\s-1SSL_CTX\s0 *ctx);  
  .IX Item "SSL *SSL_new(SSL_CTX *ctx);"
* int SSL_up_ref(\s-1SSL\s0 *s);  
  .IX Item "int SSL_up_ref(SSL *s);"
* long **SSL\_num\_renegotiations**(\s-1SSL\s0 *ssl);  
  .IX Item "long SSL_num_renegotiations(SSL *ssl);"
* int **SSL\_peek**(\s-1SSL\s0 *ssl, void *buf, int num);  
  .IX Item "int SSL_peek(SSL *ssl, void *buf, int num);"
* int **SSL\_pending**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_pending(const SSL *ssl);"
* int **SSL\_read**(\s-1SSL\s0 *ssl, void *buf, int num);  
  .IX Item "int SSL_read(SSL *ssl, void *buf, int num);"
* int **SSL\_renegotiate**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_renegotiate(SSL *ssl);"
* char ***SSL\_rstate\_string**(\s-1SSL\s0 *ssl);  
  .IX Item "char *SSL_rstate_string(SSL *ssl);"
* char ***SSL\_rstate\_string\_long**(\s-1SSL\s0 *ssl);  
  .IX Item "char *SSL_rstate_string_long(SSL *ssl);"
* long **SSL\_session\_reused**(\s-1SSL\s0 *ssl);  
  .IX Item "long SSL_session_reused(SSL *ssl);"
* void **SSL\_set\_accept\_state**(\s-1SSL\s0 *ssl);  
  .IX Item "void SSL_set_accept_state(SSL *ssl);"
* void **SSL\_set\_app\_data**(\s-1SSL\s0 *ssl, char *arg);  
  .IX Item "void SSL_set_app_data(SSL *ssl, char *arg);"
* void **SSL\_set\_bio**(\s-1SSL\s0 *ssl, \s-1BIO\s0 *rbio, \s-1BIO\s0 *wbio);  
  .IX Item "void SSL_set_bio(SSL *ssl, BIO *rbio, BIO *wbio);"
* int **SSL\_set\_cipher\_list**(\s-1SSL\s0 *ssl, char *str);  
  .IX Item "int SSL_set_cipher_list(SSL *ssl, char *str);"
* void **SSL\_set\_client\_CA\_list**(\s-1SSL\s0 *ssl, \s-1STACK\s0 *list);  
  .IX Item "void SSL_set_client_CA_list(SSL *ssl, STACK *list);"
* void **SSL\_set\_connect\_state**(\s-1SSL\s0 *ssl);  
  .IX Item "void SSL_set_connect_state(SSL *ssl);"
* int **SSL\_set\_ct\_validation\_callback**(\s-1SSL\s0 *ssl, ssl_ct_validation_cb callback, void *arg);  
  .IX Item "int SSL_set_ct_validation_callback(SSL *ssl, ssl_ct_validation_cb callback, void *arg);"
* int **SSL\_set\_ex\_data**(\s-1SSL\s0 *ssl, int idx, char *arg);  
  .IX Item "int SSL_set_ex_data(SSL *ssl, int idx, char *arg);"
* int **SSL\_set\_fd**(\s-1SSL\s0 *ssl, int fd);  
  .IX Item "int SSL_set_fd(SSL *ssl, int fd);"
* void **SSL\_set\_info\_callback**(\s-1SSL\s0 *ssl, void (*cb);(void))  
  .IX Item "void SSL_set_info_callback(SSL *ssl, void (*cb);(void))"
* void **SSL\_set\_msg\_callback**(\s-1SSL\s0 *ctx, void (*cb)(int write_p, int version, int content_type, const void *buf, size_t len, \s-1SSL\s0 *ssl, void *arg));  
  .IX Item "void SSL_set_msg_callback(SSL *ctx, void (*cb)(int write_p, int version, int content_type, const void *buf, size_t len, SSL *ssl, void *arg));"
* void **SSL\_set\_msg\_callback\_arg**(\s-1SSL\s0 *ctx, void *arg);  
  .IX Item "void SSL_set_msg_callback_arg(SSL *ctx, void *arg);"
* unsigned long **SSL\_clear\_options**(\s-1SSL\s0 *ssl, unsigned long op);  
  .IX Item "unsigned long SSL_clear_options(SSL *ssl, unsigned long op);"
* unsigned long **SSL\_get\_options**(\s-1SSL\s0 *ssl);  
  .IX Item "unsigned long SSL_get_options(SSL *ssl);"
* unsigned long **SSL\_set\_options**(\s-1SSL\s0 *ssl, unsigned long op);  
  .IX Item "unsigned long SSL_set_options(SSL *ssl, unsigned long op);"
* void **SSL\_set\_quiet\_shutdown**(\s-1SSL\s0 *ssl, int mode);  
  .IX Item "void SSL_set_quiet_shutdown(SSL *ssl, int mode);"
* void **SSL\_set\_read\_ahead**(\s-1SSL\s0 *ssl, int yes);  
  .IX Item "void SSL_set_read_ahead(SSL *ssl, int yes);"
* int **SSL\_set\_rfd**(\s-1SSL\s0 *ssl, int fd);  
  .IX Item "int SSL_set_rfd(SSL *ssl, int fd);"
* int **SSL\_set\_session**(\s-1SSL\s0 *ssl, \s-1SSL_SESSION\s0 *session);  
  .IX Item "int SSL_set_session(SSL *ssl, SSL_SESSION *session);"
* void **SSL\_set\_shutdown**(\s-1SSL\s0 *ssl, int mode);  
  .IX Item "void SSL_set_shutdown(SSL *ssl, int mode);"
* int **SSL\_set\_ssl\_method**(\s-1SSL\s0 *ssl, const \s-1SSL_METHOD\s0 *meth);  
  .IX Item "int SSL_set_ssl_method(SSL *ssl, const SSL_METHOD *meth);"
* void **SSL\_set\_time**(\s-1SSL\s0 *ssl, long t);  
  .IX Item "void SSL_set_time(SSL *ssl, long t);"
* void **SSL\_set\_timeout**(\s-1SSL\s0 *ssl, long t);  
  .IX Item "void SSL_set_timeout(SSL *ssl, long t);"
* void **SSL\_set\_verify**(\s-1SSL\s0 *ssl, int mode, int (*callback);(void))  
  .IX Item "void SSL_set_verify(SSL *ssl, int mode, int (*callback);(void))"
* void **SSL\_set\_verify\_result**(\s-1SSL\s0 *ssl, long arg);  
  .IX Item "void SSL_set_verify_result(SSL *ssl, long arg);"
* int **SSL\_set\_wfd**(\s-1SSL\s0 *ssl, int fd);  
  .IX Item "int SSL_set_wfd(SSL *ssl, int fd);"
* int **SSL\_shutdown**(\s-1SSL\s0 *ssl);  
  .IX Item "int SSL_shutdown(SSL *ssl);"
* \s-1OSSL_HANDSHAKE_STATE\s0 **SSL\_get\_state**(const \s-1SSL\s0 *ssl);  
  .IX Item "OSSL_HANDSHAKE_STATE SSL_get_state(const SSL *ssl);"
  Returns the current handshake state.
* char ***SSL\_state\_string**(const \s-1SSL\s0 *ssl);  
  .IX Item "char *SSL_state_string(const SSL *ssl);"
* char ***SSL\_state\_string\_long**(const \s-1SSL\s0 *ssl);  
  .IX Item "char *SSL_state_string_long(const SSL *ssl);"
* long **SSL\_total\_renegotiations**(\s-1SSL\s0 *ssl);  
  .IX Item "long SSL_total_renegotiations(SSL *ssl);"
* int **SSL\_use\_PrivateKey**(\s-1SSL\s0 *ssl, \s-1EVP_PKEY\s0 *pkey);  
  .IX Item "int SSL_use_PrivateKey(SSL *ssl, EVP_PKEY *pkey);"
* int **SSL\_use\_PrivateKey\_ASN1**(int type, \s-1SSL\s0 *ssl, unsigned char *d, long len);  
  .IX Item "int SSL_use_PrivateKey_ASN1(int type, SSL *ssl, unsigned char *d, long len);"
* int **SSL\_use\_PrivateKey\_file**(\s-1SSL\s0 *ssl, const char *file, int type);  
  .IX Item "int SSL_use_PrivateKey_file(SSL *ssl, const char *file, int type);"
* int **SSL\_use\_RSAPrivateKey**(\s-1SSL\s0 *ssl, \s-1RSA\s0 *rsa);  
  .IX Item "int SSL_use_RSAPrivateKey(SSL *ssl, RSA *rsa);"
* int **SSL\_use\_RSAPrivateKey\_ASN1**(\s-1SSL\s0 *ssl, unsigned char *d, long len);  
  .IX Item "int SSL_use_RSAPrivateKey_ASN1(SSL *ssl, unsigned char *d, long len);"
* int **SSL\_use\_RSAPrivateKey\_file**(\s-1SSL\s0 *ssl, const char *file, int type);  
  .IX Item "int SSL_use_RSAPrivateKey_file(SSL *ssl, const char *file, int type);"
* int **SSL\_use\_certificate**(\s-1SSL\s0 *ssl, X509 *x);  
  .IX Item "int SSL_use_certificate(SSL *ssl, X509 *x);"
* int **SSL\_use\_certificate\_ASN1**(\s-1SSL\s0 *ssl, int len, unsigned char *d);  
  .IX Item "int SSL_use_certificate_ASN1(SSL *ssl, int len, unsigned char *d);"
* int **SSL\_use\_certificate\_file**(\s-1SSL\s0 *ssl, const char *file, int type);  
  .IX Item "int SSL_use_certificate_file(SSL *ssl, const char *file, int type);"
* int **SSL\_use\_cert\_and\_key**(\s-1SSL\s0 *ssl, X509 *x, \s-1EVP_PKEY\s0 *pkey, \s-1STACK_OF\s0(X509) *chain, int override);  
  .IX Item "int SSL_use_cert_and_key(SSL *ssl, X509 *x, EVP_PKEY *pkey, STACK_OF(X509) *chain, int override);"
* int **SSL\_version**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_version(const SSL *ssl);"
* int **SSL\_want**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_want(const SSL *ssl);"
* int **SSL\_want\_nothing**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_want_nothing(const SSL *ssl);"
* int **SSL\_want\_read**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_want_read(const SSL *ssl);"
* int **SSL\_want\_write**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_want_write(const SSL *ssl);"
* int **SSL\_want\_x509\_lookup**(const \s-1SSL\s0 *ssl);  
  .IX Item "int SSL_want_x509_lookup(const SSL *ssl);"
* int **SSL\_write**(\s-1SSL\s0 *ssl, const void *buf, int num);  
  .IX Item "int SSL_write(SSL *ssl, const void *buf, int num);"
* void **SSL\_set\_psk\_client\_callback**(\s-1SSL\s0 *ssl, unsigned int (*callback)(\s-1SSL\s0 *ssl, const char *hint, char *identity, unsigned int max_identity_len, unsigned char *psk, unsigned int max_psk_len));  
  .IX Item "void SSL_set_psk_client_callback(SSL *ssl, unsigned int (*callback)(SSL *ssl, const char *hint, char *identity, unsigned int max_identity_len, unsigned char *psk, unsigned int max_psk_len));"
* int **SSL\_use\_psk\_identity\_hint**(\s-1SSL\s0 *ssl, const char *hint);  
  .IX Item "int SSL_use_psk_identity_hint(SSL *ssl, const char *hint);"
* void **SSL\_set\_psk\_server\_callback**(\s-1SSL\s0 *ssl, unsigned int (*callback)(\s-1SSL\s0 *ssl, const char *identity, unsigned char *psk, int max_psk_len));  
  .IX Item "void SSL_set_psk_server_callback(SSL *ssl, unsigned int (*callback)(SSL *ssl, const char *identity, unsigned char *psk, int max_psk_len));"
* const char ***SSL\_get\_psk\_identity\_hint**(\s-1SSL\s0 *ssl);  
  .IX Item "const char *SSL_get_psk_identity_hint(SSL *ssl);"
* const char ***SSL\_get\_psk\_identity**(\s-1SSL\s0 *ssl);  
  .IX Item "const char *SSL_get_psk_identity(SSL *ssl);"

<a name="return-values"></a>

# Return Values

.IX Header "RETURN VALUES"
See the individual manual pages for details.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**openssl**\|(1), **crypto**\|(7),
**CRYPTO\_get\_ex\_new\_index**\|(3),
**SSL\_accept**\|(3), **SSL\_clear**\|(3),
**SSL\_connect**\|(3),
**SSL\_CIPHER\_get\_name**\|(3),
**SSL\_COMP\_add\_compression\_method**\|(3),
**SSL\_CTX\_add\_extra\_chain\_cert**\|(3),
**SSL\_CTX\_add\_session**\|(3),
**SSL\_CTX\_ctrl**\|(3),
**SSL\_CTX\_flush\_sessions**\|(3),
**SSL\_CTX\_get\_verify\_mode**\|(3),
**SSL\_CTX\_load\_verify\_locations**\|(3)
**SSL\_CTX\_new**\|(3),
**SSL\_CTX\_sess\_number**\|(3),
**SSL\_CTX\_sess\_set\_cache\_size**\|(3),
**SSL\_CTX\_sess\_set\_get\_cb**\|(3),
**SSL\_CTX\_sessions**\|(3),
**SSL\_CTX\_set\_cert\_store**\|(3),
**SSL\_CTX\_set\_cert\_verify\_callback**\|(3),
**SSL\_CTX\_set\_cipher\_list**\|(3),
**SSL\_CTX\_set\_client\_CA\_list**\|(3),
**SSL\_CTX\_set\_client\_cert\_cb**\|(3),
**SSL\_CTX\_set\_default\_passwd\_cb**\|(3),
**SSL\_CTX\_set\_generate\_session\_id**\|(3),
**SSL\_CTX\_set\_info\_callback**\|(3),
**SSL\_CTX\_set\_max\_cert\_list**\|(3),
**SSL\_CTX\_set\_mode**\|(3),
**SSL\_CTX\_set\_msg\_callback**\|(3),
**SSL\_CTX\_set\_options**\|(3),
**SSL\_CTX\_set\_quiet\_shutdown**\|(3),
**SSL\_CTX\_set\_read\_ahead**\|(3),
**SSL\_CTX\_set\_security\_level**\|(3),
**SSL\_CTX\_set\_session\_cache\_mode**\|(3),
**SSL\_CTX\_set\_session\_id\_context**\|(3),
**SSL\_CTX\_set\_ssl\_version**\|(3),
**SSL\_CTX\_set\_timeout**\|(3),
**SSL\_CTX\_set\_tmp\_dh\_callback**\|(3),
**SSL\_CTX\_set\_verify**\|(3),
**SSL\_CTX\_use\_certificate**\|(3),
**SSL\_alert\_type\_string**\|(3),
**SSL\_do\_handshake**\|(3),
**SSL\_enable\_ct**\|(3),
**SSL\_get\_SSL\_CTX**\|(3),
**SSL\_get\_ciphers**\|(3),
**SSL\_get\_client\_CA\_list**\|(3),
**SSL\_get\_default\_timeout**\|(3),
**SSL\_get\_error**\|(3),
**SSL\_get\_ex\_data\_X509\_STORE\_CTX\_idx**\|(3),
**SSL\_get\_fd**\|(3),
**SSL\_get\_peer\_cert\_chain**\|(3),
**SSL\_get\_rbio**\|(3),
**SSL\_get\_session**\|(3),
**SSL\_get\_verify\_result**\|(3),
**SSL\_get\_version**\|(3),
**SSL\_load\_client\_CA\_file**\|(3),
**SSL\_new**\|(3),
**SSL\_pending**\|(3),
**SSL\_read\_ex**\|(3),
**SSL\_read**\|(3),
**SSL\_rstate\_string**\|(3),
**SSL\_session\_reused**\|(3),
**SSL\_set\_bio**\|(3),
**SSL\_set\_connect\_state**\|(3),
**SSL\_set\_fd**\|(3),
**SSL\_set\_session**\|(3),
**SSL\_set\_shutdown**\|(3),
**SSL\_shutdown**\|(3),
**SSL\_state\_string**\|(3),
**SSL\_want**\|(3),
**SSL\_write\_ex**\|(3),
**SSL\_write**\|(3),
**SSL\_SESSION\_free**\|(3),
**SSL\_SESSION\_get\_time**\|(3),
**d2i\_SSL\_SESSION**\|(3),
**SSL\_CTX\_set\_psk\_client\_callback**\|(3),
**SSL\_CTX\_use\_psk\_identity\_hint**\|(3),
**SSL\_get\_psk\_identity**\|(3),
**DTLSv1\_listen**\|(3)

<a name="history"></a>

# History

.IX Header "HISTORY"
**SSLv2\_client\_method**, **SSLv2\_server\_method** and **SSLv2\_method** were removed
in OpenSSL 1.1.0.

The return type of **SSL\_copy\_session\_id** was changed from void to int in
OpenSSL 1.1.0.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
