# Contêineres

## Visão geral

Contêineres foram criados para ser mais uma forma de se isolar a execução de _[processos](https://en.wikipedia.org/wiki/Process_(computing))_ dentro de um sistema operacional. Além dessa característica, todo o conteúdo de um contêiner pode ser empacotado em um grande arquivo _[talball](https://en.wikipedia.org/wiki/Tar_(computing))_, gerando assim o que chamamos de _imagem de contêiner_.

_**__NOTA:__** Isolar a execução de processos dentro de um mesmo sistema operacional não é algo novo. Antes dos contêineres, tecnologias como [Solaris Zones](https://docs.oracle.com/cd/E18440_01/doc.111/e18415/chapter_zones.htm) ou [chroot](https://en.wikipedia.org/wiki/Chroot) cumpriam o mesmo papel._

Uma _imagem de contêiner_ ao ser gerada, pode então ser _transportada_ e executada em um outro ambiente que suporte a execução de contêineres. Ou seja, utilizamos os contêineres para executar uma aplicação e _"empacotar"_ todas as suas dependências (frameworks, bibliotecas, arquivos de configuração, etc) e a partir disso, é possível transportar esse _"pacote"_ para ser executado no _[OCI](https://www.oracle.com/cloud/)_, por exemplo.

Contêineres revolucionaram o desenvolvimento de software pois trazem agilidade, simplificam a forma de se _empacotar_ e _distribuir aplicações_. Tudo que uma aplicação necessita em termos de dependência, está dentro do contêiner _(pacote autocontido)_. O mesmo software pode ser executado sem qualquer alteração em ambientes diferentes (desenvolvimento, teste, produção, etc).

_[Docker](https://developer.oracle.com/learn/technical-articles/what-is-docker)_ é um conjunto de ferramentas que foi desenvolvido para facilitar a _criação_, _transporte_ e _execução de contêineres_. Pode-se dizer que ele é um conjunto de ferramentas que tira proveito de algumas funcionalidades existentes no _[Kernel](https://en.wikipedia.org/wiki/Linux_kernel)_ do _[Linux](https://www.oracle.com/linux/)_ como _[namespaces](https://en.wikipedia.org/wiki/Linux_namespaces)_ e _[cgroups](https://en.wikipedia.org/wiki/Cgroups)_, para criar um _"espaço de trabalho isolado"_ chamado contêiner. 

_**__NOTA:__** Existem outras ferramentas disponíveis para criar e gerenciar contêineres, como o [Podman](https://podman.io/), por exemplo. Porém, o [Docker](https://developer.oracle.com/learn/technical-articles/what-is-docker) é a ferramenta mais popular._

Contêineres não são máquinas virtuais. Uma máquina virtual carrega consigo um sistema operacional completo e inicializável. Já um contêiner é executado dentro de um sistema operacional. Por conta disso, um único sistema operacional pode executar múltiplos contêineres que são _"mais leves"_ que máquinas virtuais completas.


```
$ docker run -it container-registry.oracle.com/os/oraclelinux:8-slim /bin/bash
```

## Semântica de versão