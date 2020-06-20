from django.db import models


class Specialization(models.Model):
    title = models.CharField("Специализация", max_length=120, default="",)

    def __str__(self):
        return self.title


class Specialist(models.Model):
    first_name = models.CharField("Имя", max_length=120, default="",)
    last_name = models.CharField("Фамилия", max_length=120, default="",)
    short_bio = models.CharField("Описание", max_length=200, default="",)
    long_bio = models.TextField("Полное описание", blank=True, default="",)
    telegram = models.CharField("Telegram", max_length=120, default="",)
    github = models.CharField(
        "Github", max_length=120, default="", blank=True,)
    photo = models.ImageField(upload_to="profile-pics",
                              verbose_name="Фото", blank=True)
    specializations = models.ManyToManyField(
        "Specialization", verbose_name="Специализации"
    )

    def __str__(self):
        return self.first_name
