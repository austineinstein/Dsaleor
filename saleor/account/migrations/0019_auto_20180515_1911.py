# Generated by Django 2.0.3 on 2018-05-15 14:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0018_dashboardimage'),
    ]

    operations = [
        migrations.AlterField(
            model_name='dashboardimage',
            name='image_location',
            field=models.CharField(choices=[('image1', 'Image1'), ('image2', 'Image2'), ('image3', 'Image3'), ('logo', 'Logo')], max_length=20, unique=True),
        ),
    ]