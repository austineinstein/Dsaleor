# Generated by Django 2.0.3 on 2018-03-17 20:51

from django.db import migrations
import django_prices.models


class Migration(migrations.Migration):

    dependencies = [
        ('order', '0042_auto_20180227_0436'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='discount_amount',
            field=django_prices.models.MoneyField(blank=True, currency='NGN', decimal_places=2, max_digits=12, null=True),
        ),
        migrations.AlterField(
            model_name='order',
            name='shipping_price_gross',
            field=django_prices.models.MoneyField(currency='NGN', decimal_places=2, default=0, editable=False, max_digits=12),
        ),
        migrations.AlterField(
            model_name='order',
            name='shipping_price_net',
            field=django_prices.models.MoneyField(currency='NGN', decimal_places=2, default=0, editable=False, max_digits=12),
        ),
        migrations.AlterField(
            model_name='order',
            name='total_gross',
            field=django_prices.models.MoneyField(currency='NGN', decimal_places=2, default=0, max_digits=12),
        ),
        migrations.AlterField(
            model_name='order',
            name='total_net',
            field=django_prices.models.MoneyField(currency='NGN', decimal_places=2, default=0, max_digits=12),
        ),
        migrations.AlterField(
            model_name='orderline',
            name='unit_price_gross',
            field=django_prices.models.MoneyField(currency='NGN', decimal_places=4, max_digits=12),
        ),
        migrations.AlterField(
            model_name='orderline',
            name='unit_price_net',
            field=django_prices.models.MoneyField(currency='NGN', decimal_places=4, max_digits=12),
        ),
    ]
