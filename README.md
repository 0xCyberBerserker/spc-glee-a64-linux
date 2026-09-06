# SPC Glee 10.1 A64 Linux

Clean, reproducible base for running Linux on the **SPC Glee 10.1 2 GB/32 GB**
tablet with an **Allwinner A64** SoC. It records the verified bring-up, the
current device tree and reusable USB access without including private apps,
credentials, workstation configuration, firmware dumps or storage images.

> Status: Linux boots from microSD and the tested system has remained stable for
> a maintainer-reported 6–7 day USB-connected uptime. This duration is a field report,
> not an automated benchmark.

## Confirmed hardware

- SoC: Allwinner A64, BSP ID `sun50iw1p1`.
- CPU/RAM: four Cortex-A53 cores and 2 GiB RAM.
- Display: 1024×600 LVDS with PWM backlight.
- GPU: Mali-400 MP2 through Lima DRM.
- Touch: GSL3675B/Silead, I²C address `0x40`.
- PMIC/battery: AXP803-compatible path over RSB.
- Wi-Fi/Bluetooth: RTL8723BS.
- Accelerometer: STK8BA50.
- Audio: A64 codec, sun6i DMA and external speaker enable on PH7.
- Cameras: GT2005 rear and GC0312 front, currently unsupported by mainline drivers.

See [docs/hardware-support.md](docs/hardware-support.md) for the evidence matrix
and [docs/touchscreen-firmware.md](docs/touchscreen-firmware.md) for the
owner-supplied firmware workflow.

## Current boot model

```text
BootROM FEL
  -> board DRAM SPL
  -> TF-A BL31
  -> U-Boot AArch64
  -> Linux + SPC Glee DTB
  -> Arch Linux ARM on microSD
```

The known-good device tree disables `mmc2`, so eMMC is not exposed to Linux.
The public baseline deliberately keeps that protection.

## Quick start

Prepare the source trees:

```bash
./scripts/fetch-sources.sh
./scripts/apply-linux-support.sh
```

Build on a Linux host with the cross toolchain:

```bash
./scripts/build-kernel.sh
```

Or use Docker:

```bash
./scripts/docker-build.sh
./scripts/docker-kernel.sh
```

Limit host load when needed with `JOBS=2 ./scripts/docker-kernel.sh`.

## Cross-compilation with Docker

The optional image contains both GNU cross toolchains:

- `aarch64-linux-gnu-` for Linux, TF-A and AArch64 U-Boot.
- `arm-linux-gnueabihf-` for AArch32 SPL/legacy investigations.

The container runs as the invoking user, mounts only the repository at
`/workspace`, receives no privileged mode, USB device or block device, and
writes artifacts to `build/`. Open an interactive toolchain shell with:

```bash
./scripts/docker-shell.sh
```

FEL identification and USB/SSH setup are documented in
[manual_usuario.md](manual_usuario.md). No script writes eMMC.

## Source baseline

- Linux stable `v7.1.9`, commit `ffc82ed665314ccf141abc4710830f3f424d98ea`.
- U-Boot `v2026.07`, commit `ece349ade2973e220f524ce59e59711cc919263f`.
- TF-A `v2.15.0`, commit `da738d5eae93af342fdc4995dd3c05acb4c9d757`.
- `sunxi-tools`, commit `d7bbd172a5da601a08f94479de308c6fb714a19a`.

The separate [mainline draft](mainline/README.md) is based on the current
Allwinner maintainer branch and contains one minimal canonical board DTS. It
does not replace the known-good staged runtime tree yet.

## Documentation constraint

No board schematic or official SPC board manual was available. The only SoC
register and memory-address reference used during low-level bring-up was the
**Allwinner A64 User Manual v1.1** PDF. Vendor Android DTBs were used only as
board evidence and are not redistributed here. See [docs/sources.md](docs/sources.md).

Made with 🖤 in Barcelona City 🇪🇸

---

## Español

Base limpia y reproducible para ejecutar Linux en la tablet **SPC Glee 10.1 de
2 GB/32 GB** con SoC **Allwinner A64**. Documenta el bring-up verificado, el
device tree actual y un acceso USB reutilizable sin incluir aplicaciones
privadas, credenciales, configuración de la torre, dumps de firmware ni imágenes.

> Estado: Linux arranca desde microSD y el sistema probado acumula un uptime
> comunicado por el mantenedor de 6–7 días conectado por USB. Es una observación
> de campo, no un benchmark automatizado.

La eMMC queda deshabilitada mediante `mmc2` en el device tree conocido-bueno.
Esta protección se conserva en la base pública.

Inicio rápido:

```bash
./scripts/fetch-sources.sh
./scripts/apply-linux-support.sh
./scripts/build-kernel.sh
```

Cross-compilación opcional con Docker:

```bash
./scripts/docker-build.sh
./scripts/docker-kernel.sh
```

Para limitar la carga del host: `JOBS=2 ./scripts/docker-kernel.sh`.

La imagen contiene toolchains GNU AArch64 y AArch32, se ejecuta con el UID del
usuario, sólo monta el repositorio y no recibe acceso privilegiado, USB ni a
dispositivos de bloques. Los resultados quedan en `build/`.

No existía un esquema de placa ni un manual oficial de SPC. El único documento
de registros y direcciones de memoria del SoC usado durante el trabajo de bajo
nivel fue el PDF **Allwinner A64 User Manual v1.1**. Los DTB vendor de Android
sirvieron como evidencia, pero no se redistribuyen.

El [borrador para mainline](mainline/README.md) está separado del árbol runtime
conocido-bueno y contiene un DTS canónico mínimo basado en la rama actual del
mantenedor Allwinner.

Consulta [manual_usuario.md](manual_usuario.md),
[arquitectura.md](arquitectura.md), [roadmap.md](roadmap.md) y
[docs/touchscreen-firmware.md](docs/touchscreen-firmware.md).
