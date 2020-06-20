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
        specialization_id = self.request.query_params.get('specialization_id',
                                                          None)

        if specialization_id:
            queryset = Specialist.objects.filter(id=specialization_id)
        else:
            queryset = Specialist.objects.all()
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
