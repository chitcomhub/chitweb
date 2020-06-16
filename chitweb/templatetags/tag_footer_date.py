from django import template
import datetime


register = template.Library()


@register.simple_tag()
def get_date_year():
    now = datetime.datetime.now().year
    return now
