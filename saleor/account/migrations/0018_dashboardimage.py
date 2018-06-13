# Generated by Django 2.0.3 on 2018-05-15 09:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0017_auto_20180206_0957'),
    ]

    operations = [
        migrations.CreateModel(
            name='DashboardImage',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image_location', models.CharField(choices=[('image1', 'Image1'), ('image2', 'Image2'), ('image3', 'Image3')], max_length=20)),
                ('image', models.ImageField(upload_to='')),
            ],
        ),
    ]