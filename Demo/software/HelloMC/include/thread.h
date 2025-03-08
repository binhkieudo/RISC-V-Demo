#ifndef _ASM_H
#define _ASM_H

#include "platform.h"
#include "clint.h"
#include "stdint.h"

// typedef unsigned int key_t;

// extern char _heap_share[];

static volatile uint32_t * msip = (uint32_t *)(CLINT_CTRL_ADDR);
uint32_t *core0 = (void *)(CLINT_CTRL_ADDR + CLINT_MSIP0);
uint32_t *core1 = (void *)(CLINT_CTRL_ADDR + CLINT_MSIP1);
uint32_t *core2 = (void *)(CLINT_CTRL_ADDR + CLINT_MSIP2);
uint32_t *core3 = (void *)(CLINT_CTRL_ADDR + CLINT_MSIP3);

extern void mux_lock();
extern void mux_unlock();
extern void sem_wait(uint32_t* channel);
extern void sem_signal(uint32_t* channel);
extern unsigned int get_hartid(void);
extern void atomic_write(uint32_t* addr, unsigned int value);

#endif