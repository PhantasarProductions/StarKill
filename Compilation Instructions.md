This will be a step by step guide on how to do things... Okay?

# What you need to compile
- The contents of this repository (duh!)
- [DOSBox](https://dosbox.com)
- [Turbo Pascal 7.0](https://winworldpc.com/product/turbo-pascal/7x) (Yes that download is legal. Borland has release TP7.0 for free).
- Thie contents of [this](https://github.com/Tricky1975/pascal70units) repository (but don't clone right away, things may get a bit awkward).
- [JCR6 CLI tools](https://github.com/jcr6/jcr6cli)

# JCR6 first
I'm not going into compiling JCR6... The tools are written in Go, but already deprecated, but my C# tools still had a few issues, so my scripts are still at the old Go version.
You can just download it from the releases. Make sure these .exe files are in your search path, and you can build.ps1 in this repository.
This is strictly speaking a PowerShell script, but frankly, Unix users can use it as a shell script. That script comes later.


# Cloning the repositories right
Create a folder dedicated to Star Kill, and do this
~~~shell
git clone https://github.com/PhantasarProductions/StarKill
git clone https://github.com/Tricky1975/pascal70units Units
~~~
It is extremely important that the second repository is cloned in "Units"... remember, the actual compiling will be done in DOS and DOS cannot handle filenames longer than 8 characters.

# Download Turbo Pascal 7.0
Unpack the stuff, likely you'll get an intallation program and tons of zip files. Don't unzip these yourself. The installation program knows how to do that, and that will save your a lot of trouble. This installation program works in DOS, so don't even try to install it.

# Time to fire up DOSBox
Run DOSBox and type
~~~batch
mount c <your-starkillwork-directory>
mount a <where you unpacked the Turbo Pascal archive in>
A:
Install
~~~
Now install Turbo Pascal in C:\TP
~~~
C:
cd StarKill
Build
~~~
Now this should create STARKILL.EXE, but you are not ready to run it yet.

# The DATA.JCR file
Open PowerShell
~~~ps1
cd <the starkill folder>
pack
~~~
Now in Unix you may try to type "./pack.ps1" and it SHOULD work if JCR6 if in the search path




Please note that it was not really my intension to make you compile this yourself, but hey, if you insist, who am I to stop you, and at least, now you know how.
Please note that in the "Units" folder you will find files with the ".TPU" extension after all compiling is done. "TPU" stands for "Turbo Pascal Unit", and just contains the machine code of the source files in there, so it doesn't have to compile them over and over. Unlike C/C++/Assembler they already contain all interface data, so no need for those irritating .h files.

I hope it works... You can of course also just wait for this game to be released and have a ready to go package. :-P
