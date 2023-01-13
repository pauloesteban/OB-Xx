#!/bin/bash
Ver=`git describe --tags`
Opt=/opt/OB-Xx-${Ver}
Loc=/usr/local
Build=Builds/LinuxMakefile/build/

echo ""
echo " 1) $Opt"
echo " 2) $Loc"
echo " 3) ~/  [.lv2/.vst3/.bin]"
echo ""
echo -n " Which of the folders above to install to? -> "
read Inst
case $Inst in 
 1) mkdir -p $Opt/lib/lv2 && test ! -d $Opt/lib/lv2 && echo "ERROR; Couldn't create $Opt. Wrong permissions?" && exit 2
    cp -a $Build/OB-Xx.lv2 $Opt/lib/lv2
    test -d $Build/OB-Xx.vst3/Contents && mkdir -p $Opt/lib/vst3 && cp -a $Build/OB-Xx.vst3 $Opt/lib/vst3
    test -f $Build/OB-Xx && mkdir -p $Opt/bin && cp -a $Build/OB-Xx $Opt/bin
    ;;
 2) test -d $Loc/lib/lv2 || mkdir $Loc/lib/lv2 >& /dev/null
    test ! -w $Loc/lib/lv2 && echo "ERROR; Couldn't write to $Loc/lib/lv2 . Wrong permissions?" && exit 3 
    cp -a $Build/OB-Xx.lv2  $Loc/lib/lv2
    if [ -d $Build/OB-Xx.vst3/Contents ]; then 
      test -d $Loc/lib/vst3 || mkdir $Loc/lib/vst3
      cp -a $Build/OB-Xx.vst3  $Loc/lib/vst3
    fi
    test -f $Build/OB-Xx && cp -a $Build/OB-Xx  $Loc/bin
    ;;
 3) test -d ~/.lv2 || mkdir ~/.lv2 ;  cp -a $Build/OB-Xx.lv2 ~/.lv2
    test -d $Build/OB-Xx.vst3/Contents && mkdir ~/.vst3 >& /dev/null ; cp -a $Build/OB-Xx.vst3 
    test -f $Build/OB-Xx && mkdir ~/.bin >& /dev/null ; cp -a $Build/OB-Xx  ~/.bin 
    ;;
 *) echo "ERROR: Wrong choice. Run $0 again manually"
esac

test ! -d ~/.config/OB-Xx && mkdir ~/.config/OB-Xx
for var in Banks MIDI Themes ; do cp -a Resources/$var  ~/.config/OB-Xx ; done  && \
echo ""
echo "Themes and Banks are located in  ~/.config/OB-Xx"

echo ""
echo "If errors were encountered you should use sudo or su to become root and run $0 manually"
echo ""

