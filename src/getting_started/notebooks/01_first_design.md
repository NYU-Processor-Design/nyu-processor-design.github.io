# Your First Design Notebook

---

## Purpose

The design notebook is the mechanism used by the team and the VIP program to
demonstrate student involvement with the program. As a practical matter, the
design notebook serves as an index for an _individual's_ contributions to the
team. Instead of searching through repositories, code, issues, and discussions
to find and evaluate what you have done, the design notebook serves as a single
point of reference to those materials.

For the **Processor Design Team**, your design notebook is expected to be
principally outbound links to pull requests, repository snapshots, and possibly
individual commits, combined with a short (one sentence) contextual explanation
of what the linked work is. This is an engineering team and the expectation is
that your work is mostly functional, not hypotheticals or explorations of
theory. Typical VIP notebook items, such as resources or "task completion"
should be implicit in the linked materials.

## Format

This website represents the expected format of design notebooks for the
**Processor Design Team**. Every page on this site is built using
[Markdown](https://commonmark.org/help/) files, a plaintext markup language
format for quickly producing reasonably formatted HTML documents.

Each VIP student is expected to create a file named `netid.md` under the
`design_notebooks/semester` folder of this repository. Where `netid` is the
student's NYU NetID (for example, `nvg7278.md`), and `semester` is the semester
they are enrolled for (for example, `design_notebooks/2023spring`).

Each week, students are expected to make a pull request against this repository
to update their design notebook file for the semester.

## Content

A typical entry in your design notebook should be a list of items that represent
work that was done that week. This list might be longer or shorter depending on
the magnitude of each item in the list. If you've completed an onboarding lab,
a single link to the completed lab repository might be the only item for that
week. If you did a little work across project repositories, you might have three
or four items linking to PRs, commits, and issue discussions.

Additionally, an entry should have a one or two paragraph personal narrative
that contextualizes the work done that week and adds details that can't be known
just from inspection of the linked work. This could be struggles, false starts,
or perhaps just the impetus for the work.

## Example

```markdown
## Week of 10 October 2022

Project Work:
  * [Onboarding Lab 5](link/to/repo): Completed Lab 5, worked with Jerry and
    Rishyak

  * [Doc Workflow Update](link/to/pull_request): Updated the documentation
    workflow, docs are now generated in ~5 seconds instead of 3-4 minutes

This week was mostly spent on lab 5 from the onboarding series. I worked in
close collaboration with Jerry and Rishyak to complete a suite of system
verilog modules that interoperated to solve the lab objectives.

We struggled with the lab's description "interfaces" and what their
applications were. After a discussion with Prof. Epstein, we gained a better
idea of how to apply interfaces to collect related signals together when
connecting components in a top level module. However, our solution to the
lab doesn't make extensive use of interfaces right now.
```
