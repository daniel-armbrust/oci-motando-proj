#
# motorcycle/api/urls.py
#

from django.urls import path

from . import views

app_name = 'motorcycle'

urlpatterns = [
    path('brands', views.MotorcycleBrandListApiView.as_view(), name='brand_list'),
    path('brands/<int:brand_id>', views.MotorcycleBrandApiView.as_view(), name='brand'),

    path('brands/<int:brand_id>/models', views.MotorcycleBrandModelListApiView.as_view(), name='brand_model_list'),
    path('brands/<int:brand_id>/models/<int:model_id>', views.MotorcycleBrandModelApiView.as_view(),
         name='brand_model'),

    path('brands/<int:brand_id>/models/<int:model_id>/versions', views.MotorcycleBrandModelVersionListApiView.as_view(), 
         name='brand_model_version_list'),
    path('brands/<int:brand_id>/models/<int:model_id>/versions/<int:version_id>', views.MotorcycleBrandModelVersionApiView.as_view(), 
         name='brand_model_version')
]