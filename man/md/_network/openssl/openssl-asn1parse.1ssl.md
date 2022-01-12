# asn1parse(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-asn1parse, asn1parse - ASN.1 parsing tool

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl asn1parse [-help] [-inform PEM|DER] [-in filename] [-out filename] [-noout] [-offset number] [-length number] [-i] [-oid filename] [-dump] [-dlimit num] [-strparse offset] [-genstr string] [-genconf file] [-strictpem] [-item name]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **asn1parse** command is a diagnostic utility that can parse \s-1ASN.1\s0
structures. It can also be used to extract data from \s-1ASN.1\s0 formatted data.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform** **DER|PEM**  
  .IX Item "-inform DER|PEM"
  The input format. **\s-1DER\s0** is binary format and **\s-1PEM\s0** (the default) is base64
  encoded.
* **-in filename**  
  .IX Item "-in filename"
  The input file, default is standard input.
* **-out filename**  
  .IX Item "-out filename"
  Output file to place the \s-1DER\s0 encoded data into. If this
  option is not present then no data will be output. This is most useful when
  combined with the **-strparse** option.
* **-noout**  
  .IX Item "-noout"
  Don't output the parsed version of the input file.
* **-offset number**  
  .IX Item "-offset number"
  Starting offset to begin parsing, default is start of file.
* **-length number**  
  .IX Item "-length number"
  Number of bytes to parse, default is until end of file.
* **-i**  
  .IX Item "-i"
  Indents the output according to the depth\*(R" of the structures.
* **-oid filename**  
  .IX Item "-oid filename"
  A file containing additional \s-1OBJECT\s0 IDENTIFIERs (OIDs). The format of this
  file is described in the \s-1NOTES\s0 section below.
* **-dump**  
  .IX Item "-dump"
  Dump unknown data in hex format.
* **-dlimit num**  
  .IX Item "-dlimit num"
  Like **-dump**, but only the first **num** bytes are output.
* **-strparse offset**  
  .IX Item "-strparse offset"
  Parse the contents octets of the \s-1ASN.1\s0 object starting at **offset**. This
  option can be used multiple times to drill down\*(R" into a nested structure.
* **-genstr string**, **-genconf file**  
  .IX Item "-genstr string, -genconf file"
  Generate encoded data based on **string**, **file** or both using
  **ASN1\_generate\_nconf**\|(3) format. If **file** only is
  present then the string is obtained from the default section using the name
  **asn1**. The encoded data is passed through the \s-1ASN1\s0 parser and printed out as
  though it came from a file, the contents can thus be examined and written to a
  file using the **out** option.
* **-strictpem**  
  .IX Item "-strictpem"
  If this option is used then **-inform** will be ignored. Without this option any
  data in a \s-1PEM\s0 format input file will be treated as being base64 encoded and
  processed whether it has the normal \s-1PEM BEGIN\s0 and \s-1END\s0 markers or not. This
  option will ignore any data prior to the start of the \s-1BEGIN\s0 marker, or after an
  \s-1END\s0 marker in a \s-1PEM\s0 file.
* **-item name**  
  .IX Item "-item name"
  Attempt to decode and print the data as **\s-1ASN1_ITEM\s0 name**. This can be used to
  print out the fields of any supported \s-1ASN.1\s0 structure if the type is known.

<a name="output"></a>

### Output

.IX Subsection "Output"
The output will typically contain lines like this:

.Vb 1
  0:d=0  hl=4 l= 681 cons: SEQUENCE
.Ve

.....

.Vb 10
  229:d=3  hl=3 l= 141 prim: BIT STRING
  373:d=2  hl=3 l= 162 cons: cont [ 3 ]
  376:d=3  hl=3 l= 159 cons: SEQUENCE
  379:d=4  hl=2 l=  29 cons: SEQUENCE
  381:d=5  hl=2 l=   3 prim: OBJECT            :X509v3 Subject Key Identifier
  386:d=5  hl=2 l=  22 prim: OCTET STRING
  410:d=4  hl=2 l= 112 cons: SEQUENCE
  412:d=5  hl=2 l=   3 prim: OBJECT            :X509v3 Authority Key Identifier
  417:d=5  hl=2 l= 105 prim: OCTET STRING
  524:d=4  hl=2 l=  12 cons: SEQUENCE
.Ve

.....

This example is part of a self-signed certificate. Each line starts with the
offset in decimal. **d=XX** specifies the current depth. The depth is increased
within the scope of any \s-1SET\s0 or \s-1SEQUENCE.\s0 **hl=XX** gives the header length
(tag and length octets) of the current type. **l=XX** gives the length of
the contents octets.

The **-i** option can be used to make the output more readable.

Some knowledge of the \s-1ASN.1\s0 structure is needed to interpret the output.

In this example the \s-1BIT STRING\s0 at offset 229 is the certificate public key.
The contents octets of this will contain the public key information. This can
be examined using the option **-strparse 229** to yield:

.Vb 3
    0:d=0  hl=3 l= 137 cons: SEQUENCE
    3:d=1  hl=3 l= 129 prim: INTEGER           :E5D21E1F5C8D208EA7A2166C7FAF9F6BDF2059669C60876DDB70840F1A5AAFA59699FE471F379F1DD6A487E7D5409AB6A88D4A9746E24B91D8CF55DB3521015460C8EDE44EE8A4189F7A7BE77D6CD3A9AF2696F486855CF58BF0EDF2B4068058C7A947F52548DDF7E15E96B385F86422BEA9064A3EE9E1158A56E4A6F47E5897
  135:d=1  hl=2 l=   3 prim: INTEGER           :010001
.Ve

<a name="notes"></a>

# Notes

.IX Header "NOTES"
If an \s-1OID\s0 is not part of OpenSSL's internal table it will be represented in
numerical form (for example 1.2.3.4). The file passed to the **-oid** option
allows additional OIDs to be included. Each line consists of three columns,
the first column is the \s-1OID\s0 in numerical format and should be followed by white
space. The second column is the short name\*(R" which is a single word followed
by white space. The final column is the rest of the line and is the
long name\*(R". **asn1parse** displays the long name. Example:

\f(CW`1.2.3.4       shortName       A long name\*(C'

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Parse a file:

.Vb 1
 openssl asn1parse -in file.pem
.Ve

Parse a \s-1DER\s0 file:

.Vb 1
 openssl asn1parse -inform DER -in file.der
.Ve

Generate a simple UTF8String:

.Vb 1
 openssl asn1parse -genstr UTF8:Hello World\*(Aq
.Ve

Generate and write out a UTF8String, don't print parsed output:

.Vb 1
 openssl asn1parse -genstr UTF8:Hello World\*(Aq -noout -out utf8.der
.Ve

Generate using a config file:

.Vb 1
 openssl asn1parse -genconf asn1.cnf -noout -out asn1.der
.Ve

Example config file:

.Vb 1
 asn1=SEQUENCE:seq_sect

 [seq_sect]

 field1=BOOL:TRUE
 field2=EXP:0, UTF8:some random string
.Ve

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
There should be options to change the format of output lines. The output of some
\s-1ASN.1\s0 types is not well handled (if at all).

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ASN1\_generate\_nconf**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
