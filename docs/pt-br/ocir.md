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

Apesar da aplicação poder ser exposta publicamente, somente os recursos existentes na VCN serão capazes de baixar a imagem (pull) deste repositório.

## Procedimento para enviar as imagens ao OCIR


