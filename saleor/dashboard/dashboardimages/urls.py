from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.image_list, name='images'),
    url(r'^add/$', views.image_create, name='image-update')
]
