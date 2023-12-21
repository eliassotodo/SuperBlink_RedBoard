#include <stdio.h>
#include "superBlink.h"

int main()
{
    int error = 0;
    int ledNum = 0;
    int colors[NUM_LEDS] = {RED_LED, GREEN_LED, BLUE_LED};

    setupGPIO();

    while (!error)
    {
        error = setLED(colors[ledNum], ON);
        delay(DELAY);

        error = setLED(colors[ledNum++], OFF);
        delay(DELAY);

        if (ledNum >= NUM_LEDS)
        {
            ledNum = 0;
        }
    }
}