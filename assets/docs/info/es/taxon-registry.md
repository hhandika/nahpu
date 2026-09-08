---
title: "Registro de taxones"
sidebar:
  order: 0
---

El registro contiene los nombres taxonómicos disponibles para este proyecto. Los registros de especímenes apuntan a un taxón registrado para su identificación.

Agregue taxones manualmente o importe archivos `.xlsx`, `.csv` o `.tsv`. El registro manual pide primero un `Taxon rank` y luego muestra los campos de nombre hasta esa categoría. Las importaciones aceptan registros de clase, orden, familia, género, especie y subespecie. Cada fila requiere los campos de clasificación desde clase hasta la categoría seleccionada. Revise cada asignación de columna detectada antes de importar.

Un archivo puede omitir `Taxon rank`, `Kingdom`, `Phylum` y `Class`. Si `Class` no está asignada, elija la clase admitida común a todas las filas en `Select the class shared by all rows`. NAHPU completa reino y filo ausentes para clases conocidas y conserva los valores proporcionados. Si no se indica la categoría, orden, familia, género y epíteto específico deben estar completos; la categoría será especie, o subespecie cuando haya epíteto subespecífico. Los archivos con varias clases necesitan una columna `Class`.

El panel cuenta los órdenes, las familias y los nombres de especie completos distintos que contiene el registro. Un total de taxones aparece cuando el registro también contiene nombres por encima o por debajo de la categoría de especie. Estos son conteos del registro; el panel de estadísticas informa los taxones que realmente usan los registros de especímenes.

Para importar desde QR, seleccione `Scan QR` y luego `Single taxon` o `Multiple taxa`. Un escaneo válido abre la vista previa; el modo múltiple mantiene la cámara abierta hasta seleccionar `Done`. Revise e importe los taxones seleccionados para guardarlos. Los taxones existentes están deshabilitados y nunca se sobrescriben.

## Más información

- [Registro de Taxones](https://nahpu.app/es/usages/taxon/)
