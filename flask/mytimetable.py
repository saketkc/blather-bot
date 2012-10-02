import httplib2
import urllib
import urllib2
from BeautifulSoup import BeautifulSoup
def mytimetable(username,password):
    http = httplib2.Http()
    url = 'http://asc.iitb.ac.in/academic/commjsp/ldaplogin.jsp'
    body = {'user': username, 'pass': password}
    headers = {'Content-type': 'application/x-www-form-urlencoded'}
    response, content = http.request(url, 'POST', headers=headers,body=urllib.urlencode(body))
    url_location = response['location']
    splitted=url_location.split("&")
    roll_no=splitted[1].split("=")[1]
    dispurl='http://asc.iitb.ac.in/academic/commjsp/displayURL.jsp?username='+username+'&code='+roll_no+'&emptype=S'
    headers = {'Host': 'asc.iitb.ac.in','User-Agent': 'Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1', 'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8','Accept-Language':'en-us,en;q=0.5', 'Accept-Encoding': 'gzip, deflate','Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.7','Connection':    'keep-alive','Referer':dispurl,'Cookie': response['set-cookie']}
    url ='http://asc.iitb.ac.in/academic/timetable/VenueOccupancy.jsp?loginCode=%s&loginnumber=%s&Home=ascwebsite&emptype=S'%(roll_no,roll_no)
    response, content = http.request(url, 'GET', headers=headers)
    soup = BeautifulSoup(content)
    return (soup.findAll('tr'))

if __name__ == "__main__":
    soup = mytimetable("saket.kumar","thisisit1314.")
