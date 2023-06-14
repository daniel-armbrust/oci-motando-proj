#
# motandoadm/views.py
#

from django.shortcuts import render, redirect, get_object_or_404
from django.views import View
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.contrib import messages
from django.core.paginator import Paginator
from django.http import Http404


from motorcycle.models import MotorcycleBrand, MotorcycleBrandModel, MotorcycleBrandModelVersion
from .forms import MotorcycleBrandForm, MotorcycleBrandModelForm, MotorcycleBrandModelVersionForm


class SuperUserRequiredMixin(LoginRequiredMixin, UserPassesTestMixin):
    """Classe para verificar se o usuário é um super usuário."""
    def test_func(self):
        return self.request.user.is_superuser


class HomeAdminView(SuperUserRequiredMixin, View):
    def get(self, request):
        return render(request, 'motandoadm/home.html', {})        


class ListAllMotorcycleAdminView(SuperUserRequiredMixin, View):
    def get(self, request):
        return render(request, 'motandoadm/motorcycle_all.html', {}) 


class ListMotorcycleBrandAdminView(SuperUserRequiredMixin, View):
    def get(self, request):
        brand_list = MotorcycleBrand.objects.all()        
        paginator = Paginator(brand_list, 10)
                        
        page_number = request.GET.get('p')        
        brands_page = paginator.get_page(page_number)

        return render(request, 'motandoadm/motorcycle_brand_list.html', 
            {'brands_page': brands_page})
    

class AddMotorcycleBrandAdminView(SuperUserRequiredMixin, View):
    def get(self, request):
        form = MotorcycleBrandForm()

        return render(request, 'motandoadm/motorcycle_brand.html', {'form': form})
    
    def post(self, request):
        form = MotorcycleBrandForm(request.POST)

        if form.is_valid():
            form.save()

            messages.success(request, 'Moto Marca cadastrada com sucesso.')
        else:
            messages.error(request, 'Erro ao cadastrar Moto Marca.')
        
        return redirect('motandoadm:motorcycle_brand_list')


class EditMotorcycleBrandAdminView(SuperUserRequiredMixin, View):
    def get(self, request, brand_id: int):
        try:
            brand = MotorcycleBrand.objects.filter(id=brand_id).get()
        except MotorcycleBrand.DoesNotExist:
            raise Http404

        form = MotorcycleBrandForm(initial={'brand': brand.brand})

        return render(request, 'motandoadm/motorcycle_brand.html', 
            {'form': form, 'brand_id': brand_id})
    
    def post(self, request, brand_id: int):
        try:
            brand = MotorcycleBrand.objects.filter(id=brand_id).get()
        except MotorcycleBrand.DoesNotExist:
            raise Http404        

        form = MotorcycleBrandForm(request.POST, instance=brand)

        if form.is_valid():
            form.save()

            messages.success(request, 'Moto Marca atualizada com sucesso.')
        else:           
            messages.error(request, 'Erro ao atualizar Moto Marca.')
        
        return redirect('motandoadm:motorcycle_brand_list')


class DeleteMotorcycleBrandAdminView(SuperUserRequiredMixin, View):
    def get(self, request, brand_id: int):
        try:
            brand = MotorcycleBrand.objects.filter(id=brand_id).get()
        except MotorcycleBrand.DoesNotExist:
            raise Http404    
        
        return render(request, 'motandoadm/motorcycle_brand_delete.html', {'brand': brand})

    def post(self, request, brand_id: int):
        try:
            brand = MotorcycleBrand.objects.filter(id=brand_id).get()
        except MotorcycleBrand.DoesNotExist:
            raise Http404
                
        deleted = brand.delete()
      
        if deleted[0] == 1:
             messages.success(request, 'Moto Marca excluída com sucesso.')
        else:           
            messages.error(request, 'Erro ao excluir Moto Marca.')

        return redirect('motandoadm:motorcycle_brand_list')


class SelectMotorcycleBrandModelAdminView(SuperUserRequiredMixin, View):
    def get(self, request):       
        return render(request, 'motandoadm/motorcycle_brand_model_select.html', {})


class AddMotorcycleBrandModelAdminView(SuperUserRequiredMixin, View):
    def get(self, request):        
        form = MotorcycleBrandModelForm()

        return render(request, 'motandoadm/motorcycle_brand_model.html', 
            {'form': form})
    
    def post(self, request):
        form = MotorcycleBrandModelForm(data=request.POST)
        
        if form.is_valid():
            form.save()

            messages.success(request, 'Moto Modelo cadastrado com sucesso.')
        else:
            messages.error(request, 'Erro ao cadastrar Moto Moto Modelo.')
        
        return redirect('motandoadm:motorcycle_brand_model_add')
    

class ListMotorcycleBrandModelAdminView(SuperUserRequiredMixin, View):
    def get(self, request, brand_id: int):       
        try:
            motorcycle_model_list = MotorcycleBrandModel.objects.filter(brand__id=brand_id).all()
        except MotorcycleBrandModel.DoesNotExist:
            raise Http404
                     
        paginator = Paginator(motorcycle_model_list, 10)

        page_number = request.GET.get('p')        
        motorcycle_models_page = paginator.get_page(page_number)

        return render(request, 'motandoadm/motorcycle_brand_model_list.html', 
            {'brand_id': brand_id, 'motorcycle_models_page': motorcycle_models_page})


