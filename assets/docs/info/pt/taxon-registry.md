---
title: "Registro de táxons"
sidebar:
  order: 0
---

O registro contém os nomes taxonômicos disponíveis para este projeto. Os registros de espécimes apontam para um táxon registrado para sua identificação.

Adicione táxons manualmente ou importe arquivos `.xlsx`, `.csv` ou `.tsv`. O registro manual pede primeiro um `Taxon rank` e depois mostra os campos de nome até essa categoria. As importações aceitam registros de classe, ordem, família, gênero, espécie e subespécie. Cada linha exige os campos de classificação de classe até a categoria selecionada. Revise cada mapeamento de coluna detectado antes de importar.

Um arquivo pode omitir `Taxon rank`, `Kingdom`, `Phylum` e `Class`. Se `Class` não estiver mapeada, escolha a classe compatível comum a todas as linhas em `Select the class shared by all rows`. O NAHPU preenche reino e filo ausentes para classes conhecidas e preserva os valores fornecidos. Se nenhuma categoria for informada, ordem, família, gênero e epíteto específico devem estar completos; a categoria será espécie, ou subespécie quando houver epíteto subespecífico. Arquivos com várias classes precisam de uma coluna `Class`.

O painel conta as ordens, as famílias e os nomes de espécie completos distintos existentes no registro. Um total de táxons aparece quando o registro também contém nomes acima ou abaixo do nível de espécie. Essas são contagens do registro; o painel de estatísticas informa os táxons que os registros de espécimes de fato usam.

Para importar de QR, selecione `Scan QR` e depois `Single taxon` ou `Multiple taxa`. Um escaneamento válido abre a prévia; o modo múltiplo mantém a câmera aberta até selecionar `Done`. Revise e importe os táxons selecionados para salvá-los. Os táxons existentes ficam desabilitados e nunca são sobrescritos.

Editar um táxon registrado altera o registro compartilhado do nome. Para corrigir apenas a identificação de um espécime, selecione o táxon adequado nesse espécime.

## Saiba mais

- [Registro de Táxons](https://nahpu.app/pt/usages/taxon/)
