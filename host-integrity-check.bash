#!/bin/bash
# For debian-based distrobutions (or any linux system which uses dpkg &>/dev/null package manager)
# LFS v11.1

export LC_ALL=C

greenEcho() { echo -e "\e[32m$1\e[39m"; }
redEcho() { echo -e "\e[31m$1\e[39m"; }
extractVersion() { read string; echo $string | grep -ioP '(\d(\.)?)*' | head -n 1; }

# Version checks :
bashVersion=`echo $BASH_VERSION | extractVersion`; if ! dpkg &>/dev/null --compare-versions $bashVersion "gt" "3.2" ; then redEcho "bash version not compatible"; else greenEcho "Bash version OK : $bashVersion"; fi
binUtilsVersion=`ld --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $binUtilsVersion "gt" "2.13.1" ; then redEcho "Binutils version not compatible"; else greenEcho "Binutils version OK : $binUtilsVersion"; fi
bisonVersion=`bison --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $bisonVersion "gt" "2.7" ; then redEcho "Bison version not compatible"; else greenEcho "Bison version OK : $bisonVersion"; fi
diffUtilsVersion=`diff --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $diffUtilsVersion "gt" "2.8.1" ; then redEcho "Diffutils version not compatible"; else greenEcho "Diffutils version OK : $diffUtilsVersion"; fi
gawkVersion=`gawk --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $gawkVersion "gt" "4.0.1" ; then redEcho "Gawk version not compatible"; else greenEcho "Gawk version OK : $gawkVersion"; fi
gccVersion=`gcc --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $gccVersion "gt" "4.8" ; then redEcho "GCC version not compatible"; else greenEcho "GCC version OK : $gccVersion"; fi
gppVersion=`g++ --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $gppVersion "gt" "4.8" ; then redEcho "G++ version not compatible"; else greenEcho "G++ version OK : $gppVersion"; fi
grepVersion=`grep --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $grepVersion "gt" "2.5.1" ; then redEcho "Grep version not compatible"; else greenEcho "Grep version OK : $grepVersion"; fi
gzipVersion=`gzip --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $gzipVersion "gt" "1.3.12" ; then redEcho "Gzip version not compatible"; else greenEcho "Gzip version OK : $gzipVersion"; fi
m4Version=`m4 --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $m4Version "gt" "1.4.10" ; then redEcho "M4 version not compatible"; else greenEcho "M4 version OK : $m4Version"; fi
makeVersion=`make --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $makeVersion "gt" "4.0" ; then redEcho "Make version not compatible"; else greenEcho "Make version OK : $makeVersion"; fi
patchVersion=`patch --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $patchVersion "gt" "2.5.4" ; then redEcho "Patch version not compatible"; else greenEcho "Patch version OK : $patchVersion"; fi
pythonVersion=`python3 --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions $pythonVersion "gt" "3.4" ; then redEcho "Python version not compatible"; else greenEcho "Python version OK : $python3Version"; fi
sedVersion=`sed --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions  $sedVersion "gt" "4.1.5" ; then redEcho "Sed version not compatible"; else greenEcho "Sed version OK : $sedVersion"; fi
findVersion=`find --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions  $findVersion "gt" "4.2.31" ; then redEcho "Find version not compatible"; else greenEcho "Find version OK : $findVersion"; fi
coreUtilsVersion=`chown --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions  $coreUtilsVersion "gt" "6.9" ; then redEcho "Coreutils version not compatible"; else greenEcho "Coreutils version OK : $coreUtilsVersion"; fi
tarVersion=`tar --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions  $tarVersion "gt" "1.22" ; then redEcho "Tar version not compatible"; else greenEcho "Tar version OK : $tarVersion"; fi
xzVersion=`xz --version | head -n1 | extractVersion`; if ! dpkg &>/dev/null --compare-versions  $xzVersion "gt" "5.0.0" ; then redEcho "XZ version not compatible"; else greenEcho "XZ version OK : $xzVersion"; fi
perlVersion=$(echo Perl `perl -V:version`|extractVersion); if ! dpkg &>/dev/null --compare-versions  $perlVersion "gt" "5.8.8" ; then redEcho "Perl version not compatible"; else greenEcho "Perl version OK : $perlVersion"; fi
makeInfoVersion=`makeinfo --version | head -n1 | grep -oPi "(\d(\.)?)*$" | head -n 1`; if ! dpkg &>/dev/null --compare-versions  $makeInfoVersion "gt" "2.5.4" ; then redEcho "Texinfo (makeinfo) version not compatible"; else greenEcho "Texinfo (makeinfo) version OK : $makeInfoVersion"; fi

# kernel check:
linuxVersion=$(cat /proc/version | grep -ioP '(\d(\.)?)*'|head -n1); if ! dpkg &>/dev/null --compare-versions $linuxVersion "gt" "3.2" ; then redEcho "\nLinux Kernel version not compatible $linuxVersion\n"; else greenEcho "\nLinux Kernel version OK : $linuxVersion\n"; fi

# symlink & alternatives checks :
if echo $(readlink /bin/sh) | grep -i bash &>/dev/null; then greenEcho "/bin/sh points to /bin/bash OK"; else redEcho "ERROR: /bin/sh doesn't point to /bin/bash"; fi
if /usr/bin/yacc --version | grep -i bison &>/dev/null; then greenEcho "/usr/bin/yacc points to bison OK"; else redEcho "ERROR: /usr/bin/bison doesn't point to $(which bison)"; fi
if awk --version | grep -i "GNU Awk" &>/dev/null; then greenEcho "GNU Awk OK"; else redEcho "ERROR: $(which awk) is not a GNU Awk!"; fi

# gcc & g++ check:
echo 'int main(){}' > foo.c && g++ -o foo.o foo.c
if [ -x foo.o ]
  then greenEcho "g++ compilation OK";
  else redEcho "g++ compilation failed"; fi
rm -f foo.o foo.c
