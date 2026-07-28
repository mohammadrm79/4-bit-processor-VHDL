.PHONY: all lint sim test synth clean asm

all: clean test synth

lint:
	./scripts/lint.sh

asm:
	./scripts/assembler.sh

sim:
	./scripts/sim.sh

test:
	./scripts/test.sh

synth:
	./scripts/synth.sh

clean:
	./scripts/clean.sh