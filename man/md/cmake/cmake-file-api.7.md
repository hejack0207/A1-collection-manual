# cmake-file-api(7) - CMake File-Based API

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

<a name="introduction"></a>

# Introduction


CMake provides a file-based API that clients may use to get semantic
information about the buildsystems CMake generates.  Clients may use
the API by writing query files to a specific location in a build tree
to request zero or more _Object Kinds_.  When CMake generates the
buildsystem in that build tree it will read the query files and write
reply files for the client to read.

The file-based API uses a **&lt;build&gt;/.cmake/api/** directory at the top
of a build tree.  The API is versioned to support changes to the layout
of files within the API directory.  API file layout versioning is
orthogonal to the versioning of _Object Kinds_ used in replies.
This version of CMake supports only one API version, _API v1_.

<a name="api-v1"></a>

# Api V1


API v1 is housed in the **&lt;build&gt;/.cmake/api/v1/** directory.
It has the following subdirectories:
.INDENT 0.0

* <b>**query/**</b>  
  Holds query files written by clients.
  These may be _v1 Shared Stateless Query Files_,
  _v1 Client Stateless Query Files_, or _v1 Client Stateful Query Files_.
* <b>**reply/**</b>  
  Holds reply files written by CMake whenever it runs to generate a build
  system.  These are indexed by a _v1 Reply Index File_ file that may
  reference additional _v1 Reply Files_.  CMake owns all reply files.
  Clients must never remove them.

Clients may look for and read a reply index file at any time.
Clients may optionally create the **reply/** directory at any time
and monitor it for the appearance of a new reply index file.
.UNINDENT

<a name="v1-shared-stateless-query-files"></a>

### v1 Shared Stateless Query Files


Shared stateless query files allow clients to share requests for
major versions of the _Object Kinds_ and get all requested versions
recognized by the CMake that runs.

Clients may create shared requests by creating empty files in the
**v1/query/** directory.  The form is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <build>/.cmake/api/v1/query/<kind>-v<major>
    .ft P
.UNINDENT
.UNINDENT

where **&lt;kind&gt;** is one of the _Object Kinds_, **-v** is literal,
and **&lt;major&gt;** is the major version number.

Files of this form are stateless shared queries not owned by any specific
client.  Once created they should not be removed without external client
coordination or human intervention.

<a name="v1-client-stateless-query-files"></a>

### v1 Client Stateless Query Files


Client stateless query files allow clients to create owned requests for
major versions of the _Object Kinds_ and get all requested versions
recognized by the CMake that runs.

Clients may create owned requests by creating empty files in
client-specific query subdirectories.  The form is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <build>/.cmake/api/v1/query/client-<client>/<kind>-v<major>
    .ft P
.UNINDENT
.UNINDENT

where **client-** is literal, **&lt;client&gt;** is a string uniquely
identifying the client, **&lt;kind&gt;** is one of the _Object Kinds_,
**-v** is literal, and **&lt;major&gt;** is the major version number.
Each client must choose a unique **&lt;client&gt;** identifier via its
own means.

Files of this form are stateless queries owned by the client **&lt;client&gt;**.
The owning client may remove them at any time.

<a name="v1-client-stateful-query-files"></a>

### v1 Client Stateful Query Files


Stateful query files allow clients to request a list of versions of
each of the _Object Kinds_ and get only the most recent version
recognized by the CMake that runs.

Clients may create owned stateful queries by creating **query.json**
files in client-specific query subdirectories.  The form is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <build>/.cmake/api/v1/query/client-<client>/query.json
    .ft P
.UNINDENT
.UNINDENT

where **client-** is literal, **&lt;client&gt;** is a string uniquely
identifying the client, and **query.json** is literal.  Each client
must choose a unique **&lt;client&gt;** identifier via its own means.

**query.json** files are stateful queries owned by the client **&lt;client&gt;**.
The owning client may update or remove them at any time.  When a
given client installation is updated it may then update the stateful
query it writes to build trees to request newer object versions.
This can be used to avoid asking CMake to generate multiple object
versions unnecessarily.

A **query.json** file must contain a JSON object:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
      "requests": [
        { "kind": "<kind>" , "version": 1 },
        { "kind": "<kind>" , "version": { "major": 1, "minor": 2 } },
        { "kind": "<kind>" , "version": [2, 1] },
        { "kind": "<kind>" , "version": [2, { "major": 1, "minor": 2 }] },
        { "kind": "<kind>" , "version": 1, "client": {} },
        { "kind": "..." }
      ],
      "client": {}
    }
    .ft P
.UNINDENT
.UNINDENT

The members are:
.INDENT 0.0

* <b>**requests**</b>  
  A JSON array containing zero or more requests.  Each request is
  a JSON object with members:
  .INDENT 7.0
* <b>**kind**</b>  
  Specifies one of the _Object Kinds_ to be included in the reply.
* <b>**version**</b>  
  Indicates the version(s) of the object kind that the client
  understands.  Versions have major and minor components following
  semantic version conventions.  The value must be
  .INDENT 7.0
* ·  
  a JSON integer specifying a (non-negative) major version number, or
* ·  
  a JSON object containing **major** and (optionally) **minor**
  members specifying non-negative integer version components, or
* ·  
  a JSON array whose elements are each one of the above.
  .UNINDENT
* <b>**client**</b>  
  Optional member reserved for use by the client.  This value is
  preserved in the reply written for the client in the
  _v1 Reply Index File_ but is otherwise ignored.  Clients may use
  this to pass custom information with a request through to its reply.
  .UNINDENT

For each requested object kind CMake will choose the _first_ version
that it recognizes for that kind among those listed in the request.
The response will use the selected _major_ version with the highest
_minor_ version known to the running CMake for that major version.
Therefore clients should list all supported major versions in
preferred order along with the minimal minor version required
for each major version.

* <b>**client**</b>  
  Optional member reserved for use by the client.  This value is
  preserved in the reply written for the client in the
  _v1 Reply Index File_ but is otherwise ignored.  Clients may use
  this to pass custom information with a query through to its reply.
  .UNINDENT

Other **query.json** top-level members are reserved for future use.
If present they are ignored for forward compatibility.

<a name="v1-reply-index-file"></a>

### v1 Reply Index File


CMake writes an **index-*.json** file to the **v1/reply/** directory
whenever it runs to generate a build system.  Clients must read the
reply index file first and may read other _v1 Reply Files_ only by
following references.  The form of the reply index file name is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <build>/.cmake/api/v1/reply/index-<unspecified>.json
    .ft P
.UNINDENT
.UNINDENT

where **index-** is literal and **&lt;unspecified&gt;** is an unspecified
name selected by CMake.  Whenever a new index file is generated it
is given a new name and any old one is deleted.  During the short
time between these steps there may be multiple index files present;
the one with the largest name in lexicographic order is the current
index file.

The reply index file contains a JSON object:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
      "cmake": {
        "version": {
          "major": 3, "minor": 14, "patch": 0, "suffix": "",
          "string": "3.14.0", "isDirty": false
        },
        "paths": {
          "cmake": "/prefix/bin/cmake",
          "ctest": "/prefix/bin/ctest",
          "cpack": "/prefix/bin/cpack",
          "root": "/prefix/share/cmake-3.14"
        },
        "generator": {
          "multiConfig": false,
          "name": "Unix Makefiles"
        }
      },
      "objects": [
        { "kind": "<kind>",
          "version": { "major": 1, "minor": 0 },
          "jsonFile": "<file>" },
        { "...": "..." }
      ],
      "reply": {
        "<kind>-v<major>": { "kind": "<kind>",
                             "version": { "major": 1, "minor": 0 },
                             "jsonFile": "<file>" },
        "<unknown>": { "error": "unknown query file" },
        "...": {},
        "client-<client>": {
          "<kind>-v<major>": { "kind": "<kind>",
                               "version": { "major": 1, "minor": 0 },
                               "jsonFile": "<file>" },
          "<unknown>": { "error": "unknown query file" },
          "...": {},
          "query.json": {
            "requests": [ {}, {}, {} ],
            "responses": [
              { "kind": "<kind>",
                "version": { "major": 1, "minor": 0 },
                "jsonFile": "<file>" },
              { "error": "unknown query file" },
              { "...": {} }
            ],
            "client": {}
          }
        }
      }
    }
    .ft P
.UNINDENT
.UNINDENT

The members are:
.INDENT 0.0

* <b>**cmake**</b>  
  A JSON object containing information about the instance of CMake that
  generated the reply.  It contains members:
  .INDENT 7.0
* <b>**version**</b>  
  A JSON object specifying the version of CMake with members:
  .INDENT 7.0
* <b>**major**, **minor**, **patch**</b>  
  Integer values specifying the major, minor, and patch version components.
* <b>**suffix**</b>  
  A string specifying the version suffix, if any, e.g. **g0abc3**.
* <b>**string**</b>  
  A string specifying the full version in the format
  **&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;[-&lt;suffix&gt;]**.
* <b>**isDirty**</b>  
  A boolean indicating whether the version was built from a version
  controlled source tree with local modifications.
  .UNINDENT
* <b>**paths**</b>  
  A JSON object specifying paths to things that come with CMake.
  It has members for **cmake**, **ctest**, and **cpack** whose values
  are JSON strings specifying the absolute path to each tool,
  represented with forward slashes.  It also has a **root** member for
  the absolute path to the directory containing CMake resources like the
  **Modules/** directory (see **CMAKE\_ROOT**).
* <b>**generator**</b>  
  A JSON object describing the CMake generator used for the build.
  It has members:
  .INDENT 7.0
* <b>**multiConfig**</b>  
  A boolean specifying whether the generator supports multiple output
  configurations.
* <b>**name**</b>  
  A string specifying the name of the generator.
* <b>**platform**</b>  
  If the generator supports **CMAKE\_GENERATOR\_PLATFORM**,
  this is a string specifying the generator platform name.
  .UNINDENT
  .UNINDENT
* <b>**objects**</b>  
  A JSON array listing all versions of all _Object Kinds_ generated
  as part of the reply.  Each array entry is a
  _v1 Reply File Reference_.
* <b>**reply**</b>  
  A JSON object mirroring the content of the **query/** directory
  that CMake loaded to produce the reply.  The members are of the form
  .INDENT 7.0
* <b>**&lt;kind&gt;-v&lt;major&gt;**</b>  
  A member of this form appears for each of the
  _v1 Shared Stateless Query Files_ that CMake recognized as a
  request for object kind **&lt;kind&gt;** with major version **&lt;major&gt;**.
  The value is a _v1 Reply File Reference_ to the corresponding
  reply file for that object kind and version.
* <b>**&lt;unknown&gt;**</b>  
  A member of this form appears for each of the
  _v1 Shared Stateless Query Files_ that CMake did not recognize.
  The value is a JSON object with a single **error** member
  containing a string with an error message indicating that the
  query file is unknown.
* <b>**client-&lt;client&gt;**</b>  
  A member of this form appears for each client-owned directory
  holding _v1 Client Stateless Query Files_.
  The value is a JSON object mirroring the content of the
  **query/client-&lt;client&gt;/** directory.  The members are of the form:
  .INDENT 7.0
* <b>**&lt;kind&gt;-v&lt;major&gt;**</b>  
  A member of this form appears for each of the
  _v1 Client Stateless Query Files_ that CMake recognized as a
  request for object kind **&lt;kind&gt;** with major version **&lt;major&gt;**.
  The value is a _v1 Reply File Reference_ to the corresponding
  reply file for that object kind and version.
* <b>**&lt;unknown&gt;**</b>  
  A member of this form appears for each of the
  _v1 Client Stateless Query Files_ that CMake did not recognize.
  The value is a JSON object with a single **error** member
  containing a string with an error message indicating that the
  query file is unknown.
* <b>**query.json**</b>  
  This member appears for clients using
  _v1 Client Stateful Query Files_.
  If the **query.json** file failed to read or parse as a JSON object,
  this member is a JSON object with a single **error** member
  containing a string with an error message.  Otherwise, this member
  is a JSON object mirroring the content of the **query.json** file.
  The members are:
  .INDENT 7.0
* <b>**client**</b>  
  A copy of the **query.json** file **client** member, if it exists.
* <b>**requests**</b>  
  A copy of the **query.json** file **requests** member, if it exists.
* <b>**responses**</b>  
  If the **query.json** file **requests** member is missing or invalid,
  this member is a JSON object with a single **error** member
  containing a string with an error message.  Otherwise, this member
  contains a JSON array with a response for each entry of the
  **requests** array, in the same order.  Each response is
  .INDENT 7.0
* ·  
  a JSON object with a single **error** member containing a string
  with an error message, or
* ·  
  a _v1 Reply File Reference_ to the corresponding reply file for
  the requested object kind and selected version.
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .UNINDENT

After reading the reply index file, clients may read the other
_v1 Reply Files_ it references.

<a name="v1-reply-file-reference"></a>

### v1 Reply File Reference


The reply index file represents each reference to another reply file
using a JSON object with members:
.INDENT 0.0

* <b>**kind**</b>  
  A string specifying one of the _Object Kinds_.
* <b>**version**</b>  
  A JSON object with members **major** and **minor** specifying
  integer version components of the object kind.
* <b>**jsonFile**</b>  
  A JSON string specifying a path relative to the reply index file
  to another JSON file containing the object.
  .UNINDENT

<a name="v1-reply-files"></a>

### v1 Reply Files


Reply files containing specific _Object Kinds_ are written by CMake.
The names of these files are unspecified and must not be interpreted
by clients.  Clients must first read the _v1 Reply Index File_ and
and follow references to the names of the desired response objects.

Reply files (including the index file) will never be replaced by
files of the same name but different content.  This allows a client
to read the files concurrently with a running CMake that may generate
a new reply.  However, after generating a new reply CMake will attempt
to remove reply files from previous runs that it did not just write.
If a client attempts to read a reply file referenced by the index but
finds the file missing, that means a concurrent CMake has generated
a new reply.  The client may simply start again by reading the new
reply index file.

<a name="object-kinds"></a>

# Object Kinds


The CMake file-based API reports semantic information about the build
system using the following kinds of JSON objects.  Each kind of object
is versioned independently using semantic versioning with major and
minor components.  Every kind of object has the form:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
      "kind": "<kind>",
      "version": { "major": 1, "minor": 0 },
      "...": {}
    }
    .ft P
.UNINDENT
.UNINDENT

The **kind** member is a string specifying the object kind name.
The **version** member is a JSON object with **major** and **minor**
members specifying integer components of the object kind’s version.
Additional top-level members are specific to each object kind.

<a name="object-kind-codemodel"></a>

### Object Kind “codemodel”


The **codemodel** object kind describes the build system structure as
modeled by CMake.

There is only one **codemodel** object major version, version 2.
Version 1 does not exist to avoid confusion with that from
**cmake-server(7)** mode.

<a name="codemodel-version-2"></a>

### “codemodel” version 2


**codemodel** object version 2 is a JSON object:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
      "kind": "codemodel",
      "version": { "major": 2, "minor": 0 },
      "paths": {
        "source": "/path/to/top-level-source-dir",
        "build": "/path/to/top-level-build-dir"
      },
      "configurations": [
        {
          "name": "Debug",
          "directories": [
            {
              "source": ".",
              "build": ".",
              "childIndexes": [ 1 ],
              "projectIndex": 0,
              "targetIndexes": [ 0 ],
              "hasInstallRule": true,
              "minimumCMakeVersion": {
                "string": "3.14"
              }
            },
            {
              "source": "sub",
              "build": "sub",
              "parentIndex": 0,
              "projectIndex": 0,
              "targetIndexes": [ 1 ],
              "minimumCMakeVersion": {
                "string": "3.14"
              }
            }
          ],
          "projects": [
            {
              "name": "MyProject",
              "directoryIndexes": [ 0, 1 ],
              "targetIndexes": [ 0, 1 ]
            }
          ],
          "targets": [
            {
              "name": "MyExecutable",
              "directoryIndex": 0,
              "projectIndex": 0,
              "jsonFile": "<file>"
            },
            {
              "name": "MyLibrary",
              "directoryIndex": 1,
              "projectIndex": 0,
              "jsonFile": "<file>"
            }
          ]
        }
      ]
    }
    .ft P
.UNINDENT
.UNINDENT

The members specific to **codemodel** objects are:
.INDENT 0.0

* <b>**paths**</b>  
  A JSON object containing members:
  .INDENT 7.0
* <b>**source**</b>  
  A string specifying the absolute path to the top-level source directory,
  represented with forward slashes.
* <b>**build**</b>  
  A string specifying the absolute path to the top-level build directory,
  represented with forward slashes.
  .UNINDENT
* <b>**configurations**</b>  
  A JSON array of entries corresponding to available build configurations.
  On single-configuration generators there is one entry for the value
  of the **CMAKE\_BUILD\_TYPE** variable.  For multi-configuration
  generators there is an entry for each configuration listed in the
  **CMAKE\_CONFIGURATION\_TYPES** variable.
  Each entry is a JSON object containing members:
  .INDENT 7.0
* <b>**name**</b>  
  A string specifying the name of the configuration, e.g. **Debug**.
* <b>**directories**</b>  
  A JSON array of entries each corresponding to a build system directory
  whose source directory contains a **CMakeLists.txt** file.  The first
  entry corresponds to the top-level directory.  Each entry is a
  JSON object containing members:
  .INDENT 7.0
* <b>**source**</b>  
  A string specifying the path to the source directory, represented
  with forward slashes.  If the directory is inside the top-level
  source directory then the path is specified relative to that
  directory (with **.** for the top-level source directory itself).
  Otherwise the path is absolute.
* <b>**build**</b>  
  A string specifying the path to the build directory, represented
  with forward slashes.  If the directory is inside the top-level
  build directory then the path is specified relative to that
  directory (with **.** for the top-level build directory itself).
  Otherwise the path is absolute.
* <b>**parentIndex**</b>  
  Optional member that is present when the directory is not top-level.
  The value is an unsigned integer 0-based index of another entry in
  the main **directories** array that corresponds to the parent
  directory that added this directory as a subdirectory.
* <b>**childIndexes**</b>  
  Optional member that is present when the directory has subdirectories.
  The value is a JSON array of entries corresponding to child directories
  created by the **add\_subdirectory()** or **subdirs()**
  command.  Each entry is an unsigned integer 0-based index of another
  entry in the main **directories** array.
* <b>**projectIndex**</b>  
  An unsigned integer 0-based index into the main **projects** array
  indicating the build system project to which the this directory belongs.
* <b>**targetIndexes**</b>  
  Optional member that is present when the directory itself has targets,
  excluding those belonging to subdirectories.  The value is a JSON
  array of entries corresponding to the targets.  Each entry is an
  unsigned integer 0-based index into the main **targets** array.
* <b>**minimumCMakeVersion**</b>  
  Optional member present when a minimum required version of CMake is
  known for the directory.  This is the **&lt;min&gt;** version given to the
  most local call to the **cmake\_minimum\_required(VERSION)**
  command in the directory itself or one of its ancestors.
  The value is a JSON object with one member:
  .INDENT 7.0
* <b>**string**</b>  
  A string specifying the minimum required version in the format:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    <major>.<minor>[.<patch>[.<tweak>]][<suffix>]
    .ft P
.UNINDENT
.UNINDENT

Each component is an unsigned integer and the suffix may be an
arbitrary string.
.UNINDENT

* <b>**hasInstallRule**</b>  
  Optional member that is present with boolean value **true** when
  the directory or one of its subdirectories contains any
  **install()** rules, i.e. whether a **make install**
  or equivalent rule is available.
  .UNINDENT
* <b>**projects**</b>  
  A JSON array of entries corresponding to the top-level project
  and sub-projects defined in the build system.  Each (sub-)project
  corresponds to a source directory whose **CMakeLists.txt** file
  calls the **project()** command with a project name different
  from its parent directory.  The first entry corresponds to the
  top-level project.

Each entry is a JSON object containing members:
.INDENT 7.0

* <b>**name**</b>  
  A string specifying the name given to the **project()** command.
* <b>**parentIndex**</b>  
  Optional member that is present when the project is not top-level.
  The value is an unsigned integer 0-based index of another entry in
  the main **projects** array that corresponds to the parent project
  that added this project as a sub-project.
* <b>**childIndexes**</b>  
  Optional member that is present when the project has sub-projects.
  The value is a JSON array of entries corresponding to the sub-projects.
  Each entry is an unsigned integer 0-based index of another
  entry in the main **projects** array.
* <b>**directoryIndexes**</b>  
  A JSON array of entries corresponding to build system directories
  that are part of the project.  The first entry corresponds to the
  top-level directory of the project.  Each entry is an unsigned
  integer 0-based index into the main **directories** array.
* <b>**targetIndexes**</b>  
  Optional member that is present when the project itself has targets,
  excluding those belonging to sub-projects.  The value is a JSON
  array of entries corresponding to the targets.  Each entry is an
  unsigned integer 0-based index into the main **targets** array.
  .UNINDENT
* <b>**targets**</b>  
  A JSON array of entries corresponding to the build system targets.
  Such targets are created by calls to **add\_executable()**,
  **add\_library()**, and **add\_custom\_target()**, excluding
  imported targets and interface libraries (which do not generate any
  build rules).  Each entry is a JSON object containing members:
  .INDENT 7.0
* <b>**name**</b>  
  A string specifying the target name.
* <b>**id**</b>  
  A string uniquely identifying the target.  This matches the **id**
  field in the file referenced by **jsonFile**.
* <b>**directoryIndex**</b>  
  An unsigned integer 0-based index into the main **directories** array
  indicating the build system directory in which the target is defined.
* <b>**projectIndex**</b>  
  An unsigned integer 0-based index into the main **projects** array
  indicating the build system project in which the target is defined.
* <b>**jsonFile**</b>  
  A JSON string specifying a path relative to the codemodel file
  to another JSON file containing a
  _“codemodel” version 2 “target” object_.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="codemodel-version-2-target-object"></a>

### “codemodel” version 2 “target” object


A codemodel “target” object is referenced by a _“codemodel” version 2_
object’s **targets** array.  Each “target” object is a JSON object
with members:
.INDENT 0.0

* <b>**name**</b>  
  A string specifying the logical name of the target.
* <b>**id**</b>  
  A string uniquely identifying the target.  The format is unspecified
  and should not be interpreted by clients.
* <b>**type**</b>  
  A string specifying the type of the target.  The value is one of
  **EXECUTABLE**, **STATIC\_LIBRARY**, **SHARED\_LIBRARY**,
  **MODULE\_LIBRARY**, **OBJECT\_LIBRARY**, or **UTILITY**.
* <b>**backtrace**</b>  
  Optional member that is present when a CMake language backtrace to
  the command in the source code that created the target is available.
  The value is an unsigned integer 0-based index into the
  **backtraceGraph** member’s **nodes** array.
* <b>**folder**</b>  
  Optional member that is present when the **FOLDER** target
  property is set.  The value is a JSON object with one member:
  .INDENT 7.0
* <b>**name**</b>  
  A string specifying the name of the target folder.
  .UNINDENT
* <b>**paths**</b>  
  A JSON object containing members:
  .INDENT 7.0
* <b>**source**</b>  
  A string specifying the path to the target’s source directory,
  represented with forward slashes.  If the directory is inside the
  top-level source directory then the path is specified relative to
  that directory (with **.** for the top-level source directory itself).
  Otherwise the path is absolute.
* <b>**build**</b>  
  A string specifying the path to the target’s build directory,
  represented with forward slashes.  If the directory is inside the
  top-level build directory then the path is specified relative to
  that directory (with **.** for the top-level build directory itself).
  Otherwise the path is absolute.
  .UNINDENT
* <b>**nameOnDisk**</b>  
  Optional member that is present for executable and library targets
  that are linked or archived into a single primary artifact.
  The value is a string specifying the file name of that artifact on disk.
* <b>**artifacts**</b>  
  Optional member that is present for executable and library targets
  that produce artifacts on disk meant for consumption by dependents.
  The value is a JSON array of entries corresponding to the artifacts.
  Each entry is a JSON object containing one member:
  .INDENT 7.0
* <b>**path**</b>  
  A string specifying the path to the file on disk, represented with
  forward slashes.  If the file is inside the top-level build directory
  then the path is specified relative to that directory.
  Otherwise the path is absolute.
  .UNINDENT
* <b>**isGeneratorProvided**</b>  
  Optional member that is present with boolean value **true** if the
  target is provided by CMake’s build system generator rather than by
  a command in the source code.
* <b>**install**</b>  
  Optional member that is present when the target has an **install()**
  rule.  The value is a JSON object with members:
  .INDENT 7.0
* <b>**prefix**</b>  
  A JSON object specifying the installation prefix.  It has one member:
  .INDENT 7.0
* <b>**path**</b>  
  A string specifying the value of **CMAKE\_INSTALL\_PREFIX**.
  .UNINDENT
* <b>**destinations**</b>  
  A JSON array of entries specifying an install destination path.
  Each entry is a JSON object with members:
  .INDENT 7.0
* <b>**path**</b>  
  A string specifying the install destination path.  The path may
  be absolute or relative to the install prefix.
* <b>**backtrace**</b>  
  Optional member that is present when a CMake language backtrace to
  the **install()** command invocation that specified this
  destination is available.  The value is an unsigned integer 0-based
  index into the **backtraceGraph** member’s **nodes** array.
  .UNINDENT
  .UNINDENT
* <b>**link**</b>  
  Optional member that is present for executables and shared library
  targets that link into a runtime binary.  The value is a JSON object
  with members describing the link step:
  .INDENT 7.0
* <b>**language**</b>  
  A string specifying the language (e.g. **C**, **CXX**, **Fortran**)
  of the toolchain is used to invoke the linker.
* <b>**commandFragments**</b>  
  Optional member that is present when fragments of the link command
  line invocation are available.  The value is a JSON array of entries
  specifying ordered fragments.  Each entry is a JSON object with members:
  .INDENT 7.0
* <b>**fragment**</b>  
  A string specifying a fragment of the link command line invocation.
  The value is encoded in the build system’s native shell format.
* <b>**role**</b>  
  A string specifying the role of the fragment’s content:
  .INDENT 7.0
* ·  
  **flags**: link flags.
* ·  
  **libraries**: link library file paths or flags.
* ·  
  **libraryPath**: library search path flags.
* ·  
  **frameworkPath**: macOS framework search path flags.
  .UNINDENT
  .UNINDENT
* <b>**lto**</b>  
  Optional member that is present with boolean value **true**
  when link-time optimization (a.k.a. interprocedural optimization
  or link-time code generation) is enabled.
* <b>**sysroot**</b>  
  Optional member that is present when the **CMAKE\_SYSROOT\_LINK**
  or **CMAKE\_SYSROOT** variable is defined.  The value is a
  JSON object with one member:
  .INDENT 7.0
* <b>**path**</b>  
  A string specifying the absolute path to the sysroot, represented
  with forward slashes.
  .UNINDENT
  .UNINDENT
* <b>**archive**</b>  
  Optional member that is present for static library targets.  The value
  is a JSON object with members describing the archive step:
  .INDENT 7.0
* <b>**commandFragments**</b>  
  Optional member that is present when fragments of the archiver command
  line invocation are available.  The value is a JSON array of entries
  specifying the fragments.  Each entry is a JSON object with members:
  .INDENT 7.0
* <b>**fragment**</b>  
  A string specifying a fragment of the archiver command line invocation.
  The value is encoded in the build system’s native shell format.
* <b>**role**</b>  
  A string specifying the role of the fragment’s content:
  .INDENT 7.0
* ·  
  **flags**: archiver flags.
  .UNINDENT
  .UNINDENT
* <b>**lto**</b>  
  Optional member that is present with boolean value **true**
  when link-time optimization (a.k.a. interprocedural optimization
  or link-time code generation) is enabled.
  .UNINDENT
* <b>**dependencies**</b>  
  Optional member that is present when the target depends on other targets.
  The value is a JSON array of entries corresponding to the dependencies.
  Each entry is a JSON object with members:
  .INDENT 7.0
* <b>**id**</b>  
  A string uniquely identifying the target on which this target depends.
  This matches the main **id** member of the other target.
* <b>**backtrace**</b>  
  Optional member that is present when a CMake language backtrace to
  the **add\_dependencies()**, **target\_link\_libraries()**,
  or other command invocation that created this dependency is
  available.  The value is an unsigned integer 0-based index into
  the **backtraceGraph** member’s **nodes** array.
  .UNINDENT
* <b>**sources**</b>  
  A JSON array of entries corresponding to the target’s source files.
  Each entry is a JSON object with members:
  .INDENT 7.0
* <b>**path**</b>  
  A string specifying the path to the source file on disk, represented
  with forward slashes.  If the file is inside the top-level source
  directory then the path is specified relative to that directory.
  Otherwise the path is absolute.
* <b>**compileGroupIndex**</b>  
  Optional member that is present when the source is compiled.
  The value is an unsigned integer 0-based index into the
  **compileGroups** array.
* <b>**sourceGroupIndex**</b>  
  Optional member that is present when the source is part of a source
  group either via the **source\_group()** command or by default.
  The value is an unsigned integer 0-based index into the
  **sourceGroups** array.
* <b>**isGenerated**</b>  
  Optional member that is present with boolean value **true** if
  the source is **GENERATED**.
* <b>**backtrace**</b>  
  Optional member that is present when a CMake language backtrace to
  the **target\_sources()**, **add\_executable()**,
  **add\_library()**, **add\_custom\_target()**, or other
  command invocation that added this source to the target is
  available.  The value is an unsigned integer 0-based index into
  the **backtraceGraph** member’s **nodes** array.
  .UNINDENT
* <b>**sourceGroups**</b>  
  Optional member that is present when sources are grouped together by
  the **source\_group()** command or by default.  The value is a
  JSON array of entries corresponding to the groups.  Each entry is
  a JSON object with members:
  .INDENT 7.0
* <b>**name**</b>  
  A string specifying the name of the source group.
* <b>**sourceIndexes**</b>  
  A JSON array listing the sources belonging to the group.
  Each entry is an unsigned integer 0-based index into the
  main **sources** array for the target.
  .UNINDENT
* <b>**compileGroups**</b>  
  Optional member that is present when the target has sources that compile.
  The value is a JSON array of entries corresponding to groups of sources
  that all compile with the same settings.  Each entry is a JSON object
  with members:
  .INDENT 7.0
* <b>**sourceIndexes**</b>  
  A JSON array listing the sources belonging to the group.
  Each entry is an unsigned integer 0-based index into the
  main **sources** array for the target.
* <b>**language**</b>  
  A string specifying the language (e.g. **C**, **CXX**, **Fortran**)
  of the toolchain is used to compile the source file.
* <b>**compileCommandFragments**</b>  
  Optional member that is present when fragments of the compiler command
  line invocation are available.  The value is a JSON array of entries
  specifying ordered fragments.  Each entry is a JSON object with
  one member:
  .INDENT 7.0
* <b>**fragment**</b>  
  A string specifying a fragment of the compile command line invocation.
  The value is encoded in the build system’s native shell format.
  .UNINDENT
* <b>**includes**</b>  
  Optional member that is present when there are include directories.
  The value is a JSON array with an entry for each directory.  Each
  entry is a JSON object with members:
  .INDENT 7.0
* <b>**path**</b>  
  A string specifying the path to the include directory,
  represented with forward slashes.
* <b>**isSystem**</b>  
  Optional member that is present with boolean value **true** if
  the include directory is marked as a system include directory.
* <b>**backtrace**</b>  
  Optional member that is present when a CMake language backtrace to
  the **target\_include\_directories()** or other command invocation
  that added this include directory is available.  The value is
  an unsigned integer 0-based index into the **backtraceGraph**
  member’s **nodes** array.
  .UNINDENT
* <b>**defines**</b>  
  Optional member that is present when there are preprocessor definitions.
  The value is a JSON array with an entry for each definition.  Each
  entry is a JSON object with members:
  .INDENT 7.0
* <b>**define**</b>  
  A string specifying the preprocessor definition in the format
  **&lt;name&gt;[=&lt;value&gt;]**, e.g. **DEF** or **DEF=1**.
* <b>**backtrace**</b>  
  Optional member that is present when a CMake language backtrace to
  the **target\_compile\_definitions()** or other command invocation
  that added this preprocessor definition is available.  The value is
  an unsigned integer 0-based index into the **backtraceGraph**
  member’s **nodes** array.
  .UNINDENT
* <b>**sysroot**</b>  
  Optional member that is present when the
  **CMAKE\_SYSROOT\_COMPILE** or **CMAKE\_SYSROOT**
  variable is defined.  The value is a JSON object with one member:
  .INDENT 7.0
* <b>**path**</b>  
  A string specifying the absolute path to the sysroot, represented
  with forward slashes.
  .UNINDENT
  .UNINDENT
* <b>**backtraceGraph**</b>  
  A JSON object describing the graph of backtraces whose nodes are
  referenced from **backtrace** members elsewhere.  The members are:
  .INDENT 7.0
* <b>**nodes**</b>  
  A JSON array listing nodes in the backtrace graph.  Each entry
  is a JSON object with members:
  .INDENT 7.0
* <b>**file**</b>  
  An unsigned integer 0-based index into the backtrace **files** array.
* <b>**line**</b>  
  An optional member present when the node represents a line within
  the file.  The value is an unsigned integer 1-based line number.
* <b>**command**</b>  
  An optional member present when the node represents a command
  invocation within the file.  The value is an unsigned integer
  0-based index into the backtrace **commands** array.
* <b>**parent**</b>  
  An optional member present when the node is not the bottom of
  the call stack.  The value is an unsigned integer 0-based index
  of another entry in the backtrace **nodes** array.
  .UNINDENT
* <b>**commands**</b>  
  A JSON array listing command names referenced by backtrace nodes.
  Each entry is a string specifying a command name.
* <b>**files**</b>  
  A JSON array listing CMake language files referenced by backtrace nodes.
  Each entry is a string specifying the path to a file, represented
  with forward slashes.  If the file is inside the top-level source
  directory then the path is specified relative to that directory.
  Otherwise the path is absolute.
  .UNINDENT
  .UNINDENT

<a name="object-kind-cache"></a>

### Object Kind “cache”


The **cache** object kind lists cache entries.  These are the
CMake Language Variables stored in the persistent cache
(**CMakeCache.txt**) for the build tree.

There is only one **cache** object major version, version 2.
Version 1 does not exist to avoid confusion with that from
**cmake-server(7)** mode.

<a name="cache-version-2"></a>

### “cache” version 2


**cache** object version 2 is a JSON object:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
      "kind": "cache",
      "version": { "major": 2, "minor": 0 },
      "entries": [
        {
          "name": "BUILD_SHARED_LIBS",
          "value": "ON",
          "type": "BOOL",
          "properties": [
            {
              "name": "HELPSTRING",
              "value": "Build shared libraries"
            }
          ]
        },
        {
          "name": "CMAKE_GENERATOR",
          "value": "Unix Makefiles",
          "type": "INTERNAL",
          "properties": [
            {
              "name": "HELPSTRING",
              "value": "Name of generator."
            }
          ]
        }
      ]
    }
    .ft P
.UNINDENT
.UNINDENT

The members specific to **cache** objects are:
.INDENT 0.0

* <b>**entries**</b>  
  A JSON array whose entries are each a JSON object specifying a
  cache entry.  The members of each entry are:
  .INDENT 7.0
* <b>**name**</b>  
  A string specifying the name of the entry.
* <b>**value**</b>  
  A string specifying the value of the entry.
* <b>**type**</b>  
  A string specifying the type of the entry used by
  **cmake-gui(1)** to choose a widget for editing.
* <b>**properties**</b>  
  A JSON array of entries specifying associated
  cache entry properties.
  Each entry is a JSON object containing members:
  .INDENT 7.0
* <b>**name**</b>  
  A string specifying the name of the cache entry property.
* <b>**value**</b>  
  A string specifying the value of the cache entry property.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="object-kind-cmakefiles"></a>

### Object Kind “cmakeFiles”


The **cmakeFiles** object kind lists files used by CMake while
configuring and generating the build system.  These include the
**CMakeLists.txt** files as well as included **.cmake** files.

There is only one **cmakeFiles** object major version, version 1.

<a name="cmakefiles-version-1"></a>

### “cmakeFiles” version 1


**cmakeFiles** object version 1 is a JSON object:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
      "kind": "cmakeFiles",
      "version": { "major": 1, "minor": 0 },
      "paths": {
        "build": "/path/to/top-level-build-dir",
        "source": "/path/to/top-level-source-dir"
      },
      "inputs": [
        {
          "path": "CMakeLists.txt"
        },
        {
          "isGenerated": true,
          "path": "/path/to/top-level-build-dir/.../CMakeSystem.cmake"
        },
        {
          "isExternal": true,
          "path": "/path/to/external/third-party/module.cmake"
        },
        {
          "isCMake": true,
          "isExternal": true,
          "path": "/path/to/cmake/Modules/CMakeGenericSystem.cmake"
        }
      ]
    }
    .ft P
.UNINDENT
.UNINDENT

The members specific to **cmakeFiles** objects are:
.INDENT 0.0

* <b>**paths**</b>  
  A JSON object containing members:
  .INDENT 7.0
* <b>**source**</b>  
  A string specifying the absolute path to the top-level source directory,
  represented with forward slashes.
* <b>**build**</b>  
  A string specifying the absolute path to the top-level build directory,
  represented with forward slashes.
  .UNINDENT
* <b>**inputs**</b>  
  A JSON array whose entries are each a JSON object specifying an input
  file used by CMake when configuring and generating the build system.
  The members of each entry are:
  .INDENT 7.0
* <b>**path**</b>  
  A string specifying the path to an input file to CMake, represented
  with forward slashes.  If the file is inside the top-level source
  directory then the path is specified relative to that directory.
  Otherwise the path is absolute.
* <b>**isGenerated**</b>  
  Optional member that is present with boolean value **true**
  if the path specifies a file that is under the top-level
  build directory and the build is out-of-source.
  This member is not available on in-source builds.
* <b>**isExternal**</b>  
  Optional member that is present with boolean value **true**
  if the path specifies a file that is not under the top-level
  source or build directories.
* <b>**isCMake**</b>  
  Optional member that is present with boolean value **true**
  if the path specifies a file in the CMake installation.
  .UNINDENT
  .UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

