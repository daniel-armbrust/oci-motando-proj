# MOTANDO

## Início Rápido

### 1. Instalação do _[Terraform](https://developer.hashicorp.com/terraform/downloads)_

```
[opc@devops ~]$ wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip

[opc@devops ~]$ unzip terraform_1.5.7_linux_amd64.zip

[opc@devops ~]$ sudo mv terraform /usr/local/bin/

[opc@devops ~]$ terraform -v
Terraform v1.5.7
on linux_amd64
```

### 2. Instalação do _[Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)_

```
[opc@devops ~]$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

[opc@devops ~]$ chmod +x ./kubectl

[opc@devops ~]$ sudo mv kubectl /usr/local/bin/

[opc@devops ~]$ kubectl version --client
Client Version: v1.28.1
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
```

### 3. Instalação do _[Docker](https://docs.docker.com/engine/install/)_

```
[opc@devops ~]$ sudo yum install -y yum-utils

[opc@devops ~]$ sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

[opc@devops ~]$ sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

[opc@devops ~]$ sudo usermod -a -G docker opc

[opc@devops ~]$ sudo systemctl enable docker

[opc@devops ~]$ sudo systemctl start docker

[opc@devops ~]$ docker -v
Docker version 24.0.6, build ed223bc
```

### 4. Instalação do _[OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__linux_and_unix)_

``` 
[opc@devops ~]$ wget https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh

[opc@devops ~]$ chmod +x ./install.sh

[opc@devops ~]$ ./install.sh --accept-all-defaults

[opc@devops ~]$ oci -v
3.33.0
```

### 5. Adicionando uma _[API Key](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#two)_ no OCI

5.1 - Selecione a região _"Brazil East (Sao Paulo)"_ e em seguida acesse _"My profile"_:

![alt_text](./githimgs/api-key_1.png "API Key #1")

5.2 - Na tela seguinte, acesse _"API keys"_ e clique no botão _"Add API key"_:

![alt_text](./githimgs/api-key_2.png "API Key #2")

5.3 - Salves as respectivas chaves e clique no botão _"Add"_:

![alt_text](./githimgs/api-key_3.png "API Key #3")

5.4 - Logo após, a tela que exibe as configurações da chave que foi adicionada é exibida:

![alt_text](./githimgs/api-key_4.png "API Key #4")

5.5 - As configurações exibidas devem ser inseridas no arquivo de configuração do _[OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__linux_and_unix)_, conforme demonstrado abaixo:

```
[opc@devops ~]$ cat <<EOF > .oci/config
> [DEFAULT]
> user=ocid1.user.oc1..aaaaaaaaqbbgqbbgaaaaqbbgqbbqbbgqbbqbbgqbbqbbgqbbqbbgqbbg
> fingerprint=ef:1d:c3:eb:eb:eb:eb:eb:d0:47:d0:47:92
> tenancy=ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> region=sa-saopaulo-1
> key_file=/home/opc/.oci/priv.key
> EOF
```

5.6 - O mesmo vale para a chave privada que foi baixada anteriormente:

```
[opc@devops ~]$ cat <<EOF >/home/opc/.oci/priv.key
> -----BEGIN PRIVATE KEY-----
> MIIJPBJPBJPBJPBJPBIgkqBADANBhBADANBBADANBBADANBBADANBkiGGvNKGeGv
> fTN+MIIJPBJPBJPBJPBJPBIgkqBADANBhBADANBBADANBBADANBBADANBkiGGvNK
> HTbHTbHTbBJPBJBJPBJBJPADANBBADANBADANBBADANBADANBBADANBYvNKGeRfa
> -----END PRIVATE KEY-----
> EOF
```

5.7 - Por último, um ajuste nas permissões dos arquivos que foram criados:

``` 
[opc@devops ~]$ oci setup repair-file-permissions
```

>_**__NOTA:__** Todos os valores das chaves e suas configurações exibidas aqui, são somente para demonstração e não podem ser utilizados em um ambiente produtivo._

### 6. Adicionando uma _[Customer Secret Key](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcredentials.htm#Working2)_ no OCI
 
6.1 - De volta ao _"My profile"_, selecione _"Customer secret keys"_ e logo após clique no botão _"Gerenate secret key"_:

![alt_text](./githimgs/cust-seckey_1.png "Customer Secret Key #1")

6.2 - Adicione um nome e em seguida clique no botão _"Gerenate secret key"_:

![alt_text](./githimgs/cust-seckey_2.png "Customer Secret Key #2")

6.3 - A tela seguinte exibe somente uma vez a _"Secret Key"_:

![alt_text](./githimgs/cust-seckey_3.png "Customer Secret Key #3")

6.4 - Já o _"Access Key"_ permanece disponível todo o tempo e pode ser obtido conforme abaixo:

![alt_text](./githimgs/cust-seckey_4.png "Customer Secret Key #4")

>_**__NOTA:__** Lembre-se de salvar o _"Secret Key"_ no momento de sua exibição. Depois disso, este não poderá mais ser visualizado._

### 7. Adicionando um _[Auth Token](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcredentials.htm#Working)_

7.1 - De volta ao _"My profile"_, selecione _"Auth tokens"_ e em seguida clique no botão _"Generate token"_:

![alt_text](./githimgs/auth-token_1.png "Auth Token #1")

7.2 - Na tela seguinte, insira uma descrição e gere o token pelo botão _"Generate token"_:

![alt_text](./githimgs/auth-token_2.png "Auth Token #2")

7.3 - Salve o token que foi gerado em local seguro:

