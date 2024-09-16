# GamescopeSession
This project allows you to easily install an additional “Steam Big Picture” session when logging into the system.
This session will launch Steam in Big Picture mode in standalone mode.

## What you need to do
1. Install Steam for your distribution:
   - For example, for Ubuntu, use [the official method](https://store.steampowered.com/about/) from Valve;
   - For Fedora use [this](https://docs.fedoraproject.org/en-US/gaming/proton/);
   - Or go your own way. But I will say in advance, I am not at all sure about the version with flatpack or snap.
2. Install Gamescope:
   - You can look for a version within your distribution's package, but it will most likely be quite old;
   - Or you can build a fresh gamescope yourself from the source files: follow the instructions in [this repository](https://github.com/ValveSoftware/gamescope).
3. Then clone the repository of this project:
   ~~~sh
   git clone --recurse-submodules https://github.com/Algorithm0/GamescopeSession.git
   ~~~
4. Go to the project folder and run the installer (you will be asked for a password):
   ~~~sh
   cd GamescopeSession
   ./config.sh install
   ~~~
5. Select the desired GPU for work:
   ~~~sh
   export-gpu
   ~~~
6. After all the steps are done, you can log out (you will get to the login window),
there you can select a "Steam Big Picture" session - select it, log in and enjoy.
Oh, and if you have a TV connected to your PC and a gamepad, then experience the real console experience.
Enjoy the game!

## Additions and recommendations
- If you need more freedom to customize your gaming session, read about the configuration file [here](https://github.com/Algorithm0/gamescope-session/tree/main).
And yes, you don't need to install this project itself if you followed the instructions - it's already installed.
- Do you have an Xbox controller? Oh, you're in luck. [Read here](https://github.com/medusalix/xone).
- Do you need a full-fledged gaming OS on Linux? Check out [ChimeraOS](https://chimeraos.org/)!