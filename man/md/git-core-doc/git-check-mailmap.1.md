# git\-check\-mailmap(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-check-mailmap - Show canonical names and email addresses of contacts

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git check-mailmap [<options>] <contact>...
<synopsis>


```

<a name="description"></a>

# Description


For each “Name &lt;user@host&gt;” or “&lt;user@host&gt;” from the command-line or standard input (when using **--stdin**), look up the person’s canonical name and email address (see "Mapping Authors" below). If found, print them; otherwise print the input as-is.

<a name="options"></a>

# Options


--stdin
Read contacts, one per line, from the standard input after exhausting contacts provided on the command-line.

<a name="output"></a>

# Output


For each contact, a single line is output, terminated by a newline. If the name is provided or known to the _mailmap_, “Name &lt;user@host&gt;” is printed; otherwise only “&lt;user@host&gt;” is printed.

<a name="mapping-authors"></a>

# Mapping Authors


If the file **.mailmap** exists at the toplevel of the repository, or at the location pointed to by the mailmap.file or mailmap.blob configuration options, it is used to map author and committer names and email addresses to canonical real names and email addresses.

In the simple form, each line in the file consists of the canonical real name of an author, whitespace, and an email address used in the commit (enclosed by _&lt;_ and _&gt;_) to map to the name. For example:

.if n \{.RS 4
.\}
    Proper Name <commit@email.xx>
.if n \{.RE
.\}

The more complex forms are:

.if n \{.RS 4
.\}
    <proper@email.xx> <commit@email.xx>
.if n \{.RE
.\}

which allows mailmap to replace only the email part of a commit, and:

.if n \{.RS 4
.\}
    Proper Name <proper@email.xx> <commit@email.xx>
.if n \{.RE
.\}

which allows mailmap to replace both the name and the email of a commit matching the specified commit email address, and:

.if n \{.RS 4
.\}
    Proper Name <proper@email.xx> Commit Name <commit@email.xx>
.if n \{.RE
.\}

which allows mailmap to replace both the name and the email of a commit matching both the specified commit name and email address.

Example 1: Your history contains commits by two authors, Jane and Joe, whose names appear in the repository under several forms:

.if n \{.RS 4
.\}
    Joe Developer <joe@example.com>
    Joe R. Developer <joe@example.com>
    Jane Doe <jane@example.com>
    Jane Doe <jane@laptop.(none)>
    Jane D. <jane@desktop.(none)>
.if n \{.RE
.\}


Now suppose that Joe wants his middle name initial used, and Jane prefers her family name fully spelled out. A proper **.mailmap** file would look like:

.if n \{.RS 4
.\}
    Jane Doe         <jane@desktop.(none)>
    Joe R. Developer <joe@example.com>
.if n \{.RE
.\}


Note how there is no need for an entry for **&lt;jane@laptop.(none)&gt;**, because the real name of that author is already correct.

Example 2: Your repository contains commits from the following authors:

.if n \{.RS 4
.\}
    nick1 <bugs@company.xx>
    nick2 <bugs@company.xx>
    nick2 <nick2@company.xx>
    santa <me@company.xx>
    claus <me@company.xx>
    CTO <cto@coompany.xx>
.if n \{.RE
.\}


Then you might want a **.mailmap** file that looks like:

.if n \{.RS 4
.\}
    <cto@company.xx>                       <cto@coompany.xx>
    Some Dude <some@dude.xx>         nick1 <bugs@company.xx>
    Other Author <other@author.xx>   nick2 <bugs@company.xx>
    Other Author <other@author.xx>         <nick2@company.xx>
    Santa Claus <santa.claus@northpole.xx> <me@company.xx>
.if n \{.RE
.\}


Use hash _#_ for comments that are either on their own line, or after the email address.

<a name="git"></a>

# Git


Part of the **git**(1) suite
