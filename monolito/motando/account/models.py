#
# account/models.py
#

from django.db import models
from django.conf import settings
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser, PermissionsMixin

from state_city.models import State, StateCity
from motorcycle.models import MotorcycleBrand, MotorcycleBrandModel


class UserManager(BaseUserManager):
    def create_user(self, email, password=None, full_name=None):
        """
        Creates and saves a User with the given email and password.
        """
        if not email:
            raise ValueError('Users must have an email address')

        if not full_name:
            raise ValueError('Users must have a name')

        user = self.model(email=self.normalize_email(email), full_name=full_name)

        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_staffuser(self, email, password):
        """
        Creates and saves a staff user with the given email and password.
        """
        user = self.create_user(email, password=password)
        user.staff = True
        user.save(using=self._db)

        return user

    def create_superuser(self, email, password):
        """
        Creates and saves a superuser with the given email and password.
        """
        user = self.create_user(email, password=password)
        user.staff = True
        user.admin = True
        user.save(using=self._db)

        return user


class User(AbstractBaseUser, PermissionsMixin):
    objects = UserManager()

    email = models.EmailField(max_length=255, unique=True)
    full_name = models.CharField(max_length=500, blank=False, null=False)
    is_active = models.BooleanField(default=True) # TODO: email for activation
    staff = models.BooleanField(default=False) # a admin user; non super-user
    admin = models.BooleanField(default=False) # a superuser
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['full_name'] # Email & Password are required by default.

    def __str__(self):
        return self.email

    def get_full_name(self):
        # The user is identified by their email address
        return self.email

    def get_short_name(self):
        # The user is identified by their email address
        return self.email

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        return self.staff

    @property
    def is_admin(self):
        "Is the user a admin member?"
        return self.admin


class UserProfile(models.Model):
    GENDER_CHOICES = (
        ('M', 'Masculino'),
        ('F', 'Feminino'),
    )

    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    subscribe_offer = models.BooleanField(default=False)
    state = models.ForeignKey(State, on_delete=models.DO_NOTHING, null=False, 
        blank=False)
    city = models.ForeignKey(StateCity, on_delete=models.DO_NOTHING, null=False, 
        blank=False)    
    zip_code = models.CharField(max_length=40, null=True, blank=True, default=None)
    address = models.CharField(max_length=1000, null=True, blank=True, default=None)
    neighborhood = models.CharField(max_length=100, null=True, blank=True, default=None)
    address_complement = models.CharField(max_length=500, null=True, blank=True, default=None)
    date_of_birth = models.DateField(blank=True, null=True, default=None)
    telephone = models.CharField(max_length=40, null=True, blank=True, default=None)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES, null=True, default=None)
    has_motorcycle = models.BooleanField(null=True, default=None)
    motorcycle_brand_wanted = models.ForeignKey(MotorcycleBrand, null=True, default=None, 
        on_delete=models.DO_NOTHING)
    motorcycle_brand_model_wanted = models.ForeignKey(MotorcycleBrandModel, null=True, 
        default=None, on_delete=models.DO_NOTHING)
    motorcycle_wanted_year = models.PositiveSmallIntegerField(null=True, default=None)
    authz_whatsapp = models.BooleanField(null=True, default=None)
    authz_sms = models.BooleanField(null=True, default=None)
    show_telephone_classifiedad = models.BooleanField(null=True, default=None)
    
    def __str__(self):
        return self.user.email