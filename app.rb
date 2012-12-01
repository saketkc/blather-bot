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
setup 'ascbot@jabber.org','fedora'#ENV['JID'], ENV['JPASSWORD']

#when_ready { write_to_stream Status.new(:available, "Now Live") }
when_ready {
puts "Connected ! send messages to #{jid.stripped}."
#status = Status.new
#status.message ="Doine"
status=Blather::Stanza::Presence::Status.new(:available,"*_Reinvention_")
write_to_stream status
}
subscription :request? do |s|
	write_to_stream s.approve!
end





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

message :chat?,:body => /search/i do |m|
	body = m.body.split(" ")
	term = body[1]
	link = "http://gymkhana.iitb.ac.in/~ugacademics/wiki/index.php?search="+"#{term}"+"&go=Go&title=Special%3ASearch"
	client = Googl.client('saketkc@gmail.com', 'uzfmTjX1314.9839')
	url = client.shorten(link)
	value =  url.short_url
	say m.from, "#{value}"
end


message :chat?,:body do |m|
	start = Time.now.strftime("%Y-%m-%d")
	endtime = Time.now + (24*60*60)
	ends = endtime.strftime("%Y-%m-%d")
	

	url = "http://ugacads-calendar.appspot.com/fetch?start="+"#{start}"+"&end="+"#{ends}"
	doc = Nokogiri::HTML(open url)
        response = doc.at('body').inner_text
	
	say m.from, "#{response}"
end
message :chat?,:body do |m|
	say m.from, "Incorrect format: Correct Format _<gstats department course_number year>_"
	say m.from, "E.g. _gstats cs 101 2010 for cs101's 2010 stats!_"
end


