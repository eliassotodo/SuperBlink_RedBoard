.section .text
.align 2
.globl setupGPIO                    # So the C compiler can find our funtion

.include "memory_map.inc"
.include "gpio.inc"

setupGPIO:
    addi sp, sp, -16                # Allocate the stack frame. Reset memmory addres on the stack pointer, so we can save a new value
    sw ra, 12(sp)                   # Save the return address onto the stack
    
    li t0, GPIO_CTRL_ADDR           # Load base GPIO address
    li t1, GPIO_RGB_PINS            # Load the RGB pin offset (t1 has all pins on 0b111)
    sw t1, GPIO_OUTPUT_EN(t0)       # Enable output on the RGB Pins so they are writable
    # sw t1, GPIO_OUTPUT_XOR(t0)      # Set the XOR so the RGB Pins are Active High
    sw x0, GPIO_OUTPUT_VAL(t0)      # Set to 0 the pins we setted as writable before to clear the LEDs

    lw ra, 12(sp)                   # Restore the return address
    addi sp, sp, 16                 # Deallocating the stack frame
    ret