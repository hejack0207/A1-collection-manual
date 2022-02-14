# rustdoc(1) - generate documentation from Rust source code

Version 1.56.1, November 2021

```
rustdoc [OPTIONS] INPUT
```


<a name="description"></a>

# Description

This tool generates API reference documentation by extracting comments from
source code written in the Rust language, available at
&lt;**https://www.rust-lang.org**&gt;. It accepts several input formats and
provides several output formats for the generated documentation.


<a name="options"></a>

# Options



* **-r**, **--input-format** _FORMAT_  
  rust
* **-w**, **--output-format** _FORMAT_  
  html
* **-o**, **--output** _OUTPUT_,  
  where to place the output (default: _doc/_ for html)
* **--passes** _LIST_  
  space\[hy]separated list of passes to run (default: '')
* **--no-defaults**  
  don't run the default passes
* **--plugins** _LIST_  
  space-separated list of plugins to run (default: '')
* **--plugin-path** _DIR_  
  directory to load plugins from (default: _/tmp/rustdoc\_ng/plugins_)
* **--target** _TRIPLE_  
  target triple to document
* **--crate-name** _NAME_  
  specify the name of this crate
* **-L**, **--library-path** _DIR_  
  directory to add to crate search path
* **--cfg** _SPEC_  
  pass a _--cfg_ to rustc
* **--extern** _VAL_  
  pass an _--extern_ to rustc
* **--test**  
  run code examples as tests
* **--test-args** _ARGS_  
  pass arguments to the test runner
* **--html-in-header** _FILE_  
  file to add to &lt;head&gt;
* **--html-before-content** _FILES_  
  files to include inline between &lt;body&gt; and the content of a rendered Markdown
  file or generated documentation
* **--markdown-before-content** _FILES_  
  files to include inline between &lt;body&gt; and the content of a rendered
  Markdown file or generated documentation
* **--html-after-content** _FILES_  
  files to include inline between the content and &lt;/body&gt; of a rendered
  Markdown file or generated documentation
* **--markdown-after-content** _FILES_  
  files to include inline between the content and &lt;/body&gt; of a rendered
  Markdown file or generated documentation
* **--markdown-css** _FILES_  
  CSS files to include via &lt;link&gt; in a rendered Markdown file Markdown file or
  generated documentation
* **--markdown-playground-url** _URL_  
  URL to send code snippets to
* **--markdown-no-toc**  
  don't include table of contents
* **-h**, **--extend-css**  
  to redefine some css rules with a given file to generate doc with your own theme
* **-V**, **--version**  
  Print rustdoc's version
  

<a name="output-formats"></a>

# Output Formats


The rustdoc tool can generate output in an HTML format.

If using an HTML format, then the specified output destination will be the root
directory of an HTML structure for all the documentation.
Pages will be placed into this directory, and source files will also
possibly be rendered into it as well.


<a name="examples"></a>

# Examples


To generate documentation for the source in the current directory:
    $ rustdoc hello.rs

List all available passes that rustdoc has, along with default passes:
    $ rustdoc --passes list

The generated HTML can be viewed with any standard web browser.


<a name="see-also"></a>

# See Also


**rustc**(1)


<a name="bugs"></a>

# Bugs

See &lt;**https://github.com/rust-lang/rust/issues**&gt;
for issues.


<a name="author"></a>

# Author

See the version control history or &lt;**https://thanks.rust-lang.org**&gt;


<a name="copyright"></a>

# Copyright

This work is dual\[hy]licensed under Apache&nbsp;2.0 and MIT terms.
See _COPYRIGHT_ file in the rust source distribution.
