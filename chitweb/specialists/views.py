from chitweb.specialists.models import Specialist, Specialization
from rest_framework import viewsets
from chitweb.specialists.serializers import SpecialistSerializer,\
    SpecializationSerializer
from django.templatetags.static import static


class SpecialistViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows specialists to be viewed or edited.
    """
    serializer_class = SpecialistSerializer
    http_method_names = ['get', 'head']

    def get_queryset(self):
        specialization_id = self.request.query_params.getlist('specialization_id',
                                                          None)
        skills_ids = self.request.query_params.getlist('skill', None)
        queryset = Specialist.objects.all()

        if specialization_id:
            queryset = queryset.filter(specializations__id__in=specialization_id).distinct()
        if skills_ids:
            queryset = queryset.filter(skill_id__in=skills_ids).distinct()
        for specialist in queryset:
            if specialist.photo == '':
                specialist.photo = static('images/default-profile.png')
        return queryset


class SpecializationViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows specializations to be viewed or edited.
    """
    queryset = Specialization.objects.all()
    serializer_class = SpecializationSerializer
    http_method_names = ['get', 'head']
