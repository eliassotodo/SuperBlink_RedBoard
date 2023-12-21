#define DELAY 500
#define ON 0x01
#define OFF 0x00
#define NUM_LEDS 0x03

#define RED_LED     0x01
#define GREEN_LED   0x02
#define BLUE_LED    0x04
#define RGB_PINS    0x07

void setupGPIO();
int setLED(int color, int state);
void delay(int milliseconds);