# MOTANDO

- To see this document in Brazilian Portuguese, access _[this link](./README-pt_br.md)_.

## Quick Start

- The commands bellow was executed on _[Oracle Linux 8.8](https://yum.oracle.com/oracle-linux-isos.html)_:

```
[opc@devops ~]$ cat /etc/oracle-release
Oracle Linux Server release 8.8

[opc@devops ~]$ uname -r
5.15.0-104.119.4.2.el8uek.x86_64
```

### 1. Install _[Terraform](https://developer.hashicorp.com/terraform/downloads)_

```
[opc@devops ~]$ wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip

[opc@devops ~]$ unzip terraform_1.5.7_linux_amd64.zip

[opc@devops ~]$ sudo mv terraform /usr/local/bin/

[opc@devops ~]$ terraform -v
Terraform v1.5.7
on linux_amd64
```

### 2. Install _[Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)_

```
[opc@devops ~]$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

[opc@devops ~]$ chmod +x ./kubectl

[opc@devops ~]$ sudo mv kubectl /usr/local/bin/

[opc@devops ~]$ kubectl version --client
Client Version: v1.28.1
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
```

### 3. Install _[Docker](https://docs.docker.com/engine/install/)_

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

### 4. Install _[OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__linux_and_unix)_

``` 
[opc@devops ~]$ wget https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh

[opc@devops ~]$ chmod +x ./install.sh

[opc@devops ~]$ ./install.sh --accept-all-defaults

[opc@devops ~]$ oci -v
3.33.0
```

### 5. Add an _[API Key](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#two)_ on _[OCI](https://www.oracle.com/cloud/)_

5.1 - Select the region _"Brazil East (Sao Paulo)"_ and then access _"My profile"_:

![alt_text](./githimgs/api-key_1.png "API Key #1")

5.2 - On the next screen, access _"API keys"_ and click on the _"Add API key"_ button:

![alt_text](./githimgs/api-key_2.png "API Key #2")

5.3 - Save the respective keys and click the _"Add"_ button:

![alt_text](./githimgs/api-key_3.png "API Key #3")

5.4 - After, the screen that displays the settings of the key that was added is displayed:

![alt_text](./githimgs/api-key_4.png "API Key #4")

5.5 - The displayed settings must be entered in the configuration file of the _[OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__linux_and_unix)_, as shown below:

```
[opc@devops ~]$ mkdir .oci

[opc@devops ~]$ cat <<EOF > .oci/config
> [DEFAULT]
> user=ocid1.user.oc1..aaaaaaaaqbbgqbbgaaaaqbbgqbbqbbgqbbqbbgqbbqbbgqbbqbbgqbbg
> fingerprint=ef:1d:c3:eb:eb:eb:eb:eb:d0:47:d0:47:92
> tenancy=ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> region=sa-saopaulo-1
> key_file=/home/opc/.oci/priv.key
> EOF
```

5.6 - The same goes for the private key that was downloaded previously:

```
[opc@devops ~]$ cat <<EOF >/home/opc/.oci/priv.key
> -----BEGIN PRIVATE KEY-----
> MIIJPBJPBJPBJPBJPBIgkqBADANBhBADANBBADANBBADANBBADANBkiGGvNKGeGv
> fTN+MIIJPBJPBJPBJPBJPBIgkqBADANBhBADANBBADANBBADANBBADANBkiGGvNK
> HTbHTbHTbBJPBJBJPBJBJPADANBBADANBADANBBADANBADANBBADANBYvNKGeRfa
> -----END PRIVATE KEY-----
> EOF
```

5.7 - Lastly, an adjustment to the permissions of the files that were created:

``` 
[opc@devops ~]$ oci setup repair-file-permissions --file /home/opc/.oci/config

[opc@devops ~]$ oci setup repair-file-permissions --file /home/opc/.oci/priv.key
```

>_**__NOTE:__** All key values and their settings displayed here are for demonstration purposes only and cannot be used in a productive environment._

### 6. Adicionando uma _[Customer Secret Key](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcredentials.htm#Working2)_ no _[OCI](https://www.oracle.com/cloud/)_
 
6.1 - Back in _"My profile"_, select _"Customer secret keys"_ and then click on the _"Generate secret key"_ button:

![alt_text](./githimgs/cust-seckey_1.png "Customer Secret Key #1")

6.2 - Add a name and then click the _"Generate secret key"_ button:

![alt_text](./githimgs/cust-seckey_2.png "Customer Secret Key #2")

6.3 - The following screen only displays the _"Secret Key"_ once:

![alt_text](./githimgs/cust-seckey_3.png "Customer Secret Key #3")

6.4 - The _"Access Key"_ remains available at all times and can be obtained as follows:

![alt_text](./githimgs/cust-seckey_4.png "Customer Secret Key #4")

>_**__NOTE:__** Remember to save the _"Secret Key"_ when viewing it. After that, it can no longer be viewed._

### 7. Adicionando um _[Auth Token](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcredentials.htm#Working)_ no _[OCI](https://www.oracle.com/cloud/)_

7.1 - Back in _"My profile"_, select _"Auth tokens"_ and then click on the _"Generate token"_ button:

![alt_text](./githimgs/auth-token_1.png "Auth Token #1")

7.2 - On the next screen, enter a description and generate the token using the _"Generate token"_ button:

![alt_text](./githimgs/auth-token_2.png "Auth Token #2")

7.3 - Save the token that was generated in a safe location:

![alt_text](./githimgs/auth-token_3.png "Auth Token #3")

>_**__NOTE:__** Remember to save the _"Auth Token"_ when viewing it. After that, it can no longer be viewed._

### 8. Clone the application _[repository](https://github.com/daniel-armbrust/oci-motando-proj.git)_

```
[opc@devops ~]$ sudo yum install -y git

[opc@devops ~]$ git clone https://github.com/daniel-armbrust/oci-motando-proj.git
```

### 9. Create the infrastructure through _[Terraform](https://developer.hashicorp.com/terraform/downloads)_ code

9.1 - Access the directory containing the _[Terraform](https://developer.hashicorp.com/terraform/downloads)_ code from the application:

```
[opc@devops ~]$ cd oci-motando-proj/terraform/
```

9.2 - Create an SSH key pair for the _[Worker Nodes](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengclustersnodes.htm#Node_Pools)_ from _[OKE](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm)_:

```
[opc@devops terraform]$ mkdir keys

[opc@devops terraform]$ ssh-keygen -t rsa -b 4096 -f keys/oke-sshkey -q -N ""
```

9.3 - Adjust _[tenancy](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingtenancy.htm)_ settings in _[Terraform](https://developer.hashicorp.com/terraform/downloads)_:

```
[opc@devops terraform]$ mv terraform.tfvars-example terraform.tfvars

[opc@devops terraform]$ cat terraform.tfvars
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

9.4 - Initialize and create the infrastructure:

```
[opc@devops terraform]$ terraform init

[opc@devops terraform]$ terraform apply -auto-approve
```

### 10. Initialize _[OKE](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm)_

10.1 - Insert the corresponding values into the _"motando.env"_ file that will be used to initialize the cluster:

```
[opc@devops terraform]$ cd scripts/

[opc@devops terraform]$ mv motando.env-example motando.env

[opc@devops terraform]$ cat motando.env
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

10.2 - Initialize the cluster:

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

10.3 - Checking the cluster access:

```
[opc@devops scripts]$ kubectl get nodes
NAME            STATUS   ROLES   AGE    VERSION
172.16.10.171   Ready    node    129m   v1.27.2
172.16.10.223   Ready    node    130m   v1.27.2
172.16.10.79    Ready    node    129m   v1.27.2
```

### 11. Create and transport the _[Docker](https://docs.docker.com/engine/)_ images to _[Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_

11.1 - Change to the _"build"_ directory:

```
[opc@devops scripts]$ cd $HOME/oci-motando-proj/build
```

11.2 - Get the value of _[tenancy namespace](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/understandingnamespaces.htm)_:

```
[opc@devops build]$ oci os ns get
{
  "data": "grxmw2a9myyj"
}
```

11.3 - Authenticate to the _[Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_ of the _São Paulo region (gru.ocir.io)_:

```
[opc@devops build]$ docker login gru.ocir.io
Username: grxmw2a9myyj/daniel.armbrust@oracle.com
Password:
WARNING! Your password will be stored unencrypted in /home/opc/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```

>_**__NOTE:__** Use the "Auth Token" that was previously generated for the requested "Password"._

11.4 - Create and transport the images to _[Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_:

```
[opc@devops build]$ ./images-build.sh
```

11.5 - To check whether the images are in the _[Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)_, you can use the command below that displays the _"display-name"_ of the three application images:

```
[opc@devops build]$ oci artifacts container repository list \
> --compartment-id ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa \
> --all | grep "display-name"
       "display-name": "motando-celery-classifiedad",
       "display-name": "motando-webapp",
       "display-name": "motando-webapp-init",
```

### 12. Deployment of the MOTANDO application

12.1 - It is possible to deploy the application using the command below:

```
[opc@devops build]$ ./k8s-deployment.sh

[INFO] Deploying "celery-classifiedad" ...
service/rabbitmq created
service/celery-classifiedad created
deployment.apps/rabbitmq created
deployment.apps/celery-classifiedad created

[INFO] Deploying "motando-webapp-init" ...
job.batch/motando-webapp-init created

[INFO] Deploying "motando-webapp" ...
deployment.apps/motando-webapp created
service/motando-webapp created
```

12.2 - To follow the initialization and insertion of application example data, use the command below:

```
[opc@devops build]$ kubectl get jobs

[opc@devops build]$ kubectl get jobs
NAME                  COMPLETIONS   DURATION   AGE
motando-webapp-init   0/1           20s        20s

[opc@devops build]$ kubectl logs -f job/motando-webapp-init
```

12.3 - The application makes use of _[Celery](https://docs.celeryq.dev/en/stable/index.html)_ to publish your images. You can monitor its operation using the commands below:

```
[opc@devops build]$ kubectl get deployments/celery-classifiedad
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
celery-classifiedad   1/1     1            1           8m32s

[opc@devops build]$ kubectl logs -f deployments/celery-classifiedad
```

12.4 - Finally, the public IP address of the application's _[Load Balancer](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengcreatingloadbalancer.htm)_ is obtained by the command below:

```
[opc@devops build]$ kubectl get service/motando-webapp
NAME             TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)        AGE
motando-webapp   LoadBalancer   10.96.46.139   144.22.206.83   80:32696/TCP   6m34s
```

12.5 - End...