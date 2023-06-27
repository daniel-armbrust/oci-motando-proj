#
# classifiedad/views.py
#

import re
from secrets import token_hex
from datetime import datetime
import pathlib

from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, QueryDict, Http404
from django.views import View
from django.contrib import messages
from django.db.models import Q
from django.core.paginator import Paginator
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.conf import settings

from storage import ClassifiedAdTmpImageStorage
from .forms import ClassifiedAdForm
from .models import ClassifiedAd, ClassifiedAdImage
from .queue import ClassifiedAdQueue
from account.models import UserProfile


class AllClassifiedAdView(View):
    def get(self, request):
        max_classfiedad = 7

        # TODO: Lazy?
        classifiedad = ClassifiedAd.objects.filter(status='PUBLISHED').all()
        paginator = Paginator(classifiedad, max_classfiedad)       

        page_number = request.GET.get('p')
        classifiedad_page = paginator.get_page(page_number)

        total_published = classifiedad.count()

        return render(request, 'classifiedad/desktop_all_classifiedad.html', {
            'classifiedad_page': classifiedad_page, 'total_published': total_published})


class HomeClassifiedAdView(View):
    def get(self, request):
        user_profile = get_object_or_404(UserProfile, user=request.user)

        classifiedad_list = ClassifiedAd.objects.filter(Q(user_id=request.user),
            Q(status='PUBLISHED') | Q(status='NEW') | Q(status='MOVE') | Q(status='UPDATE')).all()
        paginator = Paginator(classifiedad_list, 4)

        total_published = ClassifiedAd.objects.filter(user_id=request.user, 
            status='PUBLISHED').count()        

        total_not_published = ClassifiedAd.objects.filter(Q(user_id=request.user), 
            Q(status='NEW') | Q(status='MOVE') | Q(status='UPDATE')).count()
        
        page_number = request.GET.get('p')
        classifiedad_page = paginator.get_page(page_number)

        return render(request, 'classifiedad/my/classifiedad.html', {'user_profile': user_profile,
            'classifiedad_page': classifiedad_page, 'total_published': total_published, 
            'total_not_published': total_not_published})


class NewClassifiedAdView(View):
    def get(self, request):
        form = ClassifiedAdForm()

        return render(request, 'classifiedad/form_classifiedad.html', {'form': form})

    def post(self, request):               
        form = ClassifiedAdForm(request.POST)        
        image_list = request.POST.getlist('image_list[]', None)  
              
        if form.is_valid() and (isinstance(image_list, list) and len(image_list) > 0):
            new_classifiedad = form.save(commit=False)          

            new_classifiedad.user = request.user
            new_classifiedad.save()
            new_classifiedad_id = new_classifiedad.id

            bulk_img_list = []

            img_url_str = f'https://objectstorage.{settings.OCI_REGION}.oraclecloud.com/n/{settings.OCI_BUCKET_NAMESPACE}/'
 
            # Valida a URL de cada imagem enviada no POST.
            for img_url in image_list:                
                if not re.match(f'^{img_url_str}.*$', img_url):
                    ClassifiedAd(id=new_classifiedad_id).delete()
                    return HttpResponse('Bad Request', status=400)                                    

                classifiedad_img = ClassifiedAdImage(classifiedad_id=new_classifiedad_id, url=img_url)
                bulk_img_list.append(classifiedad_img)                
            else:
                ClassifiedAdImage.objects.bulk_create(bulk_img_list)

            # Queue Task
            queue_client = ClassifiedAdQueue(queue_id=settings.QUEUE_ID, region_id=settings.OCI_REGION, 
                env=settings.APP_ENV)                
            queue_client.classifiedad_id = new_classifiedad_id
            queue_client.classifiedad_status = 'NEW'
            queue_client.put_list(msg_list=image_list)

            messages.success(request, 'Anúncio cadastrado com sucesso.')

            return redirect('classifiedad:home')
        else:        
            messages.error(request, 'Erro ao criar novo Anúncio.')

            return render(request, 'classifiedad/form_classifiedad.html', {'form': form})


