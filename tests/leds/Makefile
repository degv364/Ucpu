core:
	iverilog ../../src/cpu/definitions.v ../../src/cpu/collaterals.v ../../src/cpu/alu.v  \
	../../src/cpu/decoder.v  ../../src/cpu/Module_ROM.v ../../src/cpu/register_file.v  ../../src/cpu/output.v \
	../../src/cpu/bubbler.v ../../src/cpu/cpu.v ../../src/core/ram.v ../../src/core/core.v test_leds.v \
	-o test_leds.vvp
	./test_leds.vvp	
	gtkwave test_leds.vcd

clean:
	rm *.vvp *.vcd
