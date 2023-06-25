import random

def get_passwd():
    password_length = 12
    characters = "aAbB$@#cdDe1297345"
    password = ""   

    for index in range(password_length):
        password = password + random.choice(characters)

    return password
    

email_domain_list = ('@uol.com.br', '@terra.com.br', '@gmail.com', '@globo.com', '@outlook.com', '@hotmail.com',)

f = open('accounts.csv')

for line in f.readlines():
    line = line.rstrip('\n')
    email_domain = email_domain_list[random.randint(0, len(email_domain_list)-1)]
    (name, lastname,) = line.split(' ')
    
    email = name.lower() + '.' + lastname.lower() + email_domain

    passwd = get_passwd()

    csv_line = f'{name} {lastname};{email};{passwd}'
    
    print(csv_line)

