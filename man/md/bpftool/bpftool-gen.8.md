# bpftool-gen(8) - tool for BPF code-generation

"", ""

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

<a name="synopsis"></a>

# Synopsis

```
.INDENT 0.0 .INDENT 3.5 bpftool [OPTIONS] gen COMMAND 
 OPTIONS := { { -j | --json } [{ -p | --pretty }] } 
 COMMAND := { object | skeleton | help } .UNINDENT .UNINDENT
```

<a name="gen-commands"></a>

# Gen Commands

    bpftool gen object OUTPUT_FILE INPUT_FILE [INPUT_FILE...]
    bpftool gen skeleton FILE [name OBJECT_NAME]
    bpftool gen help


<a name="description"></a>

# Description

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**bpftool gen object** _OUTPUT\_FILE_ _INPUT\_FILE_ [_INPUT\_FILE_...]</b>  
  Statically link (combine) together one or more _INPUT\_FILE_'s
  into a single resulting _OUTPUT\_FILE_. All the files involved
  are BPF ELF object files.

The rules of BPF static linking are mostly the same as for
user-space object files, but in addition to combining data
and instruction sections, .BTF and .BTF.ext (if present in
any of the input files) data are combined together. .BTF
data is deduplicated, so all the common types across
_INPUT\_FILE_'s will only be represented once in the resulting
BTF information.

BPF static linking allows to partition BPF source code into
individually compiled files that are then linked into
a single resulting BPF object file, which can be used to
generated BPF skeleton (with **gen skeleton** command) or
passed directly into **libbpf** (using **bpf\_object\_\_open()**
family of APIs).

* <b>**bpftool gen skeleton** _FILE_</b>  
  Generate BPF skeleton C header file for a given _FILE_.

BPF skeleton is an alternative interface to existing libbpf
APIs for working with BPF objects. Skeleton code is intended
to significantly shorten and simplify code to load and work
with BPF programs from userspace side. Generated code is
tailored to specific input BPF object _FILE_, reflecting its
structure by listing out available maps, program, variables,
etc. Skeleton eliminates the need to lookup mentioned
components by name. Instead, if skeleton instantiation
succeeds, they are populated in skeleton structure as valid
libbpf types (e.g., **struct bpf\_map** pointer) and can be
passed to existing generic libbpf APIs.

In addition to simple and reliable access to maps and
programs, skeleton provides a storage for BPF links (struct
bpf\_link) for each BPF program within BPF object. When
requested, supported BPF programs will be automatically
attached and resulting BPF links stored for further use by
user in pre-allocated fields in skeleton struct. For BPF
programs that can't be automatically attached by libbpf,
user can attach them manually, but store resulting BPF link
in per-program link field. All such set up links will be
automatically destroyed on BPF skeleton destruction. This
eliminates the need for users to manage links manually and
rely on libbpf support to detach programs and free up
resources.

Another facility provided by BPF skeleton is an interface to
global variables of all supported kinds: mutable, read-only,
as well as extern ones. This interface allows to pre-setup
initial values of variables before BPF object is loaded and
verified by kernel. For non-read-only variables, the same
interface can be used to fetch values of global variables on
userspace side, even if they are modified by BPF code.

During skeleton generation, contents of source BPF object
_FILE_ is embedded within generated code and is thus not
necessary to keep around. This ensures skeleton and BPF
object file are matching 1-to-1 and always stay in sync.
Generated code is dual-licensed under LGPL-2.1 and
BSD-2-Clause licenses.

It is a design goal and guarantee that skeleton interfaces
are interoperable with generic libbpf APIs. User should
always be able to use skeleton API to create and load BPF
object, and later use libbpf APIs to keep working with
specific maps, programs, etc.

As part of skeleton, few custom functions are generated.
Each of them is prefixed with object name. Object name can
either be derived from object file name, i.e., if BPF object
file name is **example.o**, BPF object name will be
**example**. Object name can be also specified explicitly
through **name** _OBJECT\_NAME_ parameter. The following
custom functions are provided (assuming **example** as
the object name):
.INDENT 7.0

