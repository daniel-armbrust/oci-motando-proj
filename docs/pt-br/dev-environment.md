# Ambiente de Desenvolvimento (DEV)

Aqui está descrito os procedimentos usados para construção do ambiente de desenvolvimento da aplicação _Motando_.

Versões em uso:
- Python 3.8
- Banco de dados MySQL 8.0.35
- Celery
- RabbitMQ

## Descrição geral 

O desenvolvimento da aplicação _Motando_ será feito a partir de um
simples _[Virtual Environment (venv)](https://docs.python.org/3/library/venv.html)_. Este ambiente virtual irá hospedar o código da aplicação e suas diversas  dependências, como também os arquivos que fazem parte do framework _[Django](https://www.djangoproject.com/)_.

Todos os outros recursos de infraestrutura necessários para execução da aplicação como o banco de dados _[MySQL](https://www.mysql.com/)_, _[Celery](https://docs.celeryq.dev/en/stable/index.html)_ para tarefas assíncronas e _[Redis](https://redis.io/)_, serão executados separadamente em contêineres _[Docker](https://www.docker.com/get-started/)_.

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

## A aplicação Motando através do framework Django

### Python Virtual Environment e as dependências da aplicação

1 - A partir do diretório raíz do código fonte, acesse o diretório _webapp_":

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

>_**__NOTA:__** Os dados contidos no arquivo data.sql são dados referente a cidades, estados e também sobre marcas e modeles de algumas motocicletas._

### Arquivos estáticos (static files)

A aplicação _Motando_ possui alguns arquivos estáticos como imagens, páginas HTML, arquivos CSS e JavaScript. Para o ambiente de desenvolvimento, esses arquivos ficarão acessíveis através do _[Bucket](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ de nome _dev\_motando-staticfiles_.

```
(venv) $ export OCI_STATICFILES_BUCKET_NAME='dev_motando-staticfiles'
```

A cópia dos arquivos estáticos da aplicação para o _[Bucket](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_ é feita pelo comando abaixo:

```
(venv) $ motando/manage.py collectstatic --no-input --verbosity 2
```

### Iniciando a aplicação

```
(venv) $ motando/manage.py runserver
Watching for file changes with StatReloader
Performing system checks...

System check identified no issues (0 silenced).
December 23, 2023 - 19:13:42
Django version 4.2.4, using settings 'motando.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
```

## Tarefas assíncronas com Celery

A aplicação _Motando_ utiliza o _[Celery](https://docs.celeryq.dev/en/stable/index.html)_ para processar tarefas independentes da parte Web. Lembrando que toda interação entre navegador e servidor, utiliza um ciclo requisição/resposta. Este ciclo possui um tempo máximo para ser completado que começa a partir da requisição feita pelo cliente (navegador), até a resposta emitida pelo servidor.

Caso a reposta do servidor demore muito, o protocolo _HTTP_ que controla esse tempo, fecha a conexão que está ativa, interrompendo assim a navegação do cliente. Em outras palavras, há um _TIMEOUT_.

O _Celery_ entra em cena para toda atividade que envolve a publicação de um novo anúncio, atualização ou exclusão. Um anúncio, além das informações que o descrevem, possuem também imagens que são armazenadas em um _[Bucket](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)_.

Para um novo anúncio, as imagens primeiramente vão para um _Bucket_ temporário (dev_motando-tmpimg). Logo após, o _Celery_ é comandado pela aplicação Web (via _[XMLRPC](https://docs.python.org/3/library/xmlrpc.html)_) para transferir a imagem do _Bucket_ temporário (dev_motando-tmpimg) para o _Bucket_ permanente (dev_motando-img).

Esse processo de cópia entre os _Buckets_, pode levar a algum tempo e prejudicar a navegação do usuário por conta do tempo no ciclo requisição/resposta imposto pelo protocolo _HTTP_.

Ter o processo de cópia entre _Buckets_, executado de forma independente da aplicação Web, assegura o não _TIMEOUT_ entre cliente e servidor para tratar as imagens dos anúncios.

Optei por utilizar essa arquitetura, de possuir dois _Buckets_, primeiramente como forma de evitar qualquer desperdício de espaço ao salvar as imagens. O _Bucket_ temporário possui uma _[Lifecycle Policy](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/usinglifecyclepolicies.htm)_ para excluír qualquer arquivo depois de um certo período de tempo. Há tempo suficiente para o _Celery_ fazer o seu trabalho e publicar o anúncio e suas imagens.

O processo de publicação (workflow de publicação) de um anúncio e suas imagens, pode ser melhor entendido observando a figura abaixo:

![alt_text](/githimgs/dev_celery-arch-2.png "Celery Arch #2")

1. Um usuário da aplicação Web posta um novo anúncio contendo algumas imagens.
2. As imagens são salvas pela aplicação Web diretamente no _Bucket_ temporário (dev_motando_tmpimg).
3. Em seguida, a aplicação Web notifica o _Celery_ via _[XMLRPC](https://docs.python.org/3/library/xmlrpc.html)_, dizendo que há um novo anúncio para ser publicado.
4. De forma independente da aplicação Web, o _Celery_ começa o trabalho de publicação do anúncio que consiste basicamente na cópia das imagens entre os _Buckets_.
5. Ao término da cópia, o _Celery_ concluí a publicação do anúncio atualizando alguns dados no _[MySQL](https://docs.oracle.com/en-us/iaas/mysql-database/index.html)_.

Tendo o processo de publicação implementado de forma independente, este pode ser incrementado facilmente com outras atividades se necessário. Por exemplo, é possível enviar um e-mail ao usuário quando a publicação do anúncio estiver sido concluída ou mesmo, acrescentar uma marca d'agua com o logotipo _Motando_ nas imagens.

### Celery

Basicamente o _[Celery](https://docs.celeryq.dev/en/stable/index.html)_ é uma ferramenta para processar tarefas de uma fila (task queue). A grande sacada do _Celery_, é que ele possibilita processar tarefas de forma independente do programa principal.  

Como parte do seu funcionamento, o _Celery_ necessita de um serviço separado que seja capaz de armazenar suas mensagens. Este é conhecido como _message broker_ ou _message transport_.

Para o _message broker_, tanto o _[RabbitMQ](https://www.rabbitmq.com/)_ quanto o _[Redis](https://redis.io/)_ são excelentes. Para a aplicação _Motando_ será usado o _Redis_ como broker de mensagens.

Além do broker, o _Celery_ pode salvar todo o progresso e o resultado das tarefas em um _result backend_. Para a aplicação _Motando_, o _result backend_ será o _MySQL_.

![alt_text](/githimgs/dev_celery-arch-3.png "Celery Arch #3")

#### Redis (message broker)

```
$ docker run --name redis --net=host -d redis:7
```

#### MySQL (result backend)

## Variáveis de ambiente

OCI_REGION_ID
OCI_BUCKET_MOTANDO_IMGTMP
OCI_BUCKET_MOTANDO_IMG
OCI_STATICFILES_BUCKET_NAME
OCI_OBJSTR_NAMESPACE

OCI_ACCESS_KEY_ID
OCI_SECRET_ACCESS_KEY

MYSQL_DBNAME
MYSQL_HOST
MYSQL_USER
MYSQL_PASSWD

RESULTDB_USER
RESULTDB_PASSWD
RESULTDB_DBNAME

BROKER_HOST
BROKER_VHOST
BROKER_USER
BROKER_PASSWD
BROKER_LOG_ID

CLASSIFIEDAD_TASK_QUEUE_HOST
CLASSIFIEDAD_TASK_QUEUE_PORT