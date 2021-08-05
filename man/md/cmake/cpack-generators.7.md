# cpack-generators(7) - CPack Generator Reference

3.17.2, Apr 28, 2020

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="generators"></a>

# Generators


<a name="cpack-archive-generator"></a>

### CPack Archive Generator


Archive CPack generator that supports packaging of sources and binaries in
different formats:
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* ·  
  7Z - 7zip - (.7z)
* ·  
  TBZ2 (.tar.bz2)
* ·  
  TGZ (.tar.gz)
* ·  
  TXZ (.tar.xz)
* ·  
  TZ (.tar.Z)
* ·  
  TZST (.tar.zst)
* ·  
  ZIP (.zip)
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="variables-specific-to-cpack-archive-generator"></a>

### Variables specific to CPack Archive generator

.INDENT 0.0

* **CPACK_ARCHIVE_FILE_NAME**  
* **CPACK_ARCHIVE_&lt;component&gt;_FILE_NAME**  
  Package file name without extension which is added automatically depending
  on the archive format.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  .INDENT 2.0
* **Default**  
  **&lt;CPACK\_PACKAGE\_FILE\_NAME&gt;[-&lt;component&gt;].&lt;extension&gt;** with
  spaces replaced by ‘-‘
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_ARCHIVE_COMPONENT_INSTALL**  
  Enable component packaging for CPackArchive
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT

If enabled (ON) multiple packages are generated. By default a single package
containing files of all components is generated.
.UNINDENT

<a name="cpack-bundle-generator"></a>

### CPack Bundle Generator


CPack Bundle generator (macOS) specific options

<a name="variables-specific-to-cpack-bundle-generator"></a>

### Variables specific to CPack Bundle generator


Installers built on macOS using the Bundle generator use the
aforementioned DragNDrop (**CPACK\_DMG\_xxx**) variables, plus the following
Bundle-specific parameters (**CPACK\_BUNDLE\_xxx**).
.INDENT 0.0

* **CPACK_BUNDLE_NAME**  
  The name of the generated bundle. This appears in the macOS Finder as the
  bundle name. Required.
  .UNINDENT
  .INDENT 0.0
* **CPACK_BUNDLE_PLIST**  
  Path to an macOS Property List (**.plist**) file that will be used
  for the generated bundle. This
  assumes that the caller has generated or specified their own **Info.plist**
  file. Required.
  .UNINDENT
  .INDENT 0.0
* **CPACK_BUNDLE_ICON**  
  Path to an macOS icon file that will be used as the icon for the generated
  bundle. This is the icon that appears in the macOS Finder for the bundle, and
  in the macOS dock when the bundle is opened. Required.
  .UNINDENT
  .INDENT 0.0
* **CPACK_BUNDLE_STARTUP_COMMAND**  
  Path to a startup script. This is a path to an executable or script that
  will be run whenever an end-user double-clicks the generated bundle in the
  macOS Finder. Optional.
  .UNINDENT
  .INDENT 0.0
* **CPACK_BUNDLE_APPLE_CERT_APP**  
  The name of your Apple supplied code signing certificate for the application.
  The name usually takes the form **Developer ID Application: [Name]** or
  **3rd Party Mac Developer Application: [Name]**. If this variable is not set
  the application will not be signed.
  .UNINDENT
  .INDENT 0.0
* **CPACK_BUNDLE_APPLE_ENTITLEMENTS**  
  The name of the Property List (**.plist**) file that contains your Apple
  entitlements for sandboxing your application. This file is required
  for submission to the macOS App Store.
  .UNINDENT
  .INDENT 0.0
* **CPACK_BUNDLE_APPLE_CODESIGN_FILES**  
  A list of additional files that you wish to be signed. You do not need to
  list the main application folder, or the main executable. You should
  list any frameworks and plugins that are included in your app bundle.
  .UNINDENT
  .INDENT 0.0
* **CPACK_BUNDLE_APPLE_CODESIGN_PARAMETER**  
  Additional parameter that will passed to **codesign**.
  Default value: **--deep -f**
  .UNINDENT
  .INDENT 0.0
* **CPACK_COMMAND_CODESIGN**  
  Path to the **codesign(1)** command used to sign applications with an
  Apple cert. This variable can be used to override the automatically
  detected command (or specify its location if the auto-detection fails
  to find it).
  .UNINDENT

<a name="cpack-cygwin-generator"></a>

### CPack Cygwin Generator


Cygwin CPack generator (Cygwin).

<a name="variables-specific-to-cpack-cygwin-generator"></a>

### Variables specific to CPack Cygwin generator


The
following variable is specific to installers build on and/or for
Cygwin:
.INDENT 0.0

* **CPACK_CYGWIN_PATCH_NUMBER**  
  The Cygwin patch number.  FIXME: This documentation is incomplete.
  .UNINDENT
  .INDENT 0.0
* **CPACK_CYGWIN_PATCH_FILE**  
  The Cygwin patch file.  FIXME: This documentation is incomplete.
  .UNINDENT
  .INDENT 0.0
* **CPACK_CYGWIN_BUILD_SCRIPT**  
  The Cygwin build script.  FIXME: This documentation is incomplete.
  .UNINDENT

<a name="cpack-deb-generator"></a>

### CPack DEB Generator


The built in (binary) CPack DEB generator (Unix only)

<a name="variables-specific-to-cpack-debian-deb-generator"></a>

### Variables specific to CPack Debian (DEB) generator


The CPack DEB generator may be used to create DEB package using **CPack**.
The CPack DEB generator is a **CPack** generator thus it uses the
**CPACK\_XXX** variables used by **CPack**.

The CPack DEB generator should work on any Linux host but it will produce
better deb package when Debian specific tools **dpkg-xxx** are usable on
the build system.

The CPack DEB generator has specific features which are controlled by the
specifics **CPACK\_DEBIAN\_XXX** variables.

**CPACK\_DEBIAN\_&lt;COMPONENT&gt;\_XXXX** variables may be used in order to have
**component** specific values.  Note however that **&lt;COMPONENT&gt;** refers to
the **grouping name** written in upper case. It may be either a component name
or a component GROUP name.

Here are some CPack DEB generator wiki resources that are here for historic
reasons and are no longer maintained but may still prove useful:
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* ·  
  _https://gitlab.kitware.com/cmake/community/wikis/doc/cpack/Configuration_
* ·  
  _https://gitlab.kitware.com/cmake/community/wikis/doc/cpack/PackageGenerators#deb-unix-only_
  .UNINDENT
  .UNINDENT
  .UNINDENT

List of CPack DEB generator specific variables:
.INDENT 0.0

* **CPACK_DEB_COMPONENT_INSTALL**  
  Enable component packaging for CPackDEB
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT

If enabled (ON) multiple packages are generated. By default a single package
containing files of all components is generated.
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_NAME**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_NAME**  
  Set Package control field (variable is automatically transformed to lower
  case).
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   :
  .INDENT 2.0
* ·  
  **CPACK\_PACKAGE\_NAME** for non-component based
  installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_NAME_ suffixed with -&lt;COMPONENT&gt;
  for component-based installations.
  .UNINDENT
  .UNINDENT

See _https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Source_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_FILE_NAME**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_FILE_NAME**  
  Package file name.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : **&lt;CPACK\_PACKAGE\_FILE\_NAME&gt;[-&lt;component&gt;].deb**
  .UNINDENT

This may be set to **DEB-DEFAULT** to allow the CPack DEB generator to generate
package file name by itself in deb format:
.INDENT 7.0
.INDENT 3.5

    .ft C
    <PackageName>_<VersionNumber>-<DebianRevisionNumber>_<DebianArchitecture>.deb
    .ft P
.UNINDENT
.UNINDENT

Alternatively provided package file name must end
with either **.deb** or **.ipk** suffix.

**NOTE:**
.INDENT 7.0
.INDENT 3.5
Preferred setting of this variable is **DEB-DEFAULT** but for backward
compatibility with the CPack DEB generator in CMake prior to version 3.6 this
feature is disabled by default.
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 7.0
.INDENT 3.5
By using non default filenames duplicate names may occur. Duplicate files
get overwritten and it is up to the packager to set the variables in a
manner that will prevent such errors.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_EPOCH**  
  The Debian package epoch
  .INDENT 7.0
* ·  
  Mandatory : No
* ·  
  Default   : -
  .UNINDENT

Optional number that should be incremented when changing versioning schemas
or fixing mistakes in the version numbers of older packages.
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_VERSION**  
  The Debian package version
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : **CPACK\_PACKAGE\_VERSION**
  .UNINDENT

This variable may contain only alphanumerics (A-Za-z0-9) and the characters
_CPACK\_DEBIAN\_PACKAGE\_RELEASE_ is not set then hyphens are not
allowed.

**NOTE:**
.INDENT 7.0
.INDENT 3.5
For backward compatibility with CMake 3.9 and lower a failed test of this
variable’s content is not a hard error when both
_CPACK\_DEBIAN\_PACKAGE\_RELEASE_ and
_CPACK\_DEBIAN\_PACKAGE\_EPOCH_ variables are not set. An author
warning is reported instead.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_RELEASE**  
  The Debian package release - Debian revision number.
  .INDENT 7.0
* ·  
  Mandatory : No
* ·  
  Default   : -
  .UNINDENT

This is the numbering of the DEB package itself, i.e. the version of the
packaging and not the version of the content (see
_CPACK\_DEBIAN\_PACKAGE\_VERSION_). One may change the default value
if the previous packaging was buggy and/or you want to put here a fancy Linux
distro specific numbering.
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_ARCHITECTURE**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_ARCHITECTURE**  
  The Debian package architecture
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : Output of **dpkg --print-architecture** (or **i386**
  if **dpkg** is not found)
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_DEBIAN_PACKAGE_DEPENDS**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_DEPENDS**  
  Sets the Debian dependencies of this package.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_DEPENDS_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

**NOTE:**
.INDENT 7.0
.INDENT 3.5
If _CPACK\_DEBIAN\_PACKAGE\_SHLIBDEPS_ or
more specifically _CPACK\_DEBIAN\_&lt;COMPONENT&gt;\_PACKAGE\_SHLIBDEPS_
is set for this component, the discovered dependencies will be appended
to _CPACK\_DEBIAN\_&lt;COMPONENT&gt;\_PACKAGE\_DEPENDS_ instead of
_CPACK\_DEBIAN\_PACKAGE\_DEPENDS_. If
_CPACK\_DEBIAN\_&lt;COMPONENT&gt;\_PACKAGE\_DEPENDS_ is an empty string,
only the automatically discovered dependencies will be set for this
component.
.UNINDENT
.UNINDENT

Example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.3.1-6), libc6 (< 2.4)")
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_ENABLE_COMPONENT_DEPENDS**  
  Sets inter component dependencies if listed with
  **CPACK\_COMPONENT\_&lt;compName&gt;\_DEPENDS** variables.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_DEBIAN_PACKAGE_MAINTAINER**  
  The Debian package maintainer
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : **CPACK\_PACKAGE\_CONTACT**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_DEBIAN_PACKAGE_DESCRIPTION**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_DESCRIPTION**  
  The Debian package description
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   :
  .INDENT 2.0
* ·  
  _CPACK\_DEBIAN\_&lt;COMPONENT&gt;\_DESCRIPTION_ (component
  based installers only) if set, or _CPACK\_DEBIAN\_PACKAGE\_DESCRIPTION_ if set, or
* ·  
  **CPACK\_COMPONENT\_&lt;compName&gt;\_DESCRIPTION** (component
  based installers only) if set, or **CPACK\_PACKAGE\_DESCRIPTION** if set, or
* ·  
  content of the file specified in **CPACK\_PACKAGE\_DESCRIPTION\_FILE** if set
  .UNINDENT
  .UNINDENT

If after that description is not set, **CPACK\_PACKAGE\_DESCRIPTION\_SUMMARY** going to be
used if set. Otherwise, **CPACK\_PACKAGE\_DESCRIPTION\_SUMMARY** will be added as the first
line of description as defined in _Debian Policy Manual_.
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_SECTION**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_SECTION**  
  Set Section control field e.g. admin, devel, doc, …
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : “devel”
  .UNINDENT

See _https://www.debian.org/doc/debian-policy/ch-archive.html#s-subsections_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_ARCHIVE_TYPE**  
  The archive format used for creating the Debian package.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : “gnutar”
  .UNINDENT

Possible value is:
.INDENT 7.0

* ·  
  gnutar
  .UNINDENT

**NOTE:**
.INDENT 7.0
.INDENT 3.5
This variable previously defaulted to the **paxr** value, but **dpkg**
has never supported that tar format. For backwards compatibility the
**paxr** value will be mapped to **gnutar** and a deprecation message
will be emitted.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_COMPRESSION_TYPE**  
  The compression used for creating the Debian package.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : “gzip”
  .UNINDENT

Possible values are:
.INDENT 7.0

* ·  
  lzma
* ·  
  xz
* ·  
  bzip2
* ·  
  gzip
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_DEBIAN_PACKAGE_PRIORITY**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_PRIORITY**  
  Set Priority control field e.g. required, important, standard, optional,
  extra
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : “optional”
  .UNINDENT

See _https://www.debian.org/doc/debian-policy/ch-archive.html#s-priorities_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_HOMEPAGE**  
  The URL of the web site for this package, preferably (when applicable) the
  site from which the original source can be obtained and any additional
  upstream documentation or information may be found.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : **CMAKE\_PROJECT\_HOMEPAGE\_URL**
  .UNINDENT