* ·  
  **example\_\_open** and **example\_\_open\_opts**.
  These functions are used to instantiate skeleton. It
  corresponds to libbpf's **bpf\_object\_\_open**() API.
  **\_opts** variants accepts extra **bpf\_object\_open\_opts**
  options.
* ·  
  **example\_\_load**.
  This function creates maps, loads and verifies BPF
  programs, initializes global data maps. It corresponds to
  libppf's **bpf\_object\_\_load**() API.
* ·  
  **example\_\_open\_and\_load** combines **example\_\_open** and
  **example\_\_load** invocations in one commonly used
  operation.
* ·  
  **example\_\_attach** and **example\_\_detach**
  This pair of functions allow to attach and detach,
  correspondingly, already loaded BPF object. Only BPF
  programs of types supported by libbpf for auto-attachment
  will be auto-attached and their corresponding BPF links
  instantiated. For other BPF programs, user can manually
  create a BPF link and assign it to corresponding fields in
  skeleton struct. **example\_\_detach** will detach both
  links created automatically, as well as those populated by
  user manually.
* ·  
  **example\_\_destroy**
  Detach and unload BPF programs, free up all the resources
  used by skeleton and BPF object.
  .UNINDENT

If BPF object has global variables, corresponding structs
with memory layout corresponding to global data data section
layout will be created. Currently supported ones are: _.data_,
_.bss_, _.rodata_, and _.kconfig_ structs/data sections.
These data sections/structs can be used to set up initial
values of variables, if set before **example\_\_load**.
Afterwards, if target kernel supports memory-mapped BPF
arrays, same structs can be used to fetch and update
(non-read-only) data from userspace, with same simplicity
as for BPF side.

* <b>**bpftool gen help**</b>  
  Print short help message.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* **-h, --help**  
  Print short help message (similar to **bpftool help**).
* **-V, --version**  
  Print version number (similar to **bpftool version**), and optional
  features that were included when bpftool was compiled. Optional
  features include linking against libbfd to provide the disassembler
  for JIT-ted programs (**bpftool prog dump jited**) and usage of BPF
  skeletons (some features like **bpftool prog profile** or showing
  pids associated to BPF objects may rely on it).
* **-j, --json**  
  Generate JSON output. For commands that cannot produce JSON, this
  option has no effect.
* **-p, --pretty**  
  Generate human-readable JSON output. Implies **-j**.
* **-d, --debug**  
  Print all logs available, even debug-level information. This includes
  logs from libbpf as well as from the verifier, when attempting to
  load programs.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="examples"></a>

# Examples


**$ cat example1.bpf.c**
.INDENT 0.0
.INDENT 3.5

    .ft C
    #include <stdbool.h>
    #include <linux/ptrace.h>
    #include <linux/bpf.h>
    #include <bpf/bpf_helpers.h>
    
    const volatile int param1 = 42;
    bool global_flag = true;
    struct { int x; } data = {};
    
    SEC("raw_tp/sys_enter")
    int handle_sys_enter(struct pt_regs *ctx)
    {
          static long my_static_var;
          if (global_flag)
                  my_static_var++;
          else
                  data.x += param1;
          return 0;
    }
    .ft P
.UNINDENT
.UNINDENT

**$ cat example2.bpf.c**
.INDENT 0.0
.INDENT 3.5

    .ft C
    #include <linux/ptrace.h>
    #include <linux/bpf.h>
    #include <bpf/bpf_helpers.h>
    
    struct {
          __uint(type, BPF_MAP_TYPE_HASH);
          __uint(max_entries, 128);
          __type(key, int);
          __type(value, long);
    } my_map SEC(".maps");
    
    SEC("raw_tp/sys_exit")
    int handle_sys_exit(struct pt_regs *ctx)
    {
          int zero = 0;
          bpf_map_lookup_elem(&my_map, &zero);
          return 0;
    }
    .ft P
.UNINDENT
.UNINDENT

This is example BPF application with two BPF programs and a mix of BPF maps
and global variables. Source code is split across two source code files.

