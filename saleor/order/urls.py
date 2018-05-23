from django.conf.urls import url

from . import views
from ..core import TOKEN_PATTERN

urlpatterns = [
    url(r'^%s/$' % (TOKEN_PATTERN,), views.details, name='details'),
    url(r'^%s/payment/$' % (TOKEN_PATTERN,),
        views.payment, name='payment'),
    url(r'^%s/payment/(?P<variant>[-\w]+)/$' % (TOKEN_PATTERN,),
        views.start_payment, name='payment'),
    url(r'^%s/cancel-payment/$' % (TOKEN_PATTERN,), views.cancel_payment,
        name='cancel-payment'),
    url(r'^%s/checkout-success/$' % (TOKEN_PATTERN,),
        views.checkout_success, name='checkout-success'),
    url(r'^%s/attach/$' % (TOKEN_PATTERN,),
        views.connect_order_with_user, name='connect-order-with-user'),
    url(r'^%s/verify/$' % (TOKEN_PATTERN,),
        views.verify_payment, name='verify-payment'),
    url(r'^webhook/$',
        views.webhook, name='webhook'),
]
