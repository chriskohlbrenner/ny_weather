require_relative '../config/environment.rb'

class FindForecast
  def initialize(hour)
    if hour == 6
      @doc = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US"))
    elsif hour == 24
      @doc = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US?pagenum=2&nextbeginIndex=6"))
    end
    intro(hour)
    scrape_forecast(hour)
  end

  def intro(hour)
    introduction = "\nToday's date: #{Date.today}.\nThe weather for the next #{hour} hours is as follows:\n\n"
    puts introduction
  end

  def scrape_forecast(hour)
    to_delete = @doc.css("span.wx-date-label").collect {|x| x.text} + @doc.css("span.wx-day-label").collect {|x| x.text}

    forecasts = @doc.css("div.wx-timepart").collect { |section| section.text.gsub(/\n/,'') }
    
    forecasts.each_with_index do |forecast, i|
      to_delete.each do |word|
        forecast.gsub!("#{word}", "")
      end
      if hour == 6
        puts forecast.gsub("°F", "°").gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")  if i % 4 == 0
      elsif hour ==24
        puts forecast.gsub("°F", "°").gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")  if i % 4 == 0
        puts forecast.gsub("°F", "°").gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")
      end    
    end
  end
end