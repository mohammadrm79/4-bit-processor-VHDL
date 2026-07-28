# Requirements

## Overview

This document lists the software required to build, simulate, test, and synthesize the RISC-4 Educational CPU.

---

## Operating System

The project is primarily developed and tested on:

- Ubuntu 24.04 LTS
- Windows 11 with WSL2 (Ubuntu)

Other Linux distributions should work with equivalent package versions.

---

## Required Software

### Bash

The build and automation scripts are written in Bash.

Recommended version:

- Bash 5.x or newer

---

### GNU Make

Used to automate common development tasks.

Recommended version:

- GNU Make 4.x or newer

---

### GNU Awk (gawk)

Used by the assembler implementation.

Recommended version:

- GNU Awk 5.x or newer

---

### GHDL

Used for:

- VHDL analysis
- Elaboration
- Simulation
- Netlist generation

Recommended version:

- GHDL 5.x (LLVM backend)

---

### Yosys

Used for RTL optimization and netlist generation.

Recommended version:

- Yosys 0.52 or newer

---

### GTKWave

Used to inspect simulation waveforms.

Recommended version:

- GTKWave 3.x

---

### Graphviz

Used to generate hardware graphs during synthesis.

Recommended version:

- Graphviz 2.x or newer

---

## Installation (Ubuntu)

```bash
sudo apt update

sudo apt install \
    bash \
    make \
    gawk \
    graphviz \
    gtkwave \
    yosys \
    ghdl
```

---

## Verify Installation

```bash
bash --version
make --version
gawk --version
ghdl --version
yosys --version
gtkwave --version
dot -V
```

---

## Project Directory

After cloning the repository:

```text
scripts/    Build and automation scripts
src/        RTL source files
tb/         Testbench and assembly programs
build/      Generated files
docs/       Documentation
```

---

## Notes

- VHDL-2008 support is required.
- GNU Awk is required; other AWK implementations are not officially supported.
- The synthesis flow uses GHDL together with Yosys.
- Generated files are written to the `build/` directory.