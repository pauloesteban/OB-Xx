# OB-Xe, an OB-Xd fork

The `e` in the project name stands for my middle name, Esteban. This software is provided without warranty.

![](https://raw.githubusercontent.com/gitterdude/OB-Xx/main/OB-Xx.jpg)

## About

OB-Xd and this fork are based on the [Oberheim OB-X](https://wikipedia.org/wiki/Oberheim_OB-X). It attempts to recreate its sound and behavior, but as the original was very limited in some important ways a number of things were added or altered to the original design. OB-Xd was designed to sound as good and as rich as the original. It implements micro random detuning which is a big part of that sound.

While not copying originals, some of the features were taken to a better point. Continuous blendable multimode filter (HP-Notch(BP)-HP in 12 dB mode and 4-1 pole in 24 dB mode). Also, like many synths of the OB-X's generation, the OB-Xd has no internal effects so its sounds and textures can be greatly enhanced by the use of additional processing like chorus, reverb, delay, etc.

Thanks to [2Dat](https://github.com/2DaT/Obxd) for the original OB-Xd and Soshi Studio for giving the rights to continue this wonderful product. Also thanks to [KVR artists for creating some amazing skins!](https://www.kvraudio.com/forum/viewtopic.php?f=1&t=471926)

As a side note, discoDSP now claims copyright on the original OB-Xd themes, so they can't be distributed in a free/libre/open source version of this program.
The default theme in Resources, and in the screenshot above, was created by [gitterdude](https://github.com/gitterdude).

## Building

### Windows
- Clone [JUCE](https://github.com/juce-framework) (version `7.0.11` at time of this writing) in your `C:\`. This is the default global path for Projucer.
- Checkout to `master` branch.
- Build Projucer from source with [Visual Studio 2022](https://visualstudio.microsoft.com/).
- Open `Ob-Xe.jucer` with Projucer.
- Select the Visual Studio 2022 exporter and click on the icon to open the solution.
- Build the VST3 or Standalone targets. As VST2 (a.k.a. VST Legacy) is no longer supported by Steinberg, it also not supported in this project even if it is listed as a target.
- Copy the `Themes` folder from `Resources` to the home folder inside a folder called `OB-Xe`, e.g., `C:\Users\<your-username>\Ob-Xe\`.


### GNU/Linux (experimental)
The source code can be compiled with [JUCE 7.0.3](https://github.com/juce-framework/JUCE/releases/tag/7.0.3).
Extract the juce zip file above this directory and rename it JUCE-7.0.3
Then run 'bash RunCompile.sh 7.0.3' and follow the instruction.

## Copyright

The original author [2Dat](https://github.com/2DaT) granted discoDSP a OB-Xd private use license on December 2022.

This repository and the source code is under GPL3 license.

Files from Source > Images folder in this commit were created by discoDSP and have Attribution-ShareAlike 2.0 Generic (CC BY-SA 2.0) license.

The Themes files in the Resources folder were created by gitterdude and have Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) license
The default skin is inspired by Ilkka Rosma's theme in the discoDSP release.

