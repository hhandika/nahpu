---
title: "Preajustes de exportación tabular"
sidebar:
  order: 0
---

Un preajuste de exportación tabular guarda una definición repetible: el tipo de registro, el grupo taxonómico del espécimen, los campos seleccionados y su orden, el formato de encabezado generado y cómo se escriben los valores repetidos. El formato de salida, el nombre del archivo y el destino se eligen al ejecutar la exportación.

`Generated header format` elige cómo se nombran los encabezados: `table::fieldName`, `fieldName`, Darwin Core o el espacio de nombres de NAHPU. Los valores repetidos pueden escribirse en una sola columna con un separador, o repartirse en columnas indexadas como `field_1`, `field_2`. Pruebe un preajuste con registros representativos, incluidos valores faltantes y repetidos, antes de depender de él, y transfiera las configuraciones de usuario cuando quienes colaboran necesiten la misma definición.

Los ajustes se guardan a medida que los cambia, pero el nombre del preajuste no: escriba un nombre nuevo y seleccione `Rename` para confirmarlo. Exporte un solo preajuste desde su fila, o todos desde el menú de opciones; ambos archivos se importan con la misma acción.

Un encabezado Darwin Core no valida por sí solo los datos exportados. Revise el significado de los campos, las unidades y los valores repetidos. Las exportaciones tabulares son para uso posterior, no para restaurar un proyecto NAHPU.

## Más información

- [Exportar Registros](https://nahpu.app/es/usages/export/export-records/)
- [Empaquetar Registros](https://nahpu.app/es/usages/export/export-bundles/)
