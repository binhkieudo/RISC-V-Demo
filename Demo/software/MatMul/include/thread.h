#ifndef _ASM_H
#define _ASM_H

#include "platform.h"
#include "clint.h"
#include "stdint.h"

volatile uint32_t thread_widx = 0;
volatile uint32_t thread_ridx = 0;
volatile uint32_t thread_cnt  = 0;
// extern char _heap_share[];

void **thread_queue = (void *)(THREAD_QUEUE_ADDR + 16);

static volatile uint32_t *msip  = (uint32_t *)(CLINT_CTRL_ADDR);
static volatile uint32_t *core0 = (void *)(CLINT_CTRL_ADDR + CLINT_MSIP0);
static volatile uint32_t *core1 = (void *)(CLINT_CTRL_ADDR + CLINT_MSIP1);
static volatile uint32_t *core2 = (void *)(CLINT_CTRL_ADDR + CLINT_MSIP2);
static volatile uint32_t *core3 = (void *)(CLINT_CTRL_ADDR + CLINT_MSIP3);

extern void mux_lock();
extern void mux_unlock();
extern void sem_wait(uint32_t* channel);
extern void sem_signal(uint32_t* channel);
extern uint32_t get_hartid(void);
extern void atomic_write(uint32_t* addr, unsigned int value);
extern void _thread0_entry();

extern uint32_t read_flag0();
extern uint32_t read_flag1();
extern uint32_t read_flag2();
extern uint32_t read_flag3();

void thread_init(uint32_t thread_count) {
    mux_lock();
    thread_cnt = thread_count;
    thread_widx = 0;
    thread_ridx = 0;
    mux_unlock();
}

void thread_create(void* funct, void *din0, void *din1, void *dout) {
    mux_lock();
    thread_queue[thread_widx++] = funct;
    thread_queue[thread_widx++] = din0;
    thread_queue[thread_widx++] = din1;
    thread_queue[thread_widx++] = dout;
    mux_unlock();
}

void thread_run() {
    while (1) {
        mux_lock();
        if ((thread_ridx < thread_widx) && (thread_cnt >0)) {
            void (*funct)(void*, void*, void*);
            funct = thread_queue[thread_ridx++];
            void* din0 = thread_queue[thread_ridx++];
            void* din1 = thread_queue[thread_ridx++];
            void *dout = thread_queue[thread_ridx++];
            thread_cnt--;
            mux_unlock();
            funct(din0, din1, dout);
        }
        else if (thread_cnt > 0) {
            mux_unlock();
        }
        else {
            mux_unlock();
            break;
        }
    }
    return;
}

void thread_join() {
    _thread0_entry();

    uint32_t core_status = 0;

    while (1) {
        core_status = 0;
        core_status += read_flag0();
        if (core_status == 0) break;
    }
}

#endif