![alt_text](./githimgs/auth-token_3.png "Auth Token #3")

>_**__NOTA:__** Lembre-se de salvar o _"Auth Token"_ no momento da sua exibição. Depois disso, este não poderá mais ser visualizado._

### 8. Clonar o _[repositório](https://github.com/daniel-armbrust/oci-motando-proj.git)_ da aplicação

```
[opc@devops ~]$ sudo yum install -y git

[opc@devops ~]$ git clone https://github.com/daniel-armbrust/oci-motando-proj.git
```

### 9. Criar a infraestrutura através do código _[Terraform](https://developer.hashicorp.com/terraform/downloads)_

9.1 - Acessar o diretório que contém o código _[Terraform](https://developer.hashicorp.com/terraform/downloads)_ da aplicação:

```
[opc@devops ~]$ cd oci-motando-proj/terraform/
```

9.2 - Criar um par de chaves SSH para os _[Worker Nodes](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengclustersnodes.htm#Node_Pools)_ do _[OKE](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm)_:

```
[opc@devops ~]$ mkdir keys

[opc@devops ~]$ ssh-keygen -t rsa -b 4096 -f keys/oke-sshkey -q -N ""
```

9.3 - Ajustar as configurações referente ao _[tenancy](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingtenancy.htm)_ no _[Terraform](https://developer.hashicorp.com/terraform/downloads)_:

```
[opc@devops ~]$ mv terraform.tfvars-example terraform.tfvars

[opc@devops ~]$ cat terraform.tfvars
#
# terraform.tfvars
#

# Identity and access parameters
api_private_key_path = "/home/opc/.oci/priv.key"
api_fingerprint = "ef:1d:c3:eb:eb:eb:eb:eb:d0:47:d0:47:92"
tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
user_id = "ocid1.user.oc1..aaaaaaaaqbbgqbbgaaaaqbbgqbbqbbgqbbqbbgqbbqbbgqbbqbbgqbbg"
root_compartment = "ocid1.compartment.oc1..aaaaaaaan272727omgdrggaaaaaaaabbqbbgqbbg"
```

9.4 - Inicializar e criar a infraestrutura:

```
[opc@devops ~]$ terraform init

[opc@devops ~]$ terraform apply -auto-approve
```

### 10. Inicializar o _[OKE](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm)_

10.1 - Inserir os valores correspondentes no arquivo _"motando.env"_ que será usado para inicializar o cluster:

```
[opc@devops ~]$ cd scripts/

[opc@devops ~]$ mv motando.env-example motando.env

[opc@devops ~]$ cat motando.env
#
# motando.env
#
export OCI_REGION_ID='sa-saopaulo-1'
export OCIR_HOST='gru.ocir.io'
export OCIR_USER='daniel.armbrust@oracle.com'
export OCIR_PASSWD='C2C2NMNMNMC2iTPzoP'
export OCI_ACCESS_KEY_ID='be6f4b525252524f49accaacca251d96d96d96'
export OCI_SECRET_ACCESS_KEY='BGf5LLSUOjSKPSPKSPKUuauaUuaZyFd15ZyFdZyFd15='
```

10.2 - Inicializar o cluster:

```
[opc@devops scripts]$ ./oke-init.sh
[INFO] Configuring access to OKE ...
New config written to the Kubeconfig file /home/opc/.kube/config

[INFO] Setting up "docker-registry" secret ...
secret/motando-ocir-secret created

[INFO] Setting up "mysql-secret" secret ...
secret/mysql-secret created

[INFO] Setting up "motando-keys" secret ...
secret/motando-keys created

[INFO] Setting up "broker-secret" secret ...
secret/broker-secret created

[INFO] Setting up "motando-config" configmap ...
configmap/motando-config created

[INFO] Done!
```

10.3 - Checando o acesso ao cluster:

```
[opc@devops scripts]$ kubectl get nodes
NAME            STATUS   ROLES   AGE    VERSION
172.16.10.171   Ready    node    129m   v1.27.2
172.16.10.223   Ready    node    130m   v1.27.2
172.16.10.79    Ready    node    129m   v1.27.2
```

### 11. Criar e transportar as imagens _[Docker](https://docs.docker.com/engine/)_ ao _[Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_

11.1 - Mudar para o diretório _"build"_:

```
[opc@devops scripts]$ cd ../../build/
```

11.2 - Obter o valor do _[tenancy namespace](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/understandingnamespaces.htm)_:

```
[opc@devops build]$ oci os ns get
{
  "data": "grxmw2a9myyj"
}
```

11.3 - Autenticar-se no _[Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ da região de _São Paulo (gru.ocir.io)_:

```
[opc@devops build]$ docker login gru.ocir.io
Username: grxmw2a9myyj/daniel.armbrust@oracle.com
Password:
WARNING! Your password will be stored unencrypted in /home/opc/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```

>_**__NOTA:__** Para o valor "Password" solicitado, utilizar o "Auth Token" que foi previamente gerado._

11.4 - Criar e transportar as imagens ao _[Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_:

```
[opc@devops build]$ ./images-build.sh
```

11.5 - Para verificar se as imagens estão no _[Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_, é possível utilizar o comando abaixo que exibe o _"display-name"_ das três imagens da aplicação:

```
[opc@devops build]$ oci artifacts container repository list \
> --compartment-id ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa \
> --all | grep "display-name"
       "display-name": "motando-celery-classifiedad",
       "display-name": "motando-webapp",
       "display-name": "motando-webapp-init",
```