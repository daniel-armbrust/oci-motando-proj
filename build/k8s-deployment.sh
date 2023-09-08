#!/bin/bash

if [ ! -f "$(which kubectl)" ]; then
   echo "[ERROR] The required binary \"kubectl\" was not found!"
   exit 1
fi

echo -e "\n[INFO] Deploying \"celery-classifiedad\" ..."
cd ../services/celery-classifiedad/
kubectl apply -f ./service.yaml
kubectl apply -f ./deployment.yaml
cd - 1>/dev/null

echo -e "\n[INFO] Deploying \"motando-webapp-init\" ..."
cd ../services/motando-webapp-init/
kubectl apply -f ./job.yaml
cd - 1>/dev/null

echo -e "\n[INFO] Deploying \"motando-webapp\" ..."
cd ../webapp/
kubectl apply -f ./deployment.yaml
kubectl apply -f ./service.yaml
cd - 1>/dev/null

exit 0