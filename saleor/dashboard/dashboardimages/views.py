from django.contrib.auth.decorators import permission_required
from django.core.files.storage import FileSystemStorage
from django.template.response import TemplateResponse

from ..views import staff_member_required
# from ...product.models import Collection
from ...account.models import DashboardImage


@staff_member_required
@permission_required('image.view_image')
def image_list(request):
    images = DashboardImage.objects.all()
    print(images.__len__())
    return TemplateResponse(
        request, 'dashboard/dashboardimages/list.html')


@staff_member_required
@permission_required('image.edit_image')
def image_create(request):
    if request.method == 'POST':
        image_location = request.POST.get('image_location')
        img = request.FILES.get('image')
        alreadyexists = DashboardImage.objects.filter(image_location=image_location)
        if alreadyexists.__len__() > 0:
            alreadyexists.delete()

        dashboard_image = DashboardImage.objects.create(image_location=image_location, image=img)
        dashboard_image.save()
    return TemplateResponse(request, 'dashboard/dashboardimages/list.html')
