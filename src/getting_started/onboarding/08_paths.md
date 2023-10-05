# Week 7: Becoming a Processor Designer

---
<span style="font-family: 'Times New Roman'; font-size: 3em;">*"Procezzor"*</span>

<span style="font-family: 'Times New Roman'; font-size: 1em; align: right">
~ Someone, sometime, somewhere, probably.
</span>

---

By now, you should be quite comfortable with CMake, SystemVerilog, C++, and
general team operations and expectations. 

## The Time Has Come
Now, you must choose what you wish to work on for the semester. Your choices 
are outlined below.

### [Core](https://github.com/NYU-Processor-Design/nyu-core)
The heart of an SoC is the CPU Core. As part of the core team, you will work on 
the design and implementation of a CPU core capable of executing the 
[RISC-V-32I instruction set](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf). 

Many of the individual modules that make up the core have been [outlined](https://github.com/NYU-Processor-Design/nyu-core/tree/main/Documentation/Module-Docs) 
in detail for easier implementation so you can get started writing Verilog code 
right away. You can find out development and testing guidelines [here](https://github.com/NYU-Processor-Design/nyu-core/blob/main/Documentation/Dev-and-Test-Docs/dev-test-process.md).
We also have interfaces between modules that need to be built. More information 
can be found [here](https://github.com/orgs/NYU-Processor-Design/projects/4) on 
the issues pages of the modules in the needs to be interfaced section.

For those with more advanced skills and seeking a deeper level of involvement on
the core design itself, many of the modules that make up the core have yet to be 
fully outlined for implementation and we encourage you to take a shot at making 
those outlines yourself, a list of where exactly each module stands can be found 
[here](https://github.com/orgs/NYU-Processor-Design/projects/4).

Finally, for those with the requisite knowledge, skills, and passion, much of the
overall core design still needs to be finalized. This includes things like the 
caches, branch prediction, hazard detection, and more. Designing these components
and functions will require a strong background in computer architecture as
you'll need to be ready to validate and troubleshoot both, your designs and the 
designs of others. You can see the block diagram of the current core design on 
the [repository](https://github.com/NYU-Processor-Design/nyu-core), and you can 
find the functionality and design documentation for the more complex components 
[here](https://github.com/NYU-Processor-Design/nyu-core/tree/main/Documentation/Complex-Module-Functions).

### [Memory](https://github.com/NYU-Processor-Design/nyu-mem)
An SoC needs memory. As part of the memory team, you will work on the memory
simulator and integrating it with the bus. You will work closely with the AMBA
team whilst designing and implementing the memory manager since the memory 
manager is a subordinate on the AMBA high-performance bus.

Our SoC's memory is an experiment in using [OpenRAM](https://openram.org/),
an open-source RAM compiler. As part of the team, you will be expected to
become an _expert_ in OpenRAM and how it interacts with our chip.

As it stands, we have RAM and ROM generations scripts, but they need to be
thoroughly tested and deciphered. If you wish to work on memory, reach out 
to leadership since the team is currently defunct. 

### [AMBA](https://github.com/NYU-Processor-Design/nyu-amba)
AMBA is the interconnect architecture which connects various parts of the SoC
together. It is the vertebrae of the chip, connecting core to important 
subordinates like RAM and ROM, GPIO, UART, etc, and to each other, when 
needed.

An intriguing facet of working on AMBA is comprehending and translating ARM's
specification. Trivial concepts have been summarised for easy access but you 
will still be expected to read the spec sheets, propose and discuss component
designs with the team.

Additionally, our implementation is one of very few open-source AMBA 
implementations on the internet, which allows us a unique challenge of not 
having a reference. Everything you produce will be one of its kind and all of us
will learn and grow from that process.

But perhaps, AMBA's most interesting challenge includes translating _logic_ into
RTL. Everything AMBA does is easy to think about programmatically, but it is 
admittedly quite challenging to translate into SystemVerilog. Every day, the 
team learns novelties in SystemVerilog and our extended toolchain.

If working on AMBA speaks to you, read more about it [here](https://github.com/NYU-Processor-Design/nyu-amba).

<!-- 
### Simulator
Every processor needs it's own simulator for verification. 

### Software
What good is a processor without software that can run on it?

-->

### Onboarding/Documentation
A project of this magnitude needs thorough technical documentation for the sake
of future team members and strangers who wish to see our work. You will work
closely with other teams to document their work...

### Something Else Entirely
You can work on things that our team has never worked on before, such as, 
the simulator, or develop software for the chip to be. Alternatively, you could
be individualist and prefer not to work in a team - feel free to work on one of
the many peripherals we need. 

Whatever the case may be, if none of the above speaks to you, reach out to 
leadership to discuss next steps so we can equip you for success. 

## Overwhelmed by Choice
Don't worry if you're not quite sure what you'd like to work on. You can work
on as many teams as you wish to. Just don't spread yourself too thin. 

Take the week to explore how various teams operate, talk to the [Czars](../../vip_course_docs/membership.md/#czars),
and other team members. 

## After Deciding
Once you know what team(s) you wish to work on, inform the project manager, 
and check in with your Czar.

**Happy processor designing!**
