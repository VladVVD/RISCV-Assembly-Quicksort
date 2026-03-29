# RISC-V Assembly & Control Flow Analysis (Quicksort)

![C](https://img.shields.io/badge/Language-C-blue.svg)
![Assembly](https://img.shields.io/badge/Language-RISC--V_Assembly-orange.svg)
![Reverse Engineering](https://img.shields.io/badge/Concept-Reverse_Engineering-green.svg)

## Overview
This repository demonstrates low-level system programming, manual register allocation, and control-flow flattening. The project implements the **Quicksort algorithm** entirely in RISC-V (RV32I) Assembly, managing stack frames, recursive calls, and memory pointers manually.

## The Two-Step Translation Process

To ensure accuracy, this project was built using a structured "Compilation by Hand" approach:

### Phase 1: Transformed C (`qsort_transformed.c`)
Before writing Assembly, the standard C algorithm was transformed to mimic Assembly constraints:
* **Control Flow Flattening:** All `for` and `while` loops were broken down into conditional jumps (`if` + `goto`), exactly how branch instructions (`BGE`, `BEQ`, `JAL`) work in hardware.
* **Manual Register Allocation:** Global variables named after RISC-V registers (`a0`, `t1`, `s2`) were used to plan out variable lifetimes and avoid register spilling.

### Phase 2: Native RISC-V Assembly (`qsort.asm`)
The transformed C code was then translated 1:1 into RV32I Assembly. 
* Implements strict standard **Calling Conventions**.
* Manages the Call Stack (Prologue/Epilogue) manually to preserve Callee-saved registers (`s1`-`s8`) and the Return Address (`ra`) during recursive `qsort` calls.
