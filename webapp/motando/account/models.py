#
# account/models.py
#

from django.db import models
from django.conf import settings
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser, PermissionsMixin

from state_city.models import State, StateCity
from motorcycle.models import MotorcycleBrand, MotorcycleBrandModel


class UserManager(BaseUserManager):
    def create_user(self, email, password=None, fullname=None):
        """
        Creates and saves a User with the given email and password.
        """
        if not email:
            raise ValueError('Users must have an email address')

        if not fullname:
            raise ValueError('Users must have a name')

        user = self.model(email=self.normalize_email(email), fullname=fullname)

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
    fullname = models.CharField(max_length=500, blank=False, null=False)        
    staff = models.BooleanField(default=False) 
    admin = models.BooleanField(default=False) 
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    # TODO: need to be changed in production!
    is_active = models.BooleanField(default=True) 

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['fullname']

    def __str__(self):
        return self.email

    def get_fullname(self):
        # The user is identified by their email address
        return self.fullname

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

    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='user')
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
    motorcycle_wanted_year = models.PositiveSmallIntegerField(null=True, blank=True, default=None)
    authz_whatsapp = models.BooleanField(null=True, default=None)
    authz_sms = models.BooleanField(null=True, default=None)
    show_telephone_classifiedad = models.BooleanField(null=True, default=None)
    
    def __str__(self):
        return self.user.email