**NOTE:**
.INDENT 7.0
.INDENT 3.5
The content of this field is a simple URL without any surrounding
characters such as &lt;&gt;.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_SHLIBDEPS**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_SHLIBDEPS**  
  May be set to ON in order to use **dpkg-shlibdeps** to generate
  better package dependency list.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_SHLIBDEPS_ if set or
* ·  
  OFF
  .UNINDENT
  .UNINDENT

**NOTE:**
.INDENT 7.0
.INDENT 3.5
You may need set **CMAKE\_INSTALL\_RPATH** to an appropriate value
if you use this feature, because if you don’t **dpkg-shlibdeps**
may fail to find your own shared libs.
See _https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/RPATH-handling_
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_DEBUG**  
  May be set when invoking cpack in order to trace debug information
  during the CPack DEB generator run.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_DEBIAN_PACKAGE_PREDEPENDS**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_PREDEPENDS**  
  Sets the _Pre-Depends_ field of the Debian package.
  Like _Depends_, except that it
  also forces **dpkg** to complete installation of the packages named
  before even starting the installation of the package which declares the
  pre-dependency.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_PREDEPENDS_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

See _http://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_ENHANCES**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_ENHANCES**  
  Sets the _Enhances_ field of the Debian package.
  Similar to _Suggests_ but works
  in the opposite direction: declares that a package can enhance the
  functionality of another package.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_ENHANCES_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

See _http://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_BREAKS**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_BREAKS**  
  Sets the _Breaks_ field of the Debian package.
  When a binary package (P) declares that it breaks other packages (B),
  **dpkg** will not allow the package (P) which declares _Breaks_ be
  **unpacked** unless the packages that will be broken (B) are deconfigured
  first.
  As long as the package (P) is configured, the previously deconfigured
  packages (B) cannot be reconfigured again.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_BREAKS_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

See _https://www.debian.org/doc/debian-policy/ch-relationships.html#s-breaks_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_CONFLICTS**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_CONFLICTS**  
  Sets the _Conflicts_ field of the Debian package.
  When one binary package declares a conflict with another using a _Conflicts_
  field, **dpkg** will not allow them to be unpacked on the system at
  the same time.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_CONFLICTS_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

See _https://www.debian.org/doc/debian-policy/ch-relationships.html#s-conflicts_

**NOTE:**
.INDENT 7.0
.INDENT 3.5
This is a stronger restriction than
_Breaks_, which prevents the
broken package from being configured while the breaking package is in
the “Unpacked” state but allows both packages to be unpacked at the same
time.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_PROVIDES**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_PROVIDES**  
  Sets the _Provides_ field of the Debian package.
  A virtual package is one which appears in the _Provides_ control field of
  another package.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_PROVIDES_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

See _https://www.debian.org/doc/debian-policy/ch-relationships.html#s-virtual_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_REPLACES**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_REPLACES**  
  Sets the _Replaces_ field of the Debian package.
  Packages can declare in their control file that they should overwrite
  files in certain other packages, or completely replace other packages.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_REPLACES_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

See _http://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_RECOMMENDS**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_RECOMMENDS**  
  Sets the _Recommends_ field of the Debian package.
  Allows packages to declare a strong, but not absolute, dependency on other
  packages.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_RECOMMENDS_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

See _http://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_SUGGESTS**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_SUGGESTS**  
  Sets the _Suggests_ field of the Debian package.
  Allows packages to declare a suggested package install grouping.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_SUGGESTS_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

See _http://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_GENERATE_SHLIBS**  
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT

Allows to generate shlibs control file automatically. Compatibility is defined by
_CPACK\_DEBIAN\_PACKAGE\_GENERATE\_SHLIBS\_POLICY_ variable value.

**NOTE:**
.INDENT 7.0
.INDENT 3.5
Libraries are only considered if they have both library name and version
set. This can be done by setting SOVERSION property with
**set\_target\_properties()** command.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_GENERATE_SHLIBS_POLICY**  
  Compatibility policy for auto-generated shlibs control file.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : “=”
  .UNINDENT

Defines compatibility policy for auto-generated shlibs control file.
Possible values: “=”, “&gt;=”

See _https://www.debian.org/doc/debian-policy/ch-sharedlibs.html#s-sharedlibs-shlibdeps_
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_CONTROL_EXTRA**  
  This variable allow advanced user to add custom script to the
  control.tar.gz.
  Typical usage is for conffiles, postinst, postrm, prerm.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

Usage:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA
        "${CMAKE_CURRENT_SOURCE_DIR}/prerm;${CMAKE_CURRENT_SOURCE_DIR}/postrm")
    .ft P
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 7.0
.INDENT 3.5
The original permissions of the files will be used in the final
package unless the variable
_CPACK\_DEBIAN\_PACKAGE\_CONTROL\_STRICT\_PERMISSION_ is set.
In particular, the scripts should have the proper executable
flag prior to the generation of the package.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_CONTROL_STRICT_PERMISSION**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_CONTROL_STRICT_PERMISSION**  
  This variable indicates if the Debian policy on control files should be
  strictly followed.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : FALSE
  .UNINDENT

Usage:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_DEBIAN_PACKAGE_CONTROL_STRICT_PERMISSION TRUE)
    .ft P
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 7.0
.INDENT 3.5
This overrides the permissions on the original files, following the rules
set by Debian policy
_https://www.debian.org/doc/debian-policy/ch-files.html#s-permissions-owners_
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_DEBIAN_PACKAGE_SOURCE**  
* **CPACK_DEBIAN_&lt;COMPONENT&gt;_PACKAGE_SOURCE**  
  Sets the **Source** field of the binary Debian package.
  When the binary package name is not the same as the source package name
  (in particular when several components/binaries are generated from one
  source) the source from which the binary has been generated should be
  indicated with the field **Source**.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   :
  .INDENT 2.0
* ·  
  An empty string for non-component based installations
* ·  
  _CPACK\_DEBIAN\_PACKAGE\_SOURCE_ for component-based
  installations.
  .UNINDENT
  .UNINDENT

See _https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Source_

**NOTE:**
.INDENT 7.0
.INDENT 3.5
This value is not interpreted. It is possible to pass an optional
revision number of the referenced source package as well.
.UNINDENT
.UNINDENT
.UNINDENT

<a name="packaging-of-debug-information"></a>

### Packaging of debug information


Dbgsym packages contain debug symbols for debugging packaged binaries.

Dbgsym packaging has its own set of variables:
.INDENT 0.0

* **CPACK_DEBIAN_DEBUGINFO_PACKAGE**  
* **CPACK_DEBIAN_&lt;component&gt;_DEBUGINFO_PACKAGE**  
  Enable generation of dbgsym .ddeb package(s).
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT
  .UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Binaries must contain debug symbols before packaging so use either **Debug**
or **RelWithDebInfo** for **CMAKE\_BUILD\_TYPE** variable value.
.UNINDENT
.UNINDENT

<a name="building-debian-packages-on-windows"></a>

### Building Debian packages on Windows


To communicate UNIX file permissions from the install stage
to the CPack DEB generator the “cmake_mode_t” NTFS
alternate data stream (ADT) is used.

When a filesystem without ADT support is used only owner read/write
permissions can be preserved.

<a name="reproducible-packages"></a>

### Reproducible packages


The environment variable **SOURCE\_DATE\_EPOCH** may be set to a UNIX
timestamp, defined as the number of seconds, excluding leap seconds,
since 01 Jan 1970 00:00:00 UTC.  If set, the CPack DEB generator will
use its value for timestamps in the package.

<a name="cpack-dragndrop-generator"></a>

### CPack DragNDrop Generator


The DragNDrop CPack generator (macOS) creates a DMG image.

<a name="variables-specific-to-cpack-dragndrop-generator"></a>

### Variables specific to CPack DragNDrop generator


The following variables are specific to the DragNDrop installers built
on macOS:
.INDENT 0.0

* **CPACK_DMG_VOLUME_NAME**  
  The volume name of the generated disk image. Defaults to
  CPACK_PACKAGE_FILE_NAME.
  .UNINDENT
  .INDENT 0.0
* **CPACK_DMG_FORMAT**  
  The disk image format. Common values are **UDRO** (UDIF read-only), **UDZO** (UDIF
  zlib-compressed) or **UDBZ** (UDIF bzip2-compressed). Refer to **hdiutil(1)** for
  more information on other available formats. Defaults to **UDZO**.
  .UNINDENT
  .INDENT 0.0
* **CPACK_DMG_DS_STORE**  
  Path to a custom **.DS\_Store** file. This **.DS\_Store** file can be used to
  specify the Finder window position/geometry and layout (such as hidden
  toolbars, placement of the icons etc.). This file has to be generated by
  the Finder (either manually or through AppleScript) using a normal folder
  from which the **.DS\_Store** file can then be extracted.
  .UNINDENT
  .INDENT 0.0
* **CPACK_DMG_DS_STORE_SETUP_SCRIPT**  
  Path to a custom AppleScript file.  This AppleScript is used to generate
  a **.DS\_Store** file which specifies the Finder window position/geometry and
  layout (such as hidden toolbars, placement of the icons etc.).
  By specifying a custom AppleScript there is no need to use
  **CPACK\_DMG\_DS\_STORE**, as the **.DS\_Store** that is generated by the AppleScript
  will be packaged.
  .UNINDENT
  .INDENT 0.0
* **CPACK_DMG_BACKGROUND_IMAGE**  
  Path to an image file to be used as the background.  This file will be
  copied to **.background**/**background.&lt;ext&gt;**, where **&lt;ext&gt;** is the original image file
  extension.  The background image is installed into the image before
  **CPACK\_DMG\_DS\_STORE\_SETUP\_SCRIPT** is executed or **CPACK\_DMG\_DS\_STORE** is
  installed.  By default no background image is set.
  .UNINDENT
  .INDENT 0.0
* **CPACK_DMG_DISABLE_APPLICATIONS_SYMLINK**  
  Default behaviour is to include a symlink to **/Applications** in the DMG.
  Set this option to **ON** to avoid adding the symlink.
  .UNINDENT
  .INDENT 0.0
* **CPACK_DMG_SLA_DIR**  
  Directory where license and menu files for different languages are stored.
  Setting this causes CPack to look for a **&lt;language&gt;.menu.txt** and
  **&lt;language&gt;.license.txt** or **&lt;language&gt;.license.rtf** file for every
  language defined in **CPACK\_DMG\_SLA\_LANGUAGES**.  If both this variable and
  **CPACK\_RESOURCE\_FILE\_LICENSE** are set, CPack will only look for the menu
  files and use the same license file for all languages.  If both
  **&lt;language&gt;.license.txt** and **&lt;language&gt;.license.rtf** exist, the **.txt**
  file will be used.
  .UNINDENT
  .INDENT 0.0
* **CPACK_DMG_SLA_LANGUAGES**  
  Languages for which a license agreement is provided when mounting the
  generated DMG. A menu file consists of 9 lines of text. The first line is
  is the name of the language itself, uppercase, in English (e.g. German).
  The other lines are translations of the following strings:
  .INDENT 7.0
* ·  
  Agree
* ·  
  Disagree
* ·  
  Print
* ·  
  Save…
* ·  
  You agree to the terms of the License Agreement when you click the
  “Agree” button.
* ·  
  Software License Agreement
* ·  
  This text cannot be saved. The disk may be full or locked, or the file
  may be locked.
* ·  
  Unable to print. Make sure you have selected a printer.
  .UNINDENT

For every language in this list, CPack will try to find files
**&lt;language&gt;.menu.txt** and **&lt;language&gt;.license.txt** in the directory
specified by the _CPACK\_DMG\_SLA\_DIR_ variable.
.UNINDENT
.INDENT 0.0

* **CPACK_DMG_&lt;component&gt;_FILE_NAME**  
  File name when packaging **&lt;component&gt;** as its own DMG
  (**CPACK\_COMPONENTS\_GROUPING** set to IGNORE).
  .INDENT 7.0
* ·  
  Default: **CPACK\_PACKAGE\_FILE\_NAME-&lt;component&gt;**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_COMMAND_HDIUTIL**  
  Path to the **hdiutil(1)** command used to operate on disk image files on
  macOS. This variable can be used to override the automatically detected
  command (or specify its location if the auto-detection fails to find it).
  .UNINDENT
  .INDENT 0.0
* **CPACK_COMMAND_SETFILE**  
  Path to the **SetFile(1)** command used to set extended attributes on files and
  directories on macOS. This variable can be used to override the
  automatically detected command (or specify its location if the
  auto-detection fails to find it).
  .UNINDENT
  .INDENT 0.0
* **CPACK_COMMAND_REZ**  
  Path to the **Rez(1)** command used to compile resources on macOS. This
  variable can be used to override the automatically detected command (or
  specify its location if the auto-detection fails to find it).
  .UNINDENT

<a name="cpack-external-generator"></a>

### CPack External Generator


CPack provides many generators to create packages for a variety of platforms
and packaging systems. The intention is for CMake/CPack to be a complete
end-to-end solution for building and packaging a software project. However, it
may not always be possible to use CPack for the entire packaging process, due
to either technical limitations or policies that require the use of certain
tools. For this reason, CPack provides the “External” generator, which allows
external packaging software to take advantage of some of the functionality
provided by CPack, such as component installation and the dependency graph.

<a name="integration-with-external-packaging-tools"></a>

### Integration with External Packaging Tools


The CPack External generator generates a **.json** file containing the
CPack internal metadata, which gives external software information
on how to package the software. External packaging software may itself
invoke CPack, consume the generated metadata,
install and package files as required.

