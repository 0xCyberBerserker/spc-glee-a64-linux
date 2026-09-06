# Architecture / Arquitectura

## English

The repository separates evidence, hardware description, upstream patches,
rootfs integration and build tooling:

```text
device-tree/       Board description and staged bring-up DTs
patches/linux/     Version-bound Linux changes
rootfs-overlay/    Generic ACM/ECM and SSH configuration
scripts/           Fetch, patch, build and validation commands
docker/            Optional cross-compilation environment
docs/              Evidence, sources and current hardware state
```

The device tree is layered so future A64 tablet ports can reuse the method:

```text
volatile
  -> display-stage1
  -> display-stage2
  -> sd-minimal (touch, Wi-Fi, Bluetooth, battery; eMMC disabled)
```

Each stage adds one bounded hardware group. `sd-minimal` is the current
known-good runtime tree. Experimental changes should start from a new stage or
small overlay, not by rewriting confirmed nodes.

Trust boundaries:

- Allwinner User Manual: SoC register and memory map reference.
- Upstream Linux/U-Boot/TF-A: executable source baseline.
- Vendor Android DTB/boot0: read-only hardware evidence, not trusted source code.
- Live FEL/Linux observations: confirmation for this tested unit and revision.
- Maintainer-reported uptime: operational evidence, not a reproducible stress test.

USB uses ConfigFS to expose ACM and ECM. SSH accepts an owner-provided public
key. The container build mounts only this repository and does not receive USB or
block-device access.

## Español

El repositorio separa evidencia, descripción de hardware, parches upstream,
integración del rootfs y herramientas de compilación.

El device tree está dividido por etapas para servir como modelo a otros ports
de tablets A64: base volátil, pantalla, periféricos y sistema microSD. Cada
etapa añade un grupo acotado y comprobable. `sd-minimal` es el árbol conocido-bueno.

Límites de confianza:

- Manual de usuario Allwinner: registros y mapa de memoria del SoC.
- Linux/U-Boot/TF-A upstream: base de código ejecutable.
- DTB/boot0 Android vendor: evidencia de sólo lectura, no código de confianza.
- Pruebas FEL/Linux: confirmación para la unidad y revisión probadas.
- Uptime comunicado: evidencia operativa, no prueba de estrés reproducible.

El gadget USB usa ConfigFS para ACM y ECM. SSH recibe una clave pública del
propietario. Docker no recibe acceso a USB ni a dispositivos de bloques.
