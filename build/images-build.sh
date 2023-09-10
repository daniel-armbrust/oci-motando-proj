#!/bin/bash

TERRAFORM_STATE_FILE="../terraform/terraform.tfstate"
REQUIRED_BIN=('terraform' 'docker')

if [ ! -f "$TERRAFORM_STATE_FILE" ]; then
   echo "[ERROR] Terraform state file \"$TERRAFORM_STATE_FILE\" was not found!"
   exit 1
else
   for ((i =  0 ; i < ${#REQUIRED_BIN[*]} ; i++)); do

      if [ ! -f "$(which ${REQUIRED_BIN[$i]})" ]; then
         echo "[ERROR] The required binary \"${REQUIRED_BIN[$i]}\" was not found!"
         exit 1
      fi

   done
fi

OCIR_HOST="gru.ocir.io"
OBJSTR_NAMESPACE="$(terraform output -state=$TERRAFORM_STATE_FILE -raw objectstorage_namespace)"
OCIR_IMAGE_PREFIX="$OCIR_HOST/$OBJSTR_NAMESPACE"
CELERY_CLASSIFIEDAD_IMGNAME="motando-celery-classifiedad:v1.0.0"
MOTANDO_APPINIT_IMGNAME="motando-webapp-init:v1.0.0"
MOTANDO_WEBAPP_IMGNAME="motando-webapp:v1.0.0"

echo -e "\n[INFO] Building and pushing \"$CELERY_CLASSIFIEDAD_IMGNAME\" ..."
cd ../services/celery-classifiedad/

docker image build --no-cache \
    --target=base \
    -t celery-classifiedad \
    -t $OCIR_IMAGE_PREFIX/$CELERY_CLASSIFIEDAD_IMGNAME .

docker push $OCIR_IMAGE_PREFIX/$CELERY_CLASSIFIEDAD_IMGNAME
cd - 1>/dev/null


echo -e "\n\n[INFO] Building and pushing \"$MOTANDO_APPINIT_IMGNAME\" ..."
cd ../services/motando-webapp-init/

docker image build --no-cache \
    -t motando-webapp-init \
    -t $OCIR_IMAGE_PREFIX/$MOTANDO_APPINIT_IMGNAME .

docker push $OCIR_IMAGE_PREFIX/$MOTANDO_APPINIT_IMGNAME
cd - 1>/dev/null


echo -e "\n\n[INFO] Building and pushing \"$MOTANDO_WEBAPP_IMGNAME\" ..."
cd ../webapp/

docker image build --no-cache \
    --target=base \
    -t motando-webapp \
    -t $OCIR_IMAGE_PREFIX/$MOTANDO_WEBAPP_IMGNAME .

docker push $OCIR_IMAGE_PREFIX/$MOTANDO_WEBAPP_IMGNAME
cd - 1>/dev/null


echo -e "\n\n[INFO] Done!"

exit 0