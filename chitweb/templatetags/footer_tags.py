from django import template
from django.conf import settings
import datetime


register = template.Library()


commit_hash = settings.RUNNING_CHITWEB_COMMIT_HASH


@register.simple_tag()
def get_date_year():
    now = datetime.datetime.now().year
    return now


@register.simple_tag()
def get_commit_hash():
    return commit_hash[:7]


@register.simple_tag()
def get_commit_url():
    commit_url = "https://github.com/chitcomhub/chitweb/commit/" + commit_hash
    return commit_url
