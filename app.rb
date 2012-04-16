
require 'rubygems'
require 'blather'
require 'blather/client'
require 'blather/stanza'
require 'pony'
require 'net/http'
=begin
#$users = {"aakanksha" => {"name"=>"Aakanksha Dimri"},"rajveer"=>"Rajveer Rathore","advait"=>"Advait Deshpande","alankar"=>"Alankar Saxena","amit"=>"Amit Mangtani","anuj"=>"Anuj Shah","anoop"=>"Anoop Date","anurag"=>"Anurag Khandelwal","deeksha"=>"Deeksha Saxena","dhiren"=>"Dhiren Sonigra","gagan"=>"Gagandeep Makkar","giri"=>"Giri Prashant Subramiam","kartik"=> "Kartik Kacholia","rahul"=>"Rahul Mallapu","saket"=>"Saket Choudhary","raunak"=>"Raunka Bardia","sankalp"=>"Sankal Goyal","sayali"=>"Sayali Bhosekar","shardul"=>"Shardul Gaur" ,"shivi"=>"Shivi Jain","sidd"=>"Siddharth Thakur" ,"gagrani" =>"Vinayak Gagrani","khatri"=>"Vishal Khatri","vivek"=>"Vivek Agrwal","yash"=>"Yash Shah"}
$users = "rajveerrathore11020@gmail.com,aakanksha023@gmail.com,advaitd7@gmail.com,alankar111@gmail.com,amitmangtani.iitb@gmail.com,anujnshah@gmail.com,anoopdate@gmail.com,sahil814@gmail.com,angeleyes1991@gmail.com,dhirensonigra016@gmail.com,gaganatiitb@gmail.com,prashant7891@gmail.com,kartikkacholia@gmail.com,rahul.mallapur@gmail.com,raunakbardia@gmail.com,rohitluhadia@gmail.com,saketkc@gmail.com,sankalpdamani@gmail.com,internship.iitb@gmail.com".split(",")
$users = $users.map { |j| Blather::JID.new(j) }


def send_mail(to="internship.iitb@gmail.com",subject="Summer Research Projects : IIT Bombay",prof_name="Professor Name")
body=%Q{Dear #{prof_name}
			Greetings from IIT Bombay, India !

			I, Saket Choudhary am the Internship Coordinator for the Department of  Chemical Engineering at IIT Bombay. I am sending this mail on behalf of the Practical Training and Internship Cell, IIT Bombay (the letter from the Dean, Academic Programmes, IIT Bombay certifying the Practical Training and Internship Cell has been appended below the mail).


			At IIT Bombay, students take up summer internships to gain first-hand experience of the professional world after the end of the second or third year of their studies. The duration varies between 8 to 11 weeks starting from the first week of May, extending till the end of June or mid-July.


			We have students pursuing 4 year BTech and 5 year Dual Degree in our department and many of them are very keen on taking up research as a career option; hence an internship opportunity at your institute shall be a great boost for them.  We would be very grateful if you would communicate to us the availability of any  internship opportunity in your esteemed institute for the period of Summer 2012.

			We can vouch for the credibility and genuineness of the students and would also like to add that being from among the best students in India, they are not only good academically, but also possess an excellent ability to solve problems and apply themselves to practical situations.

			Looking forward to a favourable response and a subsequent fruitful association with you. I will be your point of contact for any internship/process related queries. I will be more than happy to answer. Thanks a lot for your time.

			 

			Regards,

			Saket Choudhary

			Internship Coordinator,
			Practical Training Cell (http://placements.iitb.ac.in/training)
			IIT-Bombay
			training@iitb.ac.in

		}
Pony.mail(:to => to,
              :from => "internship.iitb@gmail.com",
              :subject =>  subject,
              :body => body,
              :via => :smtp,
             :via_options =>{
                  :address              => 'smtp.gmail.com',
                  :port                 => '587',
                  :user_name                 => "internship.iitb@gmail.com",
                  :enable_starttls_auto => true, 
                  :password             => "letusdoit:p",
                  :authentication       => :plain,# :plain, :login, :cram_md5, no auth by default
                  :domain => "localhost.local"
                                })
end
=end
setup 'ascgrades@jabber.org','fedora'#ENV['JID'], ENV['JPASSWORD']

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



=begin
before (:message) do |m|
	if !$users.include?(m.from.stripped)
		say m.from, "Sorry, You are not in my authorised list. Pinging further may not help"
	end

	true	
end
=end	
 


message :chat?,:body do |m|
 	a=Net::HTTP.get('www.gppgle.com', '/')
	say m.from, "#{a.body}"
end	
	

