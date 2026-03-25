# =============================================================================
# NOTE: This file contains only the core sorting algorithms (swap, partition, qsort).
# Initialization, I/O, and main routines are intentionally omitted.
# Architecture: RISC-V (RV32I)
# =============================================================================

###############################################################################
# Function: void swap(int* x, int* y)
#
# Swaps the elements
#
###############################################################################
swap:
  LW t0, 0(a0)
  LW t1, 0(a1)
  SW t1, 0(a0)
  SW t0, 0(a1)
  JALR zero, 0(ra)

###############################################################################
# Function: int partition(int* A, int l, int r)
#
# Take an array (or part of it) and reorder 
# its elements relative to a chosen pivot
#
###############################################################################
partition:
  ADDI sp, sp, -24
  SW ra, 20(sp)
  SW s1, 16(sp)
  SW s2, 12(sp)
  SW s3, 8(sp)
  SW s4, 4(sp)
  SW s5, 0(sp)

  ADDI s1, a0, 0
  ADDI s4, a2, 0
  ADDI t6, zero, 2
  SLL t0, s4, t6
  ADD t0, s1, t0
  LW s5, 0(t0)
  ADDI s2, a1, -1
  ADDI s3, a1, 0

.part_loop_begin:
  BEQ s3, s4, .part_input_loop
  ADDI t6, zero, 2
  SLL t1, s3, t6
  ADD t1, s1, t1
  LW t3, 0(t1)
  BGE t3, s5, .part_continue_read
  ADDI s2, s2, 1
  ADDI t6, zero, 2
  SLL t2, s2, t6
  ADD t2, s1, t2
  ADDI a0, t2, 0
  ADDI a1, t1, 0
  JAL  ra, swap

.part_continue_read:
  ADDI s3, s3, 1
  JAL zero, .part_loop_begin

.part_input_loop:
  ADDI s2, s2, 1
  ADDI t6, zero, 2
  SLL t2, s2, t6
  ADD t2, s1, t2
  ADDI a0, t2, 0
  ADDI t6, zero, 2
  SLL t0, s4, t6
  ADD t0, s1, t0
  ADDI a1, t0, 0
  JAL ra, swap
  ADDI a0, s2, 0

  LW   ra, 20(sp)
  LW   s1, 16(sp)
  LW   s2, 12(sp)
  LW   s3, 8(sp)
  LW   s4, 4(sp)
  LW   s5, 0(sp)
  ADDI sp, sp, 24
  JALR zero, 0(ra) 

###############################################################################
# Function: void qsort(int* A, int l, int r)
#
# Quicksort selects an element as pivot and partitions
# the other elements into two sub-arrays
# The sub-arrays are then sorted recursively
#
###############################################################################
qsort:
  ADDI sp, sp, -20
  SW ra, 16(sp)
  SW s4, 12(sp)
  SW s6, 8(sp)
  SW s7, 4(sp)
  SW s8, 0(sp)

  ADDI s6, a0, 0
  ADDI s7, a1, 0
  ADDI s8, a2, 0

  BGE s7, s8, .end_qsort
  ADDI a0, s6, 0
  ADDI a1, s7, 0
  ADDI a2, s8, 0
  JAL ra, partition
  ADDI s4, a0, 0

  ADDI a0, s6, 0
  ADDI a1, s7, 0
  ADDI a2, s4, -1
  JAL ra, qsort

  ADDI a0, s6, 0
  ADDI a1, s4, 1
  ADDI a2, s8, 0
  JAL ra, qsort

.end_qsort:
  LW   ra, 16(sp)
  LW   s4, 12(sp)
  LW   s6, 8(sp)
  LW   s7, 4(sp)
  LW   s8, 0(sp)
  ADDI sp, sp, 20
  JALR zero, 0(ra)
