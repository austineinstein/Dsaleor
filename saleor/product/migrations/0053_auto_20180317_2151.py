# Generated by Django 2.0.3 on 2018-03-17 20:51

from django.db import migrations
import django_prices.models


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0052_slug_field_length'),
    ]

    operations = [
        migrations.AlterField(
            model_name='product',
            name='price',
            field=django_prices.models.MoneyField(currency='NGN', decimal_places=2, max_digits=12),
        ),
        migrations.AlterField(
            model_name='productvariant',
            name='price_override',
            field=django_prices.models.MoneyField(blank=True, currency='NGN', decimal_places=2, max_digits=12, null=True),
        ),
        migrations.AlterField(
            model_name='stock',
            name='cost_price',
            field=django_prices.models.MoneyField(blank=True, currency='NGN', decimal_places=2, max_digits=12, null=True),
        ),
    ]
