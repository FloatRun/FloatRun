from django.shortcuts import render
from django.urls import reverse
from django.db import IntegrityError
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth import authenticate, login, logout

from .models import User, Tasks

from django.core.paginator import Paginator
from django.core.mail import send_mail
import json


dark = False


def index(request):
    #trues = []
    try:
        k = Tasks.objects.filter(username=request.user, complete=False)
    except:
        return HttpResponseRedirect(reverse("homepage"))
    """for item in k:
        trues.append(item.Postref.all().filter(liker = request.user).count() > 0)"""
    p = Paginator(k,5)
    page = request.GET.get("page")
    k=p.get_page(page)

    """q = Paginator(trues,10)
    page = request.GET.get("page")
    likestat = q.get_page(page)"""
        
    return render(request, "index.html",{
        #"tasks" : page,
        #"user" : str(request.user)
        "tasks" : k
        })



def register(request):
    if request.method == "POST":
        username = request.POST["username"]
        email = request.POST["email"]

        # Ensure password matches confirmation
        password = request.POST["password"]
        confirmation = request.POST["confirmation"]
        if password != confirmation:
            return render(request, "register.html", {
                "message": "Passwords must match."
            })

        # Attempt to create new user
        try:
            test = User
            test2 = test.objects.all()
            user = User.objects.create_user(username, email, password)
            user.save()
        except IntegrityError:
            return render(request, "register.html", {
                "message": "Username already taken."
            })
        login(request, user)
        return HttpResponseRedirect(reverse("index"))
    else:
        return render(request, "register.html")


def login_page(request):
    if request.method == "POST":

        # Attempt to sign user in
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(request, username=username, password=password)

        # Check if authentication successful
        if user is not None:
            login(request, user)
            return HttpResponseRedirect(reverse("index"))
        else:
            return render(request, "login.html", {
                "message": "Invalid username and/or password."
            })
    else:
        return render(request, "login.html")


def logout_page(request):
    logout(request)
    return HttpResponseRedirect(reverse("login"))


def newtask(request):
    if request.method == "GET":
        return render(request, "newtask.html")
    else:
        newtask = request.POST["newtask"]
        un = request.user
        time = request.POST["time"]
        date = request.POST["date"]
        status = request.POST["status"]
        if time == "":
            time = None
        if date == "":
            date = None
        try:
            image = request.FILES['image']
            taskdata = Tasks(data = newtask, username = un, datedue = date, due = time, image = image, status = status)
            taskdata.save()
        except:
            taskdata = Tasks(data = newtask, username = un, datedue = date, due = time, status = status)
            taskdata.save()
        #taskdata = Tasks(data = newtask, username = un, due = date, image = image, status = status)
        #taskdata.save()
        return HttpResponseRedirect(reverse("index"))


def edit(request, id):
    if request.method == "PUT":
        post = Tasks.objects.get(id=id)
        put = json.loads(request.body)
        edit = put["newdata"]
        if str(post.username.username) != str(request.user):
            return HttpResponse("What are you trying to do...?",status=401)
        else:
            post.data = edit
            post.save()
            return HttpResponse(status=200)
    elif request.method == "GET":
        post = Tasks.objects.get(id=id)
        content = post.data
        return HttpResponse(f"""{content}<br><br>
      <button onclick="edit(this.id)" id ="edit{id}">Edit</button>""")


def complete(request):
    #trues = []
    k = Tasks.objects.filter(username=request.user, complete=True)
    """for item in k:
        trues.append(item.Postref.all().filter(liker = request.user).count() > 0)"""
    
    p = Paginator(k,5)
    page = request.GET.get("page")
    k=p.get_page(page)

    """q = Paginator(trues,10)
    page = request.GET.get("page")
    likestat = q.get_page(page)"""

    return render(request, "complete.html",{
        #"tasks" : page,
        #"user" : str(request.user)
        "tasks" : k
        })

def mark(request,id):
    if request.method == "PUT":
        post = Tasks.objects.get(id=id)
        put = json.loads(request.body)
        edit = put["complete"]
        if str(post.username.username) != str(request.user):
            return HttpResponse("What are you trying to do...?",status=401)
        else:
            post.complete = edit
            post.save()
            #return HttpResponse("What are you trying to do...?",status=401)
            return HttpResponse(status=200)

def umark(request,id):
    if request.method == "PUT":
        post = Tasks.objects.get(id=id)
        put = json.loads(request.body)
        edit = put["complete"]
        if str(post.username.username) != str(request.user):
            return HttpResponse("What are you trying to do...?",status=401)
        else:
            post.complete = edit
            post.save()
            #return HttpResponse("What are you trying to do...?",status=401)
            return HttpResponse(status=200)


def dark(request, set):
    if request.POST["dark"] == "false":
        dark = True
    else:
        dark = False
    return HttpResponse(status=200)


def remind(request, id):
    user = User.objects.filter(username=request.user.username).values()
    email = user[0]["email"]
    task = Tasks.objects.filter(id=id).values()
    etype = task[0]["status"]
    date = task[0]["datedue"]
    day = task[0]["due"]
    details = task[0]["data"]

    if day != None:
        send_mail(
            "Taskr Reminder",
            f"""You have received this email as a reminder for your {etype}-sensitive event on {day}, {date}:
        {details}
            
        You may pin this email for your convenience.
        Regards,
        Taskr""",
            "taskr.notify@gmail.com",
            [f"{email}"]
        )
    
    else:
        send_mail(
            "Taskr Reminder",
            f"""You have received this email as a reminder for your {etype} event:
            {details} 
            
        You may pin this email for your convenience.
            
            Regards,
            Taskr""",
            "taskr.notify@gmail.com",
            [f"{email}"]
        )

    return HttpResponse(status=200)


def homepage(request):
    return render(request, "homepage.html")

    







