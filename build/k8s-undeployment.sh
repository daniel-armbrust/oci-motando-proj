#!/bin/bash

if [ ! -f "$(which kubectl)" ]; then
   echo "[ERROR] The required binary \"kubectl\" was not found!"
   exit 1
fi

echo -e "\n[INFO] Undeploying \"motando-webapp-init\" ..."
cd ../webapp/
kubectl delete -f ./service.yaml
kubectl delete -f ./deployment.yaml
cd - 1>/dev/null

echo -e "\n[INFO] Undeploying \"motando-webapp-init\" ..."
cd ../services/motando-webapp-init/
kubectl delete -f ./job.yaml
cd - 1>/dev/null

echo -e "\n[INFO] Undeploying \"celery-classifiedad\" ..."
cd ../services/celery-classifiedad/
kubectl delete -f ./deployment.yaml
kubectl delete -f ./service.yaml
cd - 1>/dev/null

exit 0