Alternatively CPack can invoke an external packaging software
through an optional custom CMake script in
_CPACK\_EXTERNAL\_PACKAGE\_SCRIPT_ instead.

Staging of installation files may also optionally be
taken care of by the generator when enabled through the
_CPACK\_EXTERNAL\_ENABLE\_STAGING_ variable.

<a name="json-format"></a>

### JSON Format


The JSON metadata file contains a list of CPack components and component groups,
the various options passed to **cpack\_add\_component()** and
**cpack\_add\_component\_group()**, the dependencies between the components
and component groups, and various other options passed to CPack.

The JSON’s root object will always provide two fields:
**formatVersionMajor** and **formatVersionMinor**, which are always integers
that describe the output format of the generator. Backwards-compatible changes
to the output format (for example, adding a new field that didn’t exist before)
cause the minor version to be incremented, and backwards-incompatible changes
(for example, deleting a field or changing its meaning) cause the major version
to be incremented and the minor version reset to 0. The format version is
always of the format **major.minor**. In other words, it always has exactly two
parts, separated by a period.

You can request one or more specific versions of the output format as described
below with _CPACK\_EXTERNAL\_REQUESTED\_VERSIONS_. The output format will
have a major version that exactly matches the requested major version, and a
minor version that is greater than or equal to the requested minor version. If
no version is requested with _CPACK\_EXTERNAL\_REQUESTED\_VERSIONS_, the
latest known major version is used by default. Currently, the only supported
format is 1.0, which is described below.

<a name="version-10"></a>

### Version 1.0


In addition to the standard format fields, format version 1.0 provides the
following fields in the root:
.INDENT 0.0

* <b>**components**</b>  
  The **components** field is an object with component names as the keys and
  objects describing the components as the values. The component objects have
  the following fields:
  .INDENT 7.0
* <b>**name**</b>  
  The name of the component. This is always the same as the key in the
  **components** object.
* <b>**displayName**</b>  
  The value of the **DISPLAY\_NAME** field passed to
  **cpack\_add\_component()**.
* <b>**description**</b>  
  The value of the **DESCRIPTION** field passed to
  **cpack\_add\_component()**.
* <b>**isHidden**</b>  
  True if **HIDDEN** was passed to **cpack\_add\_component()**, false if
  it was not.
* <b>**isRequired**</b>  
  True if **REQUIRED** was passed to **cpack\_add\_component()**, false if
  it was not.
* <b>**isDisabledByDefault**</b>  
  True if **DISABLED** was passed to **cpack\_add\_component()**, false if
  it was not.
* <b>**group**</b>  
  Only present if **GROUP** was passed to **cpack\_add\_component()**. If
  so, this field is a string value containing the component’s group.
* <b>**dependencies**</b>  
  An array of components the component depends on. This contains the values
  in the **DEPENDS** argument passed to **cpack\_add\_component()**. If no
  **DEPENDS** argument was passed, this is an empty list.
* <b>**installationTypes**</b>  
  An array of installation types the component is part of. This contains the
  values in the **INSTALL\_TYPES** argument passed to
  **cpack\_add\_component()**. If no **INSTALL\_TYPES** argument was
  passed, this is an empty list.
* <b>**isDownloaded**</b>  
  True if **DOWNLOADED** was passed to **cpack\_add\_component()**, false
  if it was not.
* <b>**archiveFile**</b>  
  The name of the archive file passed with the **ARCHIVE\_FILE** argument to
  **cpack\_add\_component()**. If no **ARCHIVE\_FILE** argument was passed,
  this is an empty string.
  .UNINDENT
* <b>**componentGroups**</b>  
  The **componentGroups** field is an object with component group names as the
  keys and objects describing the component groups as the values. The component
  group objects have the following fields:
  .INDENT 7.0
* <b>**name**</b>  
  The name of the component group. This is always the same as the key in the
  **componentGroups** object.
* <b>**displayName**</b>  
  The value of the **DISPLAY\_NAME** field passed to
  **cpack\_add\_component\_group()**.
* <b>**description**</b>  
  The value of the **DESCRIPTION** field passed to
  **cpack\_add\_component\_group()**.
* <b>**parentGroup**</b>  
  Only present if **PARENT\_GROUP** was passed to
  **cpack\_add\_component\_group()**. If so, this field is a string value
  containing the component group’s parent group.
* <b>**isExpandedByDefault**</b>  
  True if **EXPANDED** was passed to **cpack\_add\_component\_group()**,
  false if it was not.
* <b>**isBold**</b>  
  True if **BOLD\_TITLE** was passed to **cpack\_add\_component\_group()**,
  false if it was not.
* <b>**components**</b>  
  An array of names of components that are direct members of the group
  (components that have this group as their **GROUP**). Components of
  subgroups are not included.
* <b>**subgroups**</b>  
  An array of names of component groups that are subgroups of the group
  (groups that have this group as their **PARENT\_GROUP**).
  .UNINDENT
* <b>**installationTypes**</b>  
  The **installationTypes** field is an object with installation type names as
  the keys and objects describing the installation types as the values. The
  installation type objects have the following fields:
  .INDENT 7.0
* <b>**name**</b>  
  The name of the installation type. This is always the same as the key in
  the **installationTypes** object.
* <b>**displayName**</b>  
  The value of the **DISPLAY\_NAME** field passed to
  **cpack\_add\_install\_type()**.
* <b>**index**</b>  
  The integer index of the installation type in the list.
  .UNINDENT
* <b>**projects**</b>  
  The **projects** field is an array of objects describing CMake projects which
  comprise the CPack project. The values in this field are derived from
  **CPACK\_INSTALL\_CMAKE\_PROJECTS**. In most cases, this will be only a
  single project. The project objects have the following fields:
  .INDENT 7.0
* <b>**projectName**</b>  
  The project name passed to **CPACK\_INSTALL\_CMAKE\_PROJECTS**.
* <b>**component**</b>  
  The name of the component or component set which comprises the project.
* <b>**directory**</b>  
  The build directory of the CMake project. This is the directory which
  contains the **cmake\_install.cmake** script.
* <b>**subDirectory**</b>  
  The subdirectory to install the project into inside the CPack package.
  .UNINDENT
* <b>**packageName**</b>  
  The package name given in **CPACK\_PACKAGE\_NAME**. Only present if
  this option is set.
* <b>**packageVersion**</b>  
  The package version given in **CPACK\_PACKAGE\_VERSION**. Only present
  if this option is set.
* <b>**packageDescriptionFile**</b>  
  The package description file given in
  **CPACK\_PACKAGE\_DESCRIPTION\_FILE**. Only present if this option is
  set.
* <b>**packageDescriptionSummary**</b>  
  The package description summary given in
  **CPACK\_PACKAGE\_DESCRIPTION\_SUMMARY**. Only present if this option is
  set.
* <b>**buildConfig**</b>  
  The build configuration given to CPack with the **-C** option. Only present
  if this option is set.
* <b>**defaultDirectoryPermissions**</b>  
  The default directory permissions given in
  **CPACK\_INSTALL\_DEFAULT\_DIRECTORY\_PERMISSIONS**. Only present if this
  option is set.
* <b>**setDestdir**</b>  
  True if **CPACK\_SET\_DESTDIR** is true, false if it is not.
* <b>**packagingInstallPrefix**</b>  
  The install prefix given in **CPACK\_PACKAGING\_INSTALL\_PREFIX**. Only
  present if **CPACK\_SET\_DESTDIR** is true.
* <b>**stripFiles**</b>  
  True if **CPACK\_STRIP\_FILES** is true, false if it is not.
* <b>**warnOnAbsoluteInstallDestination**</b>  
  True if **CPACK\_WARN\_ON\_ABSOLUTE\_INSTALL\_DESTINATION** is true, false
  if it is not.
* <b>**errorOnAbsoluteInstallDestination**</b>  
  True if **CPACK\_ERROR\_ON\_ABSOLUTE\_INSTALL\_DESTINATION** is true,
  false if it is not.
  .UNINDENT

<a name="variables-specific-to-cpack-external-generator"></a>

### Variables specific to CPack External generator

.INDENT 0.0

* **CPACK_EXTERNAL_REQUESTED_VERSIONS**  
  This variable is used to request a specific version of the CPack External
  generator. It is a list of **major.minor** values, separated by semicolons.

If this variable is set to a non-empty value, the CPack External generator
will iterate through each item in the list to search for a version that it
knows how to generate. Requested versions should be listed in order of
descending preference by the client software, as the first matching version
in the list will be generated.

The generator knows how to generate the version if it has a versioned
generator whose major version exactly matches the requested major version,
and whose minor version is greater than or equal to the requested minor
version. For example, if **CPACK\_EXTERNAL\_REQUESTED\_VERSIONS** contains 1.0, and
the CPack External generator knows how to generate 1.1, it will generate 1.1.
If the generator doesn’t know how to generate a version in the list, it skips
the version and looks at the next one. If it doesn’t know how to generate any
of the requested versions, an error is thrown.

If this variable is not set, or is empty, the CPack External generator will
generate the highest major and minor version that it knows how to generate.

If an invalid version is encountered in **CPACK\_EXTERNAL\_REQUESTED\_VERSIONS** (one
that doesn’t match **major.minor**, where **major** and **minor** are
integers), it is ignored.
.UNINDENT
.INDENT 0.0

* **CPACK_EXTERNAL_ENABLE_STAGING**  
  This variable can be set to true to enable optional installation
  into a temporary staging area which can then be picked up
  and packaged by an external packaging tool.
  The top level directory used by CPack for the current packaging
  task is contained in **CPACK\_TOPLEVEL\_DIRECTORY**.
  It is automatically cleaned up on each run before packaging is initiated
  and can be used for custom temporary files required by
  the external packaging tool.
  It also contains the staging area **CPACK\_TEMPORARY\_DIRECTORY**
  into which CPack performs the installation when staging is enabled.
  .UNINDENT
  .INDENT 0.0
* **CPACK_EXTERNAL_PACKAGE_SCRIPT**  
  This variable can optionally specify the full path to
  a CMake script file to be run as part of the CPack invocation.
  It is invoked after (optional) staging took place and may
  run an external packaging tool. The script has access to
  the variables defined by the CPack config file.
  .UNINDENT

<a name="cpack-freebsd-generator"></a>

### CPack FreeBSD Generator


The built in (binary) CPack FreeBSD (pkg) generator (Unix only)

<a name="variables-specific-to-cpack-freebsd-pkg-generator"></a>

### Variables specific to CPack FreeBSD (pkg) generator


The CPack FreeBSD generator may be used to create pkg(8) packages – these may
be used on FreeBSD, DragonflyBSD, NetBSD, OpenBSD, but also on Linux or OSX,
depending on the installed package-management tools – using **CPack**.

The CPack FreeBSD generator is a **CPack** generator and uses the
**CPACK\_XXX** variables used by **CPack**. It tries to re-use packaging
information that may already be specified for Debian packages for the
**CPack DEB Generator**. It also tries to re-use RPM packaging
information when Debian does not specify.

The CPack FreeBSD generator should work on any host with libpkg installed. The
packages it produces are specific to the host architecture and ABI.

The CPack FreeBSD generator sets package-metadata through
**CPACK\_FREEBSD\_XXX** variables. The CPack FreeBSD generator, unlike the
CPack Deb generator, does not specially support componentized packages; a
single package is created from all the software artifacts created through
CMake.

All of the variables can be set specifically for FreeBSD packaging in
the CPackConfig file or in CMakeLists.txt, but most of them have defaults
that use general settings (e.g. CMAKE_PROJECT_NAME) or Debian-specific
variables when those make sense (e.g. the homepage of an upstream project
is usually unchanged by the flavor of packaging). When there is no Debian
information to fall back on, but the RPM packaging has it, fall back to
the RPM information (e.g. package license).
.INDENT 0.0

* **CPACK_FREEBSD_PACKAGE_NAME**  
  Sets the package name (in the package manifest, but also affects the
  output filename).
  .INDENT 7.0
* ·  
  Mandatory: YES
* ·  
  Default:
  .INDENT 2.0
* ·  
  **CPACK\_PACKAGE\_NAME** (this is always set by CPack itself,
  based on CMAKE_PROJECT_NAME).
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_FREEBSD_PACKAGE_COMMENT**  
  Sets the package comment. This is the short description displayed by
  pkg(8) in standard “pkg info” output.
  .INDENT 7.0
* ·  
  Mandatory: YES
* ·  
  Default:
  .INDENT 2.0
* ·  
  **CPACK\_PACKAGE\_DESCRIPTION\_SUMMARY** (this is always set
  by CPack itself, if nothing else sets it explicitly).
* ·  
  **PROJECT\_DESCRIPTION** (this can be set with the DESCRIPTION
  parameter for **project()**).
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_FREEBSD_PACKAGE_DESCRIPTION**  
  Sets the package description. This is the long description of the package,
  given by “pkg info” with a specific package as argument.
  .INDENT 7.0
* ·  
  Mandatory: YES
* ·  
  Default:
  .INDENT 2.0
* ·  
  **CPACK\_DEBIAN\_PACKAGE\_DESCRIPTION** (this may be set already
  for Debian packaging, so we may as well re-use it).
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_FREEBSD_PACKAGE_WWW**  
  The URL of the web site for this package, preferably (when applicable) the
  site from which the original source can be obtained and any additional
  upstream documentation or information may be found.
  .INDENT 7.0
* ·  
  Mandatory: YES
* ·  
  Default:
  .UNINDENT
  .INDENT 7.0
  .INDENT 3.5
  .INDENT 0.0
