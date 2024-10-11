from django.urls import path

from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("register", views.register, name="register"),
    path("login", views.login_page, name="login"),
    path("logout", views.logout_page, name="logout"),
    path("newtask", views.newtask, name="newtask"),
    path("edit/<int:id>", views.edit, name="edit"),
    path("complete", views.complete, name="complete"),
    path("mark/<int:id>", views.mark, name="mark"),
    path("unmark/<int:id>", views.umark, name="unmark"),
    path("dark/<str:set>", views.dark, name="dark"),
    path("remind/<int:id>", views.remind, name="remind"),
    path("homepage", views.homepage, name="homepage")
]
