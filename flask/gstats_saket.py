def gstats(dept,code,year) :
	
	
	try:
		username = 'saket.kumar'
		password = 'thisisit1314.' 
		
		dump = int(year)
		dump = int(code)	

		if int(year)>2012:
			return 'Sorry. The world is going to end in 2012. ;) '
		
		else:
			import httplib2
			import urllib
			from string import split, replace, find
	                out = ""
                        offered = 0

			
			for sem in range(1,3) :
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
			        url ='http://asc.iitb.ac.in/academic/Grading/statistics/gradstatforcrse.jsp?year=%s&semester=%s&txtcrsecode=%s+%s'%(year,sem,dept,code)
			        response, content = http.request(url, 'GET', headers=headers)
			        data = content	
				#print data
				lines = data.split('\n')
				for line in lines :
					semflag = find(line, "NOT</font> offered in this semester")
					if semflag > 0 :
						break
				if semflag < 0 :
					offered = 1
					out += "Grading statistics of %s %s for year %s sem %d\n" % (dept, code, year, sem)
					grades = ['AA', 'AB', 'AP', 'BB', 'BC', 'CC', 'CD', 'DD', 'FR', 'II', 'XX', 'AU']
					i = 0
					flag = 0
					for i in range(0,12) :	
						sub = "<td><b>%s </b></td>" % (grades[i])	
						for line in lines :
							if flag == 1 :
								line = line.replace('<td><b>', '')
								line = line.replace('</b></td>', '')
								gcount = int(line)
								out += '%s %d\n' % (grades[i], gcount)
								flag = 0
								break
							elif find(line, sub) > 0 :
								flag = 1
			if offered == 0 :
				return "The course %s %s was not offered in year %s" % (dept, code, year)
			else :
				return out
				
	
	except:
		return "Please enter a valid year and code"
		
	
if __name__ == "__main__" :
	print gstats('cs','101', '2011')
