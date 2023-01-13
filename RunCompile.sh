#!/bin/bash

test $# -ne 1 && echo "ERROR: JUCE-version needed, eg $0 7.0.3" && exit 1
test ! -r ../JUCE-$1/Projucer && echo "ERROR: ../JUCE-$1/Projucer doesn't exist" && exit 2

# Fix vst2 compile bug :
cat - > PreJuce.diff << _EOF1
--- "OB-Xx Linux.jucer.orig"	2022-12-20 11:57:49.300533563 +0100
+++ "OB-Xx Linux.jucer"	2022-12-20 11:58:25.908534039 +0100
@@ -132,7 +132,7 @@
     <MODULES id="juce_opengl" showAllCode="1" useLocalCopy="0" useGlobalPath="0"/>
   </MODULES>
   <JUCEOPTIONS JUCE_QUICKTIME="disabled" JUCE_WEB_BROWSER="0" JUCE_ASIO="1"
-               JUCE_JACK="1" JUCE_USE_CURL="0"/>
+               JUCE_JACK="1" JUCE_USE_CURL="0" JUCE_VST3_CAN_REPLACE_VST2="0"/>
   <LIVE_SETTINGS>
     <OSX/>
     <WINDOWS/>
_EOF1

patch -p0 < PreJuce.diff && rm PreJuce.diff

echo ""
echo "When Projucer starts make sure to set the global JUCE paths to JUCE-$1 and JUCE-$1/modules"
echo "Click on the gear icon, scroll down to Plugin Formats and check that ony LV2 and (optionally) VST3 and Standalone are checked"
echo ""
echo "Press Enter to start Projucer"
read Dummy

../JUCE-$1/Projucer "OB-Xx Linux.jucer"

# Fix problems finding JUCE includes :
mv Modules M.org && mkdir Modules &&  cp -a  ../JUCE-$1/modules/* Modules && cp -a M.org/* Modules && rm -rf M.org

cat - > PostJuce.diff << _EOF2
--- Modules/juce_gui_extra/misc/juce_AnimatedAppComponent.h~	2022-11-29 13:34:37.000000000 +0100
+++ Modules/juce_gui_extra/misc/juce_AnimatedAppComponent.h	2022-12-20 13:01:36.916583289 +0100
@@ -77,7 +77,7 @@
     int totalUpdates = 0;
     int framesPerSecond = 60;
     bool useVBlank = false;
-    VBlankAttachment vBlankAttachment;
+//    VBlankAttachment vBlankAttachment;
 
     void timerCallback() override;
 
--- Modules/juce_gui_extra/misc/juce_AnimatedAppComponent.cpp~	2022-11-29 13:34:37.000000000 +0100
+++ Modules/juce_gui_extra/misc/juce_AnimatedAppComponent.cpp	2022-12-20 13:06:10.232586840 +0100
@@ -44,12 +44,12 @@
     {
         stopTimer();
 
-        if (vBlankAttachment.isEmpty())
-            vBlankAttachment = { this, [this] { timerCallback(); } };
+//        if (vBlankAttachment.isEmpty())
+//            vBlankAttachment = { this, [this] { timerCallback(); } };
     }
     else
     {
-        vBlankAttachment = {};
+//        vBlankAttachment = {};
 
         const auto interval = 1000 / framesPerSecond;
 
_EOF2

patch -p0 < PostJuce.diff && rm PostJuce.diff

CPU=`nproc --ignore=1`
make -j$CPU -C Builds/LinuxMakefile CONFIG=Release64 && ./_inst.sh
