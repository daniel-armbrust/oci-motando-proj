# OCIR (Oracle Cloud Infrastructure Registry)

## Visão geral

No _[OCI](https://www.oracle.com/cloud/)_, há um serviço de _[container registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ chamado _[OCIR (Oracle Cloud Infrastructure Registry)](https://www.oracle.com/br/cloud/cloud-native/container-registry/)_ no qual é possível usar para armazenar e distribuir as suas próprias _[imagens de contêineres](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryconcepts.htm#About_Images)_.

Antes de entrar em mais detalhes sobre este serviço, há dois outros conceitos que deve-se entender quando lidamos com _imagens de contêineres_ e também com o container registry. São eles:

- [Repositório](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryconcepts.htm#About_Repositories)
    - Armazena diferentes versões de uma mesma imagem.
    - Pode ser público ou privado onde o privado, só irá permitir acesso a partir dos recursos de uma VCN e não da Internet. 