class EditClassifiedAdView(View):
    def get(self, request, classifiedad_id=None):
        try:
            classifiedad = ClassifiedAd.objects.filter(id=classifiedad_id, 
                user=request.user, status='PUBLISHED').get()
        except ClassifiedAd.DoesNotExist:
            raise Http404
        
        form = ClassifiedAdForm(instance=classifiedad)
        form.fields['brand'].initial = classifiedad.model.brand.id

        image_list = classifiedad.images.all()

        return render(request, 'classifiedad/form_classifiedad.html', 
            {'classifiedad_id': classifiedad_id, 'image_list': image_list, 'form': form})

    def post(self, request, classifiedad_id=None):
        try:
            classifiedad = ClassifiedAd.objects.filter(id=classifiedad_id, 
                user=request.user, status='PUBLISHED').get()
        except ClassifiedAd.DoesNotExist:
            raise Http404
        
        form = ClassifiedAdForm(data=request.POST, instance=classifiedad)
        new_image_list = request.POST.getlist('image_list[]', None)  

        # Valida se o formulário é válido e se o mesmo possui imagens do anúncio.
        if form.is_valid() and (isinstance(new_image_list, list) and len(new_image_list) > 0):               
            old_img_list = [old_img_url.url for old_img_url in classifiedad.images.all()]

            queue_client = ClassifiedAdQueue(queue_id=settings.QUEUE_ID, region_id=settings.OCI_REGION, 
                env=settings.APP_ENV)                
            queue_client.classifiedad_id = classifiedad_id
            queue_client.classifiedad_status = 'UPDATE'
            put_status = queue_client.put_list(msg_list=old_img_list)

            if not put_status:
                return HttpResponse(status=500)

            form.save() 

            # Excluí imagens antigas. 
            ClassifiedAdImage.objects.filter(classifiedad_id=classifiedad_id).delete()

            #  Insere novas imagens. 
            bulk_img_list = []

            for img_url in new_image_list:
                # TODO: necessário regex para validar a URL do Object Storage.
                classifiedad_img = ClassifiedAdImage(classifiedad_id=classifiedad_id, url=img_url)
                bulk_img_list.append(classifiedad_img)                
            else:
                ClassifiedAdImage.objects.bulk_create(bulk_img_list)           

            # Define o status do classificado para "EM ATUALIZAÇÃO".
            ClassifiedAd.objects.filter(id=classifiedad_id).update(status='UPDATE')                                   

            messages.success(request, 'Anúncio atualizado com sucesso.')

            return redirect('classifiedad:home')
        
        messages.error(request, 'Erro ao atualizar o Anúncio.')

        return render(request, 'classifiedad/form_classifiedad.html', {'form': form})


@method_decorator(csrf_exempt, name='dispatch')
class ClassifiedAdTmpImageUploadView(View):
    def post(self, request):
        allowed_mimetype = ('image/jpeg', 'image/png', 'image/webp',)
        max_img_size = 5242880
        token_len = 8        
        
        file_obj = request.FILES.get('files[]', None)   
        file_size = file_obj.size        

        if file_size <= 0 or file_size > max_img_size:
            return HttpResponse('Bad Request', status=400)
        elif file_obj.content_type not in allowed_mimetype:
            return HttpResponse('Bad Request', status=400)

        file_ext = pathlib.Path(file_obj.name).suffix
        
        rand_filename = '%s%s' % (
            token_hex(token_len) + datetime.now().strftime('%s%f'),
            file_ext.lower(),
        )

        image_storage = ClassifiedAdTmpImageStorage()
        image_storage.save(rand_filename, file_obj)

        file_url = 'https://objectstorage.%s.oraclecloud.com/n/%s/b/%s/o/%s' % (
            settings.OCI_REGION, settings.OCI_BUCKET_NAMESPACE,
            settings.CLASSIFIEDAD_TMPIMG_BUCKET, rand_filename,
        )               

        return HttpResponse(file_url, content_type='text/plain', status=200)

    def delete(self, request):        
        delete = QueryDict(request.body)
        slash_filename = delete.get('filename', None)

        try:
           filename = slash_filename[slash_filename.rindex('/') + 1:]
        except ValueError:
           return HttpResponse('Bad Request', status=400)
        
        image_storage = ClassifiedAdTmpImageStorage()
        image_storage.delete(filename)
        
        return HttpResponse(filename, content_type='text/plain', status=200)


class ClassifiedAdDetailView(View):
    def get(self, request, brand: str, model: str, model_year: int, classifiedad_id: int): 
        brand_str = brand.replace('-', ' ')       
        model_str = model.replace('-', ' ')       

        try:
            classifiedad = ClassifiedAd.objects.filter(model__brand__brand=brand_str, 
                model__model=model_str, model_year=model_year, id=classifiedad_id, 
                status='PUBLISHED').get()
            print(classifiedad)
        except ClassifiedAd.DoesNotExist:
            raise Http404
        
        return render(request, 'classifiedad/desktop_details_classifiedad.html', {
            'classifiedad': classifiedad})


class DeleteClassifiedAdView(View):
    def post(self, request):
        classifiedad_id = request.POST.get('classifiedad_id', None)

        try:
            classified_ad = ClassifiedAd.objects.filter(id=classifiedad_id, user=request.user, status='PUBLISHED').get()
        except ClassifiedAd.DoesNotExist:
            raise Http404
        
        img_list = []

        for img in classified_ad.images.all():
            img_list.append(img.url)
        
        queue_client = ClassifiedAdQueue(queue_id=settings.QUEUE_ID, region_id=settings.OCI_REGION, 
            env=settings.APP_ENV)                
        queue_client.classifiedad_id = classifiedad_id
        queue_client.classifiedad_status = 'DELETE'
        put_status = queue_client.put_list(msg_list=img_list)

        if put_status is not None:
            rows = ClassifiedAd.objects.filter(id=classifiedad_id, user=request.user, 
                status='PUBLISHED').update(status='DELETE')
            
            if rows:                       
                messages.success(request, 'Anúncio excluido com sucesso.')
            else:
                messages.error(request, 'Não foi possível excluír este anúncio.')
            
            return redirect('classifiedad:home')
        else:
            return HttpResponse(status=500)