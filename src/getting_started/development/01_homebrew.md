# Homebrew Installation Guide for macOS

---

[Homebrew](https://brew.sh/) is a free and open-source software package management system
for macOS. 

This guide will show you how to install the Homebrew Package Manager 
on macOS and use it to install the required dependencies for the **NYU 
Processor Design Team**.

---

## Contents
- [System Requirements](#system-requirements)
- [Installing Homebrew](#installing-homebrew)
- [Installing Packages](#installing-packages)
  - [CMake](#cmake)
  - [Verilator](#verilator)
- [Maintaining Packages](#maintaining-packages)
- [Further Reading](#further-reading)

---

## System Requirements
- **CPU:** 64-bit Intel or Apple Silicon
- **OS:** macOS Big Sur (11) or higher
- Command Line Tools for Xcode
  - You can install these by running the following from your terminal:
    ```console
    xcode-select --install
    ```
- Bourne-again shell for installation
  (You most likely have this)

---

## Installing Homebrew
- **Disclaimer:** It is best to not copy-paste commands after the first
                  installation command from this guide. The commands use
                  paths specific to the computer this was written on.
                  That computer also uses Apple Silicon and Homebrew has
                  different installation processes for Intel and Apple Silicon
                  computers. <span style="color:red">**Use this guide as a reference**.</span> 

- Open Terminal and run the following command:  
  ```console
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```  

- Next, it will ask you for your password and you should provide the password
you use to unlock your computer
  ```console
  ==>Checking for `sudo` access (which may request your password)...

  Password:
  ```

- The tool will then display a list of everything it will install and the
  directories it will create, before asking you to press <kbd>RETURN</kbd>/
  <kbd>ENTER</kbd> to continue, or any other key to abort 

- Press  <kbd>RETURN</kbd>/<kbd>ENTER</kbd> to continue the installation
  ```console
    Press RETURN/ENTER to continue or any other key to abort:
  ```

- The tool with then start to install Homebrew and any needed Xcode dependencies
  - Let the command run fully and do not close the terminal
  - It may appear at times to be stuck or frozen but it is simply downloading 
    the files it needs
  - Many of these files such as the Xcode command line tools are rather large 
    so expect the installation to take several minutes.

- You will know the installation is done when the following shows up on the Terminal:
  ```console
  ==> Installation successful!

  ==> Homebrew has enabled anonymous aggregate formulae and cask analytics.

  Read the analytics documentation (and how to opt-out) here:

  https://docs.brew.sh/Analytics

  No analytics data has been sent yet (nor will any be during this install run).

  ==> Homebrew is run entirely by unpaid volunteers. Please consider donating:

  https://github.com/Homebrew/brew#donations

  ==> Next steps:

  -Run these three commands in your terminal to add Homebrew to your PATH:

  echo '# Set PATH, MANPATH, etc., for Homebrew.' .. /Users/test/.zprofile

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/test/.zprofile

  eval "$(/opt/homebrew/bin/brew/ shellenv)"

  - Run brew help to get started

  - Further documentation:
  https://docs.brew.sh

  ```

- You will then need to run the following three commands ***one* at a time** 
  to fully set up Homebrew
  - These commands will allow you to access the homebrew commands from your
    terminal
  - Remember to change the username from the path from `test` to whatever
    your username is if you are copying commands from this guide

- Adds a comment in your `zsh` profile file
  ```console
  echo '# Set PATH, MANPATH, etc., for Homebrew.' .. /Users/test/.zprofile
  ```
- Adds homebrew to your `PATH`
  ```console
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/test/.zprofile
  ```
  ```console
  eval "$(/opt/homebrew/bin/brew/ shellenv)"
  ```

- Run the following command to confirm your installation
  ```console
  brew help
  ```

---

## Installing Packages
- The installation command for Homebrew is:
  ```console
  brew install <package name>
  ```

- This will search homebrew's registry for the specified package and install 
  it in the directory `/usr/local/Cellar/` by default

- It will then make symlinks to the package at `/usr/local/opt/` and 
  `/usr/local/bin/` so the packages can be used as executables

- If you want to get information about a specific installed package, you can 
  use the `brew info` command like this:
  ```console
  brew info <package name>
  ```

- To install dependencies used by the **NYU Processor Design Team**, run
  the following commands in the Terminal

- macOS comes with most dependencies pre-installed, so you only need CMake
  and Verilator
### CMake
```console
brew install cmake
```
### Verilator
```console
brew install verilator
```

---

## Maintaining Packages
- To update Homebrew and package definitions, regularly run the following
  ```console
  brew update
  ```

- Upgrade everything
  ```console
  brew upgrade
  ```

- Upgrade a specific package
  ```console
  brew upgrade <package name>
  ```

---

## Further Reading
- If you want to explore more about Homebrew or run into any trouble visit the
  [official site](https://brew.sh/) or the [FAQs](https://docs.brew.sh/FAQ) 
  for many more guides and explanations.