* ·  
  **CMAKE\_PROJECT\_HOMEPAGE\_URL**, or if that is not set,
  **CPACK\_DEBIAN\_PACKAGE\_HOMEPAGE** (this may be set already
  for Debian packaging, so we may as well re-use it).
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_FREEBSD_PACKAGE_LICENSE**  
  The license, or licenses, which apply to this software package. This must
  be one or more license-identifiers that pkg recognizes as acceptable license
  identifiers (e.g. “GPLv2”).
  .INDENT 7.0
* ·  
  Mandatory: YES
* ·  
  Default:
  .INDENT 2.0
* ·  
  **CPACK\_RPM\_PACKAGE\_LICENSE**
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_FREEBSD_PACKAGE_LICENSE_LOGIC**  
  This variable is only of importance if there is more than one license.
  The default is “single”, which is only applicable to a single license.
  Other acceptable values are determined by pkg – those are “dual” or “multi” –
  meaning choice (OR) or simultaneous (AND) application of the licenses.
  .INDENT 7.0
* ·  
  Mandatory: NO
* ·  
  Default: single
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_FREEBSD_PACKAGE_MAINTAINER**  
  The FreeBSD maintainer (e.g. _kde@freebsd.org_) of this package.
  .INDENT 7.0
* ·  
  Mandatory: YES
* ·  
  Default: none
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_FREEBSD_PACKAGE_ORIGIN**  
  The origin (ports label) of this package; for packages built by CPack
  outside of the ports system this is of less importance. The default
  puts the package somewhere under misc/, as a stopgap.
  .INDENT 7.0
* ·  
  Mandatory: YES
* ·  
  Default: misc/&lt;package name&gt;
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_FREEBSD_PACKAGE_CATEGORIES**  
  The ports categories where this package lives (if it were to be built
  from ports). If none is set a single category is determined based on
  the package origin.
  .INDENT 7.0
* ·  
  Mandatory: YES
* ·  
  Default: derived from ORIGIN
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_FREEBSD_PACKAGE_DEPS**  
  A list of package origins that should be added as package dependencies.
  These are in the form &lt;category&gt;/&lt;packagename&gt;, e.g. x11/libkonq.
  No version information needs to be provided (this is not included
  in the manifest).
  .INDENT 7.0
* ·  
  Mandatory: NO
* ·  
  Default: empty
  .UNINDENT
  .UNINDENT

<a name="cpack-ifw-generator"></a>

### CPack IFW Generator


<a name="overview"></a>

### Overview


This **cpack generator** generates
configuration and meta information for the _Qt Installer Framework_ (QtIFW).

QtIFW provides tools and utilities to create installers for
the platforms supported by _Qt_: Linux,
Microsoft Windows, and macOS.

To make use of this generator, QtIFW should also be installed.
The module **CPackIFW** looks for the location of the
QtIFW command-line utilities.

<a name="hints"></a>

### Hints


Generally, the CPack **IFW** generator automatically finds QtIFW tools,
but if you don’t use a default path for installation of the QtIFW tools,
the path may be specified in either a CMake or an environment variable:
.INDENT 0.0

* **CPACK_IFW_ROOT**  
  An CMake variable which specifies the location of the QtIFW tool suite.

The variable will be cached in the **CPackConfig.cmake** file and used at
CPack runtime.
.UNINDENT
.INDENT 0.0

* **QTIFWDIR**  
  An environment variable which specifies the location of the QtIFW tool
  suite.
  .UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The specified path should not contain “bin” at the end
(for example: “D:\eDevTools\eQtIFW2.0.5”).
.UNINDENT
.UNINDENT

The _CPACK\_IFW\_ROOT_ variable has a higher priority and overrides
the value of the _QTIFWDIR_ variable.

<a name="internationalization"></a>

### Internationalization


Some variables and command arguments support internationalization via
CMake script. This is an optional feature.

Installers created by QtIFW tools have built-in support for
internationalization and many phrases are localized to many languages,
but this does not apply to the description of the your components and groups
that will be distributed.

Localization of the description of your components and groups is useful for
users of your installers.

A localized variable or argument can contain a single default value, and a
set of pairs the name of the locale and the localized value.

For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(LOCALIZABLE_VARIABLE "Default value"
      en "English value"
      en_US "American value"
      en_GB "Great Britain value"
      )
    .ft P
.UNINDENT
.UNINDENT

<a name="variables"></a>

### Variables


You can use the following variables to change behavior of CPack **IFW**
generator.

<a name="debug"></a>

### Debug

.INDENT 0.0

* **CPACK_IFW_VERBOSE**  
  Set to **ON** to enable addition debug output.
  By default is **OFF**.
  .UNINDENT

<a name="package"></a>

### Package

.INDENT 0.0

