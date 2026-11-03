// ATTiny202
// Blink sample

// Physical Pin 1: VCC
// Physical Pin 2: PA6
// Physical Pin 3: PA7
// Physical Pin 4: PA1 / SDA (I2C)
// Physical Pin 5: PA2 / SDL (I2C)
// Physical Pin 6: PA0 / UPDI
// Physical Pin 7: PA3
// Physical Pin 8: GND

#include <avr/io.h>
#include <util/delay.h>

constexpr int INTERVAL = 500;

int main()
{
    // PORTA.DIRSET = PIN6_bm;  // Physical Pin 2 (PA6) => output
    // PORTA.DIRSET = PIN7_bm;  // Physical Pin 3 (PA7) => output
    VPORTA.DIR |= (PIN6_bm | PIN7_bm);

    while (true)
    {
        // PA6 ON / PA7 OFF
        // PORTA.OUTSET = PIN6_bm;
        // PORTA.OUTCLR = PIN7_bm;
        VPORTA.OUT = (VPORTA.OUT & ~PIN7_bm) | PIN6_bm;
        _delay_ms(INTERVAL);

        // PA6 OFF / PA7 ON
        // PORTA.OUTSET = PIN7_bm;
        // PORTA.OUTCLR = PIN6_bm;
        VPORTA.OUT = (VPORTA.OUT & ~PIN6_bm) | PIN7_bm;
        _delay_ms(INTERVAL);

        // PA6 OFF / PA7 OFF
        // PORTA.OUTCLR = PIN6_bm;
        // PORTA.OUTCLR = PIN7_bm;
        VPORTA.OUT &= (~PIN6_bm & ~PIN7_bm);
        _delay_ms(INTERVAL);
    }
}

