# v2 hardware validation / Validación de hardware v2

## English

Validated on 2026-09-11 using Linux `7.3.0-rc1-spc-review-v2-r2+` and the
corrected DTB (SHA-256 `76b96bc3af170659080b8233a4f347113357787f0802bd2f68d1d03bc004fcfb`).

- DTB build, full schema validation and the ALDO change checkpatch pass.
  Three inherited SoC W=1 warnings remain; optional yamllint was unavailable.
- kexec reached SSH-accessible userspace without `regulator_ignore_unused`.
- CPUfreq registered eight OPP frequencies. Requested/observed transitions:
  648/648, 816/816 and 1152/1152 MHz. CPU temperature stayed near 49 °C.
- CPU cooling state 7 capped and reduced frequency to 648 MHz. Automatic
  thermal updates were paused for one second for the actuator test and
  restored; this does not validate automatic response under sustained load.
- USB supply online/present changed 1 → 0 → 1 on physical unplug/replug.
  SSH reconnected. The known-good fixed-path boot files were preserved.

The stock firmware maps ALDO2 to VCC-PL and ALDO3 to VCC-AVCC/VCC-PLL.
The baseline reports 1.8 V and 3.0 V respectively, enabled. Keeping both on
resolved the loss of progress observed in the preceding kexec tests.

Earlier test configurations forced their compiled command line and lacked
these always-on supplies. Those packages are superseded. The corrected
configuration accepts the kexec command line. Loading required closing the
tablet graphical session and reclaiming caches after syncing the microSD.

Cold boot on a separate test microSD also reached SSH-accessible userspace
without `regulator_ignore_unused`. The test U-Boot uses fixed Image/DTB paths
with the corrected command line. CPUfreq transitions and the cooling actuator
test passed again (CPU near 44 °C); USB supply reported connected and charging.
The governor and automatic thermal updates were restored after testing.

Automatic thermal response was also exercised with SHA-256 CPU load:
- Four workers triggered automatic frequency reduction above the 75 °C passive
  trip; the test stopped at its conservative 80 °C limit after 27 seconds.
- Two workers completed 10 minutes, peaking at 78.37 °C. Cooling states 0–3
  were observed with USB online throughout and SSH remaining connected.
- After 30 seconds idle, temperature fell to 51.46 °C and cooling state returned
  to 0 with the 1152 MHz maximum restored. No load workers remained.

Pending: longer stability testing and sustained full four-core load validation.
Series submitted on 2026-09-11 via the b4 relay.

## Español

Validado el 11-09-2026 con Linux `7.3.0-rc1-spc-review-v2-r2+` y el DTB
corregido (SHA-256 `76b96bc3af170659080b8233a4f347113357787f0802bd2f68d1d03bc004fcfb`).

- Compilación, esquema completo y checkpatch del cambio ALDO correctos.
  Persisten tres avisos W=1 heredados del SoC; yamllint opcional no disponible.
- kexec alcanzó userspace accesible por SSH sin `regulator_ignore_unused`.
- CPUfreq registró ocho frecuencias OPP. Transiciones solicitadas/observadas:
  648/648, 816/816 y 1152/1152 MHz. CPU alrededor de 49 °C.
- El estado de refrigeración 7 limitó y redujo la frecuencia a 648 MHz.
  Se pausaron las actualizaciones térmicas automáticas durante un segundo y
  se restauraron después; no valida su respuesta automática bajo carga.
- La alimentación USB pasó de presente/conectada a ausente/desconectada y
  volvió al reconectar físicamente el cable. SSH se recuperó. Se conservaron
  los archivos de arranque conocidos.

El firmware original asigna ALDO2 a VCC-PL y ALDO3 a VCC-AVCC/VCC-PLL.
El sistema conocido los mantiene encendidos a 1,8 V y 3,0 V. Mantener ambas
líneas activas resolvió la pérdida de progreso de las pruebas kexec previas.

Los paquetes anteriores forzaban argumentos compilados o carecían de estas
alimentaciones permanentes: quedan sustituidos. La configuración corregida
acepta los argumentos de kexec. Para cargarla fue necesario cerrar la sesión
gráfica de la tablet y liberar cachés tras sincronizar la microSD.

El arranque en frío desde una microSD de prueba independiente también alcanzó
userspace accesible por SSH sin `regulator_ignore_unused`. El U-Boot de prueba
usa rutas fijas de Image/DTB con los argumentos corregidos. Las transiciones de
CPUfreq y la prueba del actuador térmico volvieron a pasar (CPU alrededor de
44 °C); USB indicó conexión y carga. Se restauraron el governor y las
actualizaciones térmicas automáticas tras la prueba.

También se comprobó la respuesta térmica automática con carga SHA-256:
- Cuatro procesos activaron la reducción automática de frecuencia al superar
  el umbral pasivo de 75 °C; la prueba se detuvo a los 27 segundos al alcanzar
  su límite conservador de 80 °C.
- Dos procesos completaron 10 minutos, con un máximo de 78,37 °C y estados
  de refrigeración 0–3. USB permaneció conectado y SSH mantuvo la conexión.
- Tras 30 segundos en reposo, la temperatura bajó a 51,46 °C y el estado volvió
  a 0, recuperando el máximo de 1152 MHz. No quedaron procesos de carga.

Pendientes: estabilidad prolongada y carga sostenida completa de cuatro núcleos.
Serie enviada el 11-09-2026 mediante el relay de b4.
