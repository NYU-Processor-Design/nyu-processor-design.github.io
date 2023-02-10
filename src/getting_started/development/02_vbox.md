# VirtualBox Guide
VirtualBox (VBox) is a popular hypervisor for x86 virtualisation.
It allows you to create "virtual machines", which are effectively
emulates a real computer on your computer. This allows you to use
operating systems you do not have on disk, run programs that may
be risky to run on your computer, or work with historical machines
that are hard to find now. 

We will use VirtualBox to create a virtual machine (VM) to contribute
to the **NYU Processor Design Team** without having to install
Linux natively or buy a new computer. VBox is a plug-and-play
solution for all intents and purposes of the **NYU Processor 
Design Team**.

This guide will help you use the provided VM configuration with
VBox.

## Minimum Requirements
- **CPU:** Any reasonably powerful 64-bit x86 processor  
  (fancy way to say "most modern computers")

- **Memory:** 8 GB RAM  
  (the VM uses 8 GB)

- **Disk Space:** 16 GB available space  
  (Virtual hard disks are dynamic and grow with usage. You do not 
  *need* 16 GB available immediately, that's just what the VM is set 
  up for)

- **OS:** Any major 64-bit operating system such as Windows, 
          macOS, and most Linux distributions


**Note:** If you already use Linux or macOS, you can start working
immediately and do not need a VM, but nobody will stop you if 
you wish to use one regardless. Check the [Lab Guidance](../onboarding/01_guidance.md) 
page for what you need to have. Optionally, macOS users are
encouraged to look at the [Homebrew Installation Guide](01_homebrew.md).

## Virtual Machine Information
- The provided VM is set up for VirtualBox >v7.0.0, which means it is
  guaranteed to work with any version of VBox after v7.0.0

- Currently, VirtualBox is on v7.0.1, as of writing this guide

- The VM is set up with [Ubuntu Desktop 22.04.1 LTS](https://releases.ubuntu.com/22.04/)

- The VM contains all tools you need to begin working *right away*

### Specifications
- **OS:** Ubuntu Desktop 22.04.1 LTS[^lts]
- **Processors:** 2 processors
- **Memory:** 4 GB RAM
- **Disk Space:** 16 GB
- **Appliance Size[^appliance]:** 7 GB

## Downloading VirtualBox
1. Go to [virtualbox.org](https://www.virtualbox.org)

2. Download the latest version of VirtualBox

## Download the VM
1. Go [here](https://drive.google.com/drive/folders/1vzB0ra_1gFrapqpwCEHLpuZI6Ekn0mpw?usp=share_link)

2. Download the `.ova` file
   - OVA stands for Open Virtualisation Appliance
   - It is a common file extension that hypervisors use
   - The **NYU Processor Design Team** VM conntains the *entire*
     OS, some applications, utilities, etc. and therefore is
     ~7 GB.

## Importing the VM
1. Open VBox
  
2. Click on "File" and then "Import Appliance"
<img src="/images/vbox/import1.png" width="20%" style="margin-left: auto; margin-right: auto; display: block;"/>

3. Find the `procezzor.ova` file in your file system
<img src="/images/vbox/import2.png" width="70%" style="margin-left: auto; margin-right: auto; display: block;"/>

4. Click <button>Next</Button>

5. Keep all the default options, click <button>Next</button>

## Starting the VM
- Double-click on the VM or press <button>Start</button>
<img src="/images/vbox/start.png" width="50%" style="margin-left: auto; margin-right: auto; display: block;"/>

## Logging In
- You will now be presented with a log-in screen like this:
<img src="/images/vbox/login1.png" width="60%" style="margin-left: auto; margin-right: auto; display: block;"/>

- Click on the "designer" user and you will see this:
<img src="/images/vbox/login2.png" width="60%" style="margin-left: auto; margin-right: auto; display: block;"/>

- Enter the password "processor" and hit <kbd>Enter</kbd>/<kbd>Return</kbd>

- You will now be presented with the Ubuntu homescreen
<img src="/images/vbox/login3.png" width="60%" style="margin-left: auto; margin-right: auto; display: block;"/>

## Homescreen
- You will see the home folder on the desktop

- On the dock, you will see:
  - Files
  - Firefox
  - VS Code
  - Terminal
  - Recycle Bin

## Exploring your VM
- Now you have a Linux VM to play around with

- You can do whatever you want with it
  - Since this is not a real computer, you do not have to
    worry about breaking it so play around
  - Worst case: Just re-install the VM
  - **Word of advice:** It's best to stay away from playing 
    with root, bad things can happen

- Although, it is reccomended that you change the password
  - You can do so through settings or by opening the terminal
    and typing:
  ```console
  passwd
  ```

- You can also go through the settings and customise it to
  your preferences - remember, it is now your virtual computer

- As always, it's recommended to open the terminal and run
  ```console
  sudo apt upgrade && sudo apt upgrade -y
  ```

- And then, 
  ```console
  sudo snap refresh
  ```

- This will get everything updated to the latest versions available

- You can close your VM by clicking on the close button, choosing 
  whether to keep the machine frozen in its current state or
  shut down completely; you can also use the power options in Ubuntu


[^lts]: LTS stands for Long Term Support
[^appliance]: The file contains everything you need to begin working,
hence the size.