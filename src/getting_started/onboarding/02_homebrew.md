# Mac Homebrew Installation Guide
This guide will show you how to install the [Homebrew Package Manager](https://brew.sh/) on Mac and use it to install the required dependencies for the onboarding labs. 

# Installing Homebrew
Open Terminal and run the following command:

```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Next, it will ask you for your password and you should provide the password you use to unlock your Mac

```console
==>Checking for `sudo` access (which may request your password)...
Password:
```
The tool will then display a list of everything it will install and the directories it will create, before asking you to press RETURN/ENTER to continue or any other key to abort. Press RETURN/ENTER to continue the installation.
```console
Press RETURN/ENTER to continue or any other key to abort:

```

The tool with then start to install Homebrew and any needed Xcode dependencies. Please let the command run fully and do not close the terminal. It may appear at times to be stuck or frozen but it is simply downloading the files it needs. Many of these files such as the Xcode command line tools are rather large so expect the installation to take several minutes. 

You will know the installation is done when the following shows up on the Terminal:


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

You will then need to run the following three commands **one at a time** to fully set up Homebrew.

```console
echo '# Set PATH, MANPATH, etc., for Homebrew.' .. /Users/test/.zprofile
```

```console
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/test/.zprofile
```

```console
eval "$(/opt/homebrew/bin/brew/ shellenv)"
```

	

Congratulations! You have successfully installed Homebrew! If you want to explore more about Homebrew or run into any trouble visit the [official site](https://brew.sh/) for many more guides and explanations.

# Installing Dependencies

The method to install package with homebrew is via the command **brew install *packagenamehere***.

## Installing cmake

To install cmake, run the following command in the Terminal
```console
brew install cmake
```

## Installing verilator

To install verilator, run the following command in the Terminal
```console
brew install verilator
```

## Installing curl
To install curl, run the following command in the Terminal. (Note: this install may take a while)
```console
brew install curl
```


## Installing zip and unzip
To install zip and unzip, run the following commands **one at a time** in the Terminal
```console
brew install zip
```
```console
brew install unzip
```
## Installing tar
To install tar, run the following command in the Terminal. (Note: this install may take a while)
```console
brew install tar
```

## Installing git

To install git, run the following command in the Terminal
```console
brew install git
```

Then follow the [Getting Started With Git](https://nyu-processor-design.github.io/getting_started/notebooks/02_git.html) instructions to configure git.