* **CPACK_IFW_PACKAGE_TITLE**  
  Name of the installer as displayed on the title bar.
  By default used **CPACK\_PACKAGE\_DESCRIPTION\_SUMMARY**.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_PUBLISHER**  
  Publisher of the software (as shown in the Windows Control Panel).
  By default used **CPACK\_PACKAGE\_VENDOR**.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PRODUCT_URL**  
  URL to a page that contains product information on your web site.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_ICON**  
  Filename for a custom installer icon. The actual file is ‘.icns’ (macOS),
  ‘.ico’ (Windows). No functionality on Unix.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_WINDOW_ICON**  
  Filename for a custom window icon in PNG format for the Installer
  application.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_LOGO**  
  Filename for a logo is used as QWizard::LogoPixmap.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_WATERMARK**  
  Filename for a watermark is used as QWizard::WatermarkPixmap.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_BANNER**  
  Filename for a banner is used as QWizard::BannerPixmap.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_BACKGROUND**  
  Filename for an image used as QWizard::BackgroundPixmap (only used by MacStyle).
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_WIZARD_STYLE**  
  Wizard style to be used (“Modern”, “Mac”, “Aero” or “Classic”).
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_STYLE_SHEET**  
  Filename for a stylesheet.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_WIZARD_DEFAULT_WIDTH**  
  Default width of the wizard in pixels. Setting a banner image will override this.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_WIZARD_DEFAULT_HEIGHT**  
  Default height of the wizard in pixels. Setting a watermark image will override this.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_TITLE_COLOR**  
  Color of the titles and subtitles (takes an HTML color code, such as “#88FF33”).
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_START_MENU_DIRECTORY**  
  Name of the default program group for the product in the Windows Start menu.

By default used _CPACK\_IFW\_PACKAGE\_NAME_.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_TARGET_DIRECTORY**  
  Default target directory for installation.
  By default used
  “@ApplicationsDir@/**CPACK\_PACKAGE\_INSTALL\_DIRECTORY**”

You can use predefined variables.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_ADMIN_TARGET_DIRECTORY**  
  Default target directory for installation with administrator rights.

You can use predefined variables.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_PACKAGE_GROUP**  
  The group, which will be used to configure the root package
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_NAME**  
  The root package name, which will be used if configuration group is not
  specified
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_MAINTENANCE_TOOL_NAME**  
  Filename of the generated maintenance tool.
  The platform-specific executable file extension is appended.

By default used QtIFW defaults (**maintenancetool**).
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_PACKAGE_REMOVE_TARGET_DIR**  
  Set to **OFF** if the target directory should not be deleted when uninstalling.

Is **ON** by default
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_PACKAGE_MAINTENANCE_TOOL_INI_FILE**  
  Filename for the configuration of the generated maintenance tool.

By default used QtIFW defaults (**maintenancetool.ini**).
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_PACKAGE_ALLOW_NON_ASCII_CHARACTERS**  
  Set to **ON** if the installation path can contain non-ASCII characters.

Is **ON** for QtIFW less 2.0 tools.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_PACKAGE_ALLOW_SPACE_IN_PATH**  
  Set to **OFF** if the installation path cannot contain space characters.

Is **ON** for QtIFW less 2.0 tools.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_PACKAGE_CONTROL_SCRIPT**  
  Filename for a custom installer control script.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGE_RESOURCES**  
  List of additional resources (‘.qrc’ files) to include in the installer
  binary.

You can use **cpack\_ifw\_add\_package\_resources()** command to resolve
relative paths.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_PACKAGE_FILE_EXTENSION**  
  The target binary extension.

On Linux, the name of the target binary is automatically extended with
‘.run’, if you do not specify the extension.

On Windows, the target is created as an application with the extension
‘.exe’, which is automatically added, if not supplied.

On Mac, the target is created as an DMG disk image with the extension
‘.dmg’, which is automatically added, if not supplied.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_REPOSITORIES_ALL**  
  The list of remote repositories.

The default value of this variable is computed by CPack and contains
all repositories added with command **cpack\_ifw\_add\_repository()**
or updated with command **cpack\_ifw\_update\_repository()**.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_DOWNLOAD_ALL**  
  If this is **ON** all components will be downloaded.
  By default is **OFF** or used value
  from **CPACK\_DOWNLOAD\_ALL** if set
  .UNINDENT

<a name="components"></a>

### Components

.INDENT 0.0

* **CPACK_IFW_RESOLVE_DUPLICATE_NAMES**  
  Resolve duplicate names when installing components with groups.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_PACKAGES_DIRECTORIES**  
  Additional prepared packages dirs that will be used to resolve
  dependent components.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_REPOSITORIES_DIRECTORIES**  
  Additional prepared repository dirs that will be used to resolve and
  repack dependent components. This feature available only
  since QtIFW 3.1.
  .UNINDENT

<a name="tools"></a>

### Tools

.INDENT 0.0

* **CPACK_IFW_FRAMEWORK_VERSION**  
  The version of used QtIFW tools.
  .UNINDENT
  .INDENT 0.0
* **CPACK_IFW_BINARYCREATOR_EXECUTABLE**  
  The path to “binarycreator” command line client.

This variable is cached and may be configured if needed.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_REPOGEN_EXECUTABLE**  
  The path to “repogen” command line client.

This variable is cached and may be configured if needed.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_INSTALLERBASE_EXECUTABLE**  
  The path to “installerbase” installer executable base.

This variable is cached and may be configured if needed.
.UNINDENT
.INDENT 0.0

* **CPACK_IFW_DEVTOOL_EXECUTABLE**  
  The path to “devtool” command line client.

This variable is cached and may be configured if needed.
.UNINDENT

<a name="online-installer"></a>

### Online installer


By default CPack IFW generator makes offline installer. This means that all
components will be packaged into a binary file.

To make a component downloaded, you must set the **DOWNLOADED** option in
**cpack\_add\_component()**.

Then you would use the command **cpack\_configure\_downloads()**.
If you set **ALL** option all components will be downloaded.

You also can use command **cpack\_ifw\_add\_repository()** and
variable _CPACK\_IFW\_DOWNLOAD\_ALL_ for more specific configuration.

CPack IFW generator creates “repository” dir in current binary dir. You
would copy content of this dir to specified **site** (**url**).

<a name="see-also"></a>

### See Also


Qt Installer Framework Manual:
.INDENT 0.0

* ·  
  Index page:
  _http://doc.qt.io/qtinstallerframework/index.html_
* ·  
  Component Scripting:
  _http://doc.qt.io/qtinstallerframework/scripting.html_
* ·  
  Predefined Variables:
  _http://doc.qt.io/qtinstallerframework/scripting.html#predefined-variables_
* ·  
  Promoting Updates:
  _http://doc.qt.io/qtinstallerframework/ifw-updates.html_
  .UNINDENT
  .INDENT 0.0
* **Download Qt Installer Framework for you platform from Qt site:**  
  _http://download.qt.io/official\_releases/qt-installer-framework_
  .UNINDENT

<a name="cpack-nsis-generator"></a>

### CPack NSIS Generator


CPack Nullsoft Scriptable Install System (NSIS) generator specific options.

The NSIS generator requires NSIS 3.0 or newer.

<a name="variables-specific-to-cpack-nsis-generator"></a>

### Variables specific to CPack NSIS generator


The following variables are specific to the graphical installers built
on Windows Nullsoft Scriptable Install System.
.INDENT 0.0

* **CPACK_NSIS_INSTALL_ROOT**  
  The default installation directory presented to the end user by the NSIS
  installer is under this root dir. The full directory presented to the end
  user is: **${CPACK\_NSIS\_INSTALL\_ROOT}/${CPACK\_PACKAGE\_INSTALL\_DIRECTORY}**
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_MUI_ICON**  
  An icon filename.  The name of a ***.ico** file used as the main icon for the
  generated install program.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_MUI_UNIICON**  
  An icon filename.  The name of a ***.ico** file used as the main icon for the
  generated uninstall program.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_INSTALLER_MUI_ICON_CODE**  
  undocumented.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_MUI_WELCOMEFINISHPAGE_BITMAP**  
  The filename of a bitmap to use as the NSIS **MUI\_WELCOMEFINISHPAGE\_BITMAP**.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_MUI_UNWELCOMEFINISHPAGE_BITMAP**  
  The filename of a bitmap to use as the NSIS **MUI\_UNWELCOMEFINISHPAGE\_BITMAP**.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_EXTRA_PREINSTALL_COMMANDS**  
  Extra NSIS commands that will be added to the beginning of the install
  Section, before your install tree is available on the target system.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_EXTRA_INSTALL_COMMANDS**  
  Extra NSIS commands that will be added to the end of the install Section,
  after your install tree is available on the target system.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_EXTRA_UNINSTALL_COMMANDS**  
  Extra NSIS commands that will be added to the uninstall Section, before
  your install tree is removed from the target system.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_COMPRESSOR**  
  The arguments that will be passed to the NSIS _SetCompressor_ command.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL**  
  Ask about uninstalling previous versions first.  If this is set to **ON**,
  then an installer will look for previous installed versions and if one is
  found, ask the user whether to uninstall it before proceeding with the
  install.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_MODIFY_PATH**  
  Modify **PATH** toggle.  If this is set to **ON**, then an extra page will appear
  in the installer that will allow the user to choose whether the program
  directory should be added to the system **PATH** variable.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_DISPLAY_NAME**  
  The display name string that appears in the Windows _Apps & features_
  in _Control Panel_
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_PACKAGE_NAME**  
  The title displayed at the top of the installer.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_INSTALLED_ICON_NAME**  
  A path to the executable that contains the installer icon.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_HELP_LINK**  
  URL to a web site providing assistance in installing your application.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_URL_INFO_ABOUT**  
  URL to a web site providing more information about your application.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_CONTACT**  
  Contact information for questions and comments about the installation
  process.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_&lt;compName&gt;_INSTALL_DIRECTORY**  
  Custom install directory for the specified component **&lt;compName&gt;** instead
  of **$INSTDIR**.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_CREATE_ICONS_EXTRA**  
  Additional NSIS commands for creating _Start Menu_ shortcuts.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_DELETE_ICONS_EXTRA**  
  Additional NSIS commands to uninstall _Start Menu_ shortcuts.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_EXECUTABLES_DIRECTORY**  
  Creating NSIS _Start Menu_ links assumes that they are in **bin** unless this
  variable is set.  For example, you would set this to **exec** if your
  executables are in an exec directory.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_MUI_FINISHPAGE_RUN**  
  Specify an executable to add an option to run on the finish page of the
  NSIS installer.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_MENU_LINKS**  
  Specify links in **[application]** menu.  This should contain a list of pair
  **link** **link name**. The link may be a URL or a path relative to
  installation prefix.  Like:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    set(CPACK_NSIS_MENU_LINKS
        "doc/cmake-@CMake_VERSION_MAJOR@.@CMake_VERSION_MINOR@/cmake.html"
        "CMake Help" "https://cmake.org" "CMake Web Site")
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_NSIS_UNINSTALL_NAME**  
  Specify the name of the program to uninstall the version.
  Default is **Uninstall**.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_WELCOME_TITLE**  
  The title to display on the top of the page for the welcome page.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_WELCOME_TITLE_3LINES**  
  Display the title in the welcome page on 3 lines instead of 2.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_FINISH_TITLE**  
  The title to display on the top of the page for the finish page.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_FINISH_TITLE_3LINES**  
  Display the title in the finish page on 3 lines instead of 2.
  .UNINDENT
  .INDENT 0.0
* **CPACK_NSIS_MUI_HEADERIMAGE**  
  The image to display on the header of installers pages.
  .UNINDENT

<a name="cpack-nuget-generator"></a>

### CPack NuGet Generator


When build a NuGet package there is no direct way to control an output
filename due a lack of the corresponding CLI option of NuGet, so there
is no **CPACK\_NUGET\_PACKAGE\_FILENAME** variable. To form the output filename
NuGet uses the package name and the version according to its built-in rules.

Also, be aware that including a top level directory
(**CPACK\_INCLUDE\_TOPLEVEL\_DIRECTORY**) is ignored by this generator.

<a name="variables-specific-to-cpack-nuget-generator"></a>

### Variables specific to CPack NuGet generator


The CPack NuGet generator may be used to create NuGet packages using
**CPack**. The CPack NuGet generator is a **CPack** generator thus
it uses the **CPACK\_XXX** variables used by **CPack**.

The CPack NuGet generator has specific features which are controlled by the
specifics **CPACK\_NUGET\_XXX** variables. In the “one per group” mode
(see **CPACK\_COMPONENTS\_GROUPING**), **&lt;compName&gt;** placeholder
in the variables below would contain a group name (uppercased and turned into
a “C” identifier).

List of CPack NuGet generator specific variables:
.INDENT 0.0

* **CPACK_NUGET_COMPONENT_INSTALL**  
  Enable component packaging for CPack NuGet generator
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_NAME**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_NAME**  
  The NUGET package name.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : **CPACK\_PACKAGE\_NAME**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_VERSION**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_VERSION**  
  The NuGet package version.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : **CPACK\_PACKAGE\_VERSION**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_DESCRIPTION**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_DESCRIPTION**  
  A long description of the package for UI display.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  .INDENT 2.0
* **Default :**  
  .INDENT 7.0
* ·  
  **CPACK\_COMPONENT\_&lt;compName&gt;\_DESCRIPTION**,
* ·  
  **CPACK\_COMPONENT\_GROUP\_&lt;groupName&gt;\_DESCRIPTION**,
* ·  
  **CPACK\_PACKAGE\_DESCRIPTION**
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_AUTHORS**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_AUTHORS**  
  A comma-separated list of packages authors, matching the profile names
  on _nuget.org_. These are displayed in the NuGet Gallery on
  _nuget.org_ and are used to cross-reference packages by the same
  authors.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : **CPACK\_PACKAGE\_VENDOR**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_TITLE**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_TITLE**  
  A human-friendly title of the package, typically used in UI displays
  as on _nuget.org_ and the Package Manager in Visual Studio. If not
  specified, the package ID is used.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  .INDENT 2.0
* **Default :**  
  .INDENT 7.0
* ·  
  **CPACK\_COMPONENT\_&lt;compName&gt;\_DISPLAY\_NAME**,
* ·  
  **CPACK\_COMPONENT\_GROUP\_&lt;groupName&gt;\_DISPLAY\_NAME**
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_OWNERS**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_OWNERS**  
  A comma-separated list of the package creators using profile names
  on _nuget.org_. This is often the same list as in authors,
  and is ignored when uploading the package to _nuget.org_.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_HOMEPAGE_URL**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_HOMEPAGE_URL**  
  A URL for the package’s home page, often shown in UI displays as well
  as _nuget.org_.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : **CPACK\_PACKAGE\_HOMEPAGE\_URL**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_LICENSEURL**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_LICENSEURL**  
  A URL for the package’s license, often shown in UI displays as well
  as _nuget.org_.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_ICONURL**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_ICONURL**  
  A URL for a 64x64 image with transparency background to use as the
  icon for the package in UI display.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_DESCRIPTION_SUMMARY**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_DESCRIPTION_SUMMARY**  
  A short description of the package for UI display. If omitted, a
  truncated version of description is used.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : **CPACK\_PACKAGE\_DESCRIPTION\_SUMMARY**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_RELEASE_NOTES**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_RELEASE_NOTES**  
  A description of the changes made in this release of the package,
  often used in UI like the Updates tab of the Visual Studio Package
  Manager in place of the package description.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_COPYRIGHT**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_COPYRIGHT**  
  Copyright details for the package.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_TAGS**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_TAGS**  
  A space-delimited list of tags and keywords that describe the
  package and aid discoverability of packages through search and
  filtering.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_DEPENDENCIES**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_DEPENDENCIES**  
  A list of package dependencies.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_DEPENDENCIES_&lt;dependency&gt;_VERSION**  
* **CPACK_NUGET_&lt;compName&gt;_PACKAGE_DEPENDENCIES_&lt;dependency&gt;_VERSION**  
  A _version specification_ for the particular dependency, where
  **&lt;dependency&gt;** is an item of the dependency list (see above)
  transformed with **MAKE\_C\_IDENTIFIER** function of **string()**
  command.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_NUGET_PACKAGE_DEBUG**  
  Enable debug messages while executing CPack NuGet generator.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT
  .UNINDENT

<a name="cpack-packagemaker-generator"></a>

### CPack PackageMaker Generator


PackageMaker CPack generator (macOS).

Deprecated since version 3.17: Xcode no longer distributes the PackageMaker tools.
This CPack generator will be removed in a future version of CPack.


<a name="variables-specific-to-cpack-packagemaker-generator"></a>

### Variables specific to CPack PackageMaker generator


The following variable is specific to installers built on Mac
macOS using PackageMaker:
.INDENT 0.0

* **CPACK_OSX_PACKAGE_VERSION**  
  The version of macOS that the resulting PackageMaker archive should be
  compatible with. Different versions of macOS support different
  features. For example, CPack can only build component-based installers for
  macOS 10.4 or newer, and can only build installers that download
  components on-the-fly for macOS 10.5 or newer. If left blank, this value
  will be set to the minimum version of macOS that supports the requested
  features. Set this variable to some value (e.g., 10.4) only if you want to
  guarantee that your installer will work on that version of macOS, and
  don’t mind missing extra features available in the installer shipping with
  later versions of macOS.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND**  
  Adds a background to Distribtion XML if specified. The value contains the
  path to image in **Resources** directory.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND_ALIGNMENT**  
  Adds an **alignment** attribute to the background in Distribution XML.
  Refer to Apple documentation for valid values.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND_SCALING**  
  Adds a **scaling** attribute to the background in Distribution XML.
  Refer to Apple documentation for valid values.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND_MIME_TYPE**  
  Adds a **mime-type** attribute to the background in Distribution XML.
  The option contains MIME type of an image.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND_UTI**  
  Adds an **uti** attribute to the background in Distribution XML.
  The option contains UTI type of an image.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND_DARKAQUA**  
  Adds a background for the Dark Aqua theme to Distribution XML if
  specified. The value contains the path to image in **Resources**
  directory.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND_DARKAQUA_ALIGNMENT**  
  Does the same as _CPACK\_PACKAGEMAKER\_BACKGROUND\_ALIGNMENT_ option,
  but for the dark theme.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND_DARKAQUA_SCALING**  
  Does the same as _CPACK\_PACKAGEMAKER\_BACKGROUND\_SCALING_ option,
  but for the dark theme.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND_DARKAQUA_MIME_TYPE**  
  Does the same as _CPACK\_PACKAGEMAKER\_BACKGROUND\_MIME\_TYPE_ option,
  but for the dark theme.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PACKAGEMAKER_BACKGROUND_DARKAQUA_UTI**  
  Does the same as _CPACK\_PACKAGEMAKER\_BACKGROUND\_UTI_ option,
  but for the dark theme.
  .UNINDENT

<a name="cpack-productbuild-generator"></a>

### CPack productbuild Generator


productbuild CPack generator (macOS).

<a name="variables-specific-to-cpack-productbuild-generator"></a>

### Variables specific to CPack productbuild generator


The following variable is specific to installers built on Mac
macOS using ProductBuild:
.INDENT 0.0

* **CPACK_COMMAND_PRODUCTBUILD**  
  Path to the **productbuild(1)** command used to generate a product archive for
  the macOS Installer or Mac App Store.  This variable can be used to override
  the automatically detected command (or specify its location if the
  auto-detection fails to find it).
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_IDENTITY_NAME**  
  Adds a digital signature to the resulting package.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_KEYCHAIN_PATH**  
  Specify a specific keychain to search for the signing identity.
  .UNINDENT
  .INDENT 0.0
* **CPACK_COMMAND_PKGBUILD**  
  Path to the **pkgbuild(1)** command used to generate an macOS component package
  on macOS.  This variable can be used to override the automatically detected
  command (or specify its location if the auto-detection fails to find it).
  .UNINDENT
  .INDENT 0.0
* **CPACK_PKGBUILD_IDENTITY_NAME**  
  Adds a digital signature to the resulting package.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PKGBUILD_KEYCHAIN_PATH**  
  Specify a specific keychain to search for the signing identity.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PREFLIGHT_&lt;COMP&gt;_SCRIPT**  
  Full path to a file that will be used as the **preinstall** script for the
  named **&lt;COMP&gt;** component’s package, where **&lt;COMP&gt;** is the uppercased
  component name.  No **preinstall** script is added if this variable is not
  defined for a given component.
  .UNINDENT
  .INDENT 0.0
* **CPACK_POSTFLIGHT_&lt;COMP&gt;_SCRIPT**  
  Full path to a file that will be used as the **postinstall** script for the
  named **&lt;COMP&gt;** component’s package, where **&lt;COMP&gt;** is the uppercased
  component name.  No **postinstall** script is added if this variable is not
  defined for a given component.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_RESOURCES_DIR**  
  If specified the productbuild generator copies files from this directory
  (including subdirectories) to the **Resources** directory. This is done
  before the **CPACK\_RESOURCE\_FILE\_WELCOME**,
  **CPACK\_RESOURCE\_FILE\_README**, and
  **CPACK\_RESOURCE\_FILE\_LICENSE** files are copied.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND**  
  Adds a background to Distribtion XML if specified. The value contains the
  path to image in **Resources** directory.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND_ALIGNMENT**  
  Adds an **alignment** attribute to the background in Distribution XML.
  Refer to Apple documentation for valid values.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND_SCALING**  
  Adds a **scaling** attribute to the background in Distribution XML.
  Refer to Apple documentation for valid values.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND_MIME_TYPE**  
  Adds a **mime-type** attribute to the background in Distribution XML.
  The option contains MIME type of an image.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND_UTI**  
  Adds an **uti** attribute to the background in Distribution XML.
  The option contains UTI type of an image.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND_DARKAQUA**  
  Adds a background for the Dark Aqua theme to Distribution XML if
  specified. The value contains the path to image in **Resources**
  directory.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND_DARKAQUA_ALIGNMENT**  
  Does the same as _CPACK\_PRODUCTBUILD\_BACKGROUND\_ALIGNMENT_ option,
  but for the dark theme.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND_DARKAQUA_SCALING**  
  Does the same as _CPACK\_PRODUCTBUILD\_BACKGROUND\_SCALING_ option,
  but for the dark theme.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND_DARKAQUA_MIME_TYPE**  
  Does the same as _CPACK\_PRODUCTBUILD\_BACKGROUND\_MIME\_TYPE_ option,
  but for the dark theme.
  .UNINDENT
  .INDENT 0.0
* **CPACK_PRODUCTBUILD_BACKGROUND_DARKAQUA_UTI**  
  Does the same as _CPACK\_PRODUCTBUILD\_BACKGROUND\_UTI_ option,
  but for the dark theme.
  .UNINDENT

<a name="cpack-rpm-generator"></a>

### CPack RPM Generator


The built in (binary) CPack RPM generator (Unix only)

<a name="variables-specific-to-cpack-rpm-generator"></a>

### Variables specific to CPack RPM generator


The CPack RPM generator may be used to create RPM packages using **CPack**.
The CPack RPM generator is a **CPack** generator thus it uses the
**CPACK\_XXX** variables used by **CPack**.

The CPack RPM generator has specific features which are controlled by the specifics
**CPACK\_RPM\_XXX** variables.

**CPACK\_RPM\_&lt;COMPONENT&gt;\_XXXX** variables may be used in order to have
**component** specific values.  Note however that **&lt;COMPONENT&gt;** refers to the
**grouping name** written in upper case. It may be either a component name or
a component GROUP name. Usually those variables correspond to RPM spec file
entities. One may find information about spec files here
_http://www.rpm.org/wiki/Docs_

**NOTE:**
.INDENT 0.0
.INDENT 3.5
_&lt;COMPONENT&gt;_ part of variables is preferred to be in upper case (e.g. if
component is named **foo** then use **CPACK\_RPM\_FOO\_XXXX** variable name format)
as is with other **CPACK\_&lt;COMPONENT&gt;\_XXXX** variables.
For the purposes of back compatibility (CMake/CPack version 3.5 and lower)
support for same cased component (e.g. **fOo** would be used as
**CPACK\_RPM\_fOo\_XXXX**) is still supported for variables defined in older
versions of CMake/CPack but is not guaranteed for variables that
will be added in the future. For the sake of back compatibility same cased
component variables also override upper cased versions where both are
present.
.UNINDENT
.UNINDENT

Here are some CPack RPM generator wiki resources that are here for historic
reasons and are no longer maintained but may still prove useful:
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* ·  
  _https://gitlab.kitware.com/cmake/community/wikis/doc/cpack/Configuration_
* ·  
  _https://gitlab.kitware.com/cmake/community/wikis/doc/cpack/PackageGenerators#rpm-unix-only_
  .UNINDENT
  .UNINDENT
  .UNINDENT

List of CPack RPM generator specific variables:
.INDENT 0.0

* **CPACK_RPM_COMPONENT_INSTALL**  
  Enable component packaging for CPack RPM generator
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT

If enabled (**ON**) multiple packages are generated. By default
a single package containing files of all components is generated.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_SUMMARY**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_SUMMARY**  
  The RPM package summary.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : **CPACK\_PACKAGE\_DESCRIPTION\_SUMMARY**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_PACKAGE_NAME**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_NAME**  
  The RPM package name.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : **CPACK\_PACKAGE\_NAME**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_FILE_NAME**  
* **CPACK_RPM_&lt;component&gt;_FILE_NAME**  
  Package file name.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  .INDENT 2.0
* **Default**  
  **&lt;CPACK\_PACKAGE\_FILE\_NAME&gt;[-&lt;component&gt;].rpm** with spaces
  replaced by ‘-‘
  .UNINDENT
  .UNINDENT

This may be set to **RPM-DEFAULT** to allow **rpmbuild** tool to generate package
file name by itself.
Alternatively provided package file name must end with **.rpm** suffix.

**NOTE:**
.INDENT 7.0
.INDENT 3.5
By using user provided spec file, rpm macro extensions such as for
generating **debuginfo** packages or by simply using multiple components more
than one rpm file may be generated, either from a single spec file or from
multiple spec files (each component execution produces its own spec file).
In such cases duplicate file names may occur as a result of this variable
setting or spec file content structure. Duplicate files get overwritten
and it is up to the packager to set the variables in a manner that will
prevent such errors.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_MAIN_COMPONENT**  
  Main component that is packaged without component suffix.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

This variable can be set to any component or group name so that component or
group rpm package is generated without component suffix in filename and
package name.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_EPOCH**  
  The RPM package epoch
  .INDENT 7.0
* ·  
  Mandatory : No
* ·  
  Default   : -
  .UNINDENT

Optional number that should be incremented when changing versioning schemas
or fixing mistakes in the version numbers of older packages.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_VERSION**  
  The RPM package version.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : **CPACK\_PACKAGE\_VERSION**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_PACKAGE_ARCHITECTURE**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_ARCHITECTURE**  
  The RPM package architecture.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : Native architecture output by **uname -m**
  .UNINDENT

This may be set to **noarch** if you know you are building a **noarch** package.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_RELEASE**  
  The RPM package release.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : 1
  .UNINDENT

This is the numbering of the RPM package itself, i.e. the version of the
packaging and not the version of the content (see
_CPACK\_RPM\_PACKAGE\_VERSION_). One may change the default value if
the previous packaging was buggy and/or you want to put here a fancy Linux
distro specific numbering.
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This is the string that goes into the RPM **Release:** field. Some distros
(e.g. Fedora, CentOS) require **1%{?dist}** format and not just a number.
**%{?dist}** part can be added by setting _CPACK\_RPM\_PACKAGE\_RELEASE\_DIST_.
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_RELEASE_DIST**  
  The dist tag that is added  RPM **Release:** field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT

This is the reported **%{dist}** tag from the current distribution or empty
**%{dist}** if RPM macro is not set. If this variable is set then RPM
**Release:** field value is set to **${CPACK\_RPM\_PACKAGE\_RELEASE}%{?dist}**.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_LICENSE**  
  The RPM package license policy.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : “unknown”
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_PACKAGE_GROUP**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_GROUP**  
  The RPM package group.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : “unknown”
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_PACKAGE_VENDOR**  
  The RPM package vendor.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : CPACK_PACKAGE_VENDOR if set or “unknown”
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_PACKAGE_URL**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_URL**  
  The projects URL.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : **CMAKE\_PROJECT\_HOMEPAGE\_URL**
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_PACKAGE_DESCRIPTION**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_DESCRIPTION**  
  RPM package description.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default : **CPACK\_COMPONENT\_&lt;compName&gt;\_DESCRIPTION** (component
  based installers only) if set, **CPACK\_PACKAGE\_DESCRIPTION\_FILE**
  if set or “no package description available”
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_COMPRESSION_TYPE**  
  RPM compression type.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to override RPM compression type to be used to build the
RPM. For example some Linux distribution now default to **lzma** or **xz**
compression whereas older cannot use such RPM. Using this one can enforce
compression type to be used.

Possible values are:
.INDENT 7.0

* ·  
  lzma
* ·  
  xz
* ·  
  bzip2
* ·  
  gzip
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_PACKAGE_AUTOREQ**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_AUTOREQ**  
  RPM spec autoreq field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to enable (**1**, **yes**) or disable (**0**, **no**) automatic
shared libraries dependency detection. Dependencies are added to requires list.

**NOTE:**
.INDENT 7.0
.INDENT 3.5
By default automatic dependency detection is enabled by rpm generator.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_AUTOPROV**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_AUTOPROV**  
  RPM spec autoprov field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to enable (**1**, **yes**) or disable (**0**, **no**)
automatic listing of shared libraries that are provided by the package.
Shared libraries are added to provides list.

**NOTE:**
.INDENT 7.0
.INDENT 3.5
By default automatic provides detection is enabled by rpm generator.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_AUTOREQPROV**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_AUTOREQPROV**  
  RPM spec autoreqprov field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

Variable enables/disables autoreq and autoprov at the same time.
See _CPACK\_RPM\_PACKAGE\_AUTOREQ_ and
_CPACK\_RPM\_PACKAGE\_AUTOPROV_ for more details.

**NOTE:**
.INDENT 7.0
.INDENT 3.5
By default automatic detection feature is enabled by rpm.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_REQUIRES**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_REQUIRES**  
  RPM spec requires field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set RPM dependencies (requires). Note that you must enclose
the complete requires string between quotes, for example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_RPM_PACKAGE_REQUIRES "python >= 2.5.0, cmake >= 2.8")
    .ft P
.UNINDENT
.UNINDENT

The required package list of an RPM file could be printed with:
.INDENT 7.0
.INDENT 3.5

    .ft C
    rpm -qp --requires file.rpm
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_CONFLICTS**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_CONFLICTS**  
  RPM spec conflicts field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set negative RPM dependencies (conflicts). Note that you must
enclose the complete requires string between quotes, for example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_RPM_PACKAGE_CONFLICTS "libxml2")
    .ft P
.UNINDENT
.UNINDENT

The conflicting package list of an RPM file could be printed with:
.INDENT 7.0
.INDENT 3.5

    .ft C
    rpm -qp --conflicts file.rpm
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_REQUIRES_PRE**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_REQUIRES_PRE**  
  RPM spec requires(pre) field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set RPM preinstall dependencies (requires(pre)). Note that
you must enclose the complete requires string between quotes, for example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_RPM_PACKAGE_REQUIRES_PRE "shadow-utils, initscripts")
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_REQUIRES_POST**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_REQUIRES_POST**  
  RPM spec requires(post) field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set RPM postinstall dependencies (requires(post)). Note that
you must enclose the complete requires string between quotes, for example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_RPM_PACKAGE_REQUIRES_POST "shadow-utils, initscripts")
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_REQUIRES_POSTUN**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_REQUIRES_POSTUN**  
  RPM spec requires(postun) field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set RPM postuninstall dependencies (requires(postun)). Note
that you must enclose the complete requires string between quotes, for
example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_RPM_PACKAGE_REQUIRES_POSTUN "shadow-utils, initscripts")
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_REQUIRES_PREUN**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_REQUIRES_PREUN**  
  RPM spec requires(preun) field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set RPM preuninstall dependencies (requires(preun)). Note that
you must enclose the complete requires string between quotes, for example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_RPM_PACKAGE_REQUIRES_PREUN "shadow-utils, initscripts")
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_SUGGESTS**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_SUGGESTS**  
  RPM spec suggest field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set weak RPM dependencies (suggests). Note that you must
enclose the complete requires string between quotes.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_PROVIDES**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_PROVIDES**  
  RPM spec provides field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set RPM dependencies (provides). The provided package list
of an RPM file could be printed with:
.INDENT 7.0
.INDENT 3.5

    .ft C
    rpm -qp --provides file.rpm
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_OBSOLETES**  
* **CPACK_RPM_&lt;component&gt;_PACKAGE_OBSOLETES**  
  RPM spec obsoletes field.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set RPM packages that are obsoleted by this one.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_RELOCATABLE**  
  build a relocatable RPM.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : CPACK_PACKAGE_RELOCATABLE
  .UNINDENT

If this variable is set to TRUE or ON, the CPack RPM generator will try
to build a relocatable RPM package. A relocatable RPM may
be installed using:
.INDENT 7.0
.INDENT 3.5

    .ft C
    rpm --prefix or --relocate
    .ft P
.UNINDENT
.UNINDENT

in order to install it at an alternate place see rpm(8). Note that
currently this may fail if **CPACK\_SET\_DESTDIR** is set to **ON**. If
**CPACK\_SET\_DESTDIR** is set then you will get a warning message but
if there is file installed with absolute path you’ll get unexpected behavior.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_SPEC_INSTALL_POST**  
  Deprecated - use _CPACK\_RPM\_SPEC\_MORE\_DEFINE_ instead.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
* ·  
  Deprecated: YES
  .UNINDENT

May be used to override the **\_\_spec\_install\_post** section within the
generated spec file.  This affects the install step during package creation,
not during package installation.  For adding operations to be performed
during package installation, use
_CPACK\_RPM\_POST\_INSTALL\_SCRIPT\_FILE_ instead.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_SPEC_MORE_DEFINE**  
  RPM extended spec definitions lines.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to add any **%define** lines to the generated spec file.  An
example of its use is to prevent stripping of executables (but note that
this may also disable other default post install processing):
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_RPM_SPEC_MORE_DEFINE "%define __spec_install_post /bin/true")
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PACKAGE_DEBUG**  
  Toggle CPack RPM generator debug output.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be set when invoking cpack in order to trace debug information
during CPack RPM run. For example you may launch CPack like this:
.INDENT 7.0
.INDENT 3.5

    .ft C
    cpack -D CPACK_RPM_PACKAGE_DEBUG=1 -G RPM
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_USER_BINARY_SPECFILE**  
* **CPACK_RPM_&lt;componentName&gt;_USER_BINARY_SPECFILE**  
  A user provided spec file.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be set by the user in order to specify a USER binary spec file
to be used by the CPack RPM generator instead of generating the file.
The specified file will be processed by configure_file( @ONLY).
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_GENERATE_USER_BINARY_SPECFILE_TEMPLATE**  
  Spec file template.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

If set CPack will generate a template for USER specified binary
spec file and stop with an error. For example launch CPack like this:
.INDENT 7.0
.INDENT 3.5

    .ft C
    cpack -D CPACK_RPM_GENERATE_USER_BINARY_SPECFILE_TEMPLATE=1 -G RPM
    .ft P
.UNINDENT
.UNINDENT

The user may then use this file in order to hand-craft is own
binary spec file which may be used with
_CPACK\_RPM\_USER\_BINARY\_SPECFILE_.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_PRE_INSTALL_SCRIPT_FILE**  
* **CPACK_RPM_PRE_UNINSTALL_SCRIPT_FILE**  
  Path to file containing pre (un)install script.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to embed a pre (un)installation script in the spec file.
The referred script file (or both) will be read and directly
put after the **%pre** or **%preun** section
If _CPACK\_RPM\_COMPONENT\_INSTALL_ is set to ON the (un)install
script for each component can be overridden with
**CPACK\_RPM\_&lt;COMPONENT&gt;\_PRE\_INSTALL\_SCRIPT\_FILE** and
**CPACK\_RPM\_&lt;COMPONENT&gt;\_PRE\_UNINSTALL\_SCRIPT\_FILE**.
One may verify which scriptlet has been included with:
.INDENT 7.0
.INDENT 3.5

    .ft C
    rpm -qp --scripts  package.rpm
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_POST_INSTALL_SCRIPT_FILE**  
* **CPACK_RPM_POST_UNINSTALL_SCRIPT_FILE**  
  Path to file containing post (un)install script.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to embed a post (un)installation script in the spec file.
The referred script file (or both) will be read and directly
put after the **%post** or **%postun** section.
If _CPACK\_RPM\_COMPONENT\_INSTALL_ is set to ON the (un)install
script for each component can be overridden with
**CPACK\_RPM\_&lt;COMPONENT&gt;\_POST\_INSTALL\_SCRIPT\_FILE** and
**CPACK\_RPM\_&lt;COMPONENT&gt;\_POST\_UNINSTALL\_SCRIPT\_FILE**.
One may verify which scriptlet has been included with:
.INDENT 7.0
.INDENT 3.5

    .ft C
    rpm -qp --scripts  package.rpm
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_USER_FILELIST**  
* **CPACK_RPM_&lt;COMPONENT&gt;_USER_FILELIST**  
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to explicitly specify **%(&lt;directive&gt;)** file line
in the spec file. Like **%config(noreplace)** or any other directive
that be found in the **%files** section. You can have multiple directives
per line, as in **%attr(600,root,root) %config(noreplace)**. Since
the CPack RPM generator is generating the list of files (and directories) the
user specified files of the **CPACK\_RPM\_&lt;COMPONENT&gt;\_USER\_FILELIST** list will
be removed from the generated list. If referring to directories do
not add a trailing slash.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_CHANGELOG_FILE**  
  RPM changelog file.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to embed a changelog in the spec file.
The referred file will be read and directly put after the **%changelog**
section.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST**  
  list of path to be excluded.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  .INDENT 2.0
* **Default**  
  /etc /etc/init.d /usr /usr/bin /usr/include /usr/lib
  /usr/libx32 /usr/lib64 /usr/share /usr/share/aclocal
  /usr/share/doc
  .UNINDENT
  .UNINDENT

May be used to exclude path (directories or files) from the auto-generated
list of paths discovered by CPack RPM. The default value contains a
reasonable set of values if the variable is not defined by the user. If the
variable is defined by the user then the CPack RPM generator will NOT any of
the default path. If you want to add some path to the default list then you
can use _CPACK\_RPM\_EXCLUDE\_FROM\_AUTO\_FILELIST\_ADDITION_ variable.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST_ADDITION**  
  additional list of path to be excluded.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to add more exclude path (directories or files) from the initial
default list of excluded paths. See
_CPACK\_RPM\_EXCLUDE\_FROM\_AUTO\_FILELIST_.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_RELOCATION_PATHS**  
  Packages relocation paths list.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to specify more than one relocation path per relocatable RPM.
Variable contains a list of relocation paths that if relative are prefixed
by the value of _CPACK\_RPM\_&lt;COMPONENT&gt;\_PACKAGE\_PREFIX_ or by the
value of **CPACK\_PACKAGING\_INSTALL\_PREFIX** if the component version
is not provided.
Variable is not component based as its content can be used to set a different
path prefix for e.g. binary dir and documentation dir at the same time.
Only prefixes that are required by a certain component are added to that
component - component must contain at least one file/directory/symbolic link
with _CPACK\_RPM\_RELOCATION\_PATHS_ prefix for a certain relocation
path to be added. Package will not contain any relocation paths if there are
no files/directories/symbolic links on any of the provided prefix locations.
Packages that either do not contain any relocation paths or contain
files/directories/symbolic links that are outside relocation paths print
out an **AUTHOR\_WARNING** that RPM will be partially relocatable.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_&lt;COMPONENT&gt;_PACKAGE_PREFIX**  
  Per component relocation path install prefix.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : CPACK_PACKAGING_INSTALL_PREFIX
  .UNINDENT

May be used to set per component **CPACK\_PACKAGING\_INSTALL\_PREFIX**
for relocatable RPM packages.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_NO_INSTALL_PREFIX_RELOCATION**  
* **CPACK_RPM_NO_&lt;COMPONENT&gt;_INSTALL_PREFIX_RELOCATION**  
  Removal of default install prefix from relocation paths list.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  .INDENT 2.0
* **Default**  
  CPACK_PACKAGING_INSTALL_PREFIX or CPACK_RPM_&lt;COMPONENT&gt;_PACKAGE_PREFIX
  are treated as one of relocation paths
  .UNINDENT
  .UNINDENT

May be used to remove CPACK_PACKAGING_INSTALL_PREFIX and CPACK_RPM_&lt;COMPONENT&gt;_PACKAGE_PREFIX
from relocatable RPM prefix paths.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_ADDITIONAL_MAN_DIRS**  
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set additional man dirs that could potentially be compressed
by brp-compress RPM macro. Variable content must be a list of regular
expressions that point to directories containing man files or to man files
directly. Note that in order to compress man pages a path must also be
present in brp-compress RPM script and that brp-compress script must be
added to RPM configuration by the operating system.

Regular expressions that are added by default were taken from brp-compress
RPM macro:
.INDENT 7.0

* ·  
  /usr/man/man.*
* ·  
  /usr/man/.*/man.*
* ·  
  /usr/info.*
* ·  
  /usr/share/man/man.*
* ·  
  /usr/share/man/.*/man.*
* ·  
  /usr/share/info.*
* ·  
  /usr/kerberos/man.*
* ·  
  /usr/X11R6/man/man.*
* ·  
  /usr/lib/perl5/man/man.*
* ·  
  /usr/share/doc/.*/man/man.*
* ·  
  /usr/lib/.*/man/man.*
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_DEFAULT_USER**  
* **CPACK_RPM_&lt;compName&gt;_DEFAULT_USER**  
  default user ownership of RPM content
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : root
  .UNINDENT

Value should be user name and not UID.
Note that &lt;compName&gt; must be in upper-case.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_DEFAULT_GROUP**  
* **CPACK_RPM_&lt;compName&gt;_DEFAULT_GROUP**  
  default group ownership of RPM content
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : root
  .UNINDENT

Value should be group name and not GID.
Note that &lt;compName&gt; must be in upper-case.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_DEFAULT_FILE_PERMISSIONS**  
* **CPACK_RPM_&lt;compName&gt;_DEFAULT_FILE_PERMISSIONS**  
  default permissions used for packaged files
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : - (system default)
  .UNINDENT

Accepted values are lists with **PERMISSIONS**. Valid permissions
are:
.INDENT 7.0

* ·  
  OWNER_READ
* ·  
  OWNER_WRITE
* ·  
  OWNER_EXECUTE
* ·  
  GROUP_READ
* ·  
  GROUP_WRITE
* ·  
  GROUP_EXECUTE
* ·  
  WORLD_READ
* ·  
  WORLD_WRITE
* ·  
  WORLD_EXECUTE
  .UNINDENT

Note that &lt;compName&gt; must be in upper-case.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_DEFAULT_DIR_PERMISSIONS**  
* **CPACK_RPM_&lt;compName&gt;_DEFAULT_DIR_PERMISSIONS**  
  default permissions used for packaged directories
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : - (system default)
  .UNINDENT

Accepted values are lists with PERMISSIONS. Valid permissions
are the same as for _CPACK\_RPM\_DEFAULT\_FILE\_PERMISSIONS_.
Note that &lt;compName&gt; must be in upper-case.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_INSTALL_WITH_EXEC**  
  force execute permissions on programs and shared libraries
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : - (system default)
  .UNINDENT

Force set owner, group and world execute permissions on programs and shared
libraries. This can be used for creating valid rpm packages on systems such
as Debian where shared libraries do not have execute permissions set.
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Programs and shared libraries without execute permissions are ignored during
separation of debug symbols from the binary for debuginfo packages.
.UNINDENT
.UNINDENT

<a name="packaging-of-symbolic-links"></a>

### Packaging of Symbolic Links


The CPack RPM generator supports packaging of symbolic links:
.INDENT 0.0
.INDENT 3.5

    .ft C
    execute_process(COMMAND ${CMAKE_COMMAND}
      -E create_symlink <relative_path_location> <symlink_name>)
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/<symlink_name>
      DESTINATION <symlink_location> COMPONENT libraries)
    .ft P
