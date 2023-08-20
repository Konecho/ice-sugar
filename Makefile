filename = led
pcf_file = io.pcf
ICELINK_DIR = /ice

build:
	mkdir -p build
	yosys -p "synth_ice40 -json build/$(filename).json -blif build/$(filename).blif" $(filename).v
	nextpnr-ice40 --lp1k --package cm36 --json build/$(filename).json --pcf $(pcf_file) --asc build/$(filename).asc --freq 48
	icepack build/$(filename).asc build/$(filename).bin

prog_flash:
	@if [ -d '$(ICELINK_DIR)' ]; \
        then \
            cp build/$(filename).bin $(ICELINK_DIR); \
        else \
            echo "iCELink not found"; \
            exit 1; \
    fi

test:
	mkdir -p test
	iverilog $(filename).v $(filename)_tb.v -o test/$(filename).out
	./test/$(filename).out

clean:
	echo