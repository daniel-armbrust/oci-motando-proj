#
# classifiedad/urls.py
#

from django.urls import path
from django.contrib.auth.decorators import login_required

from . import views

app_name = 'classifiedad'

urlpatterns = [

    # Visualização particular (tela administrativa)
    path('home', login_required(views.HomeClassifiedAdView.as_view()), name='home'),
    path('novo', login_required(views.NewClassifiedAdView.as_view()), name='new'),
    path('upload/imagem', login_required(views.ClassifiedAdTmpImageUploadView.as_view()), name='image_upload'),
    path('editar/<int:classifiedad_id>', login_required(views.EditClassifiedAdView.as_view()), name='edit'),   
    path('excluir', login_required(views.DeleteClassifiedAdView.as_view()), name='delete'),   

    # Visualização pública
    path('<str:brand>/<str:model>/<int:model_year>/<int:classifiedad_id>', views.ClassifiedAdDetailView.as_view(), name='detail'),
    path('todos', views.AllClassifiedAdView.as_view(), name='all')
]