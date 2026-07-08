# FPGA Required Sources

This package is the cleaned Vivado source set for the testac build.

## What This Package Uses

- CPU: `src/cpu/SCPU.v` and helper modules.
- Data memory controller: `src/top/dm_controller.v`.
- Data RAM: Vivado IP named `RAM_B`.
- Instruction ROM: Vivado IP named `ROM_D`, initialized with `program/testac.coe`.
- Remaining external peripherals: EDF netlists in `src/edf/` plus their stubs in `src/edf_stub/`.

## Expected Result

With `SW[7:5] = 000`, a passing run should show:

```text
111100
222200
333300
444400
555500
666600
```

## Do Not Add

Do not add old CPU or dm-controller black boxes:

```text
SCPU.edf
SCPU.v black-box stub
dm_controller.edf
dm_controller.v black-box stub
SCPU_RTL.v
```
