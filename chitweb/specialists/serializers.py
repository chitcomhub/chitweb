from chitweb.specialists.models import Specialist, Specialization
from rest_framework import serializers


class SpecialistSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Specialist
        fields = [
            'id',
            'first_name',
            'last_name',
            'short_bio',
            'long_bio',
            'telegram',
            'github',
            'photo',
            'specializations',
        ]


class SpecializationSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Specialization
        fields = ['id', 'title']
