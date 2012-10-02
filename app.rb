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
status=Blather::Stanza::Presence::Status.new(:available,"*Being Updated*")
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
	url = "http://gymkhana.iitb.ac.in/~ugacademics/wiki/index.php?search="+"#{term}"+"&go=Go&title=Special%3ASearch"
	say m.from, "#{url}"
end
message :chat?,:body => /calendar/i do |m|
    connection =  Mongo::Connection.new("mongodb://saket:fedora13@alex.mongohq.com:10054/oauth_data")
    db = connection.db["oauth_data"]
    db.a:
    say m.from,"teston"i

end

message :chat?,:body do |m|
	say m.from, "Incorrect format: Correct Format _<gstats department course_number year>_"
	say m.from, "E.g. _gstats cs 101 2010 for cs101's 2010 stats!_"
end

