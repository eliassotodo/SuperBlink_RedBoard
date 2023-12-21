.section .text
.align 2
.globl setLED

.include "memory_map.inc"
.include "gpio.inc"

.equ NO_ERROR,  0x0
.equ ERROR,     0x1
.equ LED_ON,    0x1

# Which LED to set comes into register a0
# Desired ON/OFF state comes into register a1

setLED:
    addi sp, sp, -16                # Allocate the stack frame
    sw ra, 12(sp)                   # Save our return address onto the stack

    li t0, GPIO_CTRL_ADDR           # Load the GPIO Address
    lw t1, GPIO_OUTPUT_VAL(t0)      # Get the current value of the pins

    beqz a1, ledOff                 # Brach off to turn off LED if a1 requests it
    li t2, LED_ON                   # Load up ON/1 in our temp register
    beq a1, t2, ledOn               # Branch if on requested
    li a0, ERROR                    # We got a bad status request, return an error
    j exit

ledOn:
    xor t1, t1, a0                  # Do an xor to only change the value of the rquested LED
    sw t1, GPIO_OUTPUT_VAL(t0)      # Write the new output value to the GPIO outpu
    li a0, NO_ERROR
    j exit


ledOff:
    xor a0, a0, 0xffffffff          # Invert everything so that all bits are 1 except the LED we're turning off
    and t1, t1, a0                  # And a0 and t1 to get the LED we want to turn off.
    sw t1, GPIO_OUTPUT_VAL(t0)      # Write the new output value to the right GPIO register
    li a0, NO_ERROR
    # No need to `j exit` here,   because the next instruction IS exit

exit:
    # a0 would be automatically sent to the C code as the return value, so
    # we don't need to do anything but to set the right value in a0, which we did

    lw ra, 12(sp)                   # Restore our return addres
    addi sp, sp, 16                 # Deallocationg stack frame
    ret
