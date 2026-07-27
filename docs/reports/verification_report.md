# Verification Report

## Testbench sources present

| Location | DUT/intended scope | Current status |
|---|---|---|
| `tb/unit/tb_alu.vhdl` | ALU | Interface-compatible; tests a subset of operations and Z. |
| `tb/unit/tb_ir.vhdl` | Instruction register | Interface-compatible. |
| `tb/unit/tb_pc.vhdl` | PC | Not interface-compatible: assigns a 4-bit value to 11-bit `next_address`. |
| `tb/unit/tb_register_file.vhdl` | Register file | Not interface-compatible: omits required debug output associations. |
| `tb/unit/tb_control.vhdl` | Control FSM | Not interface-compatible: omits required `alu_result_enable`. |
| `tb/integration/tb_cpu.vhdl` | System top | Selected by the configured flow, but that flow currently stops first at a syntax error in `src/rtl/common/mux.vhdl`; its R3=8 assertion also conflicts with the default image’s R3=13 result. |

`test/and.vhdl` and `test/traffic_light.vhdl` are standalone example designs, not CPU verification testbenches.

## Coverage status

No coverage tool, pass/fail summary, memory-instruction integration check, shift test, flag-corner-case test, control-flow success test, or reproducible passing regression is implemented.

## Revision history

| Version | Description |
|---|---|
| 1.2.0 | Corrected configured-flow status after GHDL validation. |
| 1.1.0 | Replaced empty report with source-based verification status. |
