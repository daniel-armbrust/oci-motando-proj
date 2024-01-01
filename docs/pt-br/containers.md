# Contêineres

## Visão geral

Contêineres foram criados para ser mais uma forma de se isolar a execução de _[processos](https://en.wikipedia.org/wiki/Process_(computing))_ dentro de um sistema operacional. Além dessa característica, todo o conteúdo de um contêiner pode ser empacotado em um grande arquivo _[talball](https://en.wikipedia.org/wiki/Tar_(computing))_, gerando assim o que chamamos de _imagem de contêiner_.

>_**__NOTA:__** Isolar a execução de processos dentro de um mesmo sistema operacional não é algo novo. Antes dos contêineres, tecnologias como [Solaris Zones](https://docs.oracle.com/cd/E18440_01/doc.111/e18415/chapter_zones.htm) ou [chroot](https://en.wikipedia.org/wiki/Chroot) cumpriam o mesmo papel._

Uma _imagem de contêiner_ ao ser gerada, pode então ser _transportada_ e executada em um outro ambiente que suporte a execução de contêineres. Ou seja, utilizamos os contêineres para executar uma aplicação e _"empacotar"_ todas as suas dependências (frameworks, bibliotecas, arquivos de configuração, etc) e a partir disso, é possível transportar esse _"pacote"_ para ser executado no _[OCI](https://www.oracle.com/cloud/)_, por exemplo.

Contêineres revolucionaram o desenvolvimento de software pois trazem agilidade, simplificam a forma de se _empacotar_ e _distribuir aplicações_. Tudo que uma aplicação necessita em termos de dependência, está dentro do contêiner _(pacote autocontido)_. O mesmo software pode ser executado sem qualquer alteração em ambientes diferentes (desenvolvimento, teste, produção, etc).

_[Docker](https://developer.oracle.com/learn/technical-articles/what-is-docker)_ é um conjunto de ferramentas que foi desenvolvido para facilitar a _criação_, _transporte_ e _execução de contêineres_. Pode-se dizer que ele é um conjunto de ferramentas que tira proveito de algumas funcionalidades existentes no _[Kernel](https://en.wikipedia.org/wiki/Linux_kernel)_ do _[Linux](https://www.oracle.com/linux/)_ como _[namespaces](https://en.wikipedia.org/wiki/Linux_namespaces)_ e _[cgroups](https://en.wikipedia.org/wiki/Cgroups)_, para criar um _"espaço de trabalho isolado"_ chamado contêiner. 

>_**__NOTA:__** Existem outras ferramentas disponíveis para criar e gerenciar contêineres, como o [Podman](https://podman.io/), por exemplo. Porém, o [Docker](https://developer.oracle.com/learn/technical-articles/what-is-docker) é a ferramenta mais popular._

Contêineres não são máquinas virtuais. Uma máquina virtual carrega consigo um sistema operacional completo e inicializável. Já um contêiner é executado dentro de um sistema operacional. Por conta disso, um único sistema operacional pode executar múltiplos contêineres que são _"mais leves"_ que máquinas virtuais completas.

## Dockerfile

_[Dockerfile](https://docs.docker.com/engine/reference/builder/)_ é um arquivo texto que contém todas as instruções necessárias para se criar uma imagem de contêiner. O Dockerfile da aplicação web _Motando_ possui o seguinte conteudo:

```
$ cat webapp/Dockerfile
#
# Dockerfile
#
FROM container-registry.oracle.com/os/oraclelinux:8-slim as base

LABEL maintainer="Daniel Armbrust <darmbrust@gmail.com>"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /opt/webapp

COPY requirements.txt ./
COPY docker-entrypoint.sh ./

RUN microdnf update -y && \
    microdnf install -y gcc python38-devel python3.8 mysql-devel && \
    python -m ensurepip && \
    python -m pip install --no-cache-dir --upgrade pip setuptools && \
    python -m pip install --no-cache-dir -r requirements.txt && \
    microdnf clean all && rm -rf /var/cache/yum

RUN adduser -l -d /opt/webapp webapp

COPY --chown=webapp:webapp ./motando /opt/webapp/motando/

USER webapp
EXPOSE 8000

ENTRYPOINT ["./docker-entrypoint.sh"]

# Environment: DEV
USER root

FROM base as envdev
COPY --chown=webapp:webapp ./ocisecrt/ /opt/webapp/ocisecrt/
COPY --chown=webapp:webapp ./motando-webapp-init.sh /opt/webapp/motando/
RUN microdnf install -y mysql

ENTRYPOINT ["./docker-entrypoint.sh"]
```

Abaixo, a explicação de alguns dos comandos presentes neste _Dockerfile_:

- [FROM](https://docs.docker.com/engine/reference/builder/#from) : Especifica uma _imagem base_ que será usada para se construir uma nova imagem a partir dela. Neste caso, está sendo usado o _[Oracle Linux versão 8-slim](https://container-registry.oracle.com/ords/ocr/ba/os/oraclelinux)_ como base.

- [WORKDIR](https://docs.docker.com/engine/reference/builder/#workdir) : Altera para o diretório especificado tornando este, o novo diretório raíz de trabalho para execução dos demais comandos. 

- [COPY](https://docs.docker.com/engine/reference/builder/#copy) : Copia arquivos ou diretórios de fora para dentro da imagem em construção.

- [RUN](https://docs.docker.com/engine/reference/builder/#run) : Executa um comando como parte da construção da imagem de contêiner. Perceba que aqui estamos usando o utilitário _microdnf_ para atualizar, instalar o interpretador _[Python](https://developer.oracle.com/languages/python.html)_ e as dependências da aplicação. Este utilitário é a versão reduzida do _[dnf](https://docs.oracle.com/en/learn/use_dnf_on_oracle_8/index.html#introduction)_. 

- [EXPOSE](https://docs.docker.com/engine/reference/builder/#expose) : Informa a porta de rede que a aplicação irá expor. Esta instrução não "abre" nenhuma porta de rede. Ela serve como uma forma de documentar qual é a porta que este contêiner irá expor.

- [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint) : Define o comando que será executado quando o contêiner for criado e iniciado. Para este caso de exemplo, é um shell script que irá iniciar a aplicação Web.

>_**__NOTA:__** Consulte [Dockerfile reference](https://docs.docker.com/engine/reference/builder/) para um descrição de todos os comandos suportados._

Para se construir uma imagem a partir deste _Dockerfile_, basta executar o comando _docker build_ especificando um _nome_ e _tag_ no formato _nome:tag_ através do parâmetro _-t_ conforme abaixo:

```
$ docker build -t motando-webapp:1.0.0 .
```

>_**__NOTA:__** Lembre-se de estar dentro do diretório onde encontra-se o arquivo [Dockerfile](https://docs.docker.com/engine/reference/builder/) para poder executar o comando docker build._

## Multi-stage build

Todo _Dockerfile_ da aplicação _Motando_ utiliza o _[multi-stage build](https://docs.docker.com/build/building/multi-stage/)_ que especifica alguns comandos a mais para a construção da imagem que será executada em ambiente de desenvolvimento.

Para se criar a imagem que será executada em ambiente de desenvolvimento, fora do OCI, deve-se utilizar o comando abaixo:

```
docker image build --target=envdev -t motando-webapp:dev .
```

Basicamente, a opção _--target=envdev_ irá executar também, os comandos que estão abaixo do _FROM base as envdev_:

```
$ tail -6 Dockerfile
FROM base as envdev
COPY --chown=webapp:webapp ./ocisecrt/ /opt/webapp/ocisecrt/
COPY --chown=webapp:webapp ./motando-webapp-init.sh /opt/webapp/motando/
RUN microdnf install -y mysql

ENTRYPOINT ["./docker-entrypoint.sh"]
```

![alt_text](/githimgs/docker_multi-stage-build.png "Multi-stage build")

A técnica do _[multi-stage build](https://docs.docker.com/build/building/multi-stage/)_ é necessária pois as imagens que são executadas em ambiente de desenvolvimento, precisam de alguns arquivos para assinar as solicitações de API do OCI. Tais arquivos estão contidos no diretório "_ocisecrt/"_. 

>_**__NOTA:__** O link [Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs) descreve o procedimento para gerar as chaves de autenticação usados para assinar as solicitações de API do OCI._

Uma vez, tendo as imagens construídas, é possível visualiza-las com o comando _docker images_:

```
$ docker images
REPOSITORY                                     TAG                   IMAGE ID       CREATED             SIZE
motando-webapp                                 1.0.0                 d5f276c0ea5a   About an hour ago   1.11GB
motando-webapp                                 dev                   99efd0d06555   4 days ago          1.11GB
dramatiq-classifiedad                          dev                   73417ba77b99   4 days ago          616MB
container-registry.oracle.com/os/oraclelinux   8-slim                854e7d006919   11 days ago         116MB
mysql                                          8.0.35-oraclelinux8   ba048db12589   13 days ago         591MB
redis                                          7                     e40e2763392d   3 weeks ago         138MB
```

>_**__NOTA:__** Lembrando que o [Oracle Linux](https://container-registry.oracle.com/ords/ocr/ba/os/oraclelinux) é a imagem base que foi usada para construir a imagem da aplicação. Por conta disso, ela também é exibida através do comando docker images._

## Nota sobre Container Registry

_[Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ é um sistema usado para armazenar e distribuir imagens de contêineres sendo o _[Docker Hub](https://hub.docker.com/)_, o maior _registry público_ existente. A _[Oracle](https://www.oracle.com/corporate/)_ também possui o seu próprio _registry público_ de imagens que pode ser acessado através deste _[link aqui](https://container-registry.oracle.com)_:

![alt_text](/githimgs/oracle-container-registry-1.jpg "Oracle Container Registry")

Aqui vale um detalhe! Por padrão, o ferramental do _[Docker](https://developer.oracle.com/learn/technical-articles/what-is-docker)_ sempre faz _download (pull)_ das imagens direto do _[Docker Hub (docker.io)](https://hub.docker.com/)_, quando não especificado o contrário:

```
$ docker image pull oraclelinux:8
Trying to pull repository docker.io/library/oraclelinux ...
8: Pulling from docker.io/library/oraclelinux
eeccb7e6dc78: Pull complete
Digest: sha256:9e930388d5fff03c6ba9c07223d0183bcd00c6b16b71705ca37524a0f467eb19
Status: Downloaded newer image for oraclelinux:8
oraclelinux:8
```

O problema é que o _[Docker Hub](https://hub.docker.com/)_ impõe alguns limites nas operações de _pull_ realizadas nele. Sim, uma operação _pull_ salva localmente a imagem solicitada e permite a sua reutilização, sem a necessidade de um novo _pull_ futuro. De qualquer forma, se há outros desenvolvedores no mesmo time, baixando diversas outras imagens do _Docker Hub_, este limite pode atrapalhar.

O _[Oracle Container Registry](https://container-registry.oracle.com)_ não possui esses limites e é uma alternativa válida para ser usada. Ele possui diversas _imagens docker_ disponíveis, como é o caso da imagem _[Oracle Linux](https://container-registry.oracle.com/ords/ocr/ba/os/oraclelinux)_ que está sendo usada pela  aplicação _Motando_:

```
$ head -5 Dockerfile
#
# Dockerfile
#
FROM container-registry.oracle.com/os/oraclelinux:8-slim as base

```