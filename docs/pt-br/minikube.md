# Minikube

## Instalação

```
[opc@devops ~]$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

[opc@devops ~]$ sudo install minikube-linux-amd64 /usr/local/bin/minikube

[opc@devops ~]$ minikube start
```

```
[opc@devops ~]$ kubectl get nodes
NAME       STATUS   ROLES           AGE     VERSION
minikube   Ready    control-plane   5m12s   v1.27.4
```

```
[opc@devops ~]$ minukube dashboard
```
