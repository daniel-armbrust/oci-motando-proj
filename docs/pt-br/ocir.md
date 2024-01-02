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

1. Gerar um _[Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm)_ para possibilitar que o Docker possa se autenticar no _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ do OCI.

2. Autenticar-se através do comando _"docker login"_ usando o _[Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm)_ gerado previamente.

3. Utilizar o comando _"docker tag"_ para nomear a imagem dentro do que é exigido pelo OCI.

4. Enviar a imagem local ao _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ através do comando _"docker push"_.

### Gerar um Auth Token

_[Auth Token](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm)_ é um tipo de credencial gerada pelo OCI para autenticação com APIs de terceiros, como é o caso do _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ que é implementado de acordo com a especificação da _[API do Docker Registry](https://distribution.github.io/distribution/spec/api/)_.
