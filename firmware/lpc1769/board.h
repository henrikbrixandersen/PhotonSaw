#ifndef __BOARD_H
#define __BOARD_H

#include "lpc17xx_gpio.h"
#include "lpc17xx_uart.h"

#include "board-config.h"

#define IN_IRAM1 __attribute__ ((section (".iram1")))
#define WEAK __attribute__ ((weak))

/*
  Preemption priority groups for IRQs (0..7)
*/
#define GROUP_PRIORITY_STEPPER (0<<2)
#define GROUP_PRIORITY_1000HZ  (1<<2)
#define GROUP_PRIORITY_100HZ   (2<<2)
#define GROUP_PRIORITY_SERIAL  (3<<2)
#define GROUP_PRIORITY_USB     (4<<2)


/*
  Set up port configuration constants, these constants should be the only
  place with port specific references, each constant should fit in a 32 bit int.

  Some ports are not configurable, so it's not mentioned here.

  Bits:
    0..7:   Pin number
    8..15:  Port number 
    16..23: Channel: SPI number / UART number / ADC channel / PWM channel
    24..25: Pin function    

  Use these macros to access the bits:
*/

#define OUTPUT (1<<31)

#define IO_PIN(x)  ( (x)        & 31)
#define IO_PORT(x) (((x) >> 8)  & 15)
#define IO_CHAN(x) (((x) >> 16) & 15)
#define IO_FUNC(x) (((x) >> 24) & 3)
#define IO_OUTPUT(x) (x & OUTPUT)

#define IO_P0 (0 << 8)
#define IO_P1 (1 << 8)
#define IO_P2 (2 << 8)
#define IO_P3 (3 << 8)
#define IO_P4 (4 << 8)

// This file is supplied from the board subdirectory and should never be include from other files:
#include "board-pins.h"

void configPin(const uint32_t pin);

// TODO: Make macros for manipulating GPIO pins (I/O) via bit banding
/*
typedef unsigned int *preg32;
#define GPIO_SET(x)   (*(preg32 ((LPC_GPIO0_BASE + (IO_PORT(x) << 16)) + ((1 << IO_PIN(x)) << 2)))) = 0xFFF
#define GPIO_CLEAR(x) (*(preg32 ((LPC_GPIO0_BASE + (IO_PORT(x) << 16)) + ((1 << IO_PIN(x)) << 2)))) = 0
#define GPIO_GET(x)   (*(preg32 ((LPC_GPIO0_BASE + (IO_PORT(x) << 16)) + ((1 << IO_PIN(x)) << 2))))
*/
#define GPIO_SET(x)   GPIO_SetValue(IO_PORT(x), 1<<IO_PIN(x))
#define GPIO_CLEAR(x) GPIO_ClearValue(IO_PORT(x), 1<<IO_PIN(x))
#define GPIO_GET(x)   (GPIO_ReadValue(IO_PORT(x)) & (1<<IO_PIN(x)))

// Use this macro with a pin config constant:
#define READ_ADC(pin) readADC(IO_CHAN(pin))

// 8,16 and 32 bit ints takes 10 clock cycles, 64 bit (long long) takes 16
#define SYSTICK_TYPE unsigned int
extern volatile SYSTICK_TYPE systick;

void delay(SYSTICK_TYPE ms);
SYSTICK_TYPE systickInterval(SYSTICK_TYPE t0, SYSTICK_TYPE t1);

// Implement this to get it called at 100Hz
void diskTick100Hz();

void boardInit();

#endif
