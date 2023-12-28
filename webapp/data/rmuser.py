from django.contrib.auth import get_user_model
from django.core.exceptions import ObjectDoesNotExist

User = get_user_model()

f = open('accounts.csv')

for line in f.readlines():
    line = line.rstrip('\n')
    (full_name, email, password,) = line.split(';')
    
    try:
        User.objects.get(email=email).delete()
    except ObjectDoesNotExist:
        pass

f.close()
