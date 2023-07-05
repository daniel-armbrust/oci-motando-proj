#
# motorcycle/api/urls.py
#

from django.urls import path

from . import views

app_name = 'motorcycle'

urlpatterns = [
    path('brands', views.MotorcycleBrandListView.as_view(), name='brand_list'),
    path('brands/<int:pk>', views.MotorcycleBrandDetailView.as_view(), name='brand_detail'),

    path('brands/<int:brand_id>/models', views.MotorcycleBrandModelListView.as_view(), name='brand-model_list'),
    path('brands/<int:brand_id>/models/<int:model_id>', views.MotorcycleBrandModelDetailView.as_view(), 
        name='brand-model_detail'),

    path('brands/<int:brand_id>/models/<int:model_id>/versions', views.MotorcycleModelVersionListView.as_view(), 
        name='brand-model-version_list'),
    path('brands/<int:brand_id>/models/<int:model_id>/versions/<int:version_id>', 
        views.MotorcycleModelVersionDetailView.as_view(), name='brand-model-version_detail')
]