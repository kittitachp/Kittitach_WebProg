# Kittitach Pongpairoj 5631211121
	
require 'sinatra'
require 'timezone'
require 'geocoder'

get '/' do 
	erb :form 
end

 Timezone::Configure.begin do |c|
Geocoder.configure(:timeout => 100) # 100 seconds to allow the geocoder gem to get the necesary information
c.username = 'kittitach'
end
post '/form' do
	myInput = params[:message]
  	myCon = Geocoder.coordinates(myInput) # get coordinates of particular city
	timezone = Timezone::Zone.new(:latlon => myCon)  # get timezone
	myTime = timezone.time Time.now
	myHour = myTime.hour #getHour
	myMin = myTime.min #getMinute

	checkPm = false;
	if myHour >= 12 && myMin > 0 #change to am-pm clock
		myHour -= 12
		checkPm = true
	end
	if myHour >= 12 && myMin == 0 
		checkPm = true
	end
	if myMin < 10
		myMin = "0" + myMin.to_s
	else
		myMin.to_s
	end
	if myHour < 10
		myHour = "0" + myHour.to_s
	else
		myHour.to_s
	end
	
	if checkPm == true
		showTime = myHour.to_s + ":" + myMin.to_s + "PM"
		erb :formtwo , :locals => {:a => myInput, :b => showTime}
	else 
		showTime = myHour.to_s + ":" + myMin.to_s + "AM"
		erb :formtwo , :locals => {:a => myInput, :b => showTime}
	end

end