.UNINDENT
.UNINDENT

Symbolic links will be optimized (paths will be shortened if possible)
before being added to the package or if multiple relocation paths are
detected, a post install symlink relocation script will be generated.

Symbolic links may point to locations that are not packaged by the same
package (either a different component or even not packaged at all) but
those locations will be treated as if they were a part of the package
while determining if symlink should be either created or present in a
post install script - depending on relocation paths.

Symbolic links that point to locations outside packaging path produce a
warning and are treated as non relocatable permanent symbolic links.

Currently there are a few limitations though:
.INDENT 0.0

* ·  
  For component based packaging component interdependency is not checked
  when processing symbolic links. Symbolic links pointing to content of
  a different component are treated the same way as if pointing to location
  that will not be packaged.
* ·  
  Symbolic links pointing to a location through one or more intermediate
  symbolic links will not be handled differently - if the intermediate
  symbolic link(s) is also on a relocatable path, relocating it during
  package installation may cause initial symbolic link to point to an
  invalid location.
  .UNINDENT

<a name="packaging-of-debug-information"></a>

### Packaging of debug information


Debuginfo packages contain debug symbols and sources for debugging packaged
binaries.

Debuginfo RPM packaging has its own set of variables:
.INDENT 0.0

* **CPACK_RPM_DEBUGINFO_PACKAGE**  
* **CPACK_RPM_&lt;component&gt;_DEBUGINFO_PACKAGE**  
  Enable generation of debuginfo RPM package(s).
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT
  .UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Binaries must contain debug symbols before packaging so use either **Debug**
