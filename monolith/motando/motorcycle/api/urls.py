#
# motorcycle/api/urls.py
#

from django.urls import path

from . import views

app_name = 'motorcycle'

urlpatterns = [
    path('marca', views.MotorcycleBrandListView.as_view(), name='brand_list'),
    path('marca/<int:pk>', views.MotorcycleBrandDetailView.as_view(), name='brand_detail'),

    path('marca/<int:brand_id>/modelo', views.MotorcycleBrandModelListView.as_view(), name='brand-model_list'),
    path('marca/<int:brand_id>/modelo/<int:model_id>', views.MotorcycleBrandModelDetailView.as_view(), 
        name='brand-model_detail'),

    path('marca/<int:brand_id>/modelo/<int:model_id>/versao', views.MotorcycleModelVersionListView.as_view(), 
        name='brand-model-version_list'),
    path('marca/<int:brand_id>/modelo/<int:model_id>/versao/<int:version_id>', 
        views.MotorcycleModelVersionDetailView.as_view(), name='brand-model-version_detail')
]