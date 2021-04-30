### Experimento de replicação - Workflows 

Este repositório armazena todos os *workflows* utilizados para a produção do experimento da proposta de trabalho "Brazil Data Cube Reproducible Research Management".

Para tornar as operações padronizadas de modo a permitir sua reprodução, todos os passos foram descritos utilizandos arquivos `Makefile`. Neste repositório, estão presentes 3 *workflows*, sendo eles:

- [1. Replicação do trabalho CBERS Data Cube](replication-workflow);
- [2. Reutilização de ERC para classificação de outra região](reusage-workflow)
- [3. Publicação dos ERCs na plataforma Invenio RDM](publication-workflow)

> Cabe notar que para a execução do 3° *workflow* é necessário a configuração do Invenio RDM. No repositório do portal, configurado neste Trabalho, há os passos disponíveis para a configuração do portal. Link para acesso ao portal: [M3nin0/experiment-reproducible-research-portal](https://github.com/M3nin0/experiment-reproducible-research-portal)

## Execução

Nesta seção são apresentados os passos necessários para a execução de cada um dos *workflows* descritos presentes neste repositório.

**Pré-requisitos**: É necessário ter uma máquina Linux (e.g. Ubuntu) com Docker configurado. Para instalar o Docker, confira a [documentação oficial](https://docs.docker.com/get-docker/).

> **Aviso**: Os *workflows* foram testados nos sistemas operacionais Ubuntu 18.04 e Ubuntu 20.04.

### Configuração da chave de acesso aos serviços do Brazil Data Cube

Os cubos de dados utilizados nos *workflows* são recuperados diretamente dos serviços disponibilizados pela plataforma **B**razil **D**ata **C**ube (BDC). Para a utilização desses é necessário a configuração de uma chave de acesso. Para fazer isso, pode-se utilizar o comando abaixo:

```shell
export BDC_ACCESS_TOKEN=...
```

> Substitua "..." por sua chave de acesso. Caso precise, pode-se obter uma chave de acesso através do [Datacube Explorer](https://brazildatacube.dpi.inpe.br/portal/)

Esta variável de ambiente que está sendo definida (`BDC_ACCESS_TOKEN`) é utilizada pelos *scripts* de *workflow* para a recuperação da chave de acesso. Uma vez recuperado elas são utilizadas durante o processamento para acesso aos dados.

### *workflow* - Replicação do trabalho CBERS Data Cube

Este *workflow* realiza a replicação do trabalho "CBERS DATA CUBE: A POWERFUL TECHNOLOGY FOR MAPPING AND MONITORING BRAZILIAN BIOMES". Para isso, é feito a utilização de um `Executable Research Compendium` (ERC) criado com todo o material necessário para a geração dos resultados. Pode-se conferir o ERC criado no repositório [experiment-rep-cbersdatacube](https://github.com/M3nin0/experiment-rep-cbersdatacube).

> Certifique-se de ter realizado a configuração da chave de acesso

Para executar o *workflow*, faça o uso do `make`. O comando, apresentado abaixo, fará a configuração do ambiente base, configurando algumas bibliotecas Python e em seguida realizará a replicação do artigo.

```shell
make replicate
```

Ao final do processo, o ERC utilizado, estará no diretório `replication-workflow/experiment-rep-cbersdatacube`, populado com os dados gerados. Consulte os resultados acessando o diretório `data/derived_data` dentro do ERC.

### *workflow* - Reutilização de ERC para classificação de outra região

Este *workflow* realiza a classificação de uma região no oeste da Bahia utilizando o *workflow* construído para a `Replicação do trabalho CBERS Data Cube`. Esta execução ilustra a generalização que pode ser atingida ao utilizar os conceitos de ERC e *workflows*. Os dados de amostras utilizados foram disponibilizados pelos autores do artigo [Earth Observation Data Cubes for Brazil: Requirements, Methodology and Products](https://www.mdpi.com/2072-4292/12/24/4033).

Para fazer a execução, certifique-se de ter configurado a chave de acesso do BDC, em seguida, utilize o comando `make`, como apresentado abaixo:

```shell
make reuse
```

### *workflow* - Publicação dos ERCs na plataforma Invenio RDM

> **Nota**: Para a execução deste *workflow* espera-se que as etapas listadas anteriormente já tenham sido executadas.

Neste *workflow* é realizado a publicação dos ERCs gerados em ambos os passos anteriores. A publicação é feita em uma instância da plataforma [Invenio RDM](https://inveniosoftware.org/products/rdm/), através da ferramenta [reprocli](https://github.com/M3nin0/experiment-reproducible-research-portal/tree/main/tool), desenvolvida ao neste trabalho.

**Pré-requisito**: É necessário ter uma instância do Invenio RDM configurada juntamente com uma chave de acesso à API Restful da plataforma. Neste trabalho foi feita a configuração de um Invenio RDM e os passos seguidos estão registrados em arquivos `Makefile` no [repositório da aplicação](https://github.com/M3nin0/experiment-reproducible-research-portal/tree/main/portal). Caso seja necessário, pode-se conferir os passos utilizados para realizar sua própria configuração.

Com todo o ambiente Invenio RDM configurado e os resultados gerados nos *workflows* anteriores, pode-se fazer a publicação. Para a publicação do ERC gerado no *workflow* `Replicação do trabalho CBERS Data Cube`, é usado o seguinte comando:

```shell
make publish_replication token=... url=...
```

O mesmo passo é feito para o *workflow* `Reutilização de ERC para classificação de outra região`

```shell
make publish_replication token=... url=...
```

> Lembre-se de trocar os "..." pelos valores equivalentes ao seu serviço do Invenio RDM
