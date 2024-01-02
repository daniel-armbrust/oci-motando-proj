# OCIR (Oracle Cloud Infrastructure Registry)

## Visão geral

No _[OCI](https://www.oracle.com/cloud/)_, há um serviço de _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ chamado _[OCIR (Oracle Cloud Infrastructure Registry)](https://www.oracle.com/br/cloud/cloud-native/container-registry/)_ no qual é possível usar para armazenar e distribuir as suas próprias _[imagens de contêineres](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryconcepts.htm#About_Images)_.

Antes de entrar em mais detalhes sobre este serviço, há dois outros conceitos que deve-se entender quando lidamos com _imagens de contêineres_ e também com o _container registry_. São eles:

- [Repositório](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryconcepts.htm#About_Repositories)
    - Armazena diferentes versões de uma mesma imagem.
    - Pode ser _público_ ou _privado_ onde o _privado_, só irá permitir acesso interno a partir dos recursos de uma _[VCN](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/Overview_of_VCNs_and_Subnets.htm)_ e não da Internet.

- [Tag](https://docs.docker.com/glossary/#tag)
    - É o meio usado para se versionar uma imagem.

Para a aplicação _Motando_, será criado alguns repositórios privados no _[OCIR](https://www.oracle.com/br/cloud/cloud-native/container-registry/)_ para armazenar a aplicação Web e o serviço de classificados. 

## Criação dos repositórios

A criação do repositório de imagens é bem simples e pode ser feita a partir do _[Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)_ no OCI:

- Repositório _"motando-webapp"_ para armazenar as versões da aplicação Web:

```
daniel_arm@cloudshell:~ (sa-saopaulo-1)$ oci artifacts container repository create \
    --compartment-id ocid1.compartment.oc1..aaaaaaaa \
    --is-immutable false --is-public false --display-name "motando-webapp"
```

- Repositório _"dramatiq-classifiedad"_ para armazenar as versões do serviço de anúncios:

```
daniel_arm@cloudshell:~ (sa-saopaulo-1)$ oci artifacts container repository create \
    --compartment-id ocid1.compartment.oc1..aaaaaaaa \
    --is-immutable false --is-public false --display-name "dramatiq-classifiedad"
```

## Ativando o scan de vulnerabilidades

## Enviando as imagens ao OCIR

Uma vez tendo os respositórios criado no serviço _[OCIR](https://www.oracle.com/br/cloud/cloud-native/container-registry/)_, é hora de enviar uma cópia das imagens locais a ele através de um processo conhecido como _push (upload)_.

O processo de envio das imagens pode ser resumido nos passos abaixo:

1. Gerar um _[Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm)_ para possibilitar que o _Docker_ possa se autenticar no _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ do OCI.

2. Autenticar-se através do comando _"docker login"_ usando o _[Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm)_ gerado previamente.

3. Utilizar o comando _"docker tag"_ para nomear a imagem dentro do que é exigido pelo OCI.

4. Enviar a imagem local ao _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ através do comando _"docker push"_.

### Gerando um Auth Token

_[Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm)_ é um tipo de credencial gerada pelo OCI para autenticação com APIs de terceiros, como é o caso do _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ que é implementado de acordo com a especificação da _[API do Docker Registry](https://distribution.github.io/distribution/spec/api/)_.

Para gerar um _[Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm)_ a partir do _[Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)_, utilize o comando abaixo:

```
daniel_arm@cloudshell:~ (sa-saopaulo-1)$ oci iam auth-token create \
    --user-id ocid1.user.oc1..aaaaaaa --description "Used by Docker"
{
  "data": {
    "description": "Used by Docker",
    "id": "ocid1.credential.oc1..aaaaaaaa",
    "inactive-status": null,
    "lifecycle-state": "ACTIVE",
    "time-created": "2024-01-02T11:36:22.562000+00:00",
    "time-expires": null,
    "token": "Sup3rS3cr3t0",
    "user-id": "ocid1.user.oc1..aaaaaaaa"
  },
  "etag": "3f909af8d2a14bbbbe4253ecdbb6e48d"
}
```

>_**__NOTA:__** Só é possível visualizar o [Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm) uma única vez logo após a sua criação. Caso perca esta chance, será necessário gerar um novo [Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm). Lembrando que é possível ter somente dois [Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm) por usuário._

### Login no Container Registry (OCIR)

Antes de poder enviar as imagens, é necessário realizar um _"docker login"_ no _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ da região correspondente.

O _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ é um serviço regional e, para cada _[região](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm#About)_ do OCI, há um _container registry_ diferente com seu _nome de domínio exclusivo_.

Para o exemplo aqui descrito, está sendo utilizada a região _Brazil East (São Paulo)_ no qual o _[OCIR](https://www.oracle.com/br/cloud/cloud-native/container-registry/)_ é acessado pelo nome _**gru.ocir.io**_:

![alt_text](/githimgs/ocir-region-1.jpg "OCIR - região Brazil East (São Paulo)")

>_**__NOTA:__** Para encontrar o endpoint do serviço em outra região, consulte este [link aqui](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryprerequisites.htm#regional-availability)._

Uma outra informação necessária para se autenticar no _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ é o _[Tenancy Namespace](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/understandingnamespaces.htm)_. Este também pode ser obtido através do _[Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)_:

```
daniel_arm@cloudshell:~ (sa-saopaulo-1)$ oci os ns get
{
  "data": "grxmw2a9myyj"
}
```

Tendo as informações em mãos, estas devem ser informados ao comando _docker login_ na forma _<tenancy-namespace>/<username>_ ou _<tenancy-namespace>/oracleidentitycloudservice/<username>_, caso o tenancy esteja usando a federação do _[Oracle Identity Cloud Service](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/federatingIDCS.htm#top)_. 

```
$ docker login gru.ocir.io
Username: grxmw2a9myyj/darmbrust@gmail.com
Password:
WARNING! Your password will be stored unencrypted in /home/darmbrust/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```

>_**__NOTA:__** Para o Password, deve-se utilizar o [Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm) previamente gerado._

### Enviando a imagem através do _docker push_

Como último passo, deve-se utilizar o comando _docker tag_ e nomear (ou taguear) a imagem de acordo com o seguinte formato:

```
<region-key>.ocir.io/<tenancy-namespace>/<repo-name>:<version>
```

- **region-key**
    - String de três caracteres que identifica a _[região](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm#About)_. Para o exemplo, onde a
    região _Brazil East (São Paulo)_ está sendo usada, o _region-key_ corresponde ao valor _gru_.

- **tenancy-namespace**
    - Informação do _[tenancy namespace](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/understandingnamespaces.htm)_ (valor já obtido anteriormente).

- **repo-name**
    - Nome do _[repositório](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryconcepts.htm#About_Repositories)_ onde a imagem será salva.

- **version**
    - Versão da imagem. Quando não especificado, o valor _latest_ é usado como padrão.

>_**__NOTA:__** O valor latest indica a versão mais recente. Como boa prática, é sempre melhor especificar uma versão (ex: 1.0.0). Isto garante compatibilidade.  Consulte [Versionamento Semântico (SemVer)](https://semver.org/) para saber mais sobre como versionar._

Juntando as informações, para a aplicação Web teremos algo como:

```
gru.ocir.io/grxmw2a9myyj/motando-webapp:1.0.0
```

Para aplicar a _tag_ através do _Docker_, usa-se o _IMAGE ID (d5f276c0ea5a)_ da imagem correspondente:

```
$ docker images
REPOSITORY                                     TAG                   IMAGE ID       CREATED        SIZE
motando-webapp                                 1.0.0                 d5f276c0ea5a   25 hours ago   1.11GB

$ docker tag d5f276c0ea5a gru.ocir.io/grxmw2a9myyj/motando-webapp:1.0.0
```

Assim, é possível enviar a imagem ao _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ através do comando abaixo:

```
$ docker push gru.ocir.io/grxmw2a9myyj/motando-webapp:1.0.0
```

![alt_text](/githimgs/oracle-container-registry-2.jpg "OCIR - Repositórios e imagens")
