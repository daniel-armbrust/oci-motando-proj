# Ambiente de Desenvolvimento (DEV)

Aqui está descrito os procedimentos usados para construção do ambiente de desenvolvimento da aplicação _Motando_.

Principais softwares e versões em uso:

- [Python 3.8](https://www.python.org/downloads/release/python-380/)
- [Banco de dados MySQL 8.0.35](https://dev.mysql.com/downloads/mysql/8.0.html)
- [Django 4.2](https://www.djangoproject.com/download/)
- [Dramatiq 1.15](https://dramatiq.io/installation.html)
- [Redis 7](https://redis.io/download/)

Mesmo em desenvolvimeto, o serviço de _[Object Storage](https://docs.oracle.com/en-us/iaas/Content/Object/Concepts/objectstorageoverview.htm)_ e _[Logging](https://docs.oracle.com/en-us/iaas/Content/Logging/Concepts/loggingoverview.htm)_ da _Oracle Cloud (OCI)_ são utilizados. Por conta disso, é necessário uma conta ativa no _OCI_.

_**__NOTA:__** As credênciais de acesso aqui utilizadas e valores [OCID](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/identifiers.htm#Oracle), são inválidos e não servem para uso real. Estão aqui somente para demonstração dos procedimentos._

## Descrição geral

O desenvolvimento da aplicação _Motando_ será feito a partir de um
simples _[Virtual Environment (venv)](https://docs.python.org/3/library/venv.html)_. Este ambiente virtual irá hospedar o código da aplicação e suas diversas  dependências, como também os arquivos que fazem parte do framework _[Django](https://www.djangoproject.com/)_.

Todos os outros recursos de infraestrutura necessários para execução da aplicação como o banco de dados _[MySQL](https://www.mysql.com/)_, _[Dramatiq](https://dramatiq.io/index.html)_ para tarefas assíncronas e _[Redis](https://redis.io/)_, serão executados separadamente em contêineres _[Docker](https://www.docker.com/get-started/)_.

Além da infraestrutura local, a aplicação utiliza três _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ para armazenar imagens:

| Nome do Bucket           | Visibilidade | Propósito                                                                                                                           |
|--------------------------|--------------|-------------------------------------------------------------------------------------------------------------------------------------|
| dev_motando-img          | Público      | Bucket para as imagens dos anúncios que já estão publicados.                                                                        |              
| dev_motando-tmpimg       | Público      | Bucket para as imagens dos anúncios que ainda não foram publicadas.                                                                 |   
| dev_motando-staticfiles  | Público      | Bucket para as imagens estáticas da aplicação (_[Django static files](https://docs.djangoproject.com/en/4.2/howto/static-files/)_). |

Em termos de arquitetura, a figura abaixo exibe uma visão geral dos itens que fazem parte do ambiente de desenvolvimento:

![alt_text](/githimgs/dev-env_arch-1.png "Infra - Ambiente de DEV")

## Criação dos Buckets através do Terraform

Os três _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ necessários para o funcionamento da aplicação podem ser criados manualmente pela _[Web Console](https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm)_ ou através do código _[Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)_.

Para criar os _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ através do código _[Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)_, execute os passos a seguir:

1 - A partir do diretório raíz do código fonte, acesse o diretório "terraform/dev":

```
$ pwd
/home/darmbrust/oci-motando-proj

$ cd terraform/dev/
```

2 - Inicialize o _[Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)_:


```
$ terraform init
```

3 - Crie os _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ com o comando abaixo:

```
$ terraform apply -auto-approve
```

4 - Se tudo deu certo, os _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ foram criados e você receberá uma mensagem igual a esta ao final da execução do _[Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)_:

```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
```

### Usuário e acesso aos Buckets

Para que a aplicação consiga acessar e manipular os _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_, é necessário criar um usuário com as devidas _[Policies](https://docs.oracle.com/en-us/iaas/Content/Identity/policiesgs/get-started-with-policies.htm)_ que concedam o acesso.

1 - Criando um usuário para acesso aos _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ através do _[Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)_ no OCI:

```
```

2 - Criando as _[IAM Policies](https://docs.oracle.com/en-us/iaas/Content/Identity/policiesgs/get-started-with-policies.htm)_ que concedem acesso aos _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_:

```
```

3 - Além da criação do usuário, é necessário criar também as credênciais do tipo _[Access Key/Secret Key](https://docs.oracle.com/en-us/iaas/Content/Identity/access/managing-user-credentials.htm#Working2)_ que serão usadas para autenticação ao acessar os _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_.

```
```

4 - Tendo o par _[Access Key/Secret Key](https://docs.oracle.com/en-us/iaas/Content/Identity/access/managing-user-credentials.htm#Working2)_, voltamos a máquina de desenvolvimento para criar as seguintes variáveis de ambiente:

```
$ export OCI_ACCESS_KEY='8aa0aaaaadas8923749hnadsaaaaaaaaa75'
$ export OCI_SECRET_KEY='bbaa0aG8Udv6YO+1i4Gh84mCWIkH3749hnadsaaaa=='
```

Como parte do acesso aos _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ pela aplicação, duas outras informações são necessárias para estarem disponíveis através das variáveis de ambiente na máquina de desenvolvimento.

5 - A primeira delas é o _[Object Storage Namespaces](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/understandingnamespaces.htm)_ que pode ser facilmente obtido a partir do _[Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)_ no OCI:

```
daniel_arm@cloudshell:~ (sa-saopaulo-1)$ oci os ns get
{
  "data": "grxmw2a9myyj"
}
```

6 - A outra é a identificação da _[região](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm#About)_ onde a infraestrutura será criada no OCI. Neste caso, a _[região](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm#About)_ _Brazil East (Sao Paulo)_ é identificada como _sa-saopaulo-1_.

```
$ export OCI_REGION_ID='sa-saopaulo-1'
$ export OCI_OBJSTR_NAMESPACE='grxmw2a9myyj'
```

7 - Por último, a criação das variáveis de ambiente referente aos _[Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ para armazenar as imagens dos anúncios da aplicação _Motando_:

```
$ export OCI_BUCKET_MOTANDO_IMG='dev_motando-img'
$ export OCI_BUCKET_MOTANDO_IMGTMP='dev_motando-tmpimg'
```

## Banco de Dados MySQL

A aplicação _Motando_ utiliza o banco de dados _[MySQL](https://hub.docker.com/_/mysql)_ versão 8.0.35 para persistência.

Para o ambiente de desenvolvimento, o método mais simples é inicializar o banco de dados a partir de um novo contêiner:

```
$ docker run --name mysql -e MYSQL_ROOT_PASSWORD=secreto --net=host -d mysql:8.0.35-oraclelinux8
```

Note que a opção _--net=host_ faz com que a porta _3306/tcp_ do _[MySQL](https://hub.docker.com/_/mysql)_ seja disponibilizada diretamente na interface de rede do Docker Host. Com isso, é possível se conectar diretamente ao _[MySQL](https://hub.docker.com/_/mysql)_ que roda dentro do contêiner:

```
$ mysql -h127.0.0.1 -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.35 MySQL Community Server - GPL

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

Uma vez dentro do _[MySQL](https://hub.docker.com/_/mysql)_, é necessário criar o banco de dados e o usuário que a aplicação irá utilizar:

```
mysql> CREATE DATABASE motandodb CHARSET UTF8MB4;
Query OK, 1 row affected (0.01 sec)

mysql> CREATE USER 'motandousr' IDENTIFIED BY 'secreto';
Query OK, 0 rows affected (0.00 sec)

mysql> GRANT ALL PRIVILEGES ON motandodb.* TO 'motandousr';
Query OK, 0 rows affected (0.01 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.00 sec)
```

## Tarefas assíncronas com Dramatiq

A aplicação _Motando_ utiliza o _[Dramatiq](https://dramatiq.io/index.html)_ para processar tarefas independentes da parte Web. Lembrando que toda interação entre navegador e servidor, utiliza um ciclo requisição/resposta. Este ciclo possui um tempo máximo para ser completado que começa a partir da requisição feita pelo cliente (navegador), até a resposta emitida pelo servidor.

Caso a reposta do servidor demore muito, o protocolo _HTTP_ que controla esse tempo, fecha a conexão que está ativa, interrompendo assim a navegação do cliente. Em outras palavras, há um _TIMEOUT_.

O _Dramatiq_ entra em cena para toda atividade que envolve a publicação de um novo anúncio, atualização ou exclusão. Um anúncio, além das informações que o descrevem, possuem também imagens que são armazenadas em um _[Bucket](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_.

Para um novo anúncio, as imagens primeiramente vão para um _Bucket_ temporário (dev_motando-tmpimg). Logo após, o _Dramatiq_ é comandado pela aplicação Web (via _[XMLRPC](https://docs.python.org/3/library/xmlrpc.html)_) para transferir a imagem do _Bucket_ temporário (dev_motando-tmpimg) para o _Bucket_ permanente (dev_motando-img).

Esse processo de cópia entre os _Buckets_, pode levar a algum tempo e prejudicar a navegação do usuário por conta do tempo no ciclo requisição/resposta imposto pelo protocolo _HTTP_.

Ter o processo de cópia entre _Buckets_, executado de forma independente da aplicação Web, assegura o não _TIMEOUT_ entre cliente e servidor para tratar as imagens dos anúncios.

Optei por utilizar essa arquitetura, de possuir dois _Buckets_, primeiramente como forma de evitar qualquer desperdício de espaço ao salvar as imagens. O _Bucket_ temporário possui uma _[Lifecycle Policy](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/usinglifecyclepolicies.htm)_ para excluír qualquer arquivo depois de um certo período de tempo. Há tempo suficiente para o _Dramatiq_ fazer o seu trabalho e publicar o anúncio e suas imagens.

O processo de publicação (workflow de publicação) de um anúncio e suas imagens, pode ser melhor entendido observando a figura abaixo:

![alt_text](/githimgs/dev_dramatiq-arch-2.png "Workflow de Publicação")

1. Um usuário da aplicação Web posta um novo anúncio contendo algumas imagens.
2. As imagens são salvas pela aplicação Web diretamente no _Bucket_ temporário (dev_motando_tmpimg).
3. Em seguida, a aplicação Web notifica o _Dramatiq_ via _[XMLRPC](https://docs.python.org/3/library/xmlrpc.html)_, dizendo que há um novo anúncio para ser publicado.
4. De forma independente da aplicação Web, o _Dramatiq_ começa o trabalho de publicação do anúncio que consiste basicamente na cópia das imagens entre os _Buckets_.
5. Ao término da cópia, o _Dramatiq_ concluí a publicação do anúncio atualizando alguns dados no _[MySQL](https://docs.oracle.com/en-us/iaas/mysql-database/index.html)_.

Tendo o processo de publicação implementado de forma independente, este pode ser incrementado facilmente com outras atividades se necessário. Por exemplo, é possível enviar um e-mail ao usuário quando a publicação do anúncio estiver sido concluída ou mesmo, acrescentar uma marca d'agua com o logotipo _Motando_ nas imagens.

### Descrição dos arquivos

Abaixo a descrição dos arquivos que fazem parte do serviço de publicação dos anúncios da aplicação _Motando_:

```
$ pwd
/home/darmbrust/oci-motando-proj

$ cd services/dramatiq-classifiedad/ 

$ ls -1F
Dockerfile
README.md
app/
deployment.yaml
docker-entrypoint.sh*
ocisecrt/
readiness-probe.sh*
requirements.txt
service.yaml
venv/
```

- Dockerfile : Arquivo que contém instruções para a construção da imagem Docker.
- app/ : Diretório que contém a aplicação para publicar anúncios.
- docker-entrypoint.sh : Script que é executado quando o contêiner iniciar.
- ocisecrt/ : Diretório que contém os arquivos para autenticação do _[OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#configfile)_ (neccessário somente para o ambiente de dev). 
- requirements.txt : Arquivo que lista as dependências do projeto Python.
- venv/ : Diretório do _[Virtual Environment (venv)](https://docs.python.org/3/library/venv.html)_.

Os arquivos _deployment.yaml_, _service.yaml_ e o script _readiness-probe.sh_, fazem parte da implantação deste serviço no _[Kubernetes](https://kubernetes.io/)_ e não serão detalhados aqui.

### Dramatiq

Basicamente o _[Dramatiq](https://dramatiq.io/index.html)_ é uma biblioteca para processar tarefas de forma assíncrona a partir de uma fila (queue). Porém, sua grande sacada, é que ele possibilita processar tais tarefas de forma independente do programa principal. 

>_**__NOTA:__** Aqui, o "programa principal" é a aplicação Web escrita usando o framework [Django](https://www.djangoproject.com/)._

Como parte do seu funcionamento, o _Dramatiq_ necessita de um serviço separado que seja capaz de armazenar suas mensagens. Este é conhecido como _message broker_ ou _message transport_.

Para o _message broker_, tanto o _[RabbitMQ](https://www.rabbitmq.com/)_ quanto o _[Redis](https://redis.io/)_ são excelentes. Para a aplicação _Motando_ será usado o _Redis_ como broker de mensagens.

![alt_text](/githimgs/dev_dramatiq-arch-3.png "Dramatiq Arch #3")

#### Redis (message broker)

O comando abaixo irá criar o contêiner e iniciar o serviço _[Redis](https://redis.io/)_ na porta 6379/tcp:

```
$ docker run --name redis --net=host -d redis:7
```

### Ambiente Virtual Python e suas dependências

1 - A partir do diretório raíz, deve-se acessar o diretório do serviço _Dramatic_:
```
$ pwd
/home/darmbrust/oci-motando-proj

$ cd services/dramatiq-classifiedad/
```

2- Crie e ative _[Virtual Environment (venv)](https://docs.python.org/3/library/venv.html)_ com os comandos abaixo:
```
$ python3 -m venv venv
$ source venv/bin/activate
(venv) $
```

3 - Instale o _[Dramatiq](https://dramatiq.io/index.html)_, suas dependências e salve-as no arquivo "requirements.txt":
```
(venv) $ pip install -U 'dramatiq[redis, watch]'
(venv) $ pip install oci
(venv) $ pip install mysql-connector-python

(venv) $ pip freeze > requirements.txt 
```

#### Classificados da aplicação Motando e o Dramatiq

O serviço para publicação dos classificados da aplicação _Motando_, utiliza o serviço _[XMLRPC](https://docs.python.org/3/library/xmlrpc.html)_ já presente por padrão no conjunto de bibliotecas do Python3 e o _[Dramatiq](https://dramatiq.io/index.html)_.

Por isso, este serviço depende da execução de dois processos independentes. Para o _XMLRPC_:

1 - Para iniciar o _XMLRPC_, primeiramente accesse o diretório "app/":

```
(venv) $ cd app/
```

2 - O _XMLRPC_ necessita acessar algumas informações através das seguintes variáveis de ambiente:

```
(venv) $ export APP_ENV='DEV'
(venv) $ export OCI_LOG_ID='ocid1.log.oc1.sa-saopaulo-1.amaaaaaa'
(venv) $ export OCI_CONFIG_FILE='/home/darmbrust/.oci/config'
```

3 - Agora, basta iniciar o serviço com o comando abaixo:
```
(venv) $ python xmlrpcs.py 
```

Para o _Dramatiq_:

1 - O _Dramatiq_ necessita de algumas outras informações através das seguintes variáveis de ambiente:

```
(venv) $ export APP_ENV='DEV'

(venv) $ export MYSQL_HOST='127.0.0.1'
(venv) $ export MYSQL_USER='motandousr'
(venv) $ export MYSQL_PASSWD='secreto'
(venv) $ export MYSQL_DBNAME='motandodb'

(venv) $ export REDIS_HOST='127.0.0.1'
(venv) $ export REDIS_PORT=6379
(venv) $ export REDIS_PASSWD=''

(venv) $ export OCI_CONFIG_FILE='/home/darmbrust/.oci/config'
(venv) $ export OCI_REGION_ID='sa-saopaulo-1'
(venv) $ export OCI_OBJSTR_NAMESPACE='grxmw2a9myyj'
(venv) $ export OCI_BUCKET_MOTANDO_IMG='dev_motando-img'
(venv) $ export OCI_BUCKET_MOTANDO_IMGTMP='dev_motando-tmpimg'

(venv) $ export WORKFLOW_OCI_LOG_ID='ocid1.log.oc1.sa-saopaulo-1.amaaaaaa'
```

As tarefas que serão executadas em _background_ pelo _Dramatiq_, necessitam de acesso ao _MySQL_ para publicar um determinado anúncio da aplicação. O _Redis_ é necessário para o funcionamento do _Dramatiq_ e, no ambiente de desenvolvimento, ele pode ser acessado livremente sem senha.

Já as variáveis de ambiente que possuem o prefixo *OCI_*, definem a localização do arquivo de configuração do _[OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)_, a _[região](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm#top)_ do OCI, _[Object Storage Namespace](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/understandingnamespaces.htm)_ e o nome dos _Buckets_. Todas são necessárias para a correta manipulação das imagens a partir do ambiente de desenvolvimento.

Por último, a variável de ambiente *WORKFLOW_OCI_LOG_ID*, corresponde ao OCID referente ao _[Logging](https://docs.oracle.com/en-us/iaas/Content/Logging/Concepts/loggingoverview.htm)_ usado para registrar os logs no OCI.

2 - Tendo as variáveis corretamente configuradas, é possível iniciar o _Dramatiq_ com o comando abaixo:

```
(venv) $ dramatiq tasks
```

#### Imagem Docker

O descrito acima, sobre a criação do ambiente virtual, instalação das dependências, criação das variáveis de ambiente e incialização dos processos, teve o intuíto de apresentar o passo-a-passo usado na criação do serviço que publica os anúncios da aplicação _Motando_.

Porém, para a produção, este serviço deverá ser empacotado em uma _[imagem Docker](https://docs.docker.com/engine/reference/commandline/images/)_ para facilitar todo o transporte e seu deployment

O _[multi-stage build](https://docs.docker.com/build/building/multi-stage/)_ foi especificado no _Dockerfile_, pois os arquivos do _[OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#configfile)_ precisam ser transportados para dentro da imagem. Tais arquivos só são necessários ao executar o contêiner fora do OCI, ou seja, em ambiente de desenvolvimento.

```
$ tail -5 Dockerfile
# Environment: DEV
FROM base as envdev
COPY --chown=dramatiq:dramatiq ./ocisecrt/ /opt/dramatiq-classifiedad/ocisecrt/

ENTRYPOINT ["./docker-entrypoint.sh"]
```

Uma outra necessidade, é que este serviço necessita de dois processos em execução (XMLRPC e Dramatiq). Para isso, será utilizado a estratégia de _[Multi Service Container](https://docs.docker.com/config/containers/multi-service_container/)_ ao iniciar o contêiner. 

```
$ cat app/docker-entrypoint.sh
#!/bin/bash

#
# https://docs.docker.com/config/containers/multi-service_container/
#

# Dramatiq Workers
dramatiq tasks &

# XMLRPC Server
python xmlrpcs.py &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
```

A partir do diretório _"services/dramatiq-classifiedad"_, execute o comando abaixo para criar a imagem Docker:

- Para o ambiente de **desenvolvimento**:

```
$ docker image build --target=envdev -t dramatiq-classifiedad:dev .
```

- Para o ambiente de **produção**:

```
$ docker image build -t dramatiq-classifiedad:1.0.0 .
```

>_**__NOTA:__** Observe que para produção a opção --target=envdev foi omitida ao criar a imagem para o ambiente de produção. Isso é uma boa ideia pois, imagens de produção não devem conter arquivos que contenham credenciais de qualquer tipo._

## A aplicação Motando através do framework Django

### Descrição dos arquivos

Abaixo a descrição dos arquivos que fazem parte do aplicação Web _Motando_:

```
$ pwd
/home/darmbrust/oci-motando-proj

$ cd webapp/

$ ls -1F
Dockerfile
data/
deployment.yaml
docker-entrypoint.sh*
motando/
motando-webapp-init.sh*
ocisecrt/
requirements.txt
service.yaml
venv/
```

- Dockerfile : Arquivo que contém instruções para a construção da imagem Docker.
- data/ : Diretório que contém scripts e dados fictícios para construção do ambiente de desenvolvimento.
- docker-entrypoint.sh : Script que é executado quando o contêiner iniciar.
- motando/ : Diretório da aplicação Web (_[Django Project](https://docs.djangoproject.com/en/4.2/intro/tutorial01/#creating-a-project)_). 
- motando-webapp-init.sh : Script utilizado para inicializar o ambiente de desenvolvimento a partir do contêiner.
- ocisecrt/ : Diretório que contém os arquivos para autenticação do _[OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#configfile)_ (neccessário somente para o ambiente de dev). 
- requirements.txt : Arquivo que lista as dependências do projeto Python.
- venv/ : Diretório do _[Virtual Environment (venv)](https://docs.python.org/3/library/venv.html)_.

### Ambiente Virtual Python e suas dependências

1 - A partir do diretório raíz do código fonte, acesse o diretório "webapp/":

```
$ pwd
/home/darmbrust/oci-motando-proj

$ cd webapp/
```

2 - Crie o _[Virtual Environment (venv)](https://docs.python.org/3/library/venv.html)_ com o comando abaixo:

```
$ python3 -m venv venv
```

3 - Ative o ambiente virtual criado e instale as dependências da aplicação contidas no arquivo _requirements.txt_:

```
$ source venv/bin/activate
(venv) $ pip install -r requirements.txt
```

### Acesso ao banco de dados pela aplicação Motando

1 - Crie as variáveis de ambiente referente ao banco de dados que serão utilizadas pelo framework _[Django](https://www.djangoproject.com/)_:

```
(venv) $ export MYSQL_HOST='127.0.0.1'
(venv) $ export MYSQL_USER='motandousr'
(venv) $ export MYSQL_PASSWD='secreto'
(venv) $ export MYSQL_DBNAME='motandodb'
```

2 - O comando abaixo irá criar as tabelas do banco de dados a partir do script _manage.py_ do framework _[Django](https://www.djangoproject.com/)_:

```
(venv) $ pwd
/home/darmbrust/oci-motando-proj/webapp

(venv) $ motando/manage.py migrate
```

3 - Tendo as tabelas criadas, é necessário inserir alguns dados no banco de dados referente a aplicação:

```
(venv) $ mysql -u motandousr -A motandodb -h127.0.0.1 -p

mysql> source data/data.sql
```

>_**__NOTA:__** Os dados contidos no arquivo data.sql são dados referente a cidades, estados e também sobre marcas e modelos de algumas motocicletas._

### Inserindo dados fictícios

Dentro do diretório _"data/"_, há alguns arquivos e scripts que podem ser usados para inserir alguns dados fictícios. Observe a descrição dos mesmos abaixo:

```
$ pwd
/home/darmbrust/oci-motando-proj/webapp

$ ls -1F data/
accounts.csv
data.sql
img/
load2db.py*
makecsv.py*
rmuser.py*
```

- accounts.csv : Arquivo csv que contém alguns usuários e suas senhas.
- data.sql : Arquivo que contém instruções SQL para inserir dados referentes a estados, cidades, marcas e modelos de motocicletas.
- load2db.py : Script para inserir dados fictícios referente a usuários e anúncios de motocicletas na aplicação.
- img/ : Diretório que contém algumas imagens de motocicletas.

O script **load2db.py** é bastante útil, pois consegue testar todo o processo de publicação de um anúncio (workflow de publicação), testando inclusive a regra de negócio executada pelo _Dramatiq_. Ou seja, para executar o script **load2db.py**, os serviços do _Dramatiq_, _Redis_ e _MySQL_ devem estar em execução conforme demonstrado pela figura abaixo:

![alt_text](/githimgs/dev_dramatiq-arch-4.png "Ambiente de Desenvolvimento")

>_**__NOTA:__** Lembre-se de concluír a tarefa anterior que envolve a adição dos dados contidos no arquivo data.sql. É um pré-requisito necessário para poder executar o script load2db.py._

Para carregar os dados fictícios, seguir os passos abaixo:

1 - Crie as variáveis de ambiente necessárias para execução da aplcação Web:

```
$ export APP_ENV='DEV'

$ export MYSQL_HOST='127.0.0.1'
$ export MYSQL_USER='motandousr'
$ export MYSQL_PASSWD='secreto'
$ export MYSQL_DBNAME='motandodb'

$ export OCI_CONFIG_FILE='/home/darmbrust/.oci/config'
$ export OCI_REGION_ID='sa-saopaulo-1'
$ export OCI_OBJSTR_NAMESPACE='grxmw2a9myyj'
$ export OCI_BUCKET_MOTANDO_IMG='dev_motando-img'
$ export OCI_BUCKET_MOTANDO_IMGTMP='dev_motando-tmpimg'

$ export OCI_ACCESS_KEY='8aa0aaaaadas8923749hnadsaaaaaaaaa75'
$ export OCI_SECRET_KEY='bbaa0aG8Udv6YO+1i4Gh84mCWIkH3749hnadsaaaa=='

$ export CLASSIFIEDAD_XMLRPC_HOST='127.0.0.1'
$ export CLASSIFIEDAD_XMLRPC_PORT=8100

$ export WEBAPP_OCI_LOG_ID=ocid1.log.oc1.sa-saopaulo-1.amaaaaaa
```

Para facilitar, há um arquivo em _"build/motando.env-example"_ que pode ser usado para criar as variáveis de ambiente de uma maneira mais fácil. Preencha com os valores correspondentes e é possível ter as variáveis criadas sempre que necessário da seguinte forma:

```
$ mv build/motando.env-example build/motando.env
$ source build/motando.env
```

2 - Ative o ambiente virtual:

```
$ pwd
/home/darmbrust/oci-motando-proj

$ cd webapp/

$ source venv/bin/activate
(venv) $
```

3 - Acesse o diretório que contém os dados fictícios:

```
(venv) $ pwd
/home/darmbrust/oci-motando-proj/webapp

(venv) $ cd data/
```

4 - Execute o script através do _[Django](https://www.djangoproject.com/)_ para carregar os dados fictícios:

```
(venv) $ ../motando/manage.py shell < ./load2db.py
```

5 - Depois que os dados forem carregados, obtenha um e-mail e senha de qualquer usuário contido no arquivo _"data/accounts.csv"_ para testar o acesso a aplicação.

### Iniciando a aplicação

Uma vez que os dados já foram carregados, é possível iniciar para então testar a aplicação com o comando abaixo:

```
(venv) $ motando/manage.py runserver
```

### Removendo dados fictícios  

Se desejar remover os dados fictícios que foram inseridos, seja para trazer o banco de dados ao estado zero ou mesmo, para realizar novos testes no processo de publicação dos anúncios, basta seguir os passos abaixo:

1 - Acessar o banco de dados e excluír todos os dados na ordem apresentada, das tabelas *classifiedad_images* e logo após da tabela _classifiedad_:

```
(venv) $ mysql -u motandousr -h 127.0.0.1 -A motandodb -p
Enter password: 

mysql> DELETE FROM classifiedad_images;
Query OK, 351 rows affected (0.01 sec)

mysql> DELETE FROM classifiedad;
Query OK, 117 rows affected (0.01 sec)
```

2 - Remover os usuários fictícios que foram inseridos através do _[Django](https://www.djangoproject.com/)_:

```
(venv) $ ../motando/manage.py shell < ./rmuser.py 
```

### Imagem Docker

O procedimento para criação da _[imagem Docker](https://docs.docker.com/engine/reference/commandline/images/)_ da parte Web, segue o mesmo princípio do que foi demonstrado para a imagem do _Dramatiq_.

Aqui, a técnica do _[multi-stage build](https://docs.docker.com/build/building/multi-stage/)_ também é presente, visto que a construção da imagem para o ambiente de desenvolvimento é diferente da construção para o ambiente de produção.

A partir do diretório _"webapp/"_, execute o comando abaixo para criar a imagem Docker:

- Para o ambiente de **desenvolvimento**:

```
$ docker image build --target=envdev -t motando-webapp:dev .
```

- Para o ambiente de **produção**:

```
$ docker image build -t motando-webapp:1.0.0 .
```

## Docker Compose

_[Docker Compose](https://docs.docker.com/compose/compose-file/)_ é uma ferramenta que facilita o provisionamento de múltiplos contêineres, algo que é muito útil em ambiente de desenvolvimento. Basicamente, a ferramenta lê as instruções contidas em um arquivo _[YAML](https://yaml.org/)_ para então criar e iniciar os contêineres lá especificados. Essas instruções correspondem a toda infraestrutura necessária para rodar a sua aplicação. 

Ao invés de criar e executar os contêineres da aplicação de forma manual, conforme demonstrados até aqui, usa-se o _Docker Compose_ para automatizar todo esse processo. 

Para a aplicação _Motando_, o arquivo _YAML_ correspondente ao _Docker Compose_, encontra-se no diretório _"build/"_:

```
$ pwd
/home/darmbrust/oci-motando-proj

$ cd build/

$ ls -1F *.yaml
docker-compose.yaml
```

1 - Primeiramente, lembre-se de criar as variáveis de ambiente com seus respectivos valores:

```
$ source motando.env
```

2 - Para criar as imagens a partir do _Docker Compose_, execute o comando abaixo:

```
$ docker-compose build
```

3 - Uma vez concluído o processo de construção das imagens, basta iniciar os contêineres com o comando abaixo:

```
$ docker-compose up -d
```

Após alguns minutos, a aplicação já pode ser acessada localmente através do endereço: http://127.0.0.1:8000

Para baixar os contêineres em execução, utiliza-se o comando abaixo:

```
$ docker-compose down
```

Para subir apenas um serviço, basta especificar o seu nome de acordo com o nome presente no arquivo _docker-compose.yaml_:

```
$ docker-compose up -d mysql
```

>_**__NOTA:__** O procedimento demonstrado neste tópico, levanta a aplicação sem dados para testes. Lembre-se de adicionar os dados fictícios caso necessário._