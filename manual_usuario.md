# User manual / Manual de usuario

## English

### Safety first

The provided workflow does not write eMMC. Do not substitute `/dev/mmcblk*`, an
eMMC device, or an unverified host disk in any imaging command. microSD image
creation and flashing are intentionally outside this initial public baseline.

### 1. Identify FEL

Power the tablet fully off. Hold **Volume Up**, connect USB without pressing
Power, keep holding for about ten seconds, then release. The screen stays black.

Build `sunxi-tools`, then run:

```bash
./scripts/check-fel.sh
```

Expected USB identity: `1f3a:efe8`. Expected SoC response starts with:

```text
AWUSBFEX soc=00001689(A64)
```

An optional narrow udev rule is provided in `udev/60-sunxi-fel.rules`. Install
it as root only if the active desktop user cannot access FEL.

### 2. Build the kernel and device trees

Native cross-build:

```bash
./scripts/fetch-sources.sh
./scripts/apply-linux-support.sh
./scripts/build-kernel.sh
```

Docker cross-build:

```bash
./scripts/docker-build.sh
./scripts/docker-kernel.sh
```

Outputs are placed in `build/`. Docker is optional and does not access USB or
block devices.

### 3. USB console and Ethernet on the tablet

Copy `rootfs-overlay/` into the target root filesystem while it is offline.
Network defaults are centralized in
`rootfs-overlay/etc/default/spc-usb-gadget`; edit that file before copying the
overlay if its subnet or locally administered MAC addresses conflict.
Install a public SSH key supplied by the owner:

```bash
sudo ./scripts/install-ssh-key.sh /mnt/spc-rootfs ~/.ssh/id_ed25519.pub
```

Never copy a private key. The included SSH policy disables password login and
permits root only with a public key.

Install the owner-supplied touchscreen firmware separately as described in
`docs/touchscreen-firmware.md`.

Enable the generic services in the target system:

```bash
systemctl enable spc-usb-gadget.service systemd-networkd.service sshd.service
systemctl enable serial-getty@ttyGS0.service
```

After boot, the tablet exposes:

- ACM console as `/dev/ttyGS0` on the tablet and usually `/dev/ttyACM0` on Linux hosts.
- ECM Ethernet using the addresses selected in `spc-usb-gadget`.

Configure temporary host networking:

```bash
sudo ./scripts/setup-usb-network-host.sh
# Run the SSH command printed by the setup script.
sudo ./scripts/cleanup-usb-network-host.sh
```

### Troubleshooting

- No `1f3a:efe8`: repeat the full power-off and Volume Up FEL sequence.
- FEL permission denied: install the device-specific udev rule; do not use a global USB rule.
- USB interface name changed: scripts identify ECM by its configured host MAC, not by `usb0`.
- SSH rejected: check that the public key was installed and file modes are correct.

## Español

### Seguridad

El flujo proporcionado no escribe en la eMMC. No sustituyas dispositivos
`/dev/mmcblk*`, eMMC ni discos del host sin identificar en comandos de imagen.
La creación y escritura de microSD queda fuera de esta primera base pública.

### 1. Entrar en FEL

Apaga completamente la tablet. Mantén **Volumen arriba**, conecta el USB sin
pulsar Power, espera unos diez segundos y suelta. La pantalla permanece negra.

Compila `sunxi-tools` y ejecuta:

```bash
./scripts/check-fel.sh
```

La identidad USB esperada es `1f3a:efe8` y la respuesta empieza por
`AWUSBFEX soc=00001689(A64)`.

### 2. Compilar

Ruta nativa:

```bash
./scripts/fetch-sources.sh
./scripts/apply-linux-support.sh
./scripts/build-kernel.sh
```

Ruta Docker opcional:

```bash
./scripts/docker-build.sh
./scripts/docker-kernel.sh
```

### 3. Consola, red USB y SSH

Copia `rootfs-overlay/` sobre el rootfs destino desmontado y añade únicamente
la clave pública del propietario:

Los valores de red están centralizados en
`rootfs-overlay/etc/default/spc-usb-gadget`. Modifica ese único archivo antes
de copiar el overlay si la subred o las MAC locales entran en conflicto.

```bash
sudo ./scripts/install-ssh-key.sh /mnt/spc-rootfs ~/.ssh/id_ed25519.pub
```

En el sistema destino habilita `spc-usb-gadget.service`, `systemd-networkd`,
`sshd` y `serial-getty@ttyGS0.service`.

El gadget expone consola ACM y Ethernet ECM con las direcciones elegidas en
`spc-usb-gadget`:

```bash
sudo ./scripts/setup-usb-network-host.sh
# Ejecuta el comando SSH mostrado por el script anterior.
sudo ./scripts/cleanup-usb-network-host.sh
```

No copies nunca una clave privada. La plantilla SSH desactiva contraseñas y
sólo permite acceso root mediante clave pública.

Instala por separado el firmware táctil aportado por el propietario siguiendo
`docs/touchscreen-firmware.md`.
