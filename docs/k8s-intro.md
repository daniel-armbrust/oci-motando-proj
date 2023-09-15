# Kubernetes (K8s)

Kubernetes, também conhecido como K8s, é um sistema open source para automatizar o deployment, escalabilidade e gerenciamento de aplicações contêinerizadas.

## Objetos Kubernetes

Um objeto Kubernetes é um _"registro de intenção"_. Uma vez criado o objeto, o Kubernetes irá garantir sua existência. 

As operações de criação, modificação ou exclusão de objetos são feitas pela _[API do Kubernetes (kubeapi)](https://kubernetes.io/docs/concepts/overview/kubernetes-api/)_. Esta _[API](https://kubernetes.io/docs/concepts/overview/kubernetes-api/)_ pode ser comandada diretamente que normalmente está disponível pela porta 6443/TCP ou, através da ferramenta de linha de comando _[kubectl](https://kubernetes.io/docs/reference/kubectl/)_.

Objetos Kubernetes podem ser especificados através de arquivos de manifestos,  escritos em YAML ou JSON. A ferramenta _[kubectl](https://kubernetes.io/docs/reference/kubectl/)_ converte a informação contida neste arquivo de manifesto em JSON para então realizar as chamadas de API.

```
[opc@devops ~]$ kubectl apply -f https://k8s.io/examples/application/deployment.yaml
deployment.apps/nginx-deployment created
```

### Pod

Pod é a menor unidade de deployment que você cria e gerencia no Kubernetes.

Um Pod é composto de um grupo de um ou mais contêineres que podem compartilhar storage e recursos de rede. Podemos dizer que um Pod é um ambiente de execução para contêineres. 

>_**__Para fixar:__** Um Pod é um ambiente de execução para um ou mais contêineres._

O modelo _"one-container-per-Pod"_ é o mais comum de ser criado e gerenciado. Porém, é perfeitamente possível a execução de _múltiplos contêineres_ dentro de um Pod. 

Contâiners dentro de um Pod formam uma única unidade coesa de serviço e são escalonados para execução em uma mesma máquina do cluster. Esses contâiners compartilham os mesmos recursos e podem se comunicar uns com os outros.

```
[opc@devops ~]$ cat nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
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

Um Pod ao ser criado segue um _[lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)_ pré definido que inicia na fase _(phase)_ _"Pending"_ e se tudo der certo, alcança o estado _"Running"_.

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

- **Waiting**: Fase de inicialização do contêiner. Aqui, acontece o download da imagem (pull) e sua execução.

- **Running**: O contêiner encontra-se em execução sem qualquer problema.

- **Terminated**: 



