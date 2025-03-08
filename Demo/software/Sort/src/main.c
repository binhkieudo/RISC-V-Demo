// #include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <riscv-pk/encoding.h>
#include "platform.h"
#include "kprintf.h"
#include "thread.h"

int arr0[] = {1, 9, 4, 7, 3};
int arr1[] = {2, 2, 4, 3, 1};
int arr2[] = {6, 3, 4, 6, 0};
int arr3[] = {7, 9, 4, 5, 2};


void Sort_kernel(int arr[], int n) {
    int i, j, temp;
    for (i = 0; i < n - 1; i++) {
        for (j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

int main(int hartid, char **argv) {

  REG32(uart, UART_REG_TXCTRL) = UART_TXEN;

  // Init number of thread
  thread_init(4);

  // Multiplicaton
  thread_create(Sort_kernel, &arr0, sizeof(arr0)/4, arr0);
  thread_create(Sort_kernel, &arr1, sizeof(arr1)/4, arr0);
  thread_create(Sort_kernel, &arr2, sizeof(arr2)/4, arr0);
  thread_create(Sort_kernel, &arr3, sizeof(arr3)/4, arr0);
  thread_join();

  kprintf("\r\n");
  for (int i = 0; i < 5; i++)
    kprintf("%l  ", arr0[i]);
  
  kprintf("\r\n");
  for (int i = 0; i < 5; i++)
    kprintf("%l  ", arr1[i]);
    
  kprintf("\r\n");
  for (int i = 0; i < 5; i++)
    kprintf("%l  ", arr2[i]);
    
  kprintf("\r\n");
  for (int i = 0; i < 5; i++)
    kprintf("%l  ", arr3[i]);
    	
  return 0;
}
