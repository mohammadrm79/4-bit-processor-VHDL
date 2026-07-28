# Build Scripts

## Overview

The RISC-4 Educational CPU project includes a collection of Bash scripts and a GNU Makefile to automate common development tasks such as linting, assembling, simulation, testing, synthesis, and cleanup.

All scripts are located in the `scripts/` directory.

```text
scripts/
├── assembler.awk
├── assembler.sh
├── clean.sh
├── lint.sh
├── sim.sh
├── synth.sh
└── test.sh
```

---

# GNU Make

The project provides a Makefile to simplify common tasks.

## Available Targets

| Target | Description |
|---------|-------------|
| `make` | Runs the default target (`all`). |
| `make all` | Executes the project's default workflow. |
| `make lint` | Runs the VHDL lint checker. |
| `make asm` | Assembles all assembly programs. |
| `make sim` | Runs simulation. |
| `make test` | Executes the complete test suite. |
| `make synth` | Runs the synthesis flow. |
| `make clean` | Removes generated files. |

Example:

```bash
make
```

```bash
make test
```

```bash
make synth
```

---

# assembler.awk

## Purpose

Implements the RISC-4 assembler.

It translates assembly source files into machine code that can be loaded by the instruction memory.

The assembler supports:

- Labels
- Immediate instructions
- Three-register instructions
- Memory instructions
- Jump instructions
- Comments

Supported jump instructions:

- JMP
- JZ
- JC

---

# assembler.sh

## Purpose

Builds all assembly programs located under:

```text
tb/programs/asm/
```

and generates corresponding machine-code files under:

```text
tb/programs/bin/
```

## Usage

```bash
./scripts/assembler.sh
```

## Generated Files

```text
tb/programs/bin/*.mem
```

---

# lint.sh

## Purpose

Analyzes every VHDL source file using GHDL.

This script checks:

- Syntax errors
- Missing dependencies
- Package visibility
- VHDL analysis errors

## Usage

```bash
./scripts/lint.sh
```

## Generated Files

```text
build/logs/lint_*.log
```

---

# sim.sh

## Purpose

Compiles and runs the VHDL simulation.

Simulation uses the project's testbench and produces waveform files when enabled.

## Usage

```bash
./scripts/sim.sh
```

## Generated Files

Depending on the selected options:

```text
build/sim/
```

Possible outputs include:

- Executable simulation
- Waveform files
- Simulation logs

---

# test.sh

## Purpose

Runs the complete verification flow.

The script automatically performs:

1. VHDL lint
2. Assembly generation
3. Simulation
4. Output comparison
5. Test summary

## Usage

```bash
./scripts/test.sh
```

Example output:

```text
Passed : 17
Failed : 0
Errors : 0
Total  : 17
```

Generated files:

```text
build/test/
build/logs/
```

---

# synth.sh

## Purpose

Runs the synthesis flow using GHDL and Yosys.

The script performs:

1. VHDL analysis
2. Synthesis checking
3. Netlist generation
4. Verilog generation
5. Yosys optimization
6. Export of synthesis formats

## Usage

```bash
./scripts/synth.sh
```

Generated files are stored in:

```text
build/synth/
```

Typical outputs include:

```text
system_top.vhdl
system_top_raw.vhdl
system_top.v
system_top.dot

system_top_opt.v
system_top.json
system_top.rtlil
system_top.blif
system_top.edif
```

---

# clean.sh

## Purpose

Removes all generated build artifacts.

The source files and documentation are never modified.

## Usage

```bash
./scripts/clean.sh
```

The script removes generated files under:

```text
build/
```

including:

- Logs
- Simulation outputs
- Test outputs
- Synthesis outputs
- Temporary files

---

# Typical Development Workflow

A common development cycle is:

```text
Edit RTL
      │
      ▼
make lint
      │
      ▼
make test
      │
      ▼
Fix issues
      │
      ▼
make synth
```

---

# Directory Summary

| Directory | Description |
|----------|-------------|
| `scripts/` | Build automation scripts |
| `src/` | RTL source files |
| `tb/` | Testbench and assembly programs |
| `build/` | Generated files |
| `docs/` | Project documentation |

---

# Notes

- All scripts are written for Bash.
- The assembler is implemented in GNU AWK.
- Generated files are placed inside the `build/` directory whenever possible.
- The synthesis flow is based on GHDL and Yosys.
- The Makefile provides a convenient interface for all common development tasks.
