# Roadmap

## English

### P0 — public baseline

- [x] Sanitized repository and evidence matrix.
- [x] Known-good staged device tree.
- [x] Native and Docker kernel cross-build entry points.
- [x] Configurable USB ACM, ECM and key-only SSH templates.
- [ ] Reproduce a clean kernel build from a fresh clone and record hashes.
- [ ] Select and document a redistributable touchscreen-firmware workflow.

### P1 — reproducible boot media

- [ ] Document extraction of each owner's stock boot0 without redistributing it.
- [ ] Build TF-A and U-Boot from pinned sources inside Docker.
- [ ] Create a device-independent microSD image builder with destructive safety gates.
- [ ] Test on a second SPC Glee unit or board revision.

### P2 — upstream-quality hardware support

- [ ] Convert staged DTS files into a reviewable board DTS/DTSI series.
- [ ] Re-evaluate local Linux driver changes against newer upstream kernels.
- [ ] Add suspend/resume, battery and long-duration stress tests.
- [ ] Investigate GT2005 and GC0312 camera support.

### Explicitly deferred

- eMMC installation.
- Private control applications and personal infrastructure.
- Desktop-environment customization.

## Español

### P0 — base pública

- [x] Repositorio saneado y matriz de evidencias.
- [x] Device tree por etapas conocido-bueno.
- [x] Cross-compilación nativa y con Docker.
- [x] Plantillas configurables ACM, ECM y SSH sólo con clave.
- [ ] Repetir una compilación limpia y registrar hashes.
- [ ] Definir un flujo redistribuible para el firmware táctil.

### P1 — medio de arranque reproducible

- [ ] Documentar la extracción del boot0 propio sin redistribuirlo.
- [ ] Compilar TF-A y U-Boot fijados dentro de Docker.
- [ ] Crear imágenes microSD con barreras destructivas estrictas.
- [ ] Validar una segunda unidad o revisión de placa.

### P2 — calidad upstream

- [ ] Convertir los DTS por etapas en una serie DTS/DTSI revisable.
- [ ] Reevaluar los cambios locales frente a kernels posteriores.
- [ ] Añadir pruebas de suspensión, batería y estrés prolongado.
- [ ] Investigar las cámaras GT2005 y GC0312.

Se aplazan expresamente la instalación eMMC, las aplicaciones/configuraciones personales y la
personalización del escritorio.
