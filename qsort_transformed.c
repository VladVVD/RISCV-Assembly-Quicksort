#include <stdio.h>

/* * NOTE: This file contains only the core sorting logic. 
 * I/O and main execution routines have been omitted.
 */

//-----------------------------------------------------------------------------
// RISC-V Register mapping simulation
size_t a0, a1, a2, a3, a4, a5, a6, a7;  // function arguments / return values
size_t t0, t1, t2, t3, t4, t5, t6;  // temporary registers
size_t s1, s2, s3, s4, s5, s6, s7, s8; // callee-saved registers
//-----------------------------------------------------------------------------

void swap() // void swap(int* x, int* y)
{
    t0 = *(int*)a0;
    t1 = *(int*)a1;
    *(int*)a0 = t1;
    *(int*)a1 = t0;
    return;
}

int partition() // int partition(int* A, int l, int r)
{
    size_t save_s1 = s1;
    size_t save_s2 = s2;
    size_t save_s3 = s3;
    size_t save_s4 = s4;
    size_t save_s5 = s5;

    s1 = a0; // s1 = A
    s4 = a2; // s4 = r
    t6 = 2;
    t0 = s4 << t6;
    t0 = s1 + t0; // t0 = A[r]
    s5 = *(int*)t0; // s5 = pivot
    s2 = a1 - 1; // s2 = i
    s3 = a1; // s3 = j

part_loop_begin:
    if(s3 == s4) goto part_input_loop;
    t6 = 2;
    t1 = s3 << t6;
    t1 = s1 + t1;
    t3 = *(int*)t1; // a1 = A[j]
    if((int)t3 >= (int)s5) goto part_continue_read;

    s2 = s2 + 1;
    t6 = 2;
    t2 = s2 << t6;
    t2 = s1 + t2;
    a0 = t2; // &A[i]
    a1 = t1; // &A[j]
    swap();

part_continue_read:
    s3 = s3 + 1;
    goto part_loop_begin;

part_input_loop:
    s2 = s2 + 1;
    t6 = 2;
    t2 = s2 << t6;
    t2 = s1 + t2;
    a0 = t2; // &A[i]
    t6 = 2;
    t0 = s4 << t6;
    t0 = s1 + t0;
    a1 = t0; // &A[r]
    swap();
    a0 = s2;

    s1 = save_s1;
    s2 = save_s2;
    s3 = save_s3;
    s4 = save_s4;
    s5 = save_s5;
    return a0;
}

void qsort() // void qsort(int* A, int l, int r)
{
    size_t save_s4 = s4;
    size_t save_s6 = s6;
    size_t save_s7 = s7;
    size_t save_s8 = s8;

    s6 = a0;
    s7 = a1;
    s8 = a2;

    if ((int)s7 >= (int)s8) goto end_qsort;

    a0 = s6;
    a1 = s7;
    a2 = s8;
    a0 = partition();
    s4 = a0;

    a0 = s6;
    a1 = s7;
    a2 = s4 - 1;
    qsort();

    a0 = s6;
    a1 = s4 + 1;
    a2 = s8;
    qsort();

end_qsort:
    s4 = save_s4;
    s6 = save_s6;
    s7 = save_s7;
    s8 = save_s8;
    return;
}
