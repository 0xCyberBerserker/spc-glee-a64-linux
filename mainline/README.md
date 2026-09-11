# Mainline series / Serie mainline

## English

`v1/` preserves the submitted series. `v2/` archives the submitted two-patch
series based on sunxi/for-next `913f7eda9f3e3fb1c67285e144e202494d440049`.
It uses `onspc`, adds CPU OPPs and PMIC USB detection, and keeps the VCC-PL
and PLL/AVCC supplies enabled. See [validation and remaining work](v2/TESTING.md).

DTB/schema checks and kexec runtime tests passed for CPU frequency changes,
CPU cooling frequency limits and USB cable detection/reconnection. Cold boot
and 10 minutes of two-worker CPU load with automatic thermal cooling also
passed. Longer stability and sustained full four-core load remain pending.
Earlier v1 boot-to-init
evidence must not be interpreted as proof of sustained stability. The v2 series was sent on 2026-09-11 via the authenticated b4 relay: [v2 series](https://lore.kernel.org/all/20260911-b4-spc-glee-a64-v1-v2-0-ed0b7ff02e0b@proton.me/).

Apply the two numbered patches to the recorded base with `git am`; the cover
letter records the review changes and the limits of hardware validation.

## Español

`v1/` conserva la serie enviada. `v2/` conserva la serie enviada de dos
parches sobre sunxi/for-next `913f7eda9f3e3fb1c67285e144e202494d440049`.
Utiliza `onspc`, añade OPP y detección USB del PMIC y mantiene activas las
alimentaciones VCC-PL y PLL/AVCC. Consultar [validación y pendientes](v2/TESTING.md).

Han pasado los esquemas y las pruebas mediante kexec de cambios de frecuencia,
límite de refrigeración CPU y detección/reconexión del cable USB. También han
pasado el arranque en frío y 10 minutos de carga con dos procesos y refrigeración
automática. Pendientes: estabilidad prolongada y carga sostenida de cuatro
núcleos. La evidencia previa
de v1 llegando a init no demuestra estabilidad sostenida. La v2 se envió el 11-09-2026 mediante el relay autenticado de b4: [serie v2](https://lore.kernel.org/all/20260911-b4-spc-glee-a64-v1-v2-0-ed0b7ff02e0b@proton.me/).

Aplicar los dos parches numerados sobre la base indicada mediante `git am`.
La carta de presentación recoge los cambios de revisión y los límites de
la validación física.
