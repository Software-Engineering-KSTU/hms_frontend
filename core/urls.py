from django.contrib import admin
from django.urls import path, include
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

urlpatterns = [
    # Админ-панель Django
    path('admin/', admin.site.urls),

    # JWT авторизация (выдача и обновление токенов)
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    # Пользователи (регистрация, логин, профиль)
    path('api/users/', include('users.urls')),

    # Пациенты
    path('api/patients/', include('patients.urls')),

    # Отделения
    path('api/departments/', include('departments.urls')),

    # Сотрудники и доктора
    path('api/staff/', include('staff.urls')),

    # Специализации
    path('api/specializations/', include('specializations.urls')),
]
