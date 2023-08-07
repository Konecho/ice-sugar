filename = led
pcf_file = io.pcf
ICELINK_DIR = /mnt

build:
	yosys -p "synth_ice40 -json $(filename).json -blif $(filename).blif" $(filename).v
	nextpnr-ice40 --lp1k --package cm36 --json $(filename).json --pcf $(pcf_file) --asc $(filename).asc --freq 48
	icepack $(filename).asc $(filename).bin

prog_flash:
	@if [ -d '$(ICELINK_DIR)' ]; \
        then \
            cp $(filename).bin $(ICELINK_DIR); \
        else \
            echo "iCELink not found"; \
            exit 1; \
    fi


clean:
	rm $(filename).blif $(filename).asc $(filename).bin $(filename).json
