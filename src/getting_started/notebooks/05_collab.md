# Working Collaboratively

---
## Purpose

Collaboration is an essential part of working in any team. Much of our work is 
shared and built upon each others’ contributions - whether it is the components 
themselves, editing documentation, or making improvements to this website. 

Additionally, as team members join the team with different 
areas of expertise, it is important to support one another in the learning and 
development process.

---

## Terminology
- `upstream`: The main repository owned by the organisation
- `origin`: Your fork of the repository

---

## Team Repositories

- Team members should have access to the [NYU Processor Design GitHub organization](https://GitHub.com/NYU-Processor-Design). 

- Throughout the project, you will need to work on the shared repos - for 
  example, adding a design notebook entry to [our website](https://GitHub.com/NYU-Processor-Design/nyu-processor-design.GitHub.io), or editing a component of the [AMBA](https://GitHub.com/NYU-Processor-Design/nyu-amba) or 
  [core](https://GitHub.com/NYU-Processor-Design/nyu-core). 

- To work efficiently, you want to fork the appropriate repo and make a branch 
  on your fork. 

- After making changes, create a pull request to merge your changes to the team’s
  repository by following [this guide](04_first_pr.md). 

- Once your changes have been merged, delete your branch and update your fork.

## Working on Forks

- When working on your fork of a active and constantly updating repository, 
  you want to avoid working directly on the main branch of your fork. 

- This keeps `main` clean to fast-forward[^ff] any changes from upstream. 

- If you work on `main`, merging changes from upstream will cause "merge" commits,
  making `upstream` and `origin` have different histories

- It also creates extra work for the maintainers because they have to clean 
  your fork before merging your changes.

- Working on `main` will also create messy pull requests with merge commits and 
  other commits that aren't associated with your work. 

- This 'pollution' makes it harder for git to incorporate changes from upstream
  and may cause merge conflicts, which will have to be fixed

- Before you start working, make sure to update your fork's main branch to 
  match the team's upstream repo. You can use the "Sync fork" button on GitHub 
or do this locally with the following commands:
  ```console
  git pull upstream main
  git push origin main
  ```

- Then, follow the [Your First Pull Request](04_first_pr.md) guide. 

---

## Fixing Fork Issues

After reading the previous section, you are now realizing your PRs and forked repo
are a little messy. Don't worry, you can clean up your main branch by following the
guide below and create a new, beautiful, PR.

### Guide

1. Create a branch from your current main branch so you don't lose any 
  changes.
   ```console
   git branch oldmain
   ```

1. Clean up your main branch by performing a hard reset from upstream's main. This
   will equalise upstream and origin - their histories will be the same. Anything
   not on upstream will be lost.
   ```console
   git fetch upstream
   git reset --hard upstream/main
   ```

2. Force-push your changes to origin
   ```console
   git push -f
   ```

1. Create a new branch for your changes/work (called `temp` below):
   ```console
   git switch -c temp
   ```

2. Then, cherry-pick your changes into your temporary branch:
   ```console
   git cherry-pick <commit>...
   ```
   - Where `<commit>...` will be the SHA's of the commits you want to bring over
   - For example, if you wanted to cherry-pick `1337abc`, `eb722ec`, `c00eba4`,
     your command will be:
     ```console
     git cherry-pick 1337abc eb722ec c00eba4
     ```
   - Don't worry - you're not expected to know cherry-picking or regularly use
     it.
   - For now, trust that this command will take your changes and store them on 
     your temporary branch. 
   - If you're interested, you can find out more about how/why this works 
     in the [Pro Git Book](https://git-scm.com/docs/git-cherry-pick).

1. ***Optionally***, if you have more than one commit, you can squash them into 
   one commit if you know how, but if not, the maintainers can squash and 
   merge your commits into the upstream repo.
   - The easiest way to squash commits is to perform an interactive rebase

After cleaning up your fork, you can now create a clean pull request from your
branch.

## Issues and Questions

- Nobody’s perfect, which means there may be errors and questions on component
  modules, git documentation, etc. 

- If you see a problem or have a question, ask the team and/or open a new issue 
  on GitHub using [these guidelines](https://github.com/NYU-Processor-Design/.github/blob/main/.github/CONTRIBUTING.md). 

- You should also use this contribution guide when submitting a design notebook 
  entry.

## Additional Support

- You are all talented and intelligent – that’s why you’re here – but team 
  members will join the VIP with different levels of experience and knowledge. P

- The best part of working collaboratively is learning from one another and  
  supporting each other. 
  
- If you see someone struggling or learning something new, offer your assistance
  in a helpful and respectful way.


---

[^ff]: [Fast-forwarding](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) is 
when git moves the head pointer forward to the tip of the target. You don't
have to actually "merge" the branches.

[^name]: We implore you to choose good branch names. Names like `temp`, `fix`, 
etc. are not descriptive. For example, if you're working on a UART, name your 
branch `uart`.