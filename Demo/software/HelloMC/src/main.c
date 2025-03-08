// #include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <riscv-pk/encoding.h>
#include "platform.h"
#include "kprintf.h"
#include "thread.h"

#define REG32(p, i)	((p)[(i) >> 2])

#define DELAY_TIME 1000000
#define SIZE 32
#define TEST 1
#define CORE 8

void delay() {
	for (int i = 0; i < DELAY_TIME; i = i + 1);
  for (int i = 0; i < DELAY_TIME; i = i + 1);
}

int main(int hartid, char **argv) {

  int coreid = read_csr(mhartid);

    if (coreid == 0) { // hart 0 boot first
      kputs("Hello from core 0");
      delay();
      REG32(msip, CLINT_MSIP0) = CLINT_MSIPCLR;
      REG32(msip, CLINT_MSIP1) = CLINT_MSIPEN;
    }
    if (coreid == 1) {
      kputs("Hello from core 1");
      delay();
      REG32(msip, CLINT_MSIP1) = CLINT_MSIPCLR;
      REG32(msip, CLINT_MSIP2) = CLINT_MSIPEN;
    }
    if (coreid == 2) {
      kputs("Hello from core 2");
      delay();
      REG32(msip, CLINT_MSIP2) = CLINT_MSIPCLR;
      REG32(msip, CLINT_MSIP3) = CLINT_MSIPEN;
    }
    if (coreid == 3) {
      kputs("Hello from core 3");
      delay();
      REG32(msip, CLINT_MSIP3) = CLINT_MSIPCLR;
      REG32(msip, CLINT_MSIP0) = CLINT_MSIPEN;
    }

	return 0;
}