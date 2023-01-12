#!/bin/bash
Ver=`git describe --tags`
Opt=/opt/OB-Xx-${Ver}/lib/lv2
Loc=/usr/local/lib/lv2
Build=Builds/LinuxMakefile/build/OB-Xx.lv2

echo ""
echo " 1) $Opt"
echo " 2) /usr/local/lib/lv2"
echo " 3) ~/.lv2"
echo ""
echo -n " Which of the folders above to install to? -> "
read Inst
case $Inst in 
 1) mkdir -p $Opt && cp -a $Build $Opt || echo "ERROR; Couldn't create $Opt. Wrong permissions?"  ;;
 2) test -d $Loc && touch -d $Loc/_sadflk3453j45 && rm -f $Loc/_sadflk3453j45 && cp -a $Build $Loc/ || echo "ERROR; Couldn't copy to $Loc . Wrong permissions?"  ;;
 3) test -d ~/.lv2 || mkdir ~/.lv2 ;  cp -a $Build ~/.lv2 ;;
 *) echo "ERROR: Wrong choice. Run $0 again manually"
esac

test ! -d ~/.config/OB-Xx && mkdir ~/.config/OB-Xx
for var in Banks MIDI Themes ; do cp -a Resources/$var  ~/.config/OB-Xx ; done  && \
echo ""
echo "Themes and Banks are located in  ~/.config/OB-Xx"

echo ""
echo "If errors were encountered you should use sudo or su to become root and run $0 manually"
echo ""

