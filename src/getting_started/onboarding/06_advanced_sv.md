# Lab 5: Advanced System Verilog

---

## Important Note

This lab is currently incomplete as the Lab Week 5 Repo is currently incomplete and there is no exercise for this lab. You should read over the information provided in this lab and then move on to [Lab 7](https://nyu-processor-design.github.io/getting_started/onboarding/08_paths.html) for details on what to do next.

## Purpose

System Verilog is a large language, but we have almost covered all of
the _synthesizable_ elements (meaning, "stuff that can be turned into hardware")
already. Non-synthesizable parts of the language are used for design
verification. Since the **Processor Design Team** uses C++ for performing design
verification, we won't concern ourselves with the parts of System Verilog that
cannot be synthesized.

This lab is designed to cover most of the remaining elements of System Verilog
that are useful for our purposes. This will still consist of a substantial
amount of work, and is not expected to be completed in a single week.

Having completed this lab, you will be sufficiently prepared to contribute to
component design and implementation for the team.

---

## Setup

Fork the [Lab Week 5 repo](https://github.com/NYU-Processor-Design/onboarding-lab-5)
to your personal Github account. As with lab 4, a great deal of the toolchain
code has not yet been written. You are expected to write the necessary toolchain
code to implement any required modules and design verification tests. It may be
useful to review the instructions of [lab 4](05_verification2) if you need a
refresher on this.

---

## Data Types

You are familiar with the standard names `reg` and `wire`, and have some
intuition that these map onto concepts of "registers" and "buses" that represent
physical flip flops and copper interconnects between components respectively.

This understanding is misleading, or at least insufficient. There is no
requirement that a `reg` value be implemented as a physical register, and
similarly there is no guarantee that a `wire` does not involve intermediate
buffers or other timing elements. Because these names are misleading, in our
code from here on out we never use `reg` and rarely use `wire`.

Let's be formal for a moment, in the System Verilog specification there are two
main *kinds* of data objects: **nets** and **variables**. These two groups
differ in the way in which they are assigned and hold values.

**Nets** can be written by one or more continuous assignments, primitive
outputs, or modules ports. A net cannot be procedurally assigned.

**Variables** can be written by one or more procedural statements.
Alternatively, variables can be written by one continuous assignment or one
port.

A `wire` is a type of **net** and, in plain English, the advantage of a `wire`
is that is can be driven by multiple continuous assignments. When a `wire` has
multiple drivers, it is resolved to the value of the "strongest" driver.
Electrically speaking, this can be thought of as the input with the lowest
impedance. In digital design, we rarely have any reason to have multiple
continuous assignments to the same bus, and so we rarely have any reason to use
a `wire`.

A `reg` isn't even an object kind, it's technically a data type and one that
comes with tricky restrictions that we don't have time to explore here.

`logic` is also a data type, by default it is a variable, and it has the same
semantics as `reg`. `logic` does not run afoul of the same complications as
`reg` and so it's what we'll use.

**Further Reading:** This explanation leaves a lot to be desired, I've written
[a blog post](https://blog.vito.nyc/posts/sv-types/) that explores this in much
more depth than we have room for here. You're encouraged to give it a read.

The quick and fast rules are these:
* Use `logic` for single driver circuits (most things), `wire` for anything else

* Always declare port direction for each port

* Allow everything else in a port declaration to be implicit except if you need
  an output variable, then use `output logic`

## Other Net Kinds

System Verilog includes many more kind of nets, and even allows for
user-defined net kinds. These include kinds such as `tri`, `wand`, and `wor`.

The general rule for the **Processor Design Team** is this: Don't use any of
the other net kinds.

There may exist extremely rare instances it makes sense to violate this rule,
in which case the question should be raised and the exception noted in the
code.

## Interfaces and Modports

An `interface` can be thought of as a special type of module that bundles ports
and connections between ports together.

Consider the following modules:

```verilog
module Controller(
  // Inputs from top-level module
  input alpha,
  input beta,


  // Interface with a peripheral module
  input phi,

  output chi,
  output psi,
  output omega
);
  // Do stuff
endmodule
```

This module has two sets of ports. The first set is used to receive directions
from the top-level module, and the second set is used to communicate with
a peripheral module.

The peripheral module will have an inverse set of ports:

```verilog
module Peripheral(
  output phi,

  input chi,
  input psi,
  input omega
);
  // Do stuff
endmodule
```

The top-level module will have to do some work to connect the `Controller` to
the `Peripheral`. Something like the following:

```verilog
module TopLevel(
  input alpha,
  input beta
);

  logic phi, chi, psi, omega;

  Controller ctrl(alpha, beta, phi, chi, psi, omega);
  Peripheral prph(phi, chi, psi, omega);

  // Note: System Verilog has a couple shorthands called
  // "implicit named port connections" and "wildcard named
  // port connections" that we could use here. But those
  // are outside the scope of this example

endmodule;
```

This is less than ideal. We need to make sure we get all the ports in the
right order in the module instantiations, if we ever modify the interconnects
between the `Controller` and the `Peripheral` we will need to change the code
in many places, and sometimes such interconnects can contain dozens of `logic`s
which becomes a lot of code to write.

The answer is an `interface` consider the following:

```verilog
interface Com_if();

  logic phi, chi, psi, omega;

  modport ctrl(
    input phi,

    output chi,
    output psi,
    output omega
  );

  modport prph(
    output phi,

    input chi,
    input psi,
    input omega
  );

endinterface
```

Now we could modify our modules to use this new interface:

```verilog
module Controller(
  input alpha,
  input beta,

  Com_if.ctrl com
);

  // phi, chi, psi, and omega can now be accessed via
  // com.phi, com.chi, com.psi, and com.omega respectively

endmodule
```

Similarly with `Peripheral`:

```verilog
module Peripheral(
  Com_if.prph com
);
  // Do stuff
endmodule
```

And finally in the `TopLevel`, we can interconnect like so:

```verilog
module TopLevel(
  input alpha,
  input beta
);

  Com_if com();

  Controller ctrl(alpha, beta, com.ctrl);
  Peripheral prph(com.prph);
endmodule
```

Since `interface`s work just like modules, we can take this one step further
and move `alpha` and `beta` into the interface as well, but only expose them
to the `Controller` module:

```verilog
interface Com_if(
  input alpha,
  input beta
);

  logic phi, chi, psi, omega;

  modport ctrl(
    input alpha,
    input beta,

    input phi,

    output chi,
    output psi,
    output omega
  );

  modport prph(
    output phi,

    input chi,
    input psi,
    input omega
  );

endinterface
```

The `Controller`:


```verilog
module Controller(
  Com_if.ctrl com
);

  // alpha, beta, phi, chi, psi, and omega can now
  // be accessed via com.alpha, com.beta, com.phi,
  // com.chi, com.psi, and com.omega respectively

endmodule
```

`Peripheral` is unchanged, so the `TopLevel` now looks like this:

```verilog
module TopLevel(
  input alpha,
  input beta
);

  Com_if com(alpha, beta);

  Controller ctrl(com.ctrl);
  Peripheral prph(com.prph);
endmodule
```

An `interface` is itself a module, and thus can have all the styles of logic
implemented inside it as a normal module can. That said, this should be avoided.
It may be appropriate for simple continuous assignments to be performed inside
an interface, but in most cases an interface should consist only of `logic`
elements and `modports`.

## Parameterized Modules & Interfaces

We do not always know every way a module is going to be used, parameterization
allows us to defer some elements of a module's implementation until it is
instantiated. In this way, parameterized modules work similarly to C++
templates.

Consider the following ALU-type module:

```verilog
module ALU #(
  WordSize = 16
) (
  input clk,
  input logic [1:0] op,
  input logic [WordSize - 1:0] a,
  input logic [WordSize - 1:0] b,
  output logic [WordSize - 1:0] out
);

  always_ff @(negedge clk)
    case(op)
      0: out = a + b;
      1: out = a - b;
      2: out = a & b;
      3: out = a | b;
    endcase

endmodule
```

There is some unfamiliar syntax here, notably the `#()` element. This is a
parameter list. It precedes the port list and contains a variable named
`WordSize` which is given a default value of 16.

This will make our ALU module ports 16-bits wide if we instantiate it in the
normal way, for example:

```verilog
  // This will be a 16-bit ALU
  ALU alu(clk, op, a, b, out);
```

However, we don't have to use the default values. We can expand our ALU without
having to change the module code thanks to the `WordSize` parameter. The syntax
is the following:

```verilog
  // This will be a 32-bit ALU
  ALU #(32) alu(clk, op, a, b, out);
```

## Exercise
