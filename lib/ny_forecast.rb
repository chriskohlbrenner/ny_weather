require 'nokogiri'
require 'open-uri'

class NYForecast
  def initialize
    @doc = Nokogiri::HTML(open("http://www.weather.com/weather/hourbyhour/graph/New+York+NY+USNY0996:1:US"))
    intro
    scrape_forecast
  end

  def intro
    introduction = "\nToday's date: #{Date.today}.\nThe weather for the next six hours is as follows:\n\n"
    puts introduction
  end

  def scrape_forecast
    to_delete = @doc.css("span.wx-date-label").collect {|x| x.text} + @doc.css("span.wx-day-label").collect {|x| x.text}

    forecasts = @doc.css("div.wx-timepart").collect { |section| section.text.gsub(/\n/,'') }
    
    forecasts.each_with_index do |forecast, i|
      to_delete.each do |word|
        forecast.gsub!("#{word}", "")
      end

      puts forecast.gsub("°F", "°").gsub("AM","AM\n").gsub("PM","PM\n").gsub("FEE", "\nFEE").gsub("°", "°\n").gsub("%", "%\n").gsub("Show 15 Minute Details","").gsub("mph","mph\n\n")  if i % 4 == 0
    end
  end
end