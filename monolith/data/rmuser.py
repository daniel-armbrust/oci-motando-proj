from django.contrib.auth import get_user_model

User = get_user_model()

f = open('accounts.csv')

for line in f.readlines():
    line = line.rstrip('\n')
    (full_name, email, password,) = line.split(';')

    if email == 'darmbrust@gmail.com':
        continue

    User.objects.get(email=email).delete()

f.close()
