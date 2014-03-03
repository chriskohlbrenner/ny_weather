require_relative '../config/environment.rb'

class FindForecast
  def initialize(command)
    @first_six = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US"))
    @next_eighteen = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US?pagenum=2&nextbeginIndex=6"))
    @five_day = Nokogiri::HTML(open("http://www.weather.com/weather/5-day/New+York+NY+USNY0996:1:US"))
    intro(command)
    scrape_forecast(command)
  end

  def intro(command)
    introduction = "\nToday's date: #{Date.today.strftime("%A, %B %d, %Y")}.\nThe weather for the next #{command} is as follows:\n\n"
    puts introduction
  end

  def scrape_forecast(command)
    scrape_six if command == "6 hours"
    scrape_twenty_four if command == "24 hours"
    scrape_five_days if command == "5 days"
  end

  def scrape_six
    to_delete = @first_six.css("span.wx-date-label").collect {|x| x.text} + @first_six.css("span.wx-day-label").collect {|x| x.text}
    forecasts = @first_six.css("div.wx-timepart").collect { |section| section.text.gsub(/\n/,'') }
    forecasts.each_with_index do |forecast, i|
      to_delete.each do |word|
        forecast.gsub!("#{word}", "")
      end
      puts forecast.gsub("°F", "°").gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")  if i % 4 == 0
    end
  end

  def scrape_twenty_four
    scrape_six
    to_delete = @next_eighteen.css("span.wx-date-label").collect {|x| x.text} + @next_eighteen.css("span.wx-day-label").collect {|x| x.text}
    forecasts = @next_eighteen.css("div.wx-timepart").collect { |section| section.text.gsub(/\n/,'') }
    forecasts.each_with_index do |forecast, i|
      to_delete.each do |word|
        forecast.gsub!("#{word}", "")
      end
      puts forecast.gsub("°F", "°").gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")
    end
  end

  def scrape_five_days
    forecasts = @five_day.css("div.wx-daypart").collect { |section| section.text.gsub(/\n\n/,'') }
    forecasts.each_with_index do |forecast, i|
      puts forecast.gsub("Details","")
      puts  
    end
  end
end