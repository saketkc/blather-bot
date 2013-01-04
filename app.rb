require 'rubygems'
require 'blather'
require 'blather/client'
require 'blather/stanza'
require 'pony'
require 'net/http'
require 'uri'
require 'cgi'
require 'nokogiri'
require 'open-uri'
require 'googl'
def http_get(domain,path,params)
    return Net::HTTP.get(domain, "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.reverse.join('&'))) if not params.nil?
    return Net::HTTP.get(domain, path)
end
setup 'aardvark@jabber.org','fedora13'#ENV['JID'], ENV['JPASSWORD']
subscription :request? do |s|
	write_to_stream s.approve!
end
when_ready {
status=Blather::Stanza::Presence::Status.new(:available,"Testing")
write_to_stream status
}
message :chat?,:body => /gstats/i do |m|
	body=m.body.split(" ")
	dept = body[1]
	course_no = body[2]
	year = body[3]
	params = {"txtweb-message" => "gstats cs 101 2010"}
	url = "http://prashant7891.appspot.com/?txtweb-message=gstats+"+"#{dept}+"+"#{course_no}+"+"#{year}"
        doc = Nokogiri::HTML(open url)
        response = doc.at('body').inner_text
	say m.from, "#{response}"
end	

message :chat?,:body => /info/i do |m|
	body=m.body.split(" ")
	dept = body[1]
	course_no = body[2]
	
	params = {"txtweb-message" => "gstats cs 101 2010"}
	url = "http://home.iitb.ac.in/~saket.kumar/2.php?param1=courseinfo&param2="+"#{dept}"+"&param3="+"#{course_no}"+"&param4=0"
	doc = Nokogiri::HTML(open url)
        response = doc.at('body').inner_text
	say m.from, "#{response}"
end	
#message :chat?,:body => /search/i do |m|
#	body = m.body.split(" ")
#	term = body[1]
#	link = "http://gymkhana.iitb.ac.in/~ugacademics/wiki/index.php?search="+"#{term}"+"&go=Go&title=Special%3ASearch"
#	client = Googl.client('saketkc@gmail.com', 'uzfmTjX1314.9839')
#	url = client.shorten(link)
#	value =  url.short_url
#	say m.from, "#{value}"
#end


message :chat?,:body do |m|
	start = Time.now.strftime("%Y-%m-%d")
	endtime = Time.now + (24*60*60)
	ends = endtime.strftime("%Y-%m-%d")
	sender = "#{m.from}"
	sender_a = sender.split("@")[0]	
	if sender_a=="aaaiitb" then	
		status=Blather::Stanza::Presence::Status.new(:available,"#{m.body}")
		write_to_stream status
	end
        response = "Available Options : \n 1. Grading Statistics : _gstats <dept_code> <course_number> <year>_ \n 2.Search Wiki : _search <term> to search on wiki_ \n3.Course Info : _info <dept_code> <course_number>_ \n E.g. <dept_code> : cs \n <course_number>:101\n"#doc.at('body').inner_text
	
	say m.from, response
end
