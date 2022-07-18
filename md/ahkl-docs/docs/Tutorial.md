# AutoHotkey Beginner Tutorial by tidbit

## Table of Contents

1. [The Basics](#s1)
   1. [Downloading and installing AutoHotkey](#s11)
   2. [How to create a script](#s12)
   3. [You cannot merge commands](#s13)
   4. [How to find the help file on your computer](#s14)
2. [Hotkeys & Hotstrings](#s2)
   1. [Keys and their mysterious symbols](#s21)
   2. [Window specific hotkeys/hotstrings](#s22)
   3. [Multiple hotkeys/hotstrings per file](#s23)
   4. [Examples](#s24)
3. [Sending Keystrokes](#s3)
   1. [Games](#s31)
4. [Running Programs & Websites](#s4)
5. [Commands vs. Functions()](#s5)
   1. [Code blocks](#s51)
6. [Variables](#s6)
   1. [When to use percents](#s61)
   2. [Getting user input](#s62)
   3. [Other Examples?](#s63)
7. [Objects](#s7)
   1. [Creating Objects](#s71)
   2. [Using Objects](#s72)
8. [Other Helpful Goodies](#s8)
   1. [The mysterious square brackets](#s81)
   2. [Finding your AHK version](#s82)
   3. [Trial and Error](#s83)
   4. [Indentation](#s84)
   5. [Asking for Help](#s85)
   6. [Other links](#s86)

## 1 - The Basics

Before we begin our journey, let me give some advice. Throughout this tutorial you will see a lot of text and a lot of code. For optimal learning power, it is advised that you read the text and **try** the code. Then, study the code. You can copy and paste most examples on this page. If you get confused, try reading the section again.

### a. Downloading and installing AutoHotkey

Since you're viewing this documentation locally, you've probably already installed AutoHotkey and can skip to section b.

Before learning to use AutoHotkey (AHK), you will need to download it. After downloading it, you may possibly need to install it. But that depends on the version you want. For this guide we will use the Installer since it is easiest to set up.

Text instructions:

1. Go to the AutoHotkey Homepage:[https://www.autohotkey.com/](https://www.autohotkey.com/)
2. Click Download:[https://www.autohotkey.com/download/ahk-install.exe](https://www.autohotkey.com/download/ahk-install.exe)
3. During installation of AutoHotkey, you will be asked to choose from UNICODE or ANSI. In short, you would probably want to choose UNICODE. It has support for non-English letters and numbers (characters). Keep going until you see an Install button.
4. Once done, great! Continue on to section b.

For a video instruction, watch
[Install and Hello World](https://youtu.be/HcgQlGeaPHw) on YouTube.

### b. How to create a script

Once you have AutoHotkey installed, you will probably want it to do stuff. AutoHotkey is not magic, we all wish it was, but it is not. So we will need to tell it what to do. This process is called "Scripting".

Text instructions:

01. Right-Click on your desktop.
02. Find "New" in the menu.
03. Click "AutoHotkey Script" inside the "New" menu.
04. Give the script a new name. It must end with a .ahk extension. For example: MyScript.ahk
05. Find the newly created file on your desktop and right-click it.
06. Click "Edit Script".
07. A window should have popped up, probably Notepad. If so, SUCCESS!

    So now that you have created a script, we need to add stuff into the file. For a list of all built-in commands, function and variables, see [section 5](#s5).

    Here is a very basic script containing a hotkey which types text using the [Send](commands/Send.htm) command when the hotkey is pressed:


    ```
    ^j::
    Send, My First Script
    return
    ```


    We will get more in-depth later on. Until then, here's an explanation of the above code:
    - The first line:`^j::` is the hotkey. `^` means Ctrl, `j` is the letter J. Anything to the **left** of `::` are the keys you need to press.
    - The second line:`Send, My First Script` is how you **send** keystrokes. `Send` is the command, anything after the comma (,) will be typed.
    - The third line:`return`. This will become your best friend. It literally **stops** code from going any further, to the lines below. This will prevent many issues when you start having a lot of stuff in your scripts.
08. Save the File.
09. Double-click the file/icon in the desktop to run it. Open notepad or (anything you can type in) and pressCtrl and J.
10. Hip Hip Hooray! Your first script is done. Go get some reward snacks then return to reading the rest of this tutorial.

For a video instruction, watch [Install and Hello World](https://youtu.be/HcgQlGeaPHw) on YouTube.

### c. You cannot merge commands

When you are making your code, you might have the urge to put several commands on the same line or inside of each other, don't. [In section 5](#s5) we'll talk about why it doesn't work as you might expect and what you can do instead.

### d. How to find the help file on your computer

There are a few ways to do this, I'll assume you have it installed to the default locations:

Method 1:

1. Find the Start menu or Start Orb on your screen, usually in the lower left.
2. Click**Programs** or **All Programs**.
3. Find**AutoHotkey** in the list.
4. You should then see**AutoHotkey Help File**. Click it.
5. Done!

Method 2:

1. Go to your desktop.
2. Find**My Computer** or **Computer**. Open it.
3. Go into your harddrive that contains**AutoHotkey**. Probably **C:\** drive.
4. Search within all**Program Files** folders for **AutoHotkey**.
5. Look for**AutoHotkey.chm** or a file that says AutoHotkey and has a yellow question mark on it.
6. Done!

## 2 - Hotkeys & Hotstrings

What is a hotkey? A hotkey is a key that is hot to the touch. ... Just kidding. It is a key or key combination that the person at the keyboard presses to trigger some actions. For example:

```
^j::
Send, My First Script
return
```

What is a hotstring? Hotstrings are mainly used to expand abbreviations as you type them (auto-replace), they can also be used to launch any scripted action. For example:

```
::ftw::Free the whales
```

The difference between the two examples is that the hotkey will be triggered when you press Ctrl+J while the hotstring will convert your typed "ftw" into "Free the whales".

_"So, how exactly does a person such as myself create a hotkey?"_ Good question. A hotkey is created by using a single pair of colons. The key or key combo needs to go on the **left** of the `::`. And the content needs to go below, followed by a `return`.

**Note:** There are exceptions, but those tend to cause confusion a lot of the time. So it won't be covered in the tutorial, at least, not right now.

```
Esc::
MsgBox, Escape!!!!
return

```

A hotstring has a pair of colons on each side of the text you want to trigger the text replacement. While the text to replace your typed text goes on the **right** of the second pair of colons.

Hotstrings, as mentioned above, can also launch scripted actions. That's fancy talk for _"do pretty much anything"_. Same with hotkeys.

```
::btw::
MsgBox, You typed btw.
return
```

A nice thing to know is that you can have many lines of code for each hotkey, hotstring, label, and a lot of other things we haven't talked about yet.

```
^j::
MsgBox, Wow!
MsgBox, There are
Run, notepad.exe
WinActivate, Untitled - Notepad
WinWaitActive, Untitled - Notepad
Send, 7 lines{!}{Enter}
SendInput, inside the CTRL{+}J hotkey.
return
```

### a. Keys and their mysterious symbols

You might be wondering _"How the crud am I supposed to know that ^ means Ctrl?!"_. Well, good question. To help you learn what ^ and other symbols mean, gaze upon this chart:

SymbolDescription#Win (Windows logo key)!Alt^Ctrl+Shift&An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

**(For the full list of symbols, see the [Hotkey](Hotkeys.htm) page)**

Additionally, for a list of all/most hotkey names that can be used on the **left** side of a hotkey's double-colon, see [List of Keys, Mouse Buttons, and Joystick Controls](KeyList.htm).

You can define a custom combination of two (and only two) keys (except joystick buttons) by using ` & ` between them. In the example below, you would hold down Numpad0 then press Numpad1 or Numpad2 to trigger one of the hotkeys:

```
Numpad0 & Numpad1::
MsgBox, You pressed Numpad1 while holding down Numpad0.
return

Numpad0 & Numpad2::
Run, notepad.exe
return
```

But you are now wondering if hotstrings have any cool modifiers since hotkeys do. Yes, they do! Hotstring modifiers go between the first set of colons. For example:

```
:*:ftw::Free the whales
```

Visit [Hotkeys](Hotkeys.htm) and [Hotstrings](Hotstrings.htm) for additional hotkey and hotstring modifiers, information and examples.

### b. Window specific hotkeys/hotstrings

Sometime you might want a hotkey or hotstring to only work (or be disabled) in a certain window. To do this, you will need to use either of these fancy commands with a # in-front of them:

```
#IfWinActive
#IfWinExist
```

These special commands (technically called "directives") create context-sensitive hotkeys and hotstrings. Simply specify a window title. But in some cases you might want to specify criteria such as HWND, group or class. Those are a bit advanced and are covered more in-depth here: [The WinTitle Parameter & the Last Found Window](misc/WinTitle.htm).

```
#IfWinActive Untitled - Notepad
#Space::
MsgBox, You pressed WIN+SPACE in Notepad.
return
```

To turn off context sensitivity for subsequent hotkeys or hotstrings, specify any #IfWin directive but leave all of its parameters blank. For example:

```
<em>; Untitled - Notepad</em>
#IfWinActive Untitled - Notepad
!q::
MsgBox, You pressed ALT+Q in Notepad.
return

<em>; Any window that isn't Untitled - Notepad</em>
#IfWinActive
!q::
MsgBox, You pressed ALT+Q in any window.
return
```

When #IfWin directives are never used in a script, all hotkeys and hotstrings are enabled for all windows.

The #IfWin directives are positional: they affect all hotkeys and hotstrings physically beneath them in the script. They are also mutually exclusive; that is, only the most recent one will be in effect.

```
<em>; Notepad</em>
#IfWinActive ahk_class Notepad
#Space::
MsgBox, You pressed WIN+SPACE in Notepad.
return
::msg::You typed msg in Notepad

<em>; MSPaint</em>
#IfWinActive Untitled - Paint
#Space::
MsgBox, You pressed WIN+SPACE in MSPaint!
return
::msg::You typed msg in MSPaint!
```

For more in-depth information and similar commands, check out the [#IfWinActive](commands/_IfWinActive.htm) page.

### c. Multiple hotkeys/hotstrings per file

This, for some reason crosses some people's minds. So I'll set it clear: AutoHotkey has the ability to have _as many_ hotkeys and hotstrings in one file as you want. Whether it's 1, or 3253 (or more).

```
#i::
Run, https://www.google.com/
return

^p::
Run, notepad.exe
return

~j::
Send, ack
return

:*:acheiv::achiev
::achievment::achievement
::acquaintence::acquaintance
:*:adquir::acquir
::aquisition::acquisition
:*:agravat::aggravat
:*:allign::align
::ameria::America
```

The above code is perfectly acceptable. Multiple hotkeys, multiple hotstrings. All in one big happy script file.

### d. Examples

```
::btw::by the way  <em>; Replaces "btw" with "by the way" as soon as you press an <a href="Hotstrings.htm#EndChars" data-index="43">default ending character</a>.</em>
```

```
:*:btw::by the way  <em>; Replaces "btw" with "by the way" without needing an ending character.</em>
```

```
^n::  <em>; CTRL+N hotkey</em>
Run, notepad.exe  <em>; Run Notepad when you press CTRL+N.</em>
return  <em>; This ends the hotkey. The code below this will not be executed when pressing the hotkey.</em>
```

```
^b::  <em>; CTRL+B hotkey</em>
Send, {Ctrl down}c{Ctrl up}  <em>; Copies the selected text. ^c could be used as well, but this method is more secure.</em>
SendInput, [b]{Ctrl down}v{Ctrl up}[/b] <em>; Wraps the selected text in BBCode tags to make it bold in a forum.</em>
return  <em>; This ends the hotkey. The code below this will not be executed when pressing the hotkey.</em>
```

## 3 - Sending Keystrokes

So now you decided that you want to send (type) keys to a program. We can do that. Use the [Send](commands/Send.htm) command. This command literally sends keystrokes, to simulate typing or pressing of keys.

But before we get into things, we should talk about some common issues that people have.

Just like hotkeys, the Send command has special keys too. [Lots and lots of them](commands/Send.htm). Here are the four most common symbols:

SymbolDescription!Sends Alt. For example, `Send, This is text!a` would send the keys "This is text" and then press Alt+A. **Note**: `!A` produces a different effect in some programs than `!a`. This is because `!A` presses Alt+Shift+A and `!a` presses Alt+A. If in doubt, use lowercase.+Sends Shift. For example, `Send, +abC` would send the text "AbC", and `Send, !+a` would press Alt+Shift+A.^Sends Ctrl. For example, `Send, ^!a` would press Ctrl+Alt+A, and `Send, ^{Home}` would send Ctrl+Home. **Note**: `^A` produces a different effect in some programs than `^a`. This is because `^A` presses Ctrl+Shift+A and `^a` presses Ctrl+A. If in doubt, use lowercase.#Sends Win (the key with the Windows logo) therefore `Send #e` would hold down Win and then press E.

The [gigantic table on the Send page](commands/Send.htm) shows pretty much every special key built-in to AHK. For example: `{Enter}` and `{Space}`.

**Caution:** This table **does not** apply to [hotkeys](Hotkeys.htm). Meaning, you do not wrap Ctrl or Enter (or any other key) inside curly brackets when making a hotkey.

An example showing what shouldn't be done to a hotkey:

```
<em>; When making a hotkey...
; WRONG</em>
{LCtrl}::
Send, AutoHotkey
return

<em>; CORRECT</em>
LCtrl::
Send, AutoHotkey
return
```

A common issue lots of people have is, they assume that the curly brackets are put in the documentation pages just for fun. But in fact **they are needed**. It's how AHK knows that `{!}` means "exclamation point" and not "press Alt". So please remember to check the table on the [Send](commands/Send.htm) page and make sure you have your brackets in the right places. For example:

```
Send, This text has been typed{!} <em>; Notice the ! between the curly brackets? That's because if it wasn't, AHK would press the ALT key.</em>

```

```
<em>; Same as above, but with the ENTER key. AHK would type out "Enter" if
; it wasn't wrapped in curly brackets.</em>
Send, Multiple Enter lines have Enter been sent. <em>; WRONG</em>
Send, Multiple{Enter}lines have{Enter}been sent. <em>; CORRECT</em>

```

Another common issue is that people think that **everything** needs to be wrapped in brackets with the Send command. That is FALSE. If it's not in the chart, it does not need brackets. You do **not** need to wrap common letters, numbers or even some symbols such as `.` (period) in curly brackets. Also, with the Send commands you are able to send more than one letter, number or symbol at a time. So no need for a bunch of Send commands with one letter each. For example:

```
Send, {a}       <em>; WRONG</em>
Send, {b}       <em>; WRONG</em>
Send, {c}       <em>; WRONG</em>
Send, {a}{b}{c} <em>; WRONG</em>
Send, {abc}     <em>; WRONG</em>
Send, abc       <em>; CORRECT</em>
```

To hold down or release a key, enclose the key name in curly brackets and then use the word UP or DOWN. For example:

```
<em>; This is how you hold one key down and press another key (or keys).
; If one method doesn't work in your program, please try the other.</em>
Send, ^s                     <em>; Both of these send CTRL+S</em>
Send, {Ctrl down}s{Ctrl up}  <em>; Both of these send CTRL+S</em>
Send, {Ctrl down}c{Ctrl up}
Send, {b down}{b up}
Send, {Tab down}{Tab up}
Send, {Up down}  <em>; Press down the up-arrow key.</em>
Sleep, 1000      <em>; Keep it down for one second.</em>
Send, {Up up}    <em>; Release the up-arrow key.</em>
```

But now you are wondering _"How can I make my really long Send commands readable?"_. Easy. Use what is known as a continuation section. Simply specify an opening parenthesis on a new line, then your content, finally a closing parenthesis on its own line. For more information, read about [Continuation Sections](Scripts.htm#continuation).

```
Send,
(
Line 1
Line 2
Apples are a fruit.
)
```

**Note:** There are several different forms of Send. Each has their own special features. If one form of Send does not work for your needs, try another type of Send. Simply replace the command name "Send" with one of the following: SendRaw, SendInput, SendPlay, SendEvent. For more information on what each one does, [read this](commands/Send.htm).

### a. Games

**This is important:** A lot of games, especially modern ones, have cheat prevention software. Things like GameGuard, Hackshield, PunkBuster and several others. Not only is bypassing these systems in violation of the games policies and could get you banned, they are complex to work around.

If a game has a cheat prevention system and your hotkeys, hotstrings and Send commands do not work, you are out of luck. However there are methods that can increase the chance of working in some games, but there is no magical _"make it work in my game now!!!"_ button. So try **ALL** of these before giving up.

There are also known issues with DirectX. If you are having issues and you know the game uses DirectX, try the stuff described on the [FAQ](FAQ.htm#games) page. More DirectX issues may occur when using [PixelSearch](commands/PixelSearch.htm), [PixelGetColor](commands/PixelGetColor.htm) or [ImageSearch](commands/ImageSearch.htm). Colors might turn out black (0x000000) no matter the color you try to get. You should also try running the game in windowed mode, if possible. That fixes some DirectX issues.

There is no single solution to make AutoHotkey work in all programs. If everything you try fails, it may not be possible to use AutoHotkey for your needs.

## 4 - Running Programs & Websites

To run a program such as _mspaint.exe, calc.exe, script.ahk_ or even a folder, you can use the [Run](commands/Run.htm) command. It can even be used to open URLs such as [https://www.autohotkey.com/](https://www.autohotkey.com/) . If your computer is setup to run the type of program you want to run, it's very simple:

```
<em>; Run a program. Note that most programs will require a FULL file path:</em>
Run, %A_ProgramFiles%\Some_Program\Program.exe

<em>; Run a website:</em>
Run, https://www.autohotkey.com
```

There are some other advanced features as well, such as command line parameters and CLSID. If you want to learn more about that stuff, visit the [Run](commands/Run.htm) page.

Here are a few more samples:

```
<em>; Several programs do not need a full path, such as Windows-standard programs:</em>
Run, notepad.exe
Run, mspaint.exe

<em>; Run the "My Documents" folder using a <a href="Variables.htm#BuiltIn" data-index="58">built-in variable</a>:</em>
Run, %A_MyDocuments%

<em>; Run some websites:</em>
Run, https://www.autohotkey.com
Run, https://www.google.com
```

For more in-depth information and examples, check out the [Run](commands/Run.htm) page.

## 5 - Commands vs. Functions()

AutoHotkey has two main types of things used by the scripter to create code: Commands and functions.

A list of all commands and built-in functions can be found [here](commands/index.htm).

### Commands

You can tell what a command is by looking at its syntax (the way it looks). Commands do not use parentheses around the parameters like functions do. So a command would look like this:

```
Command, Parameter1, Parameter2, Parameter3
```

When using commands, you cannot squish other commands onto the same line as a previous command (exception: [IfEqual](commands/IfEqual.htm)). You cannot put commands inside the parameters of other commands. For example:

```
MsgBox, Hello Run, notepad.exe   <em>; Wrong</em>
MsgBox, Hello, Run, notepad.exe  <em>; Wrong</em>

MsgBox, Hello      <em>; Correct</em>
Run, notepad.exe
```

Commands also differ from function in that they use "legacy syntax". This means that you **need** percent signs around a variable, such as `%Var%`, and that any text and numbers do not need to be in quotation marks, such as `This is some text`. Additionally, you cannot do math in the parameters, unlike functions.

You can do math in parameters if you force an expression with a single `%`, but that will not be covered.

### Functions

As stated above, functions are different because they use parentheses. A typical function looks like:

```
Function(Parameter1, Parameter2, Parameter3)
```

Functions have a few main differences:

1. You can do math in them:


   ```
   SubStr(37 * 12, 1, 2)
   SubStr(A_Hour - 12, 2)
   ```

2. Variables do not need to be wrapped in percent signs:


   ```
   SubStr(A_Now, 7, 2)
   ```

3. Functions can go inside of functions:


   ```
   SubStr(A_AhkPath, InStr(A_AhkPath, "AutoHotkey"))
   ```

4. Text needs to be wrapped in quotes:


   ```
   SubStr("I'm scripting, awesome!", 16)
   ```


A function usually return a value differently than a command does. Commands need an _OutputVar_ parameter, functions do not. The most common way assigning the value of a function to a variable is like so:

```
<span style="color:#ff4400"><b>MyVar</b></span> := SubStr("I'm scripting, awesome!", 16)
```

This isn't the only way, but the most common. You are using `MyVar` to store the return value of the function that is to the right of the `:=` operator. See [Functions](Functions.htm) for more details.

In short:

```
<em>; These are commands:</em>
MsgBox, This is some text.
StringReplace, Output, Input, AutoHotKey, AutoHotkey, All
SendInput, This is awesome{!}{!}{!}

<em>; These are functions:</em>
SubStr("I'm scripting, awesome!", 16)
FileExist(VariableContainingPath)
Output := SubStr("I'm scripting, awesome!", 16)
```

### a. Code blocks

[Code blocks](commands/Block.htm) are lines of code surrounded by little curly brackets ( `{` and `}`). They group a section of code together so that AutoHotkey knows it's one big family and that it needs to stay together. They are most often used with functions and control flow statements such as [If](commands/IfExpression.htm) and [Loop](commands/Loop.htm). Without them, only the first line in the block is called.

In the following code, both lines are run only if _MyVar_ equals 5:

```
if (MyVar = 5)
{
    MsgBox, MyVar equals %MyVar%!!
    ExitApp
}
```

In the following code, the message box is only shown if _MyVar_ equals 5. The script will always exit, even if _MyVar_ **is not** 5:

```
if (MyVar = 5)
    MsgBox, MyVar equals %MyVar%!!
    ExitApp
```

This is perfectly fine since the if-statement only had one line of code associated with it. It's exactly the same as above, but I outdented the second line so we know it's separated from the if-statement:

```
if (MyVar = 5)
    MsgBox, MyVar equals %MyVar%!!
MsgBox, We are now 'outside' of the if-statement. We did not need curly brackets since there was only one line below it.
```

## 6 - Variables

[Variables](Variables.htm) are like little post-it notes that hold some information. They can be used to store text, numbers, data from functions and commands or even mathematical equations. Without them, programming and scripting would be much more tedious.

Variables can be assigned a few ways. We'll cover the most common forms. Please pay attention to the equal sign ( `=`).

Legacy text assignment

```
MyVar = Text
```

This is the simplest form for a variable, a legacy assignment. Simply type in your text and done.

Legacy variable assignment

```
MyVar = %MyVar2%
```

Same as above, but you are assigning a value of a variable to another variable.

Legacy mixed assignment

```
MyVar = %MyVar2% some text %MyVar3%.
```

A combination of the two legacy assignments above.

Expression text assignment

```
MyVar := "Text"
```

This is an expression assignment, due to the `:` before the `=`. Any text needs to be in quotes.

Expression variable assignment

```
MyVar := MyVar2
```

In expression mode, variables do not need percent signs.

Expression number assignment

```
MyVar := 6 + 8 / 3 * 2 - Sqrt(9)
```

Thanks to expressions, you can do math!

Expression mixed assignment

```
MyVar := "The value of 5 + " MyVar2 " is: " 5 + MyVar2
```

A combination of the three expression assignments above.

Equal signs ( **=**) with a symbol in front of it such as `:=` `+=` `-=` `.=` etc. are called **assignment operators** and always require an expression.

### a. When to use percents

One of the most common issues with AutoHotkey involving variables is when to use the percent signs ( **%**). Hopefully this will clear some confusion.

When to use percent signs:

- When you are using commands (see above), except when the parameter is_OutputVar_ or _InputVar_.
- When you are assigning a value to a variable using the legacy mode (an equal sign with no symbol in front of it).

When **not** to use percent signs:

- In parameters that are input or output variables. For example:`StringLen, <strong>OutputVar</strong>, <strong>InputVar</strong>`
- On the left side of an assignment:`<strong>Var</strong> = 123abc`
- On the left side of legacy (non-expression) if-statements:`if <strong>Var1</strong> < %Var2%`
- Everywhere in expressions. For example:


  ```
    if (<strong>Var1</strong> != <strong>Var2</strong>)
    <strong>Var1</strong> := <strong>Var2</strong> + 100
  ```


### b. Getting user input

Sometimes you want to have the user to choose the value of stuff. There are several ways of doing this, but the simplest way is [InputBox](commands/InputBox.htm). Here is a simple example on how to ask the user a couple of questions and doing some stuff with what was entered:

```
InputBox, OutputVar, Question 1, What is your first name?
if (OutputVar = "Bill")
    MsgBox, That's an awesome name`, %OutputVar%.

InputBox, OutputVar2, Question 2, Do you like AutoHotkey?
if (OutputVar2 = "yes")
    MsgBox, Thank you for answering %OutputVar2%`, %OutputVar%! We will become great friends.
else
    MsgBox, %OutputVar%`, That makes me sad.
```

### c. Other Examples?

```
<a href="commands/MsgBox.htm" data-index="68">MsgBox</a>, 4,, Would you like to continue?
<a href="commands/IfMsgBox.htm" data-index="69">IfMsgBox</a>, No
    return  <em>; If No, stop the code from going further.</em>
MsgBox, You pressed YES.  <em>; Otherwise, the user picked yes.</em>
```

```
<em>; Some examples showing when to use percents and when not:</em>
Var = Text  <em>; Assign some text to a variable (legacy).</em>
Number := 6  <em>; Assign a number to a variable (expression).</em>
Var2 = %Var%  <em>; Assign a variable to another (legacy).</em>
Var3 := Var  <em>; Assign a variable to another (expression).</em>
Var4 .= Var  <em>; Append a variable to the end of another (expression).</em>
Var5 += Number  <em>; Add the value of a variable to another (expression).</em>
Var5 -= Number  <em>; Subtract the value of a variable from another (expression).</em>
Var6 := SubStr(Var, 2, 2)  <em>; Variable inside a function. This is always an expression.</em>
Var7 = %Var% Text  <em>; Assigns a variable to another with some extra text (legacy).</em>
Var8 := Var " Text"  <em>; Assigns a variable to another with some extra text (expression).</em>
MsgBox, %Var%  <em>; Variable inside a command. </em>
StringSplit, Var, Var, x  <em>; Variable inside a command that uses InputVar and OutputVar.</em>
if (Number = 6)  <em>; Whenever an IF has parentheses, it'll be an expression. So no percent signs.</em>
if (Var != Number)  <em>; Whenever an IF has parentheses, it'll be an expression. So no percent signs.</em>
if Number = 6  <em>; Without parentheses, the IF is legacy. However, only variables on the 'right side' need percent signs. </em>
if Var1 < %Var2%  <em>; Without parentheses, the IF is legacy. However, only variables on the 'right side' need percent signs.</em>
```

## 7 - Objects

[Objects](Objects.htm) are a way of organizing your data for more efficient usage. Sometimes objects are referred to as arrays, but it's important to note that all arrays are just objects. We call objects different things depending on what we are using them for, but all objects are the same.

An object is basically a collection of variables. The variable names are known as "Keys", and the contents of the variables are "Values".

When you hear people calling an object an _array_ or _indexed array_, it usually means that all the keys are sequential numbers 1 and up. When you hear people calling an object an _associative array_, it means that the keys are either strings (text) or non-sequential numbers. Sometimes it's a mix of both, and sequential numbers too!

There are no restrictions to what a key or value can be, and they can even be other arrays! When the values are arrays too, this is referred to as a _nested array_, and these will be explained later.

There are a number of reasons you might want to use an object for something. Some examples:

- You want to have a numbered list of things, such as a grocery list (this would be referred to as an indexed array)
- You want to represent a grid, perhaps for a board game (this would be done with nested objects)
- You have a list of things where each thing has a name, such as the characteristics of a fruit (this would be referred to as an associative array)

### a. Creating Objects

There are a few ways to create an object, and the most common ones are listed below:

Bracket syntax

```
MyObject := ["one", "two", "three", 17]
```

This will start you off with what is sometimes called an "indexed array". An indexed array is an object representing a list of items, numbered 1 and up. In this example, the value `"one"` is stored in object key `1` (aka index 1), and the value `17` is stored in object key `4` (aka index 4).

Brace syntax

```
Banana := {"Color": "Yellow", "Taste": "Delicious", "Price": 3}
```

This will let you start of by defining what is sometimes called an "associative array". An associative array is a collection of data where each item has a name. In this example, the value `"Yellow"` is stored in the object key `"Color"`. Also, the value `3` is stored in the object key `"Price"`.

Array function

```
MyObject := Array("one", "two", "three", 17)
```

This is equivalent to the bracket syntax, but wrapped in a function.

Object function

```
Banana := Object("Color", "Yellow", "Taste", "Delicious", "Price", 3)
```

This is equivalent to the brace syntax, but wrapped in a function.

It's important to remember that every one of these definitions all create the same thing (objects), just with different keys.

### b. Using Objects

There are many ways to use objects, including retrieving values, setting values, adding more values, and more.

#### To set values:

Bracket notation

```
Banana["Pickled"] := True <em>; This banana has been pickled. Eww.</em>
```

Setting values in an object is as simple as setting the value of a variable. All you have to do is put your bracket notation on the left side of an expression assignment operator `:=`.

Dot notation

```
Banana.Consistency := "Mushy"
```

The same as above but with the dot notation.

#### To retrieve values:

Bracket notation

```
Value := Banana["Color"]
```

This allows you to use an expression as the key to get the value from your object. In this case, I used the simple expression `"Color"`, which is (unsurprisingly) the key `Color`. You will get a message box with the word "Yellow", because that is what we set the key `Color` to in the [previous section](#s71).

Dot notation

```
Value := Banana.Color
```

This only lets you use literal strings for the keys. You cannot use variables in your keys with dot notation.

#### To add new keys and values:

Bracket notation

```
MyObject["NewerKey"] := 3.1415
```

To directly add a key and value, just set a key that doesn't exist yet.

Dot notation

```
MyObject.NewKey := "Shiny"
```

The same as above but with the dot notation.

InsertAt method

```
MyObject.InsertAt(Index, Value1, Value2, Value3...)
```

_Index_ is any integer key. This will shift ALL higher integer keys up by the number of values which were inserted, even if there are gaps (for example, only keys 1 and 100 exist, and you insert a value at key 50, it will shift 100 up to 101).

Push method

```
MyObject.Push(Value1, Value2, Value3...)
```

This "appends" the values to the end of the array _MyObject_. In other words, it inserts the values at the highest integer key plus one.

#### To remove keys and values:

Blanking the value out

```
Banana.Consistency := ""
```

The simplest way to remove a value is to just blank it out. You can do this by setting it to `""`, also known as an _empty string_. This doesn't remove the key, but it will make the value appear identical to an unset value. It is possible to tell that the key still exists by using the [HasKey](objects/Object.htm#HasKey) method, and it will still come up in a [For](commands/For.htm) loop.

Delete method

```
RemovedValue := MyObject.Delete(AnyKey)
```

This and the next methods below remove the key _and_ the value. The previous value of `MyObject[AnyKey]` will be stored in _RemovedValue_.

```
NumberOfRemovedKeys := MyObject.Delete(FirstKey, LastKey)
```

Allows you to remove a range of numbered/integer or string keys between _FirstKey_ and _LastKey_. The value it gives will be the number of keys that were removed, which is useful if you have a gap between your keys (e.g. you specify keys 1 through four, but key number 2 doesn't exist, this will set _NumberOfRemovedKeys_ to 3 as only three keys were there to be removed).

Pop method

```
MyObject.Pop()
```

This removes the highest integer key, and returns the value. There are no keys higher than it to be affected.

RemoveAt method

```
RemovedValue := MyObject.RemoveAt(Index)
```

```
NumberOfRemovedKeys := MyObject.RemoveAt(Index, Length)
```

This removes all keys from _Index_ to _Index + Length - 1_ (inclusive). If _Length_ is omitted it defaults to 1. After removing the keys it takes all higher numbered/integer keys and moves them down to fill the gap, so that if there was a value at _Index + Length_ it will now be at _Index_. This is similar to how the InsertAt method with multiple specified values works.

## 8 - Other Helpful Goodies

We have reached the end of our journey, my good friend. I hope you have learned something. But before we go, here are some other things that I think you should know. Enjoy!

### a. The mysterious square brackets

Throughout the documentation, you will see these two symbols ( `[` and `]`) surrounding code in the yellow syntax box at the top of almost all pages. Anything inside of these brackets are **_OPTIONAL_**. Meaning the stuff inside can be left out if you don't need them. When writing your code, it is very important to **NOT** type the square brackets in your code.

On the [ControlGetText](commands/ControlGetText.htm) page you will see this:

```
<span class="func">ControlGetText</span>, OutputVar <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

So you could simply do this if you wanted:

```
ControlGetText, OutputVar
```

Or add in some more details:

```
ControlGetText, OutputVar, Control, WinTitle
```

What if you wanted to use _ExcludeTitle_ but not fill in _WinText_ or _WinTitle_? Simple!

```
ControlGetText, OutputVar, Control,,, ExcludeTitle
```

Please note that you cannot IGNORE parameters, but you can leave them blank. If you were to ignore `WinTitle, WinText`, it would look like this and cause issues:

```
ControlGetText, OutputVar, Control, ExcludeTitle
```

### b. Finding your AHK version

Run this code to see your AHK version:

```
MsgBox, %A_AhkVersion%
```

Or look for "AutoHotkey Help File" or "AutoHotkey.chm" in the start menu or your installation directory.

### c. Trial and Error

Trial and Error is a very common and effective way of learning. Instead of asking for help on every little thing, sometimes spending some time alone (sometimes hours or days) and trying to get something to work will help you learn faster.

If you try something and it gives you an error, study that error. Then try to fix your code. Then try running it again. If you still get an error, modify your code some more. Keep trying and failing until your code fails no more. You will learn a lot this way by reading the documentation, reading errors and learning what works and what doesn't. Try, fail, try, fail, try, try, try, fail, fail, **succeed!**

This is how a lot of "pros" have learned. But don't be afraid to ask for help, we don't bite (hard). Learning takes time, the "pros" you encounter did not learn to be masters in just a few hours or days.

"If at first you don't succeed, try, try, try again." - Hickson, William E.

### d. Indentation

This stuff (indentation) is very important! Your code will run perfectly fine without it, but it will be a major headache for you and other to read your code. Small code (25 lines or less) will probably be fine to read without indentation, but it'll soon get sloppy. It's best you learn to indent ASAP. Indentation has no set style, but it's best to keep everything consistent.

" **What is indentation?**" you ask? It's simply spacing to break up your code so you can see what belongs to what. People usually use 3 or 4 spaces or 1 tab per "level".

Not indented:

```
if (car = "old")
{
MsgBox, The car is really old.
if (wheels = "flat")
{
MsgBox, This car is not safe to drive.
return
}
else
{
MsgBox, Be careful! This old car will be dangerous to drive.
}
}
else
{
MsgBox, My`, what a shiny new vehicle you have there.
}
```

Indented:

```
if (car = "old")
{
    MsgBox, The car is really old.
    if (wheels = "flat")
    {
        MsgBox, This car is not safe to drive.
        return
    }
    else
    {
        MsgBox, Be careful! This old car will be dangerous to drive.
    }
}
else
{
    MsgBox, My`, what a shiny new vehicle you have there.
}
```

See Wikipedia's [Indentation style](https://en.wikipedia.org/wiki/Indentation_style) page for various styles and examples. Choose what you like or learn to indent how you think it's easiest to read.

### e. Asking for Help

Before you ask, try doing some research yourself or try to code it yourself. If that did not yield results that satisfy you, read below.

- Don't be afraid to ask for help, even the smartest people ask others for help.
- Don't be afraid to show what you tried, even if you think it's silly.
- Post anything you have tried.
- Pretend_everyone but you_ is a doorknob and knows nothing. Give as much information as you can to educate us doorknobs at what you are trying to do. Help us help you.
- Be patient.
- Be polite.
- Be open.
- Be kind.
- Enjoy!

If you don't get an answer right away, wait at least 1 day (24 hours) before asking for more help. We love to help, but we also do this for free on our own time. We might be at work, sleeping, gaming, with family or just too busy to help.

And while you wait for help, you can try learning and doing it yourself. It's a good feeling, making something yourself without help.

### f. Other links

[Frequently Asked Questions (FAQ)](FAQ.htm)

