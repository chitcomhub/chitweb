from chitweb.specialists.models import Specialist, Specialization
from rest_framework import viewsets
from chitweb.specialists.serializers import SpecialistSerializer, SpecializationSerializer


class SpecialistViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows specialists to be viewed or edited.
    """
    queryset = Specialist.objects.all()
    # queryset = Specialist.objects.all().order_by('-date_joined')
    serializer_class = SpecialistSerializer

    def get_queryset(self):
        specialization_id = self.request.query_params.get('id', None)

        if specialization_id:
            return Specialist.objects.filter(id=specialization_id)
        return Specialist.objects.all()


class SpecializationViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows specializations to be viewed or edited.
    """
    queryset = Specialization.objects.all()
    serializer_class = SpecializationSerializer
