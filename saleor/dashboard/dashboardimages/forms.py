from django import forms
from django.shortcuts import gets_object_or_404
from django.utils.text import slugify
from django.utils.translation import pgettext_lazy
from text_unidecode import unidecode

from ...product.models import Category
from ...account.models import DashboardImage

class ImageForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        # self.parent_pk = kwargs.pop('parent_pk')
        super(ImageForm, self).__init__(*args, **kwargs)

    class Meta:
        model = DashboardImage
        fields = ['image_location' , 'image']

    def save(self, commit=True):
        # self.instance.slug = slugify(unidecode(self.instance.name))
        # if self.parent_pk:
        #     self.instance.parent = get_object_or_404(
        #         Category, pk=self.parent_pk)
        return super().save(commit=commit)
