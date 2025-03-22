// #include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <riscv-pk/encoding.h>
#include "platform.h"
#include "kprintf.h"
#include "thread.h"

#define DELAY_TIME 30000
#define SIZE 4

typedef uint16_t mat_t;

static volatile mat_t *dump  = (mat_t*)(THREAD_QUEUE_ADDR);

unsigned int data_buf0[] = {8, 7, 6, 5, 4, 3, 2, 1};
unsigned int data_buf1[] = {18, 17, 16, 15, 14, 13, 12, 11};
unsigned int data_buf2[] = {28, 27, 26, 25, 24, 23, 22, 21};
unsigned int data_buf3[] = {38, 37, 36, 35, 34, 33, 32, 31};

unsigned int result0[8];
unsigned int result1[8];
unsigned int result2[8];
unsigned int result3[8];

void Sort(unsigned int* data, unsigned int* len, unsigned int *result) {

  int n = *len / 4;

  // Copy data
  for (int i = 0; i < n; ++i) {
    result[i] = data[i];
  }

  // Sort
  int swapped;
  for (int i = 0; i < n - 1; ++i) {
      swapped = 0;
      // Last i elements are already in place
      for (int j = 0; j < n - i - 1; j++) {
          if (result[j] > result[j + 1]) {
              // Swap
              unsigned int temp = result[j];
              result[j] = result[j + 1];
              result[j + 1] = temp;
              swapped = 1;
          }
      }

      if (swapped == 0) {
          break;
      }
  }
}

int main(int hartid, char **argv) {

  REG32(uart, UART_REG_TXCTRL) = UART_TXEN;

  uint32_t len0 = sizeof(data_buf0);
  uint32_t len1 = sizeof(data_buf1);
  uint32_t len2 = sizeof(data_buf2);
  uint32_t len3 = sizeof(data_buf3);


  // Init number of thread
  thread_init(4);
  
  // Calculate
  thread_create(Sort, data_buf0, &len0, result0);
  thread_create(Sort, data_buf1, &len1, result1);
  thread_create(Sort, data_buf2, &len2, result2);
  thread_create(Sort, data_buf3, &len3, result3);
  thread_join();
 

  // Stop here to check your result
  while (1);

	return 0;
}
