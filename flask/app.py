import re
import urllib
import httplib2
import mechanize
import urllib2
import cookielib
from BeautifulSoup import BeautifulSoup
from grades import get_grades
#from gstats_scrap import gstats
from gstats_saket import gstats

from moodle import moodle_updates
from library import library_info
from flask import Flask
from flask import render_template
import datetime

app = Flask(__name__)
@app.route('/')
def index():
    return "Welcome"
	
@app.route('/library/<username>/<password>',methods=['GET','POST'])
def get_library_details(username,password):
    return library_info(username,password)
@app.route("/grades/<username>/<password>/<semester>")
def get_grades_details(username,password,semester):
        
    with open("grades.txt","r") as myfile1:
        y=int(myfile2.read())
        myfile1.close()
     
    y+=1
    grades_log_number = str(y)
    
    with open("grades.txt","w") as myfile1:
        myfile1.write(grades_log_number)
        myfile1.close()
        
    dt = datetime.datetime.now()
    time = dt.strftime("%A, %d. %B %Y %I:%M%p")
    log = "grades " + str(username) +" " + str(semester) +" =>" +  str(time) + "\n"
    
    with open("logs.txt", "a") as myfile:
        myfile.write(log)
    
    
    return get_grades(username,password,int(semester))
@app.route("/gstats/<dept>/<code>/<year>")

def return_grading_statistics(dept,code,year):
    
    with open("gstats.txt","r") as myfile2:
        z=int(myfile2.read())
        myfile2.close()
     
    z+=1
    gstats_log_number = str(z)
    with open("gstats.txt","w") as myfile2:
        myfile2.write(gstats_log_number)
        myfile2.close()
    
    dt = datetime.datetime.now()
    time = dt.strftime("%A, %d. %B %Y %I:%M%p")
    log = "gstats " + str(dept) +" " + str(code) + " " + str(year) + " => " +str(time) + "\n"
    
    with open("logs.txt", "a") as myfile:
        myfile.write(log)
    
    
    return gstats(dept,code,year)
    
@app.route("/moodle/<username>/<password>")
def get_moodle_updates(username,password):
    return moodle_updates(username,password)
@app.route("/thisisit")
def update():
    f = open("logs.txt","r") 
    a = f.read()
    f.close()
    return a
    
    
@app.route("/counter")
def update1():
    f = open("grades.txt","r")
    grades_number = f.read()
    f.close()
    f = open("gstats.txt","r")
    gstats_number = f.read()
    f.close()
    total_number = "grades => " + grades_number + "\n"+ "gstats => " + gstats_number + "\n"
    return total_number
    
if __name__ == "__main__":
    app.run('10.102.152.23',debug=True)

