"""
Django settings for motando project.

Generated by 'django-admin startproject' using Django 4.2.1.

For more information on this file, see
https://docs.djangoproject.com/en/4.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/4.2/ref/settings/
"""

import os
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# Environment
APP_ENV = os.environ.get('APP_ENV')

if APP_ENV == 'PRD':
    SECRET_KEY = os.environ.get('DJANGO_SECRET_KEY', None)
    DEBUG = False
else:
    from secrets import token_hex
    SECRET_KEY = token_hex(24)
    DEBUG = True

ALLOWED_HOSTS = []

# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.humanize',

    # 3rd party apps
    'rest_framework',

    # Local Apps
    'account.apps.AccountConfig',
    'motandoadm.apps.MotandoadmConfig',
    'home.apps.HomeConfig',
    'state_city.apps.StateCityConfig',
    'motorcycle.apps.MotorcycleConfig',
    'classifiedad.apps.ClassifiedadConfig',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'motando.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'motando.wsgi.application'

# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

DATABASES = {
    #'default': {
    #    'ENGINE': 'django.db.backends.sqlite3',
    #    'NAME': BASE_DIR / 'db.sqlite3',
    #}
    
    'default': {
        'ENGINE'  : 'django.db.backends.mysql', 
        'NAME'    : os.environ.get('OCI_MYSQL_DBNAME'),
        'USER'    : os.environ.get('OCI_MYSQL_USERNAME'),
        'PASSWORD': os.environ.get('OCI_MYSQL_PASSWORD'),
        'HOST'    : os.environ.get('OCI_MYSQL_HOSTNAME'),
        'PORT'    : '3306',
        "OPTIONS": {
            "init_command": "SET default_storage_engine=INNODB",
        }
    }
}


# Password validation
# https://docs.djangoproject.com/en/4.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.2/topics/i18n/

LANGUAGE_CODE = 'pt-br'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.2/howto/static-files/

STATIC_URL = 'static/'

STATICFILES_DIRS = [
    BASE_DIR / 'static'
]

# Default primary key field type
# https://docs.djangoproject.com/en/4.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# Login / Logout
LOGIN_URL = 'account:login'
LOGOUT_URL = 'account:logout'
LOGOUT_REDIRECT_URL = 'home:main_page'

AUTH_USER_MODEL = 'account.User'

# DJANGO RestFramework
REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.DjangoModelPermissionsOrAnonReadOnly'
    ],
    'DEFAULT_RENDERER_CLASSES': [
        'rest_framework.renderers.JSONRenderer'
    ]
}

# OCI
OCI_REGION = os.environ.get('OCI_REGION_ID')
OCI_BUCKET_NAMESPACE = os.environ.get('OCI_OBJSTR_NAMESPACE')
CLASSIFIEDAD_TMPIMG_BUCKET = os.environ.get('OCI_BUCKET_MOTANDO_IMGTMP')
CLASSIFIEDAD_IMG_BUCKET = os.environ.get('OCI_BUCKET_MOTANDO_IMG')
QUEUE_ID = os.environ.get('OCI_QUEUE_ID')

AWS_ACCESS_KEY_ID = os.environ.get('OCI_ACCESS_KEY_ID')
AWS_SECRET_ACCESS_KEY = os.environ.get('OCI_SECRET_ACCESS_KEY')
S3_REGION_NAME = OCI_REGION
AWS_S3_CUSTOM_DOMAIN = f'{OCI_BUCKET_NAMESPACE}.compat.objectstorage.{OCI_REGION}.oraclecloud.com'
AWS_S3_ENDPOINT_URL = f'https://{AWS_S3_CUSTOM_DOMAIN}'
AWS_S3_OBJECT_PARAMETERS = {'CacheControl': 'max-age=86400'}