or **RelWithDebInfo** for **CMAKE\_BUILD\_TYPE** variable value.
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Packages generated from packages without binary files, with binary files but
without execute permissions or without debug symbols will cause packaging
termination.
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_BUILD_SOURCE_DIRS**  
  Provides locations of root directories of source files from which binaries
  were built.
  .INDENT 7.0
* ·  
  Mandatory : YES if _CPACK\_RPM\_DEBUGINFO\_PACKAGE_ is set
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
For CMake project _CPACK\_BUILD\_SOURCE\_DIRS_ is set by default to
point to **CMAKE\_SOURCE\_DIR** and **CMAKE\_BINARY\_DIR** paths.
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Sources with path prefixes that do not fall under any location provided with
_CPACK\_BUILD\_SOURCE\_DIRS_ will not be present in debuginfo package.
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_BUILD_SOURCE_DIRS_PREFIX**  
* **CPACK_RPM_&lt;component&gt;_BUILD_SOURCE_DIRS_PREFIX**  
  Prefix of location where sources will be placed during package installation.
  .INDENT 7.0
* ·  
  Mandatory : YES if _CPACK\_RPM\_DEBUGINFO\_PACKAGE_ is set
* ·  
  .INDENT 2.0
* **Default**  
  “/usr/src/debug/&lt;CPACK_PACKAGE_FILE_NAME&gt;” and
  for component packaging “/usr/src/debug/&lt;CPACK_PACKAGE_FILE_NAME&gt;-&lt;component&gt;”
  .UNINDENT
  .UNINDENT
  .UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Each source path prefix is additionally suffixed by **src\_&lt;index&gt;** where
index is index of the path used from _CPACK\_BUILD\_SOURCE\_DIRS_
variable. This produces **&lt;CPACK\_RPM\_BUILD\_SOURCE\_DIRS\_PREFIX&gt;/src\_&lt;index&gt;**
replacement path.
Limitation is that replaced path part must be shorter or of equal
length than the length of its replacement. If that is not the case either
_CPACK\_RPM\_BUILD\_SOURCE\_DIRS\_PREFIX_ variable has to be set to
a shorter path or source directories must be placed on a longer path.
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_DEBUGINFO_EXCLUDE_DIRS**  
  Directories containing sources that should be excluded from debuginfo packages.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : “/usr /usr/src /usr/src/debug”
  .UNINDENT

Listed paths are owned by other RPM packages and should therefore not be
deleted on debuginfo package uninstallation.
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_DEBUGINFO_EXCLUDE_DIRS_ADDITION**  
  Paths that should be appended to _CPACK\_RPM\_DEBUGINFO\_EXCLUDE\_DIRS_
  for exclusion.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_DEBUGINFO_SINGLE_PACKAGE**  
  Create a single debuginfo package even if components packaging is set.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT

When this variable is enabled it produces a single debuginfo package even if
component packaging is enabled.

