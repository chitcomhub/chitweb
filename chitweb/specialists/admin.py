from django.contrib import admin

from .models import Specialist
from .models import Specialization


admin.site.register(Specialist)
admin.site.register(Specialization)
