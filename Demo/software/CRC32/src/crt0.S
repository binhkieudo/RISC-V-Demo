// See LICENSE.Sifive for license details.
#include <platform.h>
#include <smp.h>
#include "common.h"
#include "clint.h"

  .section .text.init
  .option norvc
  .globl _thread0_entry
  .globl _prog_start

_prog_start:
  li a0, THREAD_QUEUE_ADDR
  li t0, 0
  amoswap.w t0, t0, (a0)
  csrr s0, mhartid
  csrw mie, zero
  beq s0, zero, _main
_thread_end:
  csrr s0, mhartid
  // Ensure that you the interrupt flag is clear before sleep
# __clear_flag0: // Core 0 does not enter this way
#   li t0, 0
#   bne s0, t0, __clear_flag1
__clear_flag1:
  li t0, 1
  bne s0, t0, __clear_flag2
  li s0, (CLINT_CTRL_ADDR + CLINT_MSIP1)
  amoswap.w t0, zero, (s0)
  j __core_sleep
__clear_flag2:
  li t0, 2
  bne s0, t0, __clear_flag3
  li s0, (CLINT_CTRL_ADDR + CLINT_MSIP2)
  amoswap.w t0, zero, (s0)
  j __core_sleep
__clear_flag3:
  li t0, 3
  bne s0, t0, __clear_flag4
  li s0, (CLINT_CTRL_ADDR + CLINT_MSIP3)
  amoswap.w t0, zero, (s0)
  j __core_sleep
__clear_flag4:
  li t0, 4
  bne s0, t0, __clear_flag5
  li s0, (CLINT_CTRL_ADDR + CLINT_MSIP4)
  amoswap.w t0, zero, (s0)
  j __core_sleep
__clear_flag5:
  li t0, 5
  bne s0, t0, __clear_flag6
  li s0, (CLINT_CTRL_ADDR + CLINT_MSIP5)
  amoswap.w t0, zero, (s0)
  j __core_sleep
__clear_flag6:
  li t0, 6
  bne s0, t0, __clear_flag7
  li s0, (CLINT_CTRL_ADDR + CLINT_MSIP6)
  amoswap.w t0, zero, (s0)
  j __core_sleep
__clear_flag7:
  li s0, (CLINT_CTRL_ADDR + CLINT_MSIP7)
  amoswap.w t0, zero, (s0)
__core_sleep:
  li s2, 0x8 // Enable interrupt
  csrw mie, s2
  wfi
  csrw mie, zero // Disable interrupt
  call _thread_entry
  j _thread_end
_thread0_entry: // Thread 0 must store activation table first
  // a0 store address link
  csrw mie, zero
  addi sp, sp, -248
  sd ra, 0(sp)
  sd sp, 8(sp)
  sd gp, 16(sp)
  sd tp, 24(sp)
  sd t0, 32(sp)
  sd t1, 40(sp)
  sd t2, 48(sp)
  sd s0, 56(sp)
  sd s1, 64(sp)
  sd a0, 72(sp)
  sd a1, 80(sp)
  sd a2, 88(sp)
  sd a3, 96(sp)
  sd a4, 104(sp)
  sd a5, 112(sp)
  sd a6, 120(sp)
  sd a7, 128(sp)
  sd s2, 136(sp)
  sd s3, 144(sp)
  sd s4, 152(sp)
  sd s5, 160(sp)
  sd s6, 168(sp)
  sd s7, 176(sp)
  sd s8, 184(sp)
  sd s9, 192(sp)
  sd s10, 200(sp)
  sd s11, 208(sp)
  sd t3, 216(sp)
  sd t4, 224(sp)
  sd t5, 232(sp)
  sd t6, 240(sp)
  // Then store sp at first address of private memory
  li t0, (PRIVATE_MEM_0 + PRIVATE_MEM_SIZE - 16)
  sd sp, 0(t0)
  li sp, (PRIVATE_MEM_0 + PRIVATE_MEM_SIZE - 32)
  call thread_run
  // Cleaf flag
  li s0, (CLINT_CTRL_ADDR + CLINT_MSIP0)
  amoswap.w t0, zero, (s0)
  // Enable interrupt
  li s2, 0x8
  csrw mie, s2
  // After return, restore activate table
  // firstly recover origianl sp
  li t0, (PRIVATE_MEM_0 + PRIVATE_MEM_SIZE - 16)
  ld sp, 0(t0)
  ld ra, 0(sp)
  ld gp, 16(sp)
  ld tp, 24(sp)
  ld t0, 32(sp)
  ld t1, 40(sp)
  ld t2, 48(sp)
  ld s0, 56(sp)
  ld s1, 64(sp)
  ld a0, 72(sp)
  ld a1, 80(sp)
  ld a2, 88(sp)
  ld a3, 96(sp)
  ld a4, 104(sp)
  ld a5, 112(sp)
  ld a6, 120(sp)
  ld a7, 128(sp)
  ld s2, 136(sp)
  ld s3, 144(sp)
  ld s4, 152(sp)
  ld s5, 160(sp)
  ld s6, 168(sp)
  ld s7, 176(sp)
  ld s8, 184(sp)
  ld s9, 192(sp)
  ld s10, 200(sp)
  ld s11, 208(sp)
  ld t3, 216(sp)
  ld t4, 224(sp)
  ld t5, 232(sp)
  ld t6, 240(sp)
  ld sp, 8(sp)
  addi sp, sp, 248
  ret // Return to the main thread
_thread_entry: // For other cores
  csrw mie, zero
  csrr a0, mhartid
  li t0, 0x40000000
  slli sp, a0, 15
  or  sp, sp, t0
  li t0, 0x7ff0
  add sp, sp, t0
  call thread_run
  j _thread_end
_main: // Hart 0
  csrw mie, zero
  csrr a0, mhartid
  li sp, (MEMORY_MEM_ADDR + 0x7fff0)
  call main
_loopback:
  wfi
  j _loopback