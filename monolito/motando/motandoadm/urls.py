#
# motandoadm/urls.py
#

from django.urls import path
from django.contrib.auth.decorators import login_required

from . import views

app_name = 'motandoadm'

urlpatterns = [    
    path('home', login_required(views.HomeAdminView.as_view()), name='home'),  
    
    path('moto', login_required(views.ListAllMotorcycleAdminView.as_view()), name='motorcycle_all_list'),  

    path('moto/marca', login_required(views.ListMotorcycleBrandAdminView.as_view()), name='motorcycle_brand_list'),  
    path('moto/marca/novo', login_required(views.AddMotorcycleBrandAdminView.as_view()), name='motorcycle_brand_add'),  
    path('moto/marca/<int:brand_id>', login_required(views.EditMotorcycleBrandAdminView.as_view()), name='motorcycle_brand_edit'),  
    path('moto/marca/remover/<int:brand_id>', login_required(views.DeleteMotorcycleBrandAdminView.as_view()), name='motorcycle_brand_delete'),  

    path('moto/marca/modelo', login_required(views.SelectMotorcycleBrandModelAdminView.as_view()), name='motorcycle_brand_model_select'),  
    path('moto/marca/modelo/novo', login_required(views.AddMotorcycleBrandModelAdminView.as_view()), name='motorcycle_brand_model_add'),     
    path('moto/marca/<int:brand_id>/modelo', login_required(views.ListMotorcycleBrandModelAdminView.as_view()), name='motorcycle_brand_model_list'),  
    path('moto/marca/<int:brand_id>/modelo/<int:model_id>', login_required(views.EditMotorcycleBrandModelAdminView.as_view()), name='motorcycle_brand_model_edit'),  
    path('moto/marca/<int:brand_id>/modelo/<int:model_id>/remover', login_required(views.DeleteMotorcycleBrandModelAdminView.as_view()), name='motorcycle_brand_model_delete'),  

    path('moto/marca/modelo/versao', login_required(views.SelectMotorcycleBrandModelVersionAdminView.as_view()), name='motorcycle_brand_model_version_select'),  
    path('moto/marca/modelo/versao/novo', login_required(views.AddMotorcycleBrandModelVersionAdminView.as_view()), name='motorcycle_brand_model_version_add'),     
    path('moto/marca/<int:brand_id>/modelo/<int:model_id>/versao', login_required(views.ListMotorcycleBrandModelVersionAdminView.as_view()), name='motorcycle_brand_model_version_list'),      
    path('moto/marca/<int:brand_id>/modelo/<int:model_id>/versao/<int:version_id>', login_required(views.EditMotorcycleBrandModeVersionlAdminView.as_view()), name='motorcycle_brand_model_version_edit'),  
    path('moto/marca/modelo/versao/<int:version_id>/remover', login_required(views.DeleteMotorcycleBrandModelVersionAdminView.as_view()), name='motorcycle_brand_model_version_delete'),  

    #path('motorcycle/brand/<str:brand_id>/model/<int:model_id>/version/<int:version_id>', login_required(views.EditMotorcycleAdminView.as_view()), name='edit'),
]