**$ clang -target bpf -g example1.bpf.c -o example1.bpf.o**
**$ clang -target bpf -g example2.bpf.c -o example2.bpf.o**
**$ bpftool gen object example.bpf.o example1.bpf.o example2.bpf.o**

This set of commands compiles _example1.bpf.c_ and _example2.bpf.c_
individually and then statically links respective object files into the final
BPF ELF object file _example.bpf.o_.

**$ bpftool gen skeleton example.bpf.o name example | tee example.skel.h**
.INDENT 0.0
.INDENT 3.5

    .ft C
    /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
    
    /* THIS FILE IS AUTOGENERATED! */
    #ifndef __EXAMPLE_SKEL_H__
    #define __EXAMPLE_SKEL_H__
    
    #include <stdlib.h>
    #include <bpf/libbpf.h>
    
    struct example {
          struct bpf_object_skeleton *skeleton;
          struct bpf_object *obj;
          struct {
                  struct bpf_map *rodata;
                  struct bpf_map *data;
                  struct bpf_map *bss;
                  struct bpf_map *my_map;
          } maps;
          struct {
                  struct bpf_program *handle_sys_enter;
                  struct bpf_program *handle_sys_exit;
          } progs;
          struct {
                  struct bpf_link *handle_sys_enter;
                  struct bpf_link *handle_sys_exit;
          } links;
          struct example__bss {
                  struct {
                          int x;
                  } data;
          } *bss;
          struct example__data {
                  _Bool global_flag;
                  long int handle_sys_enter_my_static_var;
          } *data;
          struct example__rodata {
                  int param1;
          } *rodata;
    };
    
    static void example__destroy(struct example *obj);
    static inline struct example *example__open_opts(
                  const struct bpf_object_open_opts *opts);
    static inline struct example *example__open();
    static inline int example__load(struct example *obj);
    static inline struct example *example__open_and_load();
    static inline int example__attach(struct example *obj);
    static inline void example__detach(struct example *obj);
    
    #endif /* __EXAMPLE_SKEL_H__ */
    .ft P
.UNINDENT
.UNINDENT

**$ cat example.c**
.INDENT 0.0
.INDENT 3.5

    .ft C
    #include "example.skel.h"
    
    int main()
    {
          struct example *skel;
          int err = 0;
    
          skel = example__open();
          if (!skel)
                  goto cleanup;
    
          skel->rodata->param1 = 128;
    
          err = example__load(skel);
          if (err)
                  goto cleanup;
    
          err = example__attach(skel);
          if (err)
                  goto cleanup;
    
          /* all libbpf APIs are usable */
          printf("my_map name: %sen", bpf_map__name(skel->maps.my_map));
          printf("sys_enter prog FD: %den",
                 bpf_program__fd(skel->progs.handle_sys_enter));
    
          /* detach and re-attach sys_exit program */
          bpf_link__destroy(skel->links.handle_sys_exit);
          skel->links.handle_sys_exit =
                  bpf_program__attach(skel->progs.handle_sys_exit);
    
          printf("my_static_var: %lden",
                 skel->bss->handle_sys_enter_my_static_var);
    
    cleanup:
          example__destroy(skel);
          return err;
    }
    .ft P
.UNINDENT
.UNINDENT

**# ./example**
.INDENT 0.0
.INDENT 3.5

    .ft C
    my_map name: my_map
    sys_enter prog FD: 8
    my_static_var: 7
    .ft P
.UNINDENT
.UNINDENT

This is a stripped-out version of skeleton generated for above example code.

<a name="see-also"></a>

# See Also

.INDENT 0.0
.INDENT 3.5
**bpf**(2),
**bpf-helpers**(7),
**bpftool**(8),
**bpftool-btf**(8),
**bpftool-cgroup**(8),
**bpftool-feature**(8),
**bpftool-iter**(8),
**bpftool-link**(8),
**bpftool-map**(8),
**bpftool-net**(8),
**bpftool-perf**(8),
**bpftool-prog**(8),
**bpftool-struct\_ops**(8)
.UNINDENT
.UNINDENT