When using this feature in combination with components packaging and there is
more than one component this variable requires _CPACK\_RPM\_MAIN\_COMPONENT_
to be set.
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
If none of the _CPACK\_RPM\_&lt;component&gt;\_DEBUGINFO\_PACKAGE_ variables
is set then _CPACK\_RPM\_DEBUGINFO\_PACKAGE_ is automatically set to
**ON** when _CPACK\_RPM\_DEBUGINFO\_SINGLE\_PACKAGE_ is set.
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_DEBUGINFO_FILE_NAME**  
* **CPACK_RPM_&lt;component&gt;_DEBUGINFO_FILE_NAME**  
  Debuginfo package file name.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : rpmbuild tool generated package file name
  .UNINDENT

Alternatively provided debuginfo package file name must end with **.rpm**
suffix and should differ from file names of other generated packages.

Variable may contain **@cpack\_component@** placeholder which will be
replaced by component name if component packaging is enabled otherwise it
deletes the placeholder.

Setting the variable to **RPM-DEFAULT** may be used to explicitly set
filename generation to default.
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
_CPACK\_RPM\_FILE\_NAME_ also supports rpmbuild tool generated package
file name - disabled by default but can be enabled by setting the variable to
**RPM-DEFAULT**.
.UNINDENT
.UNINDENT

<a name="packaging-of-sources-srpm"></a>

### Packaging of sources (SRPM)


SRPM packaging is enabled by setting _CPACK\_RPM\_PACKAGE\_SOURCES_
variable while usually using **CPACK\_INSTALLED\_DIRECTORIES** variable
to provide directory containing CMakeLists.txt and source files.

For CMake projects SRPM package would be produced by executing:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cpack -G RPM --config ./CPackSourceConfig.cmake
    .ft P
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Produced SRPM package is expected to be built with **cmake(1)** executable
and packaged with **cpack(1)** executable so CMakeLists.txt has to be
located in root source directory and must be able to generate binary rpm
packages by executing **cpack -G** command. The two executables as well as
rpmbuild must also be present when generating binary rpm packages from the
produced SRPM package.
.UNINDENT
.UNINDENT

Once the SRPM package is generated it can be used to generate binary packages
by creating a directory structure for rpm generation and executing rpmbuild
tool:
.INDENT 0.0
.INDENT 3.5

    .ft C
    mkdir -p build_dir/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
    rpmbuild --define "_topdir <path_to_build_dir>" --rebuild <SRPM_file_name>
    .ft P
.UNINDENT
.UNINDENT

Generated packages will be located in build_dir/RPMS directory or its sub
directories.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
SRPM package internally uses CPack/RPM generator to generate binary packages
so CMakeScripts.txt can decide during the SRPM to binary rpm generation step
what content the package(s) should have as well as how they should be packaged
(monolithic or components). CMake can decide this for e.g. by reading environment
variables set by the package manager before starting the process of generating
binary rpm packages. This way a single SRPM package can be used to produce
different binary rpm packages on different platforms depending on the platform’s
packaging rules.
.UNINDENT
.UNINDENT

Source RPM packaging has its own set of variables:
.INDENT 0.0

* **CPACK_RPM_PACKAGE_SOURCES**  
  Should the content be packaged as a source rpm (default is binary rpm).
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : OFF
  .UNINDENT
  .UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
For cmake projects _CPACK\_RPM\_PACKAGE\_SOURCES_ variable is set
to **OFF** in CPackConfig.cmake and **ON** in CPackSourceConfig.cmake
generated files.
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_RPM_SOURCE_PKG_BUILD_PARAMS**  
  Additional command-line parameters provided to **cmake(1)** executable.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_SOURCE_PKG_PACKAGING_INSTALL_PREFIX**  
  Packaging install prefix that would be provided in **CPACK\_PACKAGING\_INSTALL\_PREFIX**
  variable for producing binary RPM packages.
  .INDENT 7.0
* ·  
  Mandatory : YES
* ·  
  Default   : “/”
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_RPM_BUILDREQUIRES**  
  List of source rpm build dependencies.
  .INDENT 7.0
* ·  
  Mandatory : NO
* ·  
  Default   : -
  .UNINDENT

May be used to set source RPM build dependencies (BuildRequires). Note that
you must enclose the complete build requirements string between quotes, for
example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    set(CPACK_RPM_BUILDREQUIRES "python >= 2.5.0, cmake >= 2.8")
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT

<a name="cpack-wix-generator"></a>

### CPack WIX Generator


CPack WIX generator specific options

<a name="variables-specific-to-cpack-wix-generator"></a>

### Variables specific to CPack WIX generator


The following variables are specific to the installers built on
Windows using WiX.
.INDENT 0.0

* **CPACK_WIX_UPGRADE_GUID**  
  Upgrade GUID (**Product/@UpgradeCode**)

Will be automatically generated unless explicitly provided.

It should be explicitly set to a constant generated globally unique
identifier (GUID) to allow your installers to replace existing
installations that use the same GUID.

You may for example explicitly set this variable in your
CMakeLists.txt to the value that has been generated per default.  You
should not use GUIDs that you did not generate yourself or which may
belong to other projects.

A GUID shall have the following fixed length syntax:
.INDENT 7.0
.INDENT 3.5

    .ft C
    XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
    .ft P
.UNINDENT
.UNINDENT

(each X represents an uppercase hexadecimal digit)
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_PRODUCT_GUID**  
  Product GUID (**Product/@Id**)

Will be automatically generated unless explicitly provided.

If explicitly provided this will set the Product Id of your installer.

The installer will abort if it detects a pre-existing installation that
uses the same GUID.

The GUID shall use the syntax described for CPACK_WIX_UPGRADE_GUID.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_LICENSE_RTF**  
  RTF License File

If CPACK_RESOURCE_FILE_LICENSE has an .rtf extension it is used as-is.

If CPACK_RESOURCE_FILE_LICENSE has an .txt extension it is implicitly
converted to RTF by the WIX Generator.
The expected encoding of the .txt file is UTF-8.

With CPACK_WIX_LICENSE_RTF you can override the license file used by the
WIX Generator in case CPACK_RESOURCE_FILE_LICENSE is in an unsupported
format or the .txt -&gt; .rtf conversion does not work as expected.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_PRODUCT_ICON**  
  The Icon shown next to the program name in Add/Remove programs.

If set, this icon is used in place of the default icon.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_UI_REF**  
  This variable allows you to override the Id of the **&lt;UIRef&gt;** element
  in the WiX template.

The default is **WixUI\_InstallDir** in case no CPack components have
been defined and **WixUI\_FeatureTree** otherwise.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_UI_BANNER**  
  The bitmap will appear at the top of all installer pages other than the
  welcome and completion dialogs.

If set, this image will replace the default banner image.

This image must be 493 by 58 pixels.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_UI_DIALOG**  
  Background bitmap used on the welcome and completion dialogs.

If this variable is set, the installer will replace the default dialog
image.

This image must be 493 by 312 pixels.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_PROGRAM_MENU_FOLDER**  
  Start menu folder name for launcher.

If this variable is not set, it will be initialized with CPACK_PACKAGE_NAME

If this variable is set to **.**, then application shortcuts will be
created directly in the start menu and the uninstaller shortcut will be
omitted.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_CULTURES**  
  Language(s) of the installer

Languages are compiled into the WixUI extension library.  To use them,
simply provide the name of the culture.  If you specify more than one
culture identifier in a comma or semicolon delimited list, the first one
that is found will be used.  You can find a list of supported languages at:
_http://wix.sourceforge.net/manual-wix3/WixUI\_localization.htm_
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_TEMPLATE**  
  Template file for WiX generation

If this variable is set, the specified template will be used to generate
the WiX wxs file.  This should be used if further customization of the
output is required.

If this variable is not set, the default MSI template included with CMake
will be used.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_PATCH_FILE**  
  Optional list of XML files with fragments to be inserted into
  generated WiX sources

This optional variable can be used to specify an XML file that the
WIX generator will use to inject fragments into its generated
source files.

Patch files understood by the CPack WIX generator
roughly follow this RELAX NG compact schema:
.INDENT 7.0
.INDENT 3.5

    .ft C
    start = CPackWiXPatch
    
    CPackWiXPatch = element CPackWiXPatch { CPackWiXFragment* }
    
    CPackWiXFragment = element CPackWiXFragment
    {
        attribute Id { string },
        fragmentContent*
    }
    
    fragmentContent = element * - CPackWiXFragment
    {
        (attribute * { text } | text | fragmentContent)*
    }
    .ft P
.UNINDENT
.UNINDENT

Currently fragments can be injected into most
Component, File, Directory and Feature elements.

The following additional special Ids can be used:
.INDENT 7.0

* ·  
  **#PRODUCT** for the **&lt;Product&gt;** element.
* ·  
  **#PRODUCTFEATURE** for the root **&lt;Feature&gt;** element.
  .UNINDENT

The following example illustrates how this works.

Given that the WIX generator creates the following XML element:
.INDENT 7.0
.INDENT 3.5

    .ft C
    <Component Id="CM_CP_applications.bin.my_libapp.exe" Guid="*"/>
    .ft P
.UNINDENT
.UNINDENT

The following XML patch file may be used to inject an Environment element
into it:
.INDENT 7.0
.INDENT 3.5

    .ft C
    <CPackWiXPatch>
      <CPackWiXFragment Id="CM_CP_applications.bin.my_libapp.exe">
        <Environment Id="MyEnvironment" Action="set"
          Name="MyVariableName" Value="MyVariableValue"/>
      </CPackWiXFragment>
    </CPackWiXPatch>
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_EXTRA_SOURCES**  
  Extra WiX source files

This variable provides an optional list of extra WiX source files (.wxs)
that should be compiled and linked.  The full path to source files is
required.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_EXTRA_OBJECTS**  
  Extra WiX object files or libraries

This variable provides an optional list of extra WiX object (.wixobj)
and/or WiX library (.wixlib) files.  The full path to objects and libraries
is required.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_EXTENSIONS**  
  This variable provides a list of additional extensions for the WiX
  tools light and candle.
  .UNINDENT
  .INDENT 0.0
* **CPACK_WIX_&lt;TOOL&gt;_EXTENSIONS**  
  This is the tool specific version of CPACK_WIX_EXTENSIONS.
  **&lt;TOOL&gt;** can be either LIGHT or CANDLE.
  .UNINDENT
  .INDENT 0.0
* **CPACK_WIX_&lt;TOOL&gt;_EXTRA_FLAGS**  
  This list variable allows you to pass additional
  flags to the WiX tool **&lt;TOOL&gt;**.

Use it at your own risk.
Future versions of CPack may generate flags which may be in conflict
with your own flags.

**&lt;TOOL&gt;** can be either LIGHT or CANDLE.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_CMAKE_PACKAGE_REGISTRY**  
  If this variable is set the generated installer will create
  an entry in the windows registry key
  **HKEY\_LOCAL\_MACHINE\eSoftware\eKitware\eCMake\ePackages\e&lt;PackageName&gt;**
  The value for **&lt;PackageName&gt;** is provided by this variable.

Assuming you also install a CMake configuration file this will
allow other CMake projects to find your package with
the **find\_package()** command.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_PROPERTY_&lt;PROPERTY&gt;**  
  This variable can be used to provide a value for
  the Windows Installer property **&lt;PROPERTY&gt;**

The following list contains some example properties that can be used to
customize information under
“Programs and Features” (also known as “Add or Remove Programs”)
.INDENT 7.0

* ·  
  ARPCOMMENTS - Comments
* ·  
  ARPHELPLINK - Help and support information URL
* ·  
  ARPURLINFOABOUT - General information URL
* ·  
  ARPURLUPDATEINFO - Update information URL
* ·  
  ARPHELPTELEPHONE - Help and support telephone number
* ·  
  ARPSIZE - Size (in kilobytes) of the application
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **CPACK_WIX_ROOT_FEATURE_TITLE**  
  Sets the name of the root install feature in the WIX installer. Same as
  CPACK_COMPONENT_&lt;compName&gt;_DISPLAY_NAME for components.
  .UNINDENT
  .INDENT 0.0
* **CPACK_WIX_ROOT_FEATURE_DESCRIPTION**  
  Sets the description of the root install feature in the WIX installer. Same as
  CPACK_COMPONENT_&lt;compName&gt;_DESCRIPTION for components.
  .UNINDENT
  .INDENT 0.0
* **CPACK_WIX_SKIP_PROGRAM_FOLDER**  
  If this variable is set to true, the default install location
  of the generated package will be CPACK_PACKAGE_INSTALL_DIRECTORY directly.
  The install location will not be located relatively below
  ProgramFiles or ProgramFiles64.
  .INDENT 7.0
  .INDENT 3.5

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Installers created with this feature do not take differences
between the system on which the installer is created
and the system on which the installer might be used into account.

It is therefore possible that the installer e.g. might try to install
onto a drive that is unavailable or unintended or a path that does not
follow the localization or convention of the system on which the
installation is performed.
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_ROOT_FOLDER_ID**  
  This variable allows specification of a custom root folder ID.
  The generator specific **&lt;64&gt;** token can be used for
  folder IDs that come in 32-bit and 64-bit variants.
  In 32-bit builds the token will expand empty while in 64-bit builds
  it will expand to **64**.

When unset generated installers will default installing to
**ProgramFiles&lt;64&gt;Folder**.
.UNINDENT
.INDENT 0.0

* **CPACK_WIX_ROOT**  
  This variable can optionally be set to the root directory
  of a custom WiX Toolset installation.

When unspecified CPack will try to locate a WiX Toolset
installation via the **WIX** environment variable instead.
.UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

