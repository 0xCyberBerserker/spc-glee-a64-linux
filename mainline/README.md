# Mainline Linux submission / Envío a Linux mainline

## English

`v1/` contains a draft two-patch series based on the Allwinner maintainer
branch `sunxi/for-next` at commit
`913f7eda9f3e3fb1c67285e144e202494d440049`.

The first patch registers the `spc` vendor prefix and board compatible. The
second adds one canonical board DTS. It enables only the AXP803 PMIC, battery
monitoring, microSD, UART and USB peripheral mode. eMMC and hardware requiring
local driver patches remain disabled.

Apply and validate in a clean Linux tree:

```bash
git am /path/to/mainline/v1/0001-*.patch /path/to/mainline/v1/0002-*.patch
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
  dt_binding_check \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/sunxi.yaml
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
  CHECK_DTBS=y allwinner/sun50i-a64-spc-glee.dtb
```

Before submission:

- Boot-test the exact generated DTB from microSD without writing eMMC.
- Rebase on the current `sunxi/for-next` branch and regenerate the series.
- Replace the draft sign-off with the submitter's real DCO identity.
- Generate recipients with `scripts/get_maintainer.pl`.

Do not mail the series until all four points are complete.

Recorded on 2026-09-06: clean `git am`, targeted DT compilation,
`dt_binding_check` and `CHECK_DTBS=y` passed against the pinned baseline using
dt-schema 2026.6. `W=1` reports only three warnings inherited from
`sun50i-a64.dtsi`. Boot validation of this exact DTB remains pending.

## Español

`v1/` contiene un borrador de dos parches basado en la rama del mantenedor
Allwinner `sunxi/for-next`, commit
`913f7eda9f3e3fb1c67285e144e202494d440049`.

El primer parche registra el prefijo `spc` y el compatible de la placa. El
segundo añade un único DTS canónico. Sólo activa el PMIC AXP803, batería,
microSD, UART y USB periférico. La eMMC y el hardware que aún necesita parches
locales permanecen deshabilitados.

Los comandos anteriores aplican y validan la serie en un árbol Linux limpio.
Antes de enviarla hay que probar el DTB exacto arrancando desde microSD, rebasar
contra la rama actual, usar la identidad DCO real del remitente y recalcular los
destinatarios. No debe enviarse antes de completar esos cuatro puntos.

Validación registrada el 06-09-2026: `git am` limpio, compilación dirigida del
DTB, `dt_binding_check` y `CHECK_DTBS=y` correctos contra la base fijada usando
dt-schema 2026.6. `W=1` sólo muestra tres avisos heredados de
`sun50i-a64.dtsi`. Sigue pendiente arrancar este DTB exacto.
