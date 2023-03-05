# Windows Subsystem for Linux (WSL) Installation Guide

---

The [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/about)
(WSL) is a type 1 hypervisor[^hypervisor] developed by Microsoft to allow
developers to run Linux environments directly on Windows, without the drawbacks of type 2 hypervisors[^hypervisor] such as virtual machines, or, the
hassles of dual-boot setups.

This guide will show you how to install the Windows Subsystem for Linux (WSL) 
on Windows and use it to install the required dependencies for the **NYU 
Processor Design Team**.

---

## Contents
- [Installing WSL](#installing-wsl)
- [Using VSCode with WSL](#using-vscode-with-wsl)
- [Installing Packages (Ubuntu)](#installing-packages-ubuntu)
  - [CMake](#cmake)
  - [Verilator](#verilator)
  - [cURL](#curl)
  - [Git](#git)
- [Maintaining Packages](#maintaining-packages)
- [Optional: Using Zsh](#optional-using-zsh)
  - [Prettifying Zsh](#prettifying-zsh)
  - [Changing VSCode's Default Terminal](#changing-vscodes-default-terminal)
- [Further Reading](#further-reading)

---

## Installing WSL

- Open a Terminal and run the following command:
  ```console
  wsl --install
  ```

- The following command will install the default Linux distribution (Ubuntu),
  but you can install any of the distributions listed by `wsl -l -o`
  ```console
  wsl --install -d <distribution_name>
  ```

- After a restart, running the command `wsl` in the terminal or running the 
  `wsl` command in your start menu will open a virtual linux environment in 
  your pc

- Once WSL has been set up you will have to create a username and password for
   your linux machine
   
- Follow the instructions provided and remember the password you enter as it 
  will be required to run `sudo` commands
  - `sudo` stands for "Super User Do"

---

## Using VSCode with WSL
- Install [VSCode](https://code.visualstudio.com/) in your native Windows
  environment first.

- In VSCode, install the [WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) 
  extension using the **Extensions** tab on the left tool panel

- Now, VSCode can be run in the WSL environment by doing one of the following:
  1. Clicking on the **"Remote Window"** button at the bottom left of your 
     VSCode window and clicking **"New WSL Window"**
<img src="/images/wsl/code1.png" width="70%" style="margin-left: auto; margin-right: auto; display: block;"/>
  2. Pressing <kbd>F1</kbd> or <kbd>Control</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>
     to open the command palette and selecting ```WSL: New WSL Window```

---

## Installing Packages (Ubuntu)
- The installation command for Ubuntu is
  ```console
  sudo apt install <package name>
  ```
  - This will search for the specified package in the APT registry
    and install it in your system.
  - You can list multiple package names in one command, for example:
    ```console
    sudo apt install cmake verilator clang-format
    ```

### CMake
Unfortunately, APT doesn't have the latest version of CMake, so we must use
this alternative[^cmake].
- #### Uninstall existing CMake Versions
  ```console
  sudo apt remove --purge --auto-remove cmake
  ```
- #### Preparing for Installation
  ```console
  sudo apt update && \
  sudo apt install -y software-properties-common lsb-release && \
  sudo apt clean all
  ```
- #### Obtain a copy of kitware's signing key
  ```console
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
  ```
- #### Add kitware's reposity to sources list
  ```console
  sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main"
  ```
- #### Optionally, installing kitware-archive keyring package to keep Kitware's keyring up to date
  ```console 
  sudo apt update
  sudo apt install kitware-archive-keyring
  sudo rm /etc/apt/trusted.gpg.d/kitware.gpg
  ```
- #### If running `sudo apt update` gets the following error:
  ```console
  Err:7 https://apt.kitware.com/ubuntu bionic InRelease
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 6AF7F09730B3F0A4
  Fetched 11.0 kB in 1s (7552 B/s)
  ```
  Copy the public key `6AF7F09730B3F0A4` and run this command:
  ```console
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6AF7F09730B3F0A4
  ```
- #### Finally, update and install the `cmake` package
  ```console
  sudo apt update
  sudo apt install cmake
  ```
  
### Verilator  
```console
sudo apt install verilator
```
### cURL
```console
sudo apt install curl
```
### Git
```console
sudo apt install git
```
- Then follow the [Getting Started With Git](../notebooks/02_git.md) tutorial
  to configure git

---

## Maintaining Packages
- To update APT and package definitions, run the following
  ```console
  sudo apt update
  ```
  - `update` fetches the latest information of the installed packages

- Upgrade everything
  ```console
  sudo apt upgrade -y
  ```
  - `upgrade` will upgrade them if newer versions have been released
  - the `-y` flag simply tells APT that it has permission to upgrade everything
    and doesn't have to ask you to say "yes" to each upgrade

- Uninstall a packages
  ```console
  sudo apt remove <package name>
  ```

---

## Optional: Using Zsh
- Ubuntu's default shell is the Bourne-again shell (Bash)

- Z-shell (Zsh) is a Unix shell built on top of BASH

- Zsh includes more features and is the default shell on other popular Linux
  distros such as Arch Linux

- To replace Bash as Ubuntu's default shell, first install zsh:
  ```console
  sudo apt install zsh
  ```

- Change login shell to Zsh
  ```console
  chsh -s $(which zsh)
  ```
  - [`chsh`](https://linux.die.net/man/1/chsh) changes your login shell
  - The `-s` flag specifies the login shell
  - The `$()` syntax tells the shell to interpret everything between the 
    parentheses as a command
  - `which` identifies the location for various executables and prints the full
    path of the executables; in this case, we want the path for `zsh`

- Log out and log back in for the change to take effect

### Prettifying Zsh
- The default Zsh appearance is, for the lack of better words, hideous, 
  unpleasant, and unsightly

- To fix this, many open-source frameworks have been created to create themes
  for Zsh terminals

- [Oh My Zsh](https://ohmyz.sh/) is the most popular Zsh theme framework
  - **Sidetrack:** [Fun story](https://medium.com/free-code-camp/d-oh-my-zsh-af99ca54212c) 
    about the ideation of Oh my Zsh, written by the creator, Robby Russel

- Not only does it make Zsh much more pleasant to look at, it also provides
  useful and important information such as your current working directory,
  git branch, git status, etc.

- To install Oh My Zsh, use the following command
  ```console
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```

- To change the theme of your terminal, you can run the command `nano ~/.zshrc`
  and change the line `ZHS_THEME="robbyrussell"` to any of the available themes listed [here](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
  - The `.zshrc` file is a special run-command file that contains configurations 
    for your zsh terminal session
  - It exists on your home directory as a hidden file, hence the `~` and `.` beginning
  - It is executed when you log in

### Changing VSCode's Default Terminal
- To change VSCode's default terminal, press <kbd>F1</kbd> or <kbd>Control</kbd>+
<kbd>Shift</kbd>+<kbd>P</kbd> to open up the command palette 

- Search for `Terminal: Select Default Shell` and select `zsh`

- Now every time you open a terminal in WSL, VSCode will open a zsh terminal

---

## Further Reading
- Microsoft's [excellent documentation](https://learn.microsoft.com/en-us/windows/wsl/)
  for WSL

- VSCode's [excellent documentation](https://code.visualstudio.com/docs/remote/wsl)
  on developing in WSL

- Ubuntu's [documentation](https://ubuntu.com/wsl) about Ubuntu on WSL

---

[^hypervisor]: A [hypervisor](https://www.vmware.com/topics/glossary/content/hypervisor.html?resource=cat-1299087558#cat-1299087558) 
is software that runs and monitors virtual machines   

[^cmake]: Summarized from [this Stack Exchange question](https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line)