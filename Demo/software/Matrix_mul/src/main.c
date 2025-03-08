// #include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <riscv-pk/encoding.h>
#include "platform.h"
#include "kprintf.h"
#include "thread.h"


#define DELAY_TIME 30000
#define SIZE 64
#define TEST 1
#define CORE 8

typedef uint8_t mat_t;

static volatile mat_t *dump  = (mat_t*)(THREAD_QUEUE_ADDR);

mat_t in0[4][(SIZE/2)*(SIZE/2)];
mat_t in1[4][(SIZE/2)*(SIZE/2)];
mat_t out[8][(SIZE/2)*(SIZE/2)];

void matMul(void *din, void *dout) {
  mat_t matA[SIZE][SIZE];
  mat_t matB[SIZE][SIZE];
  mat_t matC[SIZE][SIZE];

  mat_t *matOut = (mat_t*)dout;

  // Intialize
  for (int i = 0; i < SIZE; i++)
    for (int j = 0;  j < SIZE; j++){
      matA[i][j] = i*SIZE + j;
      matB[i][j] = i*SIZE + j;
      matC[i][j] = 0;
    }

  // Multiplication
  for (int i = 0; i < SIZE; i++)
    for (int j = 0;  j < SIZE; j++){
      mat_t sum = 0;
      for (int k = 0; k < SIZE; k++) {
        sum += matA[i][k]*matB[k][j]; 
      }
      matC[i][j] = sum;
    }

  // Writeback
  for (int i = 0; i < SIZE; i++)
    for (int j = 0;  j < SIZE; j++)
      matOut[i*SIZE + j] = matC[i][j];
  
  // Replace the first element with core id for debug
  matOut[0] = get_hartid();
}

void strassen_mul(void *din0, void *din1, void *dout) {
  mat_t matA[SIZE/2][SIZE/2];
  mat_t matB[SIZE/2][SIZE/2];
  mat_t matC[SIZE/2][SIZE/2];

  mat_t *dinA = (mat_t*)din0;
  mat_t *dinB = (mat_t*)din1;

  mat_t *matOut = (mat_t*)dout;

  // Fetch
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0;  j < SIZE/2; j++){
      matA[i][j] = dinA[i*(SIZE/2)+j];
      matB[i][j] = dinB[i*(SIZE/2)+j];
    }

  // Multiplication
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0;  j < SIZE/2; j++){
      mat_t sum = 0;
      for (int k = 0; k < SIZE/2; k++) {
        sum += matA[i][k]*matB[k][j]; 
      }
      matC[i][j] = sum;
    }

  // Writeback
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0;  j < SIZE/2; j++)
      matOut[i*(SIZE/2) + j] = matC[i][j];
  
}

void strassen_add(void *din0, void *din1, void *dout) {
  mat_t matA[SIZE/2][SIZE/2];
  mat_t matB[SIZE/2][SIZE/2];
  mat_t matC[SIZE/2][SIZE/2];

  mat_t *dinA = (mat_t*)din0;
  mat_t *dinB = (mat_t*)din1;
  mat_t *matOut = (mat_t*)dout;

  // Fetch
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0;  j < SIZE/2; j++){
      matA[i][j] = dinA[i*(SIZE/2)+j];
      matB[i][j] = dinB[i*(SIZE/2)+j];
    }

  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0;  j < SIZE/2; j++)
      matC[i][j] = matA[i][j] + matB[i][j];

  // Writeback
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0;  j < SIZE/2; j++)
      matOut[i*(SIZE/2) + j] = matC[i][j];

}

int main(int hartid, char **argv) {

  REG32(uart, UART_REG_TXCTRL) = UART_TXEN;
  uint64_t t_start, t_end, ts_gap, tm_gap;

  // ======================================================
  // Run matrix multiplication in single core, shared mem
  mat_t matA[SIZE][SIZE];
  mat_t matB[SIZE][SIZE];
  mat_t matC[SIZE][SIZE];

  // Intialize
  for (int i = 0; i < SIZE; i++)
    for (int j = 0;  j < SIZE; j++){
      matA[i][j] = i*SIZE + j;
      matB[i][j] = i*SIZE + j;
      matC[i][j] = 0;
    }


  t_start = read_csr(mcycle);
  // Multiplication
  for (int i = 0; i < SIZE; i++)
    for (int j = 0;  j < SIZE; j++){
      mat_t sum = 0;
      for (int k = 0; k < SIZE; k++) {
        sum += matA[i][k]*matB[k][j]; 
      }
      matC[i][j] = sum;
    }
  t_end = read_csr(mcycle);

  ts_gap = t_end - t_start;
  kprintf("Single core: %l(cycles) \r\n", ts_gap);

  // ======================================================
  // Run matrix multiplication on eight core

  t_start = read_csr(mcycle);
  int k = 0;

  // Split matrix
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0; j < SIZE/2; j++) {
      in0[0][k] = matA[i][j];
      in1[0][k] = matB[i][j];
      k++;
    }
  k = 0;
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0; j < SIZE/2; j++) {
      in0[1][k] = matA[i][j+(SIZE/2)];
      in1[1][k] = matB[i][j+(SIZE/2)];
      k++;
    }
  k = 0;
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0; j < SIZE/2; j++) {
      in0[2][k] = matA[i+(SIZE/2)][j];
      in1[2][k] = matB[i+(SIZE/2)][j];
      k++;
    }
  k = 0;
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0; j < SIZE/2; j++) {
      in0[3][k] = matA[i+(SIZE/2)][j+(SIZE/2)];
      in1[3][k] = matB[i+(SIZE/2)][j+(SIZE/2)];
      k++;
    }

  // Init number of thread
  thread_init(CORE);

  // Multiplicaton
  thread_create(strassen_mul, &in0[0], &in1[0], out[0]);
  thread_create(strassen_mul, &in0[1], &in1[2], out[1]);
  thread_create(strassen_mul, &in0[0], &in1[1], out[2]);
  thread_create(strassen_mul, &in0[1], &in1[3], out[3]);
  thread_create(strassen_mul, &in0[2], &in1[0], out[4]);
  thread_create(strassen_mul, &in0[3], &in1[2], out[5]);
  thread_create(strassen_mul, &in0[2], &in1[1], out[6]);
  thread_create(strassen_mul, &in0[3], &in1[3], out[7]);
  thread_join();

  
  // Addition
  thread_create(strassen_add, &out[0], &out[1], out[0]);
  thread_create(strassen_add, &out[2], &out[3], out[2]);
  thread_create(strassen_add, &out[4], &out[5], out[4]);
  thread_create(strassen_add, &out[6], &out[7], out[6]);
  thread_join();

  // Write back result
  k = 0;
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0; j < SIZE/2; j++)
      matC[i][j] = out[0][k];
  k = 0;
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0; j < SIZE/2; j++)
      matC[i][j+SIZE/2] = out[2][k];
  k = 0;
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0; j < SIZE/2; j++)
      matC[i+SIZE/2][j] = out[4][k];      
  k = 0;
  for (int i = 0; i < SIZE/2; i++)
    for (int j = 0; j < SIZE/2; j++)
      matC[i+SIZE/2][j+SIZE/2] = out[6][k];
      
  t_end = read_csr(mcycle);
  tm_gap = t_end - t_start;

  for (int i = 0; i < SIZE; i++) {
    for (int j = 0; j < SIZE; j++)
      REG32(dump, 0) =  matC[i][j];
  }

kprintf("Multi core: %l(cycles) \r\n", tm_gap);
  kprintf("Complete\r\n\r\n");
	
	return 0;
}