class EditMotorcycleBrandModelAdminView(SuperUserRequiredMixin, View):
    def get(self, request, brand_id: int, model_id: int):         
        motorcycle_model = get_object_or_404(MotorcycleBrandModel, id=model_id)
        
        form = MotorcycleBrandModelForm(instance=motorcycle_model)

        return render(request, 'motandoadm/motorcycle_brand_model.html', 
            {'form': form, 'brand_id': brand_id, 'model_id': model_id})
    
    def post(self, request, brand_id: int, model_id: int):
        motorcycle_model = get_object_or_404(MotorcycleBrandModel, id=model_id)
        
        form = MotorcycleBrandModelForm(request.POST, instance=motorcycle_model)
                                                          
        if form.is_valid():            
            form.save()            

            messages.success(request, 'Moto Marca Modelo atualizado com sucesso.')
        else:           
            messages.error(request, 'Erro ao atualizar Moto Marca Modelo.')
        
        return redirect('motandoadm:motorcycle_brand_model_list', brand_id=brand_id)


class DeleteMotorcycleBrandModelAdminView(SuperUserRequiredMixin, View):
    def get(self, request, brand_id: int, model_id: int): 
        motorcycle_model = get_object_or_404(MotorcycleBrandModel, id=model_id)

        return render(request, 'motandoadm/motorcycle_brand_model_delete.html', {'motorcycle_model': motorcycle_model})

    def post(self, request, brand_id: int, model_id: int): 
        motorcycle_model = get_object_or_404(MotorcycleBrandModel, id=model_id)

        deleted = motorcycle_model.delete()

        if deleted[0] == 1:
             messages.success(request, 'Moto Modelo excluído com sucesso.')
        else:           
            messages.error(request, 'Erro ao excluir Moto Modelo.')

        return redirect('motandoadm:motorcycle_brand_model_list', brand_id=brand_id)


class SelectMotorcycleBrandModelVersionAdminView(SuperUserRequiredMixin, View):
    def get(self, request):       
        return render(request, 'motandoadm/motorcycle_brand_model_version_select.html', {})


class AddMotorcycleBrandModelVersionAdminView(SuperUserRequiredMixin, View):
    pass


class ListMotorcycleBrandModelVersionAdminView(SuperUserRequiredMixin, View):
    def get(self, request, brand_id: int, model_id: int): 
        try:
            motorcycle_version_list = MotorcycleBrandModelVersion.objects.filter(model__brand__id=brand_id, 
                model__id=model_id).all()
        except MotorcycleBrandModelVersion.DoesNotExist:
            raise Http404
        
        paginator = Paginator(motorcycle_version_list, 10)

        page_number = request.GET.get('p')        
        motorcycle_versions_page = paginator.get_page(page_number)

        return render(request, 'motandoadm/motorcycle_brand_model_version_list.html', 
            {'motorcycle_versions_page': motorcycle_versions_page})


class EditMotorcycleBrandModeVersionlAdminView(SuperUserRequiredMixin, View):
    def get(self, request, brand_id: int, model_id: int, version_id: int):         
        motorcycle_version = get_object_or_404(MotorcycleBrandModelVersion, id=version_id)
        
        form = MotorcycleBrandModelVersionForm(instance=motorcycle_version)

        return render(request, 'motandoadm/motorcycle_brand_model_version.html', 
            {'form': form, 'brand_id': brand_id, 'model_id': model_id, 'version_id': version_id})

    def post(self, request, brand_id: int, model_id: int, version_id: int):  
        motorcycle_version = get_object_or_404(MotorcycleBrandModelVersion, id=version_id)
        
        form = MotorcycleBrandModelVersionForm(request.POST, instance=motorcycle_version)
                                                          
        print(form)

        if form.is_valid():            
            form.save()            

            messages.success(request, 'Moto Modelo Versão atualizado com sucesso.')
        else:           
            messages.error(request, 'Erro ao atualizar Moto Modelo Versão.')
        
        return redirect('motandoadm:motorcycle_brand_model_version_list', brand_id=brand_id, 
            model_id=model_id)


class DeleteMotorcycleBrandModelVersionAdminView(SuperUserRequiredMixin, View):
    def get(self, request, version_id: int):
        motorcycle_version = get_object_or_404(MotorcycleBrandModelVersion, id=version_id)       
        
        return render(request, 'motandoadm/motorcycle_brand_model_version_delete.html', 
            {'motorcycle_version': motorcycle_version})

    def post(self, request, version_id: int):
        motorcycle_version = get_object_or_404(MotorcycleBrandModelVersion, id=version_id)     
                      
        deleted = motorcycle_version.delete()
      
        if deleted[0] == 1:
             messages.success(request, 'Moto Versão excluída com sucesso.')
        else:           
            messages.error(request, 'Erro ao excluir Moto Versão.')

        return redirect('motandoadm:motorcycle_brand_model_version_list', 
            brand_id=motorcycle_version.model.brand.id, model_id=motorcycle_version.model.id)



        







            








