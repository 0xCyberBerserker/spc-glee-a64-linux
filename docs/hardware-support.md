# Hardware support / Soporte de hardware

## English

| Subsystem | State | Evidence or limitation |
|---|---|---|
| BootROM FEL | Confirmed | USB `1f3a:efe8`, A64 SoC ID `0x1689` |
| CPU | Confirmed | Four Cortex-A53 cores |
| RAM | Confirmed | 2 GiB, live range `0x40000000–0xbfffffff` |
| microSD boot | Confirmed | Root on MMC0 |
| eMMC isolation | Confirmed | MMC2 disabled in the runtime DTB |
| Display | Confirmed | LVDS 1024×600, Lima DRM, PWM backlight |
| Touch | Confirmed | GSL3675B/Silead at I²C `0x40`; external firmware required |
| Audio output | Confirmed | ALSA + sun6i DMA; clean PCM playback |
| Battery | Confirmed | AXP20x/AXP803 power-supply telemetry |
| Wi-Fi | Confirmed | RTL8723BS SDIO association and traffic |
| Bluetooth | Confirmed | RTL8723BS UART transport |
| Accelerometer | Confirmed | STK8BA50; rotation path operational |
| USB gadget | Confirmed | ACM console + ECM Ethernet |
| GPU | Confirmed | Mali-400 MP2 through Lima; 24-bit color path used |
| Cameras | Pending | GT2005 rear and GC0312 front lack compatible mainline drivers |
| Suspend/resume | Partial | Normal operation is stable; formal cycle/stress suite pending |

Operational note dated 2026-09-06: the current user reports 6–7 days of uptime
while connected over USB, without a required reboot. This has not yet been
captured by an automated soak-test record.

## Español

| Subsistema | Estado | Evidencia o límite |
|---|---|---|
| BootROM FEL | Confirmado | USB `1f3a:efe8`, ID A64 `0x1689` |
| CPU | Confirmado | Cuatro Cortex-A53 |
| RAM | Confirmada | 2 GiB, rango real `0x40000000–0xbfffffff` |
| Arranque microSD | Confirmado | Raíz en MMC0 |
| Aislamiento eMMC | Confirmado | MMC2 deshabilitada en el DTB runtime |
| Pantalla | Confirmada | LVDS 1024×600, Lima DRM y brillo PWM |
| Táctil | Confirmado | GSL3675B/Silead en I²C `0x40`; requiere firmware externo |
| Audio | Confirmado | ALSA + DMA sun6i; PCM limpio |
| Batería | Confirmada | Telemetría power-supply AXP20x/AXP803 |
| Wi-Fi | Confirmado | RTL8723BS SDIO, asociación y tráfico |
| Bluetooth | Confirmado | RTL8723BS por UART |
| Acelerómetro | Confirmado | STK8BA50; rotación operativa |
| Gadget USB | Confirmado | Consola ACM + Ethernet ECM |
| GPU | Confirmada | Mali-400 MP2 mediante Lima; ruta de color de 24 bits |
| Cámaras | Pendientes | GT2005 y GC0312 sin drivers mainline compatibles |
| Suspensión | Parcial | Uso normal estable; falta una prueba formal repetida |

Nota operativa del 06-09-2026: el mantenedor comunica 6–7 días de uptime conectado
por USB sin reinicios necesarios. Todavía no existe un registro automático de
soak test que mida ese periodo.
