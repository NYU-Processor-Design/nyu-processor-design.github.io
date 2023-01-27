# Windows Subsystem for Linux (WSL) Installation Guide

 

This guide will show you how to install the Windows Subsystem for Linux (WSL) on Win and use it to install the required dependencies for the onboarding labs.

  

# Installing WSL

Open a Terminal and run the following command:


```console
wsl --install
```

This command will install the default Linux distribution (Ubuntu) but you can install any of the distributions listed by the command `wsl -l -o` with the following command:

```console
wsl --install -d <distribution_name>
```
After a restart, running the command `wsl` in the terminal or running the wsl command in your start menu will open a virtual linux environment in your pc.   

Once WSL has been set up you will have to create a username and password for your linux machine. Follow the instructions provided and remember the password you enter as it will be required to run `sudo` commands.

# Using VSCode with WSL

Install [VSCode](https://code.visualstudio.com/) in your native windows environment first.

In VSCode, install the [WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) extension using the Extension tab on the left tool panel.

Now VSCode can be run in the WSL environment by clicking on the green button at the bottom left of your window and clicking "New WSL Window" or by pressing ```F1``` or ```Ctrl-Shift-P``` to open the command palette and selecting ```WSL: New WSL Window```.

# Installing Dependencies (Ubuntu)

The installation command for Linux is ```sudo install <package_name_here>```. This will search for the specified package and install it in your system.
  
Before installing any packages, run this command to update your package information
```console
sudo apt-get update && sudo apt-get upgrade
```

## Installing cmake

  

To install cmake, run the following command in the Terminal

```console
sudo apt install cmake
```

  

## Installing verilator

  

To install verilator, run the following command in the Terminal

```console

sudo apt install verilator

```

  

## Installing cURL

To install cURL, run the following command in the Terminal. (Note: this install may take a while)

```console

sudo apt install curl

```

  
  

## Installing zip and unzip

To install zip and unzip, run the following commands **one at a time** in the Terminal

```console

sudo apt install zip unzip

```

## Installing tar

To install tar, run the following command in the Terminal. (Note: this install may take a while)

```console

sudo apt install tar

```

  

## Installing git

  

To install git, run the following command in the Terminal

```console

sudo apt install git

```
Optionally, to install all packages in one command, run the command
```console 
sudo apt install cmake verilator curl zip unzip tar git -y
```
  

Then follow the [Getting Started With Git](https://nyu-processor-design.github.io/getting_started/notebooks/02_git.html) instructions to configure git.

# Optional: Installing Oh My ZSH
[Oh My ZSH](https://ohmyz.sh/) is an open-source framework for creating themes for ZSH terminals. It can provide useful information like which git branch you are in and overall makes the terminal more pleasant to look at. 

To install it, run these two commands and follow the instructions that are provided.
```console
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
To change the theme of your terminal, you can run the command ```nano ~/.zshrc``` and change the line ```ZHS_THEME="robbyrussell"``` to any of the available themes listed [here](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes).

## Changing VSCode's Default Terminal
To change VSCode's default terminal, press ```F1``` or ```Ctrl-Shift-P``` to open up the command palette and search for Terminal: Select Default Shell and select ```zsh```. Now every time you open a terminal in WSL, VSCode will open a zsh terminal with your selected theme. 