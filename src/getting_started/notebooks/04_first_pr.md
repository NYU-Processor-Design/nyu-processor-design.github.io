# Your First Pull Request

---

## Purpose

The pull request is a mechanism for integrating changes between two copies of
the same repository. It is not an inherent process builtin to `git`, but rather
a formal or informal process built on top of `git`. In this section we'll
briefly exam the usage of the *GitHub* pull request system.

## Fork the Repo

A pull request is a request to incorporate changes made on one copy of a repo,
into another copy of the same repo. So to start we will need to make a copy
to perform changes on. In the case of the design notebooks, the repo to fork
is [the one that contains the site you're reading right now](https://github.com/NYU-Processor-Design/nyu-processor-design.github.io).

To create a fork, you need only click the fork button at the top right of the page:

<img src="/images/git/fork.png" width="50%" style="margin-left: auto; margin-right: auto; display: block;" />

We can now clone the fork as usual.

## Branching

Before we start making changes, we probably want to _branch_ the repo. This way
we don't mess with the commit history of the "main" branch, so it will be
easy to incorporate changes that happen in the main repo we forked from.

To create a branch we can use the following command:

```
git branch -c branch_name
```

Then to switch to the branch we can use:

```
git checkout branch_name
```

These two operations are so common, that there is a shortcut to do them in a
single command:

```
git checkout -b branch_name
```

The same behavior can be found in GitLens by right clicking on a branch you
would like to branch from:

<img src="/images/git/branch.png" width="50%" style="margin-left: auto; margin-right: auto; display: block;" />

## Publishing Changes

After you have added your commits to the branch, you can publish the results to
Github with the following commands:

```
git push [remote_name] [branch_name]
```

This is equivalent to the GitLens "Publish Branch" button:

<img src="/images/git/publish.png" width="50%" style="margin-left: auto; margin-right: auto; display: block;" />
