# Unknown Detection Party
### A Minecraft Cheat in Haskell

![](https://i.imgur.com/LhpA6Kl.png)

Nothing big, just a small intro for (s)kids wanting to make Haskell clients (and no, this doesn't involve any Java code)

Happy skidding!

### Requirements

  - GHC (Stack || Cabal) 8 or higher.
  - JDK 8

### Getting Started

    - install JNI using stack, I used this command:
    `stack install --extra-lib-dirs=/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/jre/lib/server --extra-include-dirs=/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include --extra-include-dirs=/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include/darwin jni --ghc-options -rpath,/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/jre/lib/server`
    I am on macOS so make sure to set `LD_LIBRARY_PATH` to libjvm.dylib as well!

### Disclaimer

This does not currently allow you to log in with your Minecraft account, so for now it is just a proof of concept, but will eventually be more. It also doesn't run off your current install of Minecraft (it only requires specific files), so if you're wanting your saves, options, texturepacks, multiplayer stuff, then copy that over to your projects root directory