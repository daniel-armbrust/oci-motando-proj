# Introdução ao Kubernetes (K8s)

Kubernetes, também conhecido como K8s, é um sistema open source para automatizar o deployment, escalabilidade e gerenciamento de aplicações contêinerizadas.

## Versões utilizadas

```
[opc@devops ~]$ kubectl version
Client Version: v1.28.1
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.27.4
```

## Objetos Kubernetes

Um objeto Kubernetes é um _"registro de intenção"_. Uma vez criado o objeto, o Kubernetes irá garantir a sua existência. 

As operações de criação, modificação ou exclusão de objetos são feitas pela _[API do Kubernetes (kubeapi)](https://kubernetes.io/docs/concepts/overview/kubernetes-api/)_. Esta _[API](https://kubernetes.io/docs/concepts/overview/kubernetes-api/)_ é disponibilizada normalmente na porta 6443/TCP e pode ser comandada pelo utilitário de linha de comando _[kubectl](https://kubernetes.io/docs/reference/kubectl/)_.

Objetos Kubernetes podem ser especificados através de arquivos de manifestos,  escritos em YAML ou JSON. A ferramenta _[kubectl](https://kubernetes.io/docs/reference/kubectl/)_ converte a informação contida neste arquivo de manifesto em JSON, para então se comunicar com a _[API (kubeapi)](https://kubernetes.io/docs/concepts/overview/kubernetes-api/)_.

```
[opc@devops ~]$ kubectl apply -f https://k8s.io/examples/application/deployment.yaml
deployment.apps/nginx-deployment created
```

Dá se o nome de _modo declarativo_, quando o _"estado desejado"_ é expresso em arquivo de manifesto (YAML ou JSON). Um outro modo de se atingir o _"estado desejado"_ é através do chamado _modo imperativo_.

### Pod

Pod é a menor unidade de deployment que você cria e gerencia no Kubernetes.

Um Pod é composto de um grupo de um ou mais contêineres que podem compartilhar storage e recursos de rede. Podemos dizer que um Pod é um ambiente de execução para contêineres. 

>_**__Para fixar:__** Um Pod é um ambiente de execução para um ou mais contêineres._

O modelo _"one-container-per-Pod"_ é o mais comum de ser criado e gerenciado. Porém, é perfeitamente possível a execução de _múltiplos contêineres_ dentro de um Pod. 

Contâiners dentro de um Pod formam uma única unidade coesa de serviço e são _escalonados_ para execução em uma mesma máquina do cluster. Esses contâiners compartilham os mesmos recursos e podem se comunicar uns com os outros.

>_**__NOTA:__** A tarefa do escalonador é decidir onde executar um determinado Pod.

```
[opc@devops ~]$ cat nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
```

>_**__NOTA:__** O nome de um Pod deve ser um subdomínio DNS válido [(RFC 1123)](https://datatracker.ietf.org/doc/html/rfc1123)._

```
[opc@devops ~]$ kubectl apply -f ./nginx.yaml
```

```
[opc@devops ~]$ kubectl get pod -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE            NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          22h   10.244.1.5   172.16.10.180   <none>           <none>
```

Normalmente não se cria Pods diretamente no Kubernetes. Eles são criados e gerenciados através de outros objetos, como o Deployment ou Job.

Cada Pod recebe um endereço IP único e todos os seu(s) contêiner(es), compartilham este mesmo endereço IP _(network namespace)_ e as portas de rede _(port space)_. Os contêineres existentes dentro do Pod podem se comunicar uns com os outros através do _localhost_ e também através de padrões entre processos como semáforos SystemV ou por memória compartilhada POSIX. 

```
[opc@devops ~]$ kubectl get pod nginx --template '{{.status.podIP}}'
10.244.1.5
```

#### Pod Lifecycle

Pods são considerados entidades efêmeras, não duráveis. Ao ser criado, será atribuído um ID _[(UID)](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids)_ único e o Pod é então escalonado para ser executado em algum _worker node_ do cluster, onde ele permanesce até a sua exclusão ou término.

Um Pod ao ser criado, segue um _[lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)_ pré definido que inicia na fase _(phase)_ _"Pending"_ e se tudo der certo, alcança o estado _"Running"_.

As fases do seu _[lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)_ são:

- **Pending**: o Pod foi aceito para execução no cluster porém, nenhum contêiner foi iniciado ainda.

- **Running**: o Pod está vinculado a um _worker node_ e pelo menos um de seus contêiners está em execução.

- **Succeeded**: Todos os contêiners do Pod terminaram sua execução com sucesso.

- **Failed**: Todos os contêiners de um Pod foram encerrados e pelo menos um, com estado de falha (non-zero status).

- **Unknown**: Por alguma razão, o estado do Pod não pode ser obtido. Este é um tipo de erro na comunicação com o _worker node_ onde o Pod deveria estar em execução.

```
[opc@devops ~]$ kubectl get pod nginx --template '{{.status.phase}}'
Running
```

Além das fases de um Pod, o Kubernetes rastreia o estado de cada um dos seus contêineres. Uma vez que o Pod é agendado para execução em um _worker node_, o processo _[kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)_ inicia a criação dos contêineres que então transitam pelos seguintes estados _[(container states)](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-states)_:

- **Waiting**: Fase de inicialização do contêiner. Aqui, acontece o download da imagem _(pull)_ e sua execução.

- **Running**: O contêiner encontra-se em execução sem qualquer problema.

- **Terminated**: O contêiner terminou a sua execução com sucesso ou falhou por  alguma razão.

#### Container Probes

Um _probe_ é uma maneira de verificar se o contêiner encontra-se _"saudável"_ e em execução. O processo _[kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)_ de um _worker node_, pode tanto executar um código dentro do contêiner ou realizar alguma verificação em nível de rede com o proprósito de aferir a _"saúde"_ do contêiner.

Existem três tipos diferentes de _probes_ que podem ser configurados:

- **liveness probe**: O _[kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)_ utiliza as configurações do _liveness probe_ para saber quando o contêiner precisa ser reiniciado. Em caso de falha, o contêiner é removido e a sua reinicialização está sujeita ao valor especificado em _[restartPolicy](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy)_.

- **readiness probe**: O _[kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)_ utiliza as configurações do _readiness probe_ para saber quando o contêiner está pronto para receber requisições. Em caso de falha, o Pod será removido do Service no qual ele faz parte.

- **startup probe**: O _[kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)_ utiliza as configurações do _startup probe_ para saber quando a aplicação de um contêiner foi iniciada. Em caso de falha, o contêiner é removido e a sua reinicialização está sujeita ao valor especificado em _[restartPolicy](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy)_.

Nas configurações de um _probe_, deve-se especificar um dos quatro modos abaixo para verificar o contêiner:

- **exec**: Executa um comando específico dentro do contêiner. O _exit status_ igual a 0, indica sucesso.

- **grpc**: Executa uma chamada de procedimento remoto através do _[gRPC](https://grpc.io/)_. Um retorno do tipo _SERVING_ em _status_, indica sucesso.

- **httpGet**: Executa uma requisição HTTP GET no endereço IP do Pod em uma porta e path, que devem ser especificados. Um código de retorno igual ou maior que 200 e menor que 400, indica sucesso.

- **tcpSocket**: Executa uma checagem no endereço IP do Pod em uma porta de rede TCP. Se for possível estabelecer o _socket_, o resultado é tido como sucesso.

Além dos modos de checagem, há outras opções disponíveis que controlam a periodicidade do _probe_ que será feito:

- **initialDelaySeconds**: Atrasa a verificação pelo número de segundos aqui definido. Por exemplo, um valor 5 em _initialDelaySeconds_ irá aguardar cinco segundos até o disparo do primeiro _probe_.

- **periodSeconds**: Periodicidade em segundos que os _probes_ devem ocorrer.

- **timeoutSeconds**: Numero em segundos em que se aguarda uma resposta do _probe_ feito. 

```
[opc@devops ~]$ cat nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    livenessProbe:
        httpGet:
            path: /
            port: 80
        initialDelaySeconds: 5
        periodSeconds: 3
```

>_**__NOTA:__** Para maiores detalhes, consulte a documentação oficial neste [link aqui](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)._

#### Limitando Recursos

Quando se especifica um Pod, opcionalmente é possível especificar o quanto de recursos computacionais que um contêiner necessita _(require)_, e o quanto ele pode consumir ao máximo _(limit)_. Os recursos mais comuns de serem especificados são CPU e memória RAM porém, há suporte para outros.

Há dois modos para se especificar como os contêineres podem consumir os recursos computacionais do cluster:

- **requests**: especifica a quantidade mínima de recursos exigidos para executar um contêiner. O componente _(kube-scheduler)[https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/]_, utiliza essa informação para determinar em qual _worker node_ executar o Pod. Caso nenhum _worker node_ tenha tal capacidade disponível, o Pod permanesce em estado _Pending_ até que a quantidade de recursos exigidos sejam liberados.

- **limits**: especifica a quantidade máxima de recursos que um contêiner pode consumir. O componente _[kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)_, monitora e impede que um contêiner extrapole o limite imposto. Quando se ultrapassa o tempo de CPU especificado, o contêiner sofre um _throttling_ que reduz o seu desempenho. Para memória RAM, o contêiner será encerrado e se possível, reescalonado em seguida _(kill and restart)_.

>_**__NOTA:__** Lembrando que as requisições por recursos são feitas por contêiner e não por Pod. Ou seja, o total de recursos mínimos para execução de um Pod, compreende a soma total dos recursos de todos os seus contêineres._

As unidades de medidas usadas para CPU e memória são:

- **CPU**: expresso no formato _millicpu_ ou _millicores_. Utilizar o valor 1, garantirá o uso de 100% da CPU que é equivalente a 1000m (1000 millicores). Ao se utilizar o  valor 0.1, isto é equivalente a 100m.

- **memória**: o recurso memória é medido em bytes. Para se especificar, é possível utilizar os prefixos M, Mi, G ou Gi ao se definir a quantidade.

>_**__NOTA:__** 1 megabyte = 1024 KB e 1 mebibytes (MiB) é 1000 KiB.

```
[opc@devops ~]$ cat nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    livenessProbe:
        httpGet:
            path: /
            port: 80
        initialDelaySeconds: 5
        periodSeconds: 3
    resources:
        requests:
            memory: "100Mi"
            cpu: "100m"
        limits:
            memory: "200Mi"
            cpu: "200m"
```

### [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)



### Services

#### Labels