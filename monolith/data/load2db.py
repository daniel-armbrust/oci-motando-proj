#
# load2db.py
#

import sys
import os
import random
import pathlib
from secrets import token_hex
from datetime import datetime

import oci

from django.contrib.auth import get_user_model

from account.models import UserProfile
from motorcycle.models import MotorcycleBrand, MotorcycleBrandModel, MotorcycleBrandModelVersion
from classifiedad.models import ClassifiedAd, ClassifiedAdImage
from state_city.models import State, StateCity
from classifiedad.queue import ClassifiedAdQueue


APP_ENV = os.environ.get('APP_ENV')
OCI_REGION_ID = os.environ.get('OCI_REGION_ID')
OCI_BUCKET_NAMESPACE = os.environ.get('OCI_OBJSTR_NAMESPACE')
CLASSIFIEDAD_TMPIMG_BUCKET = os.environ.get('OCI_BUCKET_MOTANDO_IMGTMP')
OCI_QUEUE_ID = os.environ.get('OCI_QUEUE_ID')


def get_motorcycle_brands():
    """Retorna todas as marcas das Motos cadastradas.
    
    """
    brand_data = {}

    for brand in MotorcycleBrand.objects.all():
        brand_data.update({brand.id: brand.brand})
    
    return brand_data


def get_telephone():    
    n = '00000000000'
    while '9' in n[3:6] or n[3:6]=='000' or n[6]==n[7]==n[8]==n[9]:
        n = str(random.randint(10**9, 10**10-1))
    return n[:3] + n[3:6] + n[6:] + n[9:]


