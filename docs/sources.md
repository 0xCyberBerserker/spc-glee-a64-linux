# Sources and provenance / Fuentes y procedencia

## English

### Primary low-level documentation

The only available document used as a register and physical memory-address map
during the low-level SoC work was:

- **Allwinner A64 User Manual v1.1** —
  <https://linux-sunxi.org/images/b/b4/Allwinner_A64_User_Manual_V1.1.pdf>

It provided the A64 memory map and peripheral register bases used to reason
about UART, USB OTG/MUSB, clock control, DMA and other SoC blocks. It is linked,
not redistributed. No official SPC schematic, board manual or board source tree
was available.

### Upstream source baselines

- Linux stable: <https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git>,
  tag `v7.1.9`, commit `ffc82ed665314ccf141abc4710830f3f424d98ea`.
- U-Boot: <https://github.com/u-boot/u-boot.git>, tag `v2026.07`, commit
  `ece349ade2973e220f524ce59e59711cc919263f`.
- Trusted Firmware-A: <https://github.com/ARM-software/arm-trusted-firmware.git>,
  tag `v2.15.0`, commit `da738d5eae93af342fdc4995dd3c05acb4c9d757`.
- sunxi-tools: <https://github.com/linux-sunxi/sunxi-tools.git>, commit
  `d7bbd172a5da601a08f94479de308c6fb714a19a`.

### Board evidence

The stock Android DTB, boot0 and firmware were inspected read-only to identify
panel timing, GPIOs, regulators and peripheral candidates. These extracted
files are deliberately absent because their redistribution rights are unclear.
The vendor DTB declared 1 GiB, while live anti-alias tests and Linux confirmed
2 GiB; therefore it is evidence, not a directly reusable truth source.

## Español

### Documentación primaria de bajo nivel

El único documento disponible usado como mapa de registros y direcciones
físicas durante el trabajo de bajo nivel fue:

- **Allwinner A64 User Manual v1.1** —
  <https://linux-sunxi.org/images/b/b4/Allwinner_A64_User_Manual_V1.1.pdf>

El PDF aportó el mapa de memoria y las bases de registros de UART, USB
OTG/MUSB, clocks, DMA y otros bloques del SoC. Se enlaza, pero no se
redistribuye. No existía un esquema oficial de SPC, manual de placa ni árbol de
código oficial para este modelo.

### Evidencia de placa

Los DTB, boot0 y firmware Android stock se inspeccionaron únicamente en modo
lectura para identificar temporización del panel, GPIO, reguladores y posibles
periféricos. No se incluyen por no estar claros sus derechos de redistribución.
El DTB vendor declaraba 1 GiB, pero las pruebas anti-alias y Linux confirmaron
2 GiB: debe tratarse como evidencia, no como fuente de verdad directamente
arrancable.
