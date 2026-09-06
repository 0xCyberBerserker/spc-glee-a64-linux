# Touchscreen firmware / Firmware de la pantalla táctil

## English

The GSL3675B controller requires `silead/spc-glee-a102.fw`. The tested microSD
system uses a 39,864-byte blob with this SHA-256 digest:

```text
abad43e66f9ee9a4848f4fc1e18f5618fa1518b3c0da575d82a661af971686d6
```

It was obtained read-only from the owner's stock Android material and is
confirmed working on the tested tablet. It is not included here because no
redistribution grant has been established. The `gsl-firmware` project also
warns that extracted firmware images may remain covered by proprietary
licenses or copyright.

Obtain the matching blob lawfully from your own backup or vendor image. Do not
substitute firmware from a different tablet merely because it uses a GSL3675.
Install it into an offline root filesystem with:

```bash
sudo ./scripts/install-touch-firmware.sh /mnt/spc-rootfs OWNER_FIRMWARE_FILE
```

The installer rejects the host root filesystem, follows no destination
symlink and accepts only the known-good digest. It writes the verified blob as
`/usr/lib/firmware/silead/spc-glee-a102.fw` inside the selected root filesystem.

Reference tooling and licensing warning:
<https://github.com/onitake/gsl-firmware>

## Español

El controlador GSL3675B necesita `silead/spc-glee-a102.fw`. El sistema probado
en microSD utiliza un blob de 39.864 bytes con la huella SHA-256 indicada arriba.

Se obtuvo en modo de sólo lectura del material Android stock del propietario y
funciona en la tablet probada. No se incluye porque no se ha demostrado un
permiso de redistribución. El proyecto `gsl-firmware` también advierte que los
firmwares extraídos pueden seguir sujetos a copyright o licencias propietarias.

Cada propietario debe obtener legalmente el blob correspondiente desde su
propia copia de seguridad o imagen vendor. No debe usarse un firmware de otra
tablet sólo porque monte un GSL3675. Instálalo sobre el rootfs desmontado con:

```bash
sudo ./scripts/install-touch-firmware.sh /mnt/spc-rootfs FIRMWARE_DEL_PROPIETARIO
```

El instalador rechaza el rootfs del host, no sigue enlaces simbólicos de destino
y sólo acepta la huella conocida-buena. El resultado queda en
`/usr/lib/firmware/silead/spc-glee-a102.fw` dentro del rootfs elegido.