def create_classifiedad(user=None, max_classifiedad=3):
    """Cria classificado do usuário.
    
    """
    sales_phrase_list = [
        'UNICO DONO, DOCUMENTACAO IMPECAVEL , IPVA  PAGO. Ja licenciada 2023',
        'Único dono, todas as revisões feitas pela concessionária.',
        'moto super conservada.',
        'excelente oportunidade de compra.',
        'Vendo ou troco por carro ou NMax 160.',
        'Moto conservada, com o tanque pintado recentemente. Todas a manutenções feitas recentemente.',
        'MOTO TODA ORIGINALsem acessorios !! UNICO DONO, DOCUMENTACAO IMPECAVEL, IPVA PAGO.'
    ]

    description_list = [
        'Moto em perfeito estado. Para pessoas exigentes.',
        'ATENDIMENTO ON-LINE E PRESENCIAL.<br>OPORTUNIDADE<br>MOTOCICLETA EM PERFEITO ESTADO DE CONSERVAÇÃO.',
        'Bateria nova, Revisão feita, Laudo feito recentemente.<br> A moto ela fica muito parada porque não tenho tempo de usar!',
        'Moto com pneus em ótimo estado , transmissão nova , amortecedor traseiro novo , feito revisão a poucos dias',
        'Super conservada, moto importada com detalhes mínimos na carenagem, pneus novos, disco de freio traseiro novo.',
        '-Manual e chave reserva<br>-Documentação OK<br>-Manutenção OK<br>-Pneus trocas recentemente',
        'Moto tá bem conservada relação boa 2 pneus bem conservados 61 mil km original preço pra ir embora sou de Guarulhos pimentas.'
    ]

    config = oci.config.from_file()
    os_client = oci.object_storage.ObjectStorageClient(config=config)
    ns = os_client.get_namespace().data

    # Obtém as marcas das motocicletas.
    brand_dict = get_motorcycle_brands()

    img_list = os.listdir('img/')

    token_len = 8 
    max_classifiedad_img = 3   

    # Percorre as marcas das motocicletas randomincamente.
    for brand_id, brand_name in random.choices(list(brand_dict.items()), k=3): 
        print(f'[INFO] Processando MARCA: "{brand_name}"')

        for motorcycle_data in random.choices(MotorcycleBrandModelVersion.objects.filter(model__brand__id=brand_id), k=1):
            motorcycle_model = motorcycle_data.model
            motorcycle_version = motorcycle_data

            print(f'[INFO] Processando MODELO/VERSAO: "{motorcycle_model}/{motorcycle_version}"')

            motorcycle_type = random.choices(ClassifiedAd.MOTORCYCLE_TYPE_CHOICES)[0][0]
            motorcycle_origin = random.choices(ClassifiedAd.ORIGIN_CHOICES)[0][0]
            motorcycle_color = random.choices(ClassifiedAd.COLOR_CHOICES)[0][0]
            motorcycle_brake = random.choices(ClassifiedAd.BRAKE_SYSTEM_CHOICES)[0][0] 
            motorcycle_ignition = random.choices(ClassifiedAd.IGNITION_SYSTEM_CHOICES)[0][0] 
            motorcycle_refrigeration = random.choices(ClassifiedAd.REFRIGERATION_CHOICES)[0][0] 

            year = random.randint(1990, 2023)
            model_year = random.randint(year, 2023)
            mileage = random.randint(100, 200000)
            price = round(random.uniform(30000.0, 105000.9),2)

            sales_phrase = random.choices(sales_phrase_list)[0]
            description = random.choices(description_list)[0]           

            ClassifiedAd(user=user, model=motorcycle_model, model_version=motorcycle_version, 
                type=motorcycle_type, origin=motorcycle_origin, fabrication_year=year, model_year=model_year,
                mileage=mileage, color=motorcycle_color, price=price, sales_phrase=sales_phrase, 
                description=description, accept_new_offer=bool(random.getrandbits(1)), 
                accept_exchange=bool(random.getrandbits(1)), doc_ok=bool(random.getrandbits(1)),
                brake_system=motorcycle_brake, ignition_system=motorcycle_ignition, 
                refrigeration=motorcycle_refrigeration).save()
            
            new_classifiedad_id = ClassifiedAd.objects.latest('id').id
            
            # Processa a imagem do classificado
            image_list = []
            
            for i in range(max_classifiedad_img):
                img = random.choices(img_list)[0]

                file_ext = pathlib.Path(img).suffix

                rand_filename = '%s%s' % (
                    token_hex(token_len) + datetime.now().strftime('%s%f'),
                    file_ext.lower(),
                )              

                os_client.put_object(namespace_name=ns, bucket_name=CLASSIFIEDAD_TMPIMG_BUCKET,
                    object_name=rand_filename, put_object_body=pathlib.Path(f'img/{img}').read_bytes(),
                    content_type='image/jpeg'
                )

                file_url = 'https://objectstorage.%s.oraclecloud.com/n/%s/b/%s/o/%s' % (
                    OCI_REGION_ID, ns, CLASSIFIEDAD_TMPIMG_BUCKET, rand_filename,
                )         

                image_list.append(file_url)          

                ClassifiedAdImage(url=file_url, classifiedad_id=new_classifiedad_id).save()

                # Queue Task
                queue_client = ClassifiedAdQueue(queue_id=OCI_QUEUE_ID, region_id=OCI_REGION_ID, env=APP_ENV)                
                queue_client.classifiedad_id = new_classifiedad_id
                queue_client.classifiedad_status = 'NEW'
                queue_client.put_list(msg_list=image_list)
       

    print('[INFO] Fim ...\n')


def main():
    """Execução principal.
    
    """
    User = get_user_model()

    # Será criado os usuários contidos no arquivo CSV junto com
    # seu classificado.
    f = open('accounts.csv')
    
    for line in f.readlines():
        line = line.rstrip('\n')
        (full_name, email, password,) = line.split(';')

        telephone = get_telephone()
        state = random.choices(State.objects.all(), k=1)[0]
        city = random.choices(StateCity.objects.filter(state__id=state.id).all(), k=1)[0]
        
        user = User.objects.create_user(full_name=full_name, email=email, 
            password=password)        
        
        UserProfile(user=user, state=state, city=city, telephone=telephone).save()

        #user = User.objects.filter(email=email).get()
                
        create_classifiedad(user=user)     
        
    f.close()


main()