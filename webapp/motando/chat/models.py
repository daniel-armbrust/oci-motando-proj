#
#  
#

from django.db import models
from django.conf import settings


from classifiedad.models import ClassifiedAd


class Chat(models.Model):
    classifiedad = models.ForeignKey(ClassifiedAd, on_delete=models.DO_NOTHING, null=False, blank=False)
    user_to = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING, null=False, blank=False, related_name='user_to')
    user_from = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING, null=True, default=None, related_name='user_from')
    user_from_fullname = models.CharField(max_length=200, null=True, blank=False)
    user_from_email = models.EmailField(null=True, blank=False)
    user_from_telephone = models.CharField(max_length=40, null=True, blank=False)  
    messages = models.JSONField(null=False, blank=False)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'chats'
        ordering = ['created']