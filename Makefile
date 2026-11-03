# ==========================================
# ATtiny202 C++ Development
# Debian Linux + AVR-GCC + FT234X
# ==========================================

# MCU
MCU = attiny202
# F_CPU = 20000000UL
# 20MHz ÷ 6 = ~3.33MHz
F_CPU = 3333333UL

# Compiler
CXX = avr-g++

# Programmer
PROGRAMMER = serialupdi
PORT = /dev/ttyUSB0
BAUD = 57600

# Output
TARGET = main

# Compiler options
CXXFLAGS = \
    -mmcu=$(MCU) \
    -DF_CPU=$(F_CPU) \
    -std=gnu++17 \
    -Os \
    -Wall \
    -Wextra \
    -ffunction-sections \
    -fdata-sections \
    -fno-exceptions \
    -fno-rtti \
    -fno-threadsafe-statics

# Linker options
LDFLAGS = \
    -mmcu=$(MCU) \
    -Wl,--gc-sections

# ==========================================
# Build
# ==========================================

all: $(TARGET).hex

$(TARGET).elf: main.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $<

$(TARGET).hex: $(TARGET).elf
	avr-objcopy -O ihex -R .eeprom $< $@

# ==========================================
# Upload via FT234X SerialUPDI
# ==========================================

upload: $(TARGET).hex
	avrdude \
		-p t202 \
		-c $(PROGRAMMER) \
		-P $(PORT) \
		-b $(BAUD) \
		-U flash:w:$(TARGET).hex:i \
		-v

# ==========================================
# Verify
# ==========================================

verify:
	avrdude \
		-p t202 \
		-c $(PROGRAMMER) \
		-P $(PORT) \
		-b $(BAUD) \
		-U flash:v:$(TARGET).hex:i \
		-v

# ==========================================
# Clean
# ==========================================

clean:
	rm -f $(TARGET).elf $(TARGET).hex

# ==========================================
# Information
# ==========================================

size: $(TARGET).elf
	avr-size --format=avr --mcu=$(MCU) $(TARGET).elf

.PHONY: all upload verify clean size

