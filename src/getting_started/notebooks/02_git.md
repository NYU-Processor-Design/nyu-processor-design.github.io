# Getting Started With Git

---

## Purpose

`git` is a tool for tracking changes to a set of files, collectively called a
"repository" or "repo" for short. The importance of `git` is in its distributed
nature. `git` makes it possible for members of a team to clone a repository,
work on the set of files individually, and then re-integrate those individual
changes into a cohesive whole.

For collaborative projects like the **Processor Design Team**, these functions
are fundamental to the work we do. Thus, your ability to use `git` is vital to
participating with the team. With that in mind, you will need to use `git`
to submit your first (and all future) design notebook entry.

## `git` and GitHub

We need to take a moment to discuss the difference between the tool, `git` and
the website **GitHub**. `git` is a program that runs on your computer and allows
you to track, manage, diverge, and integrate changes to a repository of files.
**GitHub** is website and web service that understands the protocols and storage
conventions used by the `git` program.

The advantage of **GitHub** is it allows users to easily setup and manage
_remote_ repositories. A _remote_ repo is a simply a repository that does not
exist on your computer, instead the set of tracked files exist on a server,
just another computer somewhere on the internet.

Because this repo exists on a continuously hosted internet server, many people
can get access to the repo and clone the files. Using **Github** we can also
easily manage who has permission to make changes to the remote repo. If we were
hosting our own server we would have to manually create accounts and setup
permissions for each person who wanted to access and modify our remote repo.

This is not an idea exclusive to **Github**. Many different web services are
built around `git` and allow users to easily create and manage remote repos.
**Github** is one of the most popular of these services, and it is the one
used by the **Processor Design Team** which is why it is discussed here.

**Github** also provides many other services that are unrelated to `git` the
program. Issue tracking, team management, file browsing, and most notably a
formal pull request mechanism are all features of **Github** the service, not
`git` the program.

## Creating a Github Account

For the purposes of your design notebook, the first step is going to be
[creating an account on Github](https://github.com/signup). If you already have
a Github account, there is no need to create a new one exclusively for the
team.

## Setting up SSH Access

`ssh` stands for "**s**ecure **sh**ell" and is a encrypted communication
protocol for logging into and communicating with servers. `git` does not
inherently have a mechanism to communicate with remote repositories, instead it
piggy-backs on existing protocols such as `https` and `ssh`. For security
purposes, **Github** restricts many operations to the `ssh` protocol.

`ssh` is built upon the principles of public-key cryptography. What this means
for users is you must generate and store a public/private key pair for use with
the protocol. There is no single way to do this step depending on your
development environment. What follows is a description of how to generate this
key pair and use it with the **Anubis** ProcDesign IDE environment, but
**Github** [provides excellent instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh)
for how to work through this process on a variety of platforms.

The first thing to do is generate a public/private key pair, you can do this with
the following command:

```
ssh-keygen -t ed25519 -C "your.email@nyu.edu"
```

The generator will ask the following questions:

```
Enter file in which to save the key (/home/anubis/.ssh/id_ed25519):
```

Hit enter, as we want to use the default location for this file

The next question will be:

```
Enter passphrase (empty for no passphrase):
```

If you enter a passphrase, you will be required to enter it prior to performing
most ssh operations. It's fine to leave this blank.

Now we need to let various operating system components know about your new keys,
so that `git` will be able to find them later. The way to do this is by using
a command called `ssh-add`. Unfortunately, `ssh-add` doesn't have enough
information to do its job by default. So we need to run a command to retrieve
this information and add it to the local environment. If those words don't mean
anything to you, don't worry, just run this command:

```
eval "$(ssh-agent -s)"
```

Finally we can add our new ssh keys with the command:

```
ssh-add ~/.ssh/id_ed25519
```

The last step is adding your SSH keys to Github, for which you should follow the
[public Github documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).
