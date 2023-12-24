# Docker HOWTO

- Inspecionar o sistema de arquivos de uma imagem recém construída:

```
$ docker run -ti --entrypoint bash oci-simple-form
```

# Kubernetes HOWTO

## [Pods](https://kubernetes.io/docs/concepts/workloads/pods/)

- Executando um Pod e obtendo shell dentro do contêiner:

```
$ kubectl run -ti --image=container-registry.oracle.com/os/oraclelinux:8-slim -- bash
```

```
$ kubectl run oci-simple-form \
    --image gru.ocir.io/grxmw2a9myyj/oci-simple-form:v1.0.0 \
    --overrides='{ "apiVersion": "v1", "spec": {"imagePullSecrets": [{"name": "motando-ocir-secret"}]} }'
```

## [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)

- Sintaxe do comando:

```
$ kubectl <AÇÃO> configmap <NOME>
```

- Sintaxe abreviada do comando:

```
$ kubectl <AÇÃO> cm <NOME>
```

- Criar um ConfigMap a partir de valores literais:

```
$ kubectl create configmap app-cm \
    --from-literal=hostname=webapp1 \
    --from-literal=env=prod
configmap/app-cm created
```

- Criar um ConfigMap a partir de um arquivo de _[variáveis de ambiente](https://en.wikipedia.org/wiki/Environment_variable)_:

```
$ cat app.env
hostname=webapp1
env=prod

$ kubectl create configmap app-cm --from-env-file=app.env
configmap/app-cm created
```

- Exibir os ConfigMaps criados no cluster: 

```
$ kubectl get configmap
NAME               DATA   AGE
app-cm             2      2m46s
kube-root-ca.crt   1      7d1h
```

>_**__NOTA:__** A coluna DATA exibe a quantidade de pares chave/valor de cada ConfigMap criado no cluster. Ou seja, existem dois pares chave/valor dentro do ConfigMap de nome app-cm._

- Exibir os pares chave/valor de um determinado ConfigMap:

```
$ kubectl describe configmap app-cm
Name:         app-cm
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
env:
----
prod
hostname:
----
webapp1

BinaryData
====

Events:  <none>
```

- Exibir um ConfigMap em formato YAML:

```
$ kubectl get configmap app-cm -o yaml
apiVersion: v1
data:
  env: prod
  hostname: webapp1
kind: ConfigMap
metadata:
  creationTimestamp: "2023-09-30T16:35:24Z"
  name: app-cm
  namespace: default
  resourceVersion: "231304"
  uid: 7378f092-1622-4756-b6c4-f3700ed3c209
```

- Excluir um ConfigMap:

```
$ kubectl delete configmap app-cm
configmap "app-cm" deleted
```

- Injetar um par chave/valor de um ConfigMap em um Pod:

```
$ kubectl create configmap nginx-cm --from-literal=NGINX_PORT=8080
configmap/nginx-cm created

$ cat nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 8080
    env:
       - name: NGINX_PORT
         valueFrom:
             configMapKeyRef:
                 name: nginx-cm
                 key: NGINX_PORT

$ kubectl apply -f ./nginx.yaml
pod/nginx created
```

- Exibir a variável de ambiente NGINX_PORT injetada no Pod através do ConfigMap:

```
$ kubectl exec pod/nginx -- env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=nginx
NGINX_PORT=8080
KUBERNETES_PORT=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
KUBERNETES_SERVICE_HOST=10.96.0.1
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
NGINX_VERSION=1.25.2
NJS_VERSION=0.8.0
PKG_RELEASE=1~bookworm
HOME=/root
```

- Injetar todos os pares chave/valor de um ConfigMap em um Pod:

```
$ cat nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 8080
    envFrom:
       - configMapRef:
           name: nginx-cm

$ kubectl apply -f ./nginx.yaml
pod/nginx created
```

- Editar um ConfigMap:

```
$ kubectl edit configmap nginx-cm
configmap/nginx-cm edited
```

- ConfigMap imutável:

```
$ cat immutable.yaml
apiVersion: v1
kind: ConfigMap
metadata:  
  name: app-cm   
data:
  env: prod
  hostname: webapp1
immutable: true 
```

>_**__NOTA:__** Não é possível alterar os valores de um ConfigMap imutável. Se esta for a intenção, será necessário excluir e criar um novo ConfigMap._

## [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
