# Generated by Django 2.0.3 on 2018-05-21 11:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0019_auto_20180515_1911'),
    ]

    operations = [
        migrations.AlterField(
            model_name='dashboardimage',
            name='image',
            field=models.ImageField(upload_to='images/'),
        ),
    ]
