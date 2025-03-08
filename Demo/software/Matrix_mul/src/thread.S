#include "platform.h"  
  
  .section .text.init
  .option norvc
  .globl mux_lock
  .globl mux_unlock
  .globl sem_wait
  .globl sem_signal
  .globl get_hartid
  .globl atomic_write
  .globl sem_wait
  .globl read_flag0
  .globl read_flag1
  .globl read_flag2
  .globl read_flag3
  .globl read_flag4
  .globl read_flag5
  .globl read_flag6
  .globl read_flag7

// ====== Lock ====================  
mux_lock:
    addi sp, sp, -24
    sd  t0, 16(sp)
    sd  t1, 8(sp)
    sd  a0, 0(sp)    
    li t0, 1
    li a0, THREAD_QUEUE_ADDR
_again:
    lw t1, 0(a0)   // Check if lock is held
    bnez t1, _again  // Retry if held
    amoswap.w t1, t0, (a0)
    bnez t1, _again  // Retry if held
    ld  t0, 16(sp)
    ld  t1, 8(sp)
    ld  a0, 0(sp) 
    addi sp, sp, 24
    ret

// ====== Unlock ==================
mux_unlock:
    addi sp, sp, -16
    sd  t0, 8(sp)
    sd  t1, 0(sp)
    li t0, 0
    li a0, THREAD_QUEUE_ADDR
    lw t1, 0(a0)   // Check if lock is held
    beqz t1, _exit_unlock
    amoswap.w t0, t0, (a0)
_exit_unlock:
    ld  t0, 8(sp)
    ld  t1, 0(sp)
    addi sp, sp, 16    
    ret

// ====== Get hartid ==============
get_hartid:
    csrr a0, mhartid
    ret

// ====== Atomic write ============
atomic_write:
    addi sp, sp, -8
    sd t0, 0(sp)
    amoswap.w t0, a1, (a0)
    ld t0, 0(sp)
    addi sp, sp, 8    
    ret

// ====== Semaphore wait ==========
sem_wait:
    addi sp, sp, -16
    sd  t0, 8(sp)
    sd  s0, 0(sp)
    amoswap.w t0, zero, (a0) // Clear interrupt flag
    li s0, 0x8 // Enable interrupt
    csrw mie, s0
    wfi
    csrw mie, zero // Disable interrupt
    amoswap.w t0, zero, (a0) // Clear interrupt flag
    ld  t0, 8(sp)
    ld  s0, 0(sp)
    addi sp, sp, 16
    ret

// ====== Semaphore signal ========
sem_signal:
    addi sp, sp, -8
    sd t0, 0(sp)
    li t0, 1 // Set interrupt flag of target core
    amoswap.w t1, t0, (a0)
    ld t0, 0(sp)
    addi sp, sp, 8
    ret

// ===== Check core status ========
read_flag0:
  li t0, (CLINT_CTRL_ADDR + CLINT_MSIP0)
  amoor.w a0, zero, (t0)
  ret
read_flag1:
  li t0, (CLINT_CTRL_ADDR + CLINT_MSIP1)
  amoor.w a0, zero, (t0)
  ret
read_flag2:
  li t0, (CLINT_CTRL_ADDR + CLINT_MSIP2)
  amoor.w a0, zero, (t0)
  ret
read_flag3:
  li t0, (CLINT_CTRL_ADDR + CLINT_MSIP3)
  amoor.w a0, zero, (t0)
  ret
read_flag4:
  li t0, (CLINT_CTRL_ADDR + CLINT_MSIP4)
  amoor.w a0, zero, (t0)
  ret
read_flag5:
  li t0, (CLINT_CTRL_ADDR + CLINT_MSIP5)
  amoor.w a0, zero, (t0)
  ret
read_flag6:
  li t0, (CLINT_CTRL_ADDR + CLINT_MSIP6)
  amoor.w a0, zero, (t0)
  ret
read_flag7:
  li t0, (CLINT_CTRL_ADDR + CLINT_MSIP7)
  amoor.w a0, zero, (t0)
  ret