
require 'rubygems'
require 'blather'
require 'blather/client'
require 'blather/stanza'
require 'pony'
require 'net/http'
require 'uri'
require 'cgi'

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
status=Blather::Stanza::Presence::Status.new(:available,"*Beta Phase !*")
write_to_stream status
}
subscription :request? do |s|
	write_to_stream s.approve!
end





message :chat?,:body do |m|
	#uri=URI.parse('http://prashant7891.appspot.com')
	#host = uri.host
	#port = uri.port
	#http_session = Net::HTTP.new(host,port)
        #response = http_session.get("?txtweb-message=gstats+cs+101+2010")
 	#a=Net::HTTP.get('www.google.com', '/')
	params = {"txtweb-message" => "gstats cs 101 2010"}
	response = http_get("prashant7891.appspot.com", "/", params)
	say m.from, "TEST #{response.body}"
end	
	

