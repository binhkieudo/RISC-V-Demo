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

uint8_t data_buf0[] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};
uint8_t data_buf1[] = {0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18};
uint8_t data_buf2[] = {0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28};
uint8_t data_buf3[] = {0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38};

uint32_t crc0;
uint32_t crc1;
uint32_t crc2;
uint32_t crc3;

void crc32(const uint8_t* data, unsigned int* len, unsigned int *crc) {
  unsigned int checksum = 0xFFFFFFFF; // Initial CRC value
  unsigned int length = *len;
  
  for (int i = 0; i < length; ++i) {
      uint8_t byte = data[i];
      checksum ^= byte;

      for (int j = 0; j < 8; ++j) {
          if (checksum & 1) {
            checksum = (checksum >> 1) ^ 0xEDB88320; // Polynomial: 0xEDB88320 (reversed)
          } else {
            checksum >>= 1;
          }
      }
  }

  *crc = ~checksum;
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
  thread_create(crc32, data_buf0, &len0, &crc0);
  thread_create(crc32, data_buf1, &len1, &crc1);
  thread_create(crc32, data_buf2, &len2, &crc2);
  thread_create(crc32, data_buf3, &len3, &crc3);
  thread_join();
 

  // Stop here to check your result
  while (1);

	return 0;
}
