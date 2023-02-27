# Working Collaboratively

---
## Purpose

Collaboration is an essential part of working in any team. Much of our work is shared and built upon each others’ contributions - whether it is the components themselves, editing documentation, or making improvements to the **Processor Design Team** website. Additionally, as team members join the team with different areas of expertise, it is important to support one another in the learning and development process.

## Team Repositories

Team members should have access to the [NYU Processor Design Github organization](https://github.com/NYU-Processor-Design) and its repos. Throughout the project, you will need to add to or change the shared repos - for example, adding a design notebook entry to [this website](https://github.com/NYU-Processor-Design/nyu-processor-design.github.io) or editing a component of the [AMBA] (https://github.com/NYU-Processor-Design/nyu-amba). To edit efficiently, fork the appropriate repo and make a temporary branch of your fork. After making changes, create a pull request to merge your changes to the team’s upstream repository by following [this guide](https://nyu-processor-design.github.io/getting_started/notebooks/04_first_pr.html). Creating a temporary branch ensures that you won’t be pushing extra/irrelevant changes to the team repo, such as syncing your fork from the upstream.

## Working on Forks

When working on your fork of a repo, you want to avoid working directly on the main branch of your fork, then pushing your commits to the upstream repo from the main branch itself. This can cause messy pull requests that include merge commits and other commits that aren't associated with your work. This 'pollution' makes it harder for git to incorporate changes from upstream and may cause merge conflicts. Ideally, all PRs should come from separate branches (single-commit PRs are the best).

Before you start working, make sure to update your fork's main branch to match the team's upstream repo. You can use the 'Sync Fork' button on GitHub or do this locally with the following commands:

```
git pull upstream main
git push origin main
```

Then, make a new temporary branch (you can call it anything you want, we called it `temp` here). You can do this on GitHub or using the command below:

```
git switch -c temp
```

This creates a new branch, then switches to that branch. You can also do this in two steps:

```
git branch temp
git switch temp
```
Now, you can make and commit your changes to the temporary branch. Your PR should take the changes from your temporary branch to the upstream repo. After your changes are merged to upstream, you can delete your temporary branch:

```
git switch main
git branch -D temp
```
You can't delete a branch you're currently working on, so remember to switch to your main branch before deleting the temporary one.

`-d` is delete and `-D` is force delete. You want to force delete the `temp` branch because git doesn't want you to try deleting a branch that hasn't been merged anywhere.

Repeat this process for each change/addition/PR you make to avoid convoluted PRs.

## Fixing Fork Issues

After reading the previous section, you're now realizing your PRs and forked repo are a little messy. Don't worry, you can clean up your main branch and create a new, single-commit PR.

First, create a branch from your current main branch so you don't lose any changes.

```
git branch oldmain
```
Clean up your main branch by merging any changes from the upstream repo and resetting your fork.
```
git fetch upstream
git reset --hard upstream/main
```
Force-push your changes to your remote version of the repo:
```
git push -f
```
Create a new branch for your changes/work (called `temp` below):
```
git switch -c temp
```
Then, cherry-pick your changes and put them into your temporary branch:
```
git cherry-pick "44026dc^..1a5494c"
```
Don't worry - you're not expected to know cherry-picking or regularly use it. For now, trust that this command will take your changes and store them on your temporary PR branch. If you're interested, you can find out more about how/why this works in the Pro Git Book.

If you have more than one commit, you can squash them into one single-commit if you know how, but if not, team leaders can squash and merge your commits into the upstream repo.

After cleaning up your fork, you can now create an efficient, clean pull request from the temporary branch.

## Issues and Questions

Nobody’s perfect, which means there may be errors and questions on component modules, git documentation, et cetera. If you see a problem or have a question, ask the team and/or open a new issue on GitHub using [these guidelines](https://github.com/NYU-Processor-Design/.github/blob/main/.github/CONTRIBUTING.md). You can also use this contribution guide when submitting a design notebook entry.

## Additional Support

You are all talented and intelligent – that’s why you’re here – but team members will join the VIP with different levels of experience and knowledge. Part of working collaboratively is learning from one another and supporting each other. If you see someone struggling or learning something new, offer your assistance in a helpful and respectful way.
