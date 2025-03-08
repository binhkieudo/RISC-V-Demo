// See LICENSE.Sifive for license details.
#include <platform.h>
#include <clint.h>
#include <smp.h>
#include "common.h"

  .section .text.init
  .option norvc
  .globl _prog_start
_prog_start:
  csrr s0, mhartid
  beq s0, zero, _setup
  li s2, 0x8
  csrw mie, s2
  wfi
  j _main
_setup:
  li t0, 1
  li a0, (UART_CTRL_ADDR + UART_REG_TXCTRL)
  sw t0, 0(a0)
_main: // Hart 1 to 4 run main
  csrw mie, zero
  csrr a0, mhartid
  li s0, 0
  bne a0, s0, _set1
_set0:
  li sp, (PRIVATE_MEM_0 + PRIVATE_MEM_SIZE - 16)
  j _entry
_set1:
  li s0, 1
  bne a0, s0, _set2
  li sp, (PRIVATE_MEM_1 + PRIVATE_MEM_SIZE - 16)
  j _entry
_set2:
  li s0, 2
  bne a0, s0, _set3  
  li sp, (PRIVATE_MEM_2 + PRIVATE_MEM_SIZE - 16)
  j _entry
_set3:
  li sp, (PRIVATE_MEM_3 + PRIVATE_MEM_SIZE - 16)
_entry:
  call main
_loopback:
  li s2, 0x8
  csrw mie, s2
  wfi
  j _main
