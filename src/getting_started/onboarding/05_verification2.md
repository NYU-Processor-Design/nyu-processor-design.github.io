# Week 4: Verification Toolchain

---

## Purpose

This lab will be a walkthrough of the toolchain elements of verification. This
will build on the toolchain lessons establish in [Lab 1](02_cmake.md) and cover
much of the material that was glossed over in [Lab 3](04_verification.md).

Some of the ideas that will be covered include: creating libraries of System
Verilog modules, adding dependencies to a project, and using a testing
framework.

---

## Background

Oftentimes when building either software or hardware, we want to integrate
third-party components and libraries, code written by other people. To do this
we use a tool called a **package manager**. In the **Process Design Team**, the
package manager we use is called [vcpkg](https://vcpkg.io/). While `vcpkg` is
nominally a package manager for C/C++ projects, it's suitable to be used with
any collection of files including with our System Verilog projects.

One of the dependencies we'll be interested in for the purposes of verification
will be a test framework. A test framework provides utilities for running and
logging information about our design verification tests. Since correctness is
very important to hardware development, these utilities will come in handy. The
**Process Design Team** uses a test framework called
[catch2](https://github.com/catchorg/Catch2) for its design verification.

---

## Setup

Fork the [Lab Week 4 repo](https://github.com/NYU-Processor-Design/onboarding-lab-4)
to your personal Github account. This repo features the
same modules as [Lab 3](04_verification.md), but you will be converting your
tests to use the catch2 framework. In addition, much of the toolchain code is
not yet written. We will need to add it ourselves.

## Registries

A **registry** is a collection of information about **packages**, where packages
are the source code files (System Verilog, C++, or even cmake files) that we wish
to use in our project. We keep track of the registries we're using in a given
project with the `vcpkg-configuration.json` file.

If you look at the `vcpkg-configuration.json` file in the Lab 4 repo, you will
find something that looks like the following:

```
{
  "default-registry": {
    "kind": "git",
    "baseline": "b4f29c54450ddfc7efd2989cb9d32158ae291b40",
    "repository": "https://github.com/microsoft/vcpkg.git"
  },
  "registries": []
}
```

This is a registry listing, a json file that tells `vcpkg` where to look for
packages. In this case, the only registry listed is the `default-registry`,
which is where `vcpkg` will search if a requested package is not listed for
any other registry. Here the `default-registry` is pointed at a git repo managed by Microsoft, which has many useful packages in it. The `registries` list, which
would contain all other registries we wish to use, is empty.

We will need to add a registry to the registry list. The required fields for a
registry are:

* `kind`: What type of registry is this? For our purposes this will always be a
git repository, so you can always put `"git"` here

* `baseline`: the git hash to pull from. We'll cover where to get this in a
moment

* `repository`: a link to the git repository

* `packages`: a list of packages you would like this registry to be responsible
for

The Processor Design package registry is located at:

[https://github.com/NYU-Processor-Design/nyu-registry](https://github.com/NYU-Processor-Design/nyu-registry)

To add that registry to the registries list, the entry should look like this:

```
  "registries": [
    {
      "kind": "git",
      "baseline": "",
      "repository": "https://github.com/NYU-Processor-Design/nyu-registry.git",
      "packages": [
        "nyu-*"
      ]
    }
  ]
```

This is incomplete, we still need to add a baseline. In order to get the
necessary hash, go the registry repo page and click on "commits".

<img src="/images/labs/commits.png" width="50%" style="margin-left: auto; margin-right: auto; display: block;" />

Then, on the commits page, click on the double square icon to copy the full hash
to your clipboard. You can then paste this into the baseline field.

<img src="/images/labs/hash.png" width="75%" style="margin-left: auto; margin-right: auto; display: block;" />

We briefly note that the packages field contains the string `"nyu-*"`, this
tells `vcpkg` that this registry will provide every package that begins with
"nyu-".

## Dependencies

Now take a look at `vcpkg.json`, this file describes our project. It should
look something like this:

```
{
  "name": "week-four-lab",
  "version": "1.0.0",
  "description": "Template for week four lab",
  "homepage": "https://github.com/NYU-Processor-Design/onboarding-lab-4",
  "maintainers": [
    "Vito Gamberini <vito@gamberini.email>"
  ],
  "license": "CC0-1.0",
  "dependencies": []
}
```

The most important field to note is the `dependencies` list, it's empty. Here is
where we'll list the packages we need `vcpkg` to fetch for us.

The packages we'll need for this lab are:

* `nyu-cmake`: Utility functions for `cmake`. These functions make working with
  System Verilog more convenient

* `catch2`: The catch2 test framework mentioned above

Add these as a list of strings to the `dependencies` field of `vcpkg.json`. The
order you list them does not matter.

## Libraries and Packages

Once a package has been listed as a dependency, `vcpkg` will fetch it for us
when we run `cmake` to generate our build files. We need to let `cmake` know
about these packages in order to be able to integrate them, and the command
to do this is called `find_package()`.

The first package we're going to need is `nyu-cmake`, so in the CML add the
following line of code after the `project()` command:

```cmake
find_package(nyu-cmake CONFIG REQUIRED)
```

`find_package()` takes three arguments here:

* `nyu-cmake`: this is the name of the package we want `cmake` to find

* `CONFIG`: this flag changes the search behavior `cmake` uses to find the
  package. If you're curious to learn more, you can read about this in
  [the official cmake documentation](https://cmake.org/cmake/help/latest/command/find_package.html#config-mode-search-procedure),
  but it's not vital to understand

* `REQUIRED`: this flag tells `cmake` to throw a build error if it cannot find
  the requested package

Next we need to create a library. This works just like creating an executable
from Lab 1, except the command is `add_library()` instead of `add_executable()`.

We're actually going to create a special kind of library called an ***interface
library***. This differs slightly from a "normal" library because an interface
library can consist of code and files that aren't compiled immediately.

Our System Verilog files cannot be compiled directly, so they're a good fit for
this style of library. To create our System Verilog library, add the following
line to the CML:

```cmake
add_library(lab4 INTERFACE)
```

## Subdirectories and `nyu_` Commands

In the same way that we split up source code into multiple files to keep it
organized, we often split CMLs into multiple files for the same reason.

One way to do this is the `add_subdirectory` command, which will search a
subdirectory for a CML and then run that CML. First, create a CML inside the
`rtl` folder of the repo, then add the following line to our original CML after
the `add_library()` command:

```cmake
add_subdirectory(rtl)
```

Now we can add code to the `rtl/CMakeLists.txt` file, and it will be run by
`cmake` when it reaches the `add_subdirectory()` command.

One of the important commands that the `nyu-cmake` package gives us is
`nyu_add_sv()`, which lets us associate System Verilog files with a library (or
any other `cmake` "target").

In the `rtl` CML file, add the following lines:

```
nyu_add_sv(lab4
  Exercise1.sv Exercise2.sv Exercise3.sv Exercise4.sv
  Mysteries/Mystery1.sv Mysteries/Mystery2.sv
)
```

Note that the first argument is the target we wish to associate the files with,
followed by said files. Also note that the paths are relative to the CML file
the command is written in.

## Conditional Statements and Enabling Testing

It's not always appropriate to build simulators. Sometimes people will want to
integrate our modules into their own code, and reassured that we have thoroughly
tested the modules ourselves, do not need to spend the time and CPU cycles
building and running the tests themselves.

To support this style of usage we will check a variable, in the case of the
**Processor Design Team** this variable will always be named `NYU_BUILD_TESTS`.

The usage of the conditional then looks like this:

```cmake
if(NYU_BUILD_TESTS)
  # Conditionally run commands go here
endif()
```

The exact semantics of a `cmake` conditional are a little bizarre and not
something we're going to worry about too much. If you're interested in all the
things that are considered "true" or "false" by `cmake`, you can read more about
it [in the official docs](https://cmake.org/cmake/help/latest/command/if.html#basic-expressions).

We're going to write our testing commands inside the `dv` directory (`dv`
stands for _**d**esign **v**erification_), so add a CML to the `dv` directory.

Inside the top level CML ("top level" means the original CML, in the root
directory of the repository), add a conditional that checks `NYU_BUILD_TEST` and
inside that conditional add the following lines:

```cmake
  enable_testing()
  add_subdirectory(dv)
```

The `add_subdirectory()` command should now be familiar. The `enable_testing()`
command tells `cmake` that we want it to generate files necessary to
automatically run tests for us.

When running `cmake`, we'll need to turn this conditional on. To set the
`NYU_BUILD_TESTS` variable when running `cmake`, we'll use the following command
(assuming we're running `cmake` from inside a build directory):

```
cmake -DNYU_BUILD_TESTS=TRUE ..
```

## The Test Executable

Inside the `dv` CML, we're going to need to grab our test framework package with
the following line of code:

```cmake
find_package(Catch2 3 REQUIRED CONFIG)
```

You might notice that this `find_package()` has an additional argument, `3`,
this is a major version number. We're telling `find_package()` we need at least
version 3 of the Catch2 package.

Now we can create an executable file that consists of our tests. To do this,
use the `add_executable()` command to create an executable named `tests` and
the `target_sources()` command to add all the `.cpp` files in the `dv` directory
as sources.

We also need to associate the `lab4` System Verilog library to our executable.
We do this with the following command from the `nyu-util` package:

```cmake
nyu_link_sv(tests PRIVATE lab4)
```

This takes all the System Verilog files we associated with the `lab4` library,
and also associates them with our `tests` executable. But we still need to tell
`cmake` what to do with these files.

To transform a System Verilog file into a _model_, like the ones in Lab2 and
Lab3, we need to tell the `verilator` tool which modules we would like to be
exposed for simulation. These exposed modules are called ***top modules***, and
we'll need to tell `cmake` and `verilator` about them explicitly.

In these labs, the `Exercise1`, `Exercise2`, `Exercise3` and `Exercise4` modules
are our top modules, while the `Mystery1` and `Mystery2` modules are only used
internally and don't need to be available for testing on their own.

The command to invoke `verilator` and choose top modules is the following:

```cmake
nyu_target_verilate(tests
  TOP_MODULES Exercise1 Exercise2 Exercise3 Exercise4
)
```

Because of limitations in `cmake` and `verilator`, the `nyu_target_verilate()`
command should always come _after_ all `nyu_add_sv()` and `nyu_link_sv()`
commands.

Finally, we also need to associate Catch2 with our `tests` executable and tell
Catch2 we would like it to handle generating tests for us. We do that with
the following command:

```cmake
target_link_libraries(tests PRIVATE Catch2::Catch2WithMain)
```

This is sort of like `nyu_link_sv()` above, but it's linking a C++ library
instead of verilog source code.

The absolute final thing is we need to tell Catch2 about our tests we would like
it to run. This is an automatic process, and we're not going to worry too much
about how it works or the exact semantics, the commands are:

```cmake
include(Catch)
catch_discover_tests(tests)
```

If you're curious, you can learn more about Catch2's cmake-integration from
[the official docs](https://github.com/catchorg/Catch2/blob/devel/docs/cmake-integration.md#automatic-test-registration).

## Adapting the Test Cases

Previously your test cases probably looked something like this:

```cpp
int main() {
  VExercise1 model;

  // Setup some inputs
  model.eval();

  int expected;
  // Calculate the expected value

  if(model.out != expected)
    return 1;
}
```

When writing test cases with Catch2, our code will look like this:

```cpp
TEST_CASE("Exercise 1") {
  VExercise1 model;

  // Setup some inputs
  model.eval();

  int expected;
  // Calculate the expected value

  REQUIRE(model.out == expected);
}
```

To adapt your current code to Catch2, you should only need the `REQUIRE()`
macro, but Catch2 has many other useful structures as well that you can explore
[in its docs](https://github.com/catchorg/Catch2/blob/devel/docs/Readme.md).

To complete the lab, adapt all of your test cases to the Catch2 model and run
it using the same procedure used for the previous two labs.

## Review

***Answer the Following:***
* What is a registry?

* What is a package?

* What's the difference between an interface library and a "normal" library or
executable? Can you think of any uses for this besides System Verilog files?
(Think about source code used for generic programming)

* What is a top module?
