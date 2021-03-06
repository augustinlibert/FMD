# Free Manga Downloader (FMD)

<sup>(Forked from https://github.com/riderkick/FMD)</sup>

## Download

[![Latest release](https://img.shields.io/github/release/fmd-project-team/FMD.svg)](https://github.com/fmd-project-team/FMD/releases/latest)
[![Download latest release (Win32)](https://img.shields.io/github/downloads/fmd-project-team/FMD/latest/fmd_0.9.168.0.7z.svg?label=Win32)](https://github.com/fmd-project-team/FMD/releases/download/0.9.168.0/fmd_0.9.168.0.7z)
[![Download latest release (Win64)](https://img.shields.io/github/downloads/fmd-project-team/FMD/latest/fmd_0.9.168.0_Win64.7z.svg?label=Win64)](https://github.com/fmd-project-team/FMD/releases/download/0.9.168.0/fmd_0.9.168.0_Win64.7z)

## About FMD

This is an active fork of the Free Manga Downloader which is a free open source application written in Object Pascal for managing and downloading manga from various websites. The source code was released under the GPLv2 license.  
  
  
[Supported Websites](https://github.com/fmd-project-team/FMD/wiki/Supported-Websites)  
  
## Build instructions

In order to build FMD from the source code, you must install the latest version of Lazarus and Free Pascal Compiler:  
[![Lazarus IDE 2.0.6](https://img.shields.io/badge/Lazarus%20IDE-2.0.6-Blue.svg)](http://www.lazarus-ide.org/)  

To compile FMD some packages and components are needed. You can download and install most of them by the built-in Online Package Manager (OPM).  
The following packages and components are used for building FMD:  
[![Synapse r209](https://img.shields.io/badge/Synapse-r209-Blue.svg)](https://sourceforge.net/p/synalist/code/HEAD/tree/trunk/) <sup>(Compile before "InternetTools")</sup>  
![DCPCrypt 2.0.4.1](https://img.shields.io/badge/DCPCrypt-OPM%20(2.0.4.1)-Blue.svg)  
![RichMemo (18.01.2020)](https://img.shields.io/badge/RichMemo-OPM%20(18.01.2020)-Blue.svg)  
![LCL Extensions 0.6.1](https://img.shields.io/badge/LCL%20Extensions-OPM%20(0.6.1)-Blue.svg) <sup>(Compile before "Virtual TreeView")</sup>  
![Virtual TreeView 5.5.3.1](https://img.shields.io/badge/Virtual%20TreeView-OPM%20(5.5.3.1)-Blue.svg)  
![MultiLog 0.6.0.0](https://img.shields.io/badge/MultiLog-OPM%20(0.6.0.0)-Blue.svg)  
![InternetTools (18.01.2020)](https://img.shields.io/badge/InternetTools-OPM%20(18.01.2020)-Blue.svg)  
  
After everything is installed, open the file `md.lpi` by using Lazarus IDE.  
Make sure to add `ssl_openssl` to the uses list of `Synapse` and compile the package again.  
To compile and build the source code of FMD select `Run -> Build`. If everything is ok, the binary file should be in `FMD_source_code_folder/bin`.  
  
If `InternetTools` fails to compile because of a missing or incompatible PPU, make sure to compile `Synapse` first.  
  
Some other external 3rd party tools and libraries are used as well:  
[![7-Zip](https://img.shields.io/badge/7--Zip%20(Standalone)-19.00-Blue.svg)](https://www.7-zip.org)  
[![Duktape](https://img.shields.io/badge/Duktape-2.5.0-Blue.svg)](https://github.com/grijjy/DelphiDuktape)  
[![WebP (libwebp)](https://img.shields.io/badge/WebP%20(libwebp)-1.1.0-Blue.svg)](https://github.com/webmproject/libwebp/)  
[![Lua](https://img.shields.io/badge/Lua-5.3.3-Blue.svg)](http://luabinaries.sourceforge.net/)  
[![OpenSSL](https://img.shields.io/badge/OpenSSL-1.1.1d-Blue.svg)](https://www.openssl.org/)  
[![SQLite](https://img.shields.io/badge/SQLite-3.30.1-Blue.svg)](https://www.sqlite.org/)  
  
These tools and libraries are not part of the source. You have to either download pre-compiled binaries, compile them yourself or just copy them from the latest FMD releases.  
  
## Localization

Translations are stored inside `languages` folder with `.po` extension.  
In order to translate FMD to your native language you can copy `fmd.po` and rename it to `fmd.xx.po`, where `xx` stand for two-letter language code.  
Additionally you can add country code at the end of language code. For reference you can look at http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes and http://en.wikipedia.org/wiki/ISO_3166-1. For example `id_ID` will be recognized as `Bahasa Indonesia (Indonesia)`.  
To translate the content of the file you need to use translation tools like [Poedit](https://poedit.net).  
Once you have finished translating all of its content you can launch FMD and it will automatically detect your new languages upon startup.
