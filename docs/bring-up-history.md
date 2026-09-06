# Bring-up history / Historial de bring-up

## English

1. Confirmed BootROM FEL and added a device-specific `uaccess` rule.
2. Loaded an A64/H5 SPL into SRAM and returned cleanly to FEL.
3. Probed the expected 2 GiB DRAM range with anti-alias patterns.
4. Built TF-A and U-Boot and established a volatile AArch64 chain.
5. Booted a storage-disabled Linux probe entirely from RAM.
6. Brought up LVDS, backlight, input, PMIC, audio, radio and GPU incrementally.
7. Diagnosed audio with a PIO FIFO test, then fixed the normal ALSA path.
8. Created a microSD-only Arch Linux ARM system with eMMC disabled.
9. Added an ACM console, ECM Ethernet and key-only SSH over the same USB cable.
10. Reached multi-day normal operation; cameras remain the principal hardware gap.

Important audio finding: hardware and DMA were functional. On the tested
TinyALSA non-mmap path, a stale userspace `appl_ptr` was copied back through
`SNDRV_PCM_IOCTL_SYNC_PTR`, rewinding the second write and causing an XRUN. This
was fixed by synchronizing application pointer and availability flags before
checking PCM state. The current public base records the result but does not
vendor TinyALSA.

## Español

1. Se confirmó BootROM FEL y se añadió una regla `uaccess` específica.
2. Se cargó un SPL A64/H5 en SRAM y regresó correctamente a FEL.
3. Se comprobó el rango esperado de 2 GiB de DRAM con patrones anti-alias.
4. Se compiló TF-A/U-Boot y se estableció una cadena AArch64 volátil.
5. Se arrancó Linux íntegramente en RAM, sin rutas de almacenamiento.
6. Se activaron progresivamente LVDS, brillo, entrada, PMIC, audio, radio y GPU.
7. Se aisló el audio mediante PIO/FIFO y se corrigió la ruta ALSA normal.
8. Se creó Arch Linux ARM para microSD con la eMMC deshabilitada.
9. Se añadieron consola ACM, Ethernet ECM y SSH sólo con clave por el mismo USB.
10. Se alcanzó funcionamiento normal durante varios días; las cámaras siguen pendientes.

Hallazgo de audio: el hardware y DMA funcionaban. En la ruta TinyALSA sin mmap,
un `appl_ptr` obsoleto regresaba al kernel mediante `SNDRV_PCM_IOCTL_SYNC_PTR`,
rebobinaba la segunda escritura y generaba XRUN. Se corrigió sincronizando los
flags de puntero y disponibilidad antes de consultar el estado PCM.
