from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    pass

class Tasks(models.Model):
    data = models.CharField(max_length=256)
    due = models.TimeField(null=True)
    username = models.ForeignKey(User, on_delete=models.CASCADE, related_name="Tasker", default="")
    status = models.CharField(default = "Normal", max_length=20)
    image = models.ImageField(null=True, blank=True, upload_to="images/")
    datedue = models.DateField(null=True)
    complete = models.BooleanField(default=False)

    class Meta:
        ordering = ('-status',)