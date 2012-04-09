#!/usr/bin/perl
use strict;
use warnings;
use FindBin qw($Bin $Script);

open H, ">$Bin/board-pins.h" or die "Unable to write $Bin/board-pins.h: $!";
print H "// WARNING: Do not edit this file it is generated by $Script\n\n";
print H "#ifndef __BOARD_PINS_H\n";
print H "#define __BOARD_PINS_H\n\n";

my @all;
while (my $line = <DATA>) {
    if ($line =~ /^\#define\s+(\S+)\s+/) {
	my $name = $1;
	push @all, $name if $name =~ /^IO_/;
    }

    print H $line;
}

my $all = @all;
print H "\n\n#define ALL_PINS_SIZE $all\n";

print H "#ifdef __FROM_BOARD_C\n";
print H "const uint32_t ALL_PINS[ALL_PINS_SIZE] = {".join(", ", @all)."};\n\n";
print H "#else\n";
print H "extern const uint32_t ALL_PINS[ALL_PINS_SIZE];\n\n";
print H "#endif\n";

print H "#endif\n";


close H;


# NOTICE: Do not use block quotes in the __DATA__ section or the parser will break!!!

__DATA__
// Outputs:
#define IO_LED        (OUTPUT | IO_P1 | 27)
#define IO_EXHAUST    (OUTPUT | IO_P1 | 28)
#define IO_ASSIST_AIR (OUTPUT | IO_P1 | 29)
#define IO_LASER_FIRE (OUTPUT | IO_P1 | 19)

#define IO_X_ENABLE   (OUTPUT | IO_P2 | 0)
#define IO_X_DIR      (OUTPUT | IO_P2 | 1)
#define IO_X_STEP     (OUTPUT | IO_P2 | 4)
#define IO_X_USM0     (OUTPUT | IO_P2 | 3)
#define IO_X_USM1     (OUTPUT | IO_P2 | 2)

#define IO_Y_ENABLE   (OUTPUT | IO_P2 | 5)
#define IO_Y_DIR      (OUTPUT | IO_P2 | 6)
#define IO_Y_STEP     (OUTPUT | IO_P0 | 16)
#define IO_Y_USM0     (OUTPUT | IO_P2 | 8)
#define IO_Y_USM1     (OUTPUT | IO_P2 | 7)

#define IO_Z_ENABLE   (OUTPUT | IO_P0 | 15)
#define IO_Z_DIR      (OUTPUT | IO_P0 | 17)
#define IO_Z_STEP     (OUTPUT | IO_P0 | 20)
#define IO_Z_USM0     (OUTPUT | IO_P0 | 19)
#define IO_Z_USM1     (OUTPUT | IO_P0 | 18)

#define IO_A_ENABLE   (OUTPUT | IO_P0 | 21)
#define IO_A_DIR      (OUTPUT | IO_P0 | 22)
#define IO_A_STEP     (OUTPUT | IO_P2 | 13)
#define IO_A_USM0     (OUTPUT | IO_P2 | 12)
#define IO_A_USM1     (OUTPUT | IO_P2 | 11)


// Inputs:
#define IO_WATERFLOW   (IO_P1 | 16)
#define IO_ISP         (IO_P2 | 10)
#define IO_WD_READY    (IO_P0 | 28)
#define IO_LASER_READY (IO_P3 | 25)
#define IO_ESTOP       (IO_P3 | 26)

#define IO_X_MAX      (IO_P1 | 14)
#define IO_X_MIN      (IO_P1 | 15)

#define IO_Y_MAX      (IO_P1 | 9)
#define IO_Y_MIN      (IO_P1 | 10)

#define IO_Z_MAX      (IO_P1 | 4)
#define IO_Z_MIN      (IO_P1 | 8)

#define IO_A_MAX      (IO_P1 | 0)
#define IO_A_MIN      (IO_P1 | 1)



// SPI (bit 15..23 is SPI channel)
#define IO_SD_CS       ((2<<24) | (1<<16) | IO_P0 | 6)
#define IO_SD_SCK      ((2<<24) | (1<<16) | IO_P0 | 7)
#define IO_SD_MISO     ((2<<24) | (1<<16) | IO_P0 | 8)
#define IO_SD_MOSI     ((2<<24) | (1<<16) | IO_P0 | 9)


// AD channels (bit 15..23 is ADC channel)
#define IO_AIRFLOW       ((1<<24) | (0<<16) | IO_P0 | 23)
#define IO_TEMP_OUT      ((1<<24) | (1<<16) | IO_P0 | 24)
#define IO_TEMP_IN       ((1<<24) | (2<<16) | IO_P0 | 25)
#define IO_TEMP_INTERNAL ((1<<24) | (3<<16) | IO_P0 | 26)

#define IO_VOLTAGE       ((3<<24) | (5<<16) | IO_P1 | 31)


// PWM channels (bit 15..23 is PWM channel)
#define IO_X_CURRENT     ((2<<24) | (1<<16) | IO_P1 | 18)
#define IO_Y_CURRENT     ((2<<24) | (2<<16) | IO_P1 | 20)
#define IO_Z_CURRENT     ((2<<24) | (3<<16) | IO_P1 | 21)
#define IO_A_CURRENT     ((2<<24) | (4<<16) | IO_P1 | 23)
#define IO_LASER_POWER   ((2<<24) | (5<<16) | IO_P1 | 24)


// UARTs (bit 15..23 is UART number)
#define IO_DEBUG_TX      ((1<<24) | (0<<16) | IO_P0 | 2)
#define IO_DEBUG_RX      ((1<<24) | (0<<16) | IO_P0 | 3)

#define IO_WATCHDOG_TX   ((2<<24) | (3<<16) | IO_P0 | 0)
#define IO_WATCHDOG_RX   ((2<<24) | (3<<16) | IO_P0 | 1)

#define IO_CHILLER_TX    ((1<<24) | (2<<16) | IO_P0 | 10)
#define IO_CHILLER_RX    ((1<<24) | (2<<16) | IO_P0 | 11)

#define USE_UART0
#define USE_UART2
#define USE_UART3

// The USB port, if nothing else, then for setting the mode.
#define IO_USB_CONN      ((1<<24) |           IO_P2 | 9)
#define IO_USB_D_PLUS    ((1<<24) |           IO_P0 | 29)
#define IO_USB_D_MINUS   ((1<<24) |           IO_P0 | 30)


// Misc outputs:
#define IO_STEPPER_ACTIVE     (OUTPUT | IO_P1 